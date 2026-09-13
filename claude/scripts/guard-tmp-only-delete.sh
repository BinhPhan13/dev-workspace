#!/usr/bin/env bash
# Claude Code PreToolUse hook for the Bash tool.
# Not wired into settings.json yet - written for review only.
#
# Policy: `rm` (any flags), `git clean` (any flags), `find -delete`, and
# `rsync --delete` may only ever target a path under /tmp (a strict subfolder,
# not /tmp itself). rm and git clean are checked unconditionally - unlike
# find/rsync, they're still capable of deleting named files with no special
# flag at all, so gating on a flag would miss plain `rm somefile`. Anything
# that fails the check is hard-denied, and the deny message lists the
# resolved path(s) so they can be deleted by hand if that's really wanted.
#
# Why /tmp-only instead of "protect $HOME": a scratch $HOME made with
# `mktemp -d` should never resolve to anything but a /tmp path. If it does,
# something already went wrong (e.g. a reassignment that didn't survive
# across separate Bash tool calls) - so the safe rule is an allowlist, not a
# blocklist of specific paths to avoid.
#
# Every allowed command also gets its `command` rewritten (via
# hookSpecificOutput.updatedInput) to unconditionally strip aliases and shell
# functions first:
#   unalias -a 2>/dev/null; unset -f $(compgen -A function) 2>/dev/null; <original command>
# This runs in the same shell invocation that already sourced Claude Code's
# shell snapshot, so no alias or function - dangerous or not - can silently
# stand in for a real command. That does mean benign aliases (e.g.
# `alias ll='ls -la'`) stop working for every Bash call too; there's no way to
# tell "safe" from "dangerous" aliases without reintroducing the detection
# work this design deliberately avoids.
#
# jq is a hard, required dependency: if it's missing, every Bash call is
# hard-blocked (see deny_jq_missing below) rather than silently letting
# unchecked commands through. Likewise, set -e + an ERR trap turn any other
# unexpected internal failure into a hard block instead of a silent allow.
#
# ponytail: command splitting is a crude ;/&&/||/| -> newline replace plus
# IFS word-splitting, not a real shell parser. It does not respect quoting
# (so `rm -rf "/tmp/has space"` mis-tokenizes), and does not see through
# `sudo`, `command`, or backslash-escaped names. Good enough for catching an
# agent's own mistakes; revisit with a real parser (e.g. shfmt -tojson) if
# that ever proves not enough.

set -e

# Fixed string literals below are deliberate: if jq is what's broken, or an
# ERR trap is firing because something upstream broke, we can't lean on jq to
# build the message reporting that.
deny_internal_error() {
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked: guard-tmp-only-delete.sh hit an internal error and is failing closed. Bash tool calls are blocked until this is fixed."}}'
  exit 2
}
trap deny_internal_error ERR

# jq is installed via lapt (this user's local package manager), whose bin dir
# isn't necessarily on PATH in whatever environment this hook is launched in.
PATH="$HOME/.lapt/bin:$PATH"

deny_jq_missing() {
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked: jq is required by guard-tmp-only-delete.sh but was not found on PATH. Install jq, then retry."}}'
  exit 2
}
command -v jq >/dev/null 2>&1 || deny_jq_missing

input="$(cat)"
tool_name="$(jq -r '.tool_name // empty' <<<"$input")"
[[ "$tool_name" == "Bash" ]] || { echo '{}'; exit 0; }

command_text="$(jq -r '.tool_input.command // empty' <<<"$input")"
cwd="$(jq -r '.cwd // empty' <<<"$input")"
[[ -z "$cwd" ]] && cwd="$PWD"
[[ -z "$command_text" ]] && { echo '{}'; exit 0; }

TMP_REAL="$(realpath -m -- /tmp)"
violations=()

# Expands one raw argument token (as it appeared in the command) using
# bash's own rules, then canonicalizes it relative to $cwd. Empty stdout
# means "couldn't resolve" - callers treat that as a violation.
resolve_target() {
  local raw="$1" resolved
  resolved="$(
    cd "$cwd" 2>/dev/null || exit 1
    expanded="$(eval "printf '%s' $raw" 2>/dev/null)"
    [[ -z "$expanded" ]] && exit 1
    realpath -m -- "$expanded" 2>/dev/null
  )" || return 1
  [[ -z "$resolved" ]] && return 1
  printf '%s' "$resolved"
}

