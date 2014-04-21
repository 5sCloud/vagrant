#/bin/bash

function get_apt_installed_version() {
  if [ "x"$1 == "x" ] ; then
    echo "(none)"
    return 0;
  fi

  local __version=$(apt-cache -q policy $1 | awk '/Installed/    { printf("%s", $2) }')
  echo "$__version"
}

function get_apt_latest_version() {
  if [ "x"$1 == "x" ] ; then
    echo "(none)"
    return 0;
  fi

  local __version=$(apt-cache -q policy $1 | awk '/Candidate/    { printf("%s", $2) }')
  echo "$__version"
}

function check_none_version()
{
  if [ $1 == "(none)" -o $2 == "(none)" ] ; then
    return 1
  fi
  return 0
}

function version_eq()
{
  check_none_version "$1" "$2" && dpkg --compare-versions "$1" eq "$2"
  return $?
}

function version_ge()
{
  check_none_version "$1" "$2" && dpkg --compare-versions "$1" ge "$2"
  return $?
}

CHECK_INSTALLED=0
CHECK_LATEST=0
OPTIONS="-q -y -o DPkg::Options::=--force-confold -o DPkg::Options::=--force-confdef"
APT=apt-get

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "Help $0"
      exit 0
      ;;
    --installed)
      CHECK_INSTALLED=1
      shift
      ;;
    --latest)
      CHECK_LATEST=1
      shift
      ;;
    -o|--option)
      shift
      if test $# -gt 0; then
        export OPTIONS="$OPTIONS $1"
      else
        echo "no options specified"
        exit 1
      fi
      shift
      ;;
     *)
      break;
      ;;
  esac
done

PACKAGE=$1
INSTALLED=$(get_apt_installed_version $PACKAGE)
LATEST=$(get_apt_latest_version $PACKAGE)

function print_changed() {
  echo "package=$PACKAGE installed_version=$2 changed=$1"
}

function call_apt() {
  DEBIAN_FRONTEND=noninteractive $APT $OPTIONS install $PACKAGE > /dev/null 2>&1 && print_changed "true" $(get_apt_installed_version $PACKAGE)
}

if [ $CHECK_INSTALLED == 1 ] ; then
  if [ $INSTALLED == "(none)" ] ; then
    call_apt
    exit
  fi
fi

if [ $CHECK_LATEST == 1 ] ; then
  version_ge $INSTALLED $LATEST
  if [ $? != 0 ] ; then
    call_apt
    exit
  fi
fi

print_changed "false" $INSTALLED
