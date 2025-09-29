BIN_PATH="$HOME/.local/bin" && mkdir -p "$BIN_PATH"
OPT_PATH="$HOME/.local/opt" && mkdir -p "$OPT_PATH"

log() {
  local prefix red green yellow blue nc
  red='\033[0;31m'
  green='\033[0;32m'
  yellow='\033[1;33m'
  blue='\033[0;34m'
  nc='\033[0m'

  case "$1" in
    debug) prefix="$blue[DEBUG]" ;;
    info) prefix="$nc[INFO]" ;;
    success) prefix="$green[SUCCESS]" ;;
    warning) prefix="$yellow[WARNING]" ;;
    error) prefix="$red[ERROR]" ;;
    *)
      echo "Usage: log <level> <message>"
      echo "level: debug, info, success, warning, error"
      return 1
      ;;
  esac
  printf "$prefix $2$nc\n" >&2
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

need_cmd() {
  has_cmd "$1" || die "command '$1' is required"
}

die() {
  local show_help="false"
  [ "$1" = "-h" ] && show_help="true" && shift
  log error "$1"
  [ "$show_help" = "true" ] && log info "Try '$0 -help' for more info"
  return 1
}

get_opt() {
  local opt_name="$1" opt_value="$2"
  [ -z "$opt_value" ] || [ "${opt_value#-}" != "$opt_value" ] &&
    die -h "'$opt_name' requires a value"
  echo "$opt_value"
}

fetch() {
  need_cmd curl
  set -- "$1" "${2:-.}"
  curl -#fLO "$1" --output-dir "$2"
}

extract() {
  set -- "$1" "${2:-.}"
  local fmt
  case "$1" in
    *.zip) fmt="zip" ;;
    *.tar) fmt="tar" ;;
    *.txz | *.tar.xz)
      need_cmd xz
      fmt="tar"
      ;;
    *.tgz | *.tar.gz)
      need_cmd gzip
      fmt="tar"
      ;;
  esac

  [ -d "$2" ] || mkdir -p "$2"
  case "$fmt" in
    tar) tar xf "$1" -C "$2" ;;
    zip) unzip -q "$1" -d "$2" ;;
  esac
}

path_clean() {
  # remove redundant slashes
  [ -z "$1" ] && die "missing operand"
  local out root _ifs
  [ "${1#/}" != "$1" ] && root="/"
  _ifs=$IFS
  IFS='/'
  set -- $1
  IFS=$_ifs
  for part in "$@"; do
    [ -z "$part" ] && continue
    [ -z "$out" ] && out="$part" || out="$out/$part"
  done
  echo "$root$out"
}

path_dir() {
  local path="$(path_clean "$1")"
  local out="${path%/*}"
  case "$out" in
    "") echo "/" ;;
    "$path") echo "." ;;
    *) echo "$out" ;;
  esac
}

path_base() {
  local path="$(path_clean "$1")"
  local out="${path##*/}"
  case "$out" in
    "") echo "/" ;;
    *) echo "$out" ;;
  esac
}

path_abs() {
  local path="$(path_clean "$1")"
  case "$path" in
    /*) echo "$path" ;;
    *) echo "$(pwd)/$path" ;;
  esac
}