check_target() {
  local raw="$1" resolved
  resolved="$(resolve_target "$raw")" || true
  if [[ -z "$resolved" ]]; then
    violations+=("$raw (could not resolve - treated as unsafe)")
    return
  fi
  if [[ "$resolved" != "$TMP_REAL"/* ]]; then
    violations+=("$resolved")
  fi
}

is_flag() { [[ "$1" == -* ]]; }

check_rm() {
  local -n words_ref="$1"
  local i w
  local -a targets=()
  for ((i = 1; i < ${#words_ref[@]}; i++)); do
    w="${words_ref[$i]}"
    is_flag "$w" || targets+=("$w")
  done
  for t in "${targets[@]}"; do check_target "$t"; done
}

check_find_delete() {
  local -n words_ref="$1"
  local has_delete=0 i w
  local -a targets=()
  for ((i = 1; i < ${#words_ref[@]}; i++)); do
    [[ "${words_ref[$i]}" == "-delete" ]] && has_delete=1
  done
  if [[ "$has_delete" -eq 1 ]]; then
    for ((i = 1; i < ${#words_ref[@]}; i++)); do
      w="${words_ref[$i]}"
      is_flag "$w" && break
      targets+=("$w")
    done
    [[ ${#targets[@]} -eq 0 ]] && targets=(".")
    for t in "${targets[@]}"; do check_target "$t"; done
  fi
}

check_rsync_delete() {
  local -n words_ref="$1"
  local has_delete=0 last="" i w
  for ((i = 1; i < ${#words_ref[@]}; i++)); do
    w="${words_ref[$i]}"
    [[ "$w" == "--delete" ]] && has_delete=1
    if ! is_flag "$w"; then last="$w"; fi
  done
  if [[ "$has_delete" -eq 1 && -n "$last" ]]; then
    check_target "$last"
  fi
}

check_git_clean() {
  local -n words_ref="$1"
  [[ "${words_ref[1]:-}" == "clean" ]] || return 0
  local i w
  local -a pathspecs=()
  for ((i = 2; i < ${#words_ref[@]}; i++)); do
    w="${words_ref[$i]}"
    is_flag "$w" || pathspecs+=("$w")
  done
  if [[ ${#pathspecs[@]} -eq 0 ]]; then
    check_target "."
  else
    for t in "${pathspecs[@]}"; do check_target "$t"; done
  fi
}

# Dispatches to the per-verb checker for word[0]. Returns 1 (not an error -
# callers must tolerate it) if word[0] isn't one of the watched verbs.
scan_known_verbs() {
  local -n words_ref="$1"
  local cmd_word cmd_base
  cmd_word="${words_ref[0]:-}"
  [[ -z "$cmd_word" ]] && return 0
  cmd_base="$(basename -- "${cmd_word#\\}")"

  case "$cmd_base" in
  rm) check_rm "$1" ;;
  find) check_find_delete "$1" ;;
  rsync) check_rsync_delete "$1" ;;
  git) check_git_clean "$1" ;;
  *) return 1 ;;
  esac
}

segments="$(printf '%s' "$command_text" | sed -E 's/(&&|\|\||;|\|)/\n/g')"

while IFS= read -r seg; do
  seg="$(printf '%s' "$seg" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
  [[ -z "$seg" ]] && continue
  read -r -a words <<<"$seg"
  scan_known_verbs words || true
done <<<"$segments"

if [[ ${#violations[@]} -gt 0 ]]; then
  reason="Blocked: this command would delete/modify path(s) outside /tmp:"$'\n'
  for v in "${violations[@]}"; do reason+="  - ${v}"$'\n'; done
  reason+=$'\n'"Only deletions under /tmp are allowed automatically. Delete these paths yourself if you really want them gone."
  jq -n --arg reason "$reason" \
    '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
else
  neutralized_command="unalias -a 2>/dev/null; unset -f \$(compgen -A function) 2>/dev/null; ${command_text}"
  jq -n --arg cmd "$neutralized_command" \
    '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"allow",updatedInput:{command:$cmd}}}'
fi
exit 0
