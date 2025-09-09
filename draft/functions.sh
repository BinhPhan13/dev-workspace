detect_platform() {
  local os arch
  os=$(uname -s | tr '[:upper:]' '[:lower:]')
  arch=$(uname -m)

  case "$arch" in
    x86_64|amd64) arch="amd64";;
  esac

  echo "$os-$arch"
}

command_exists() {
  command -v "$1" > /dev/null 2>&1
}


log() {
  local prefix red green yellow blue nc
  red='\033[0;31m'
  green='\033[0;32m'
  yellow='\033[1;33m'
  blue='\033[0;34m'
  nc='\033[0m'

  case "$1" in
    info) prefix="$blue[INFO]";;
    success) prefix="$green[SUCCESS]";;
    warning) prefix="$yellow[WARNING]";;
    error) prefix="$red[ERROR]";;
    *)
      log info "Usage: log <level> <message>"
      log info "level: info, success, warning, error"
      return 0;;
  esac

  printf "$prefix $2$nc\n"
}


download() {
  url="$1"
  out="$2"
  if [ -z "$url" ]; then
    log info "Usage: download <url> [outfile]"
    return 1
  fi

  if command_exists axel; then
    cmd="axel -cn5"
    [ -n "$out" ] && cmd="$cmd -o '$out'"
  elif command_exists curl; then
    cmd="curl -fLC -"
    [ -n "$out" ] && cmd="$cmd -o '$out'" || cmd="$cmd -O"
  else
    log error "no supported download tool (axel, curl) found!"
    return 1
  fi

  sh -c "$cmd '$url'"
}

