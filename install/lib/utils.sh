log() {
  local prefix red green yellow blue nc
  red='\033[0;31m'
  green='\033[0;32m'
  yellow='\033[1;33m'
  blue='\033[0;34m'
  nc='\033[0m'

  case "$1" in
    debug) prefix="$blue[DEBUG]";;
    info) prefix="$nc[INFO]";;
    success) prefix="$green[SUCCESS]";;
    warning) prefix="$yellow[WARNING]";;
    error) prefix="$red[ERROR]";;
    *)
      echo "Usage: log <level> <message>"
      echo "level: debug, info, success, warning, error"
      return 1;;
  esac
  printf "$prefix $2$nc\n" >&2
}

die() {
  local help="false" clean="false"
  case "$1" in
    -h) help="true"; shift;;
    -c) clean="true"; shift;;
  esac
  log error "$1"
  [ "$help" = "true" ] && has_cmd usage && usage
  [ "$clean" = "true" ] && has_cmd cleanup && cleanup
  exit 1
}

get_opt() {
  local opt_name="$1" opt_value="$2"
  [ -z "$opt_value" ] || [ "${opt_value#-}" != "$opt_value" ] &&
    die -h "'$opt_name' requires a value"
  echo "$opt_value"
}

has_cmd() {
  command -v "$1" > /dev/null 2>&1
}

need_cmd() {
  has_cmd "$1" || die "command '$1' is required"
}

path_clean() {
  # remove redundant slashes
  [ -z "$1" ] && die "missing operand"
  local out root _ifs
  [ "${1#/}" != "$1" ] && root="/"
  _ifs=$IFS; IFS='/'; set -- $1; IFS=$_ifs
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
    "") echo "/";;
    "$path") echo ".";;
    *) echo "$out";;
  esac
}

path_base() {
  local path="$(path_clean "$1")"
  local out="${path##*/}"
  case "$out" in
    "") echo "/";;
    *) echo "$out";;
  esac
}

path_abs() {
  local path="$(path_clean "$1")"
  case "$path" in
    /*) echo "$path";;
    *) echo "$(pwd)/$path";;
  esac
}

check_installed() {
  [ -z "$1" ] && die "missing operand"
  if [ -d "$1" ]; then
    log warning "$1 exists, skip download"
    log info "To reinstall, remove $1 first"
    exit 0
  fi
}


get_platform() {
  local os arch
  os=$(uname -s | tr '[:upper:]' '[:lower:]')
  arch=$(uname -m)

  case "$arch" in
    x86_64|amd64) arch="amd64";;
  esac

  echo "$os-$arch"
}

