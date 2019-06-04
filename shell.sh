#!/usr/bin/env bash
# use /usr/bin/env bash instead of /bin/bash
# because some folks use BSD

# use set -e instead of #!/bin/bash -e in case we're
# called with `bash ~/bin/scriptname`
set -e # bail out early if any command fails
set -u # fail if we hit unset variables
set -o pipefail # fail if any component of any pipe fails

# Usually our workspace is in ~/workspace -- but not on
# all on-call machines.
: "${WORKSPACE:="$HOME/workspace"}"
# this is equivalent to:
# WORKSPACE="${WORKSPACE:-"$HOME/workspace"}"
# which means the user can override the WORKSPACE variable, but if they don't,
# it'll be set to $HOME/workspace by default
#
# To understad how it works, type:
#   `help :`
#   `info "(bash.info)Shell Parameter Expansion"`

# set env var DEBUG to 1 to enable debugging
[[ -z "${DEBUG:-""}" ]] || set -x

# print out usage when something goes wrong
usage() {
  echo "usage: $0 blabla"
}

main() {
  if [[ "$#" -eq 0 ]]
  then
    # If the user calls with the wrong number of arguments,
    # print verbose help
    fail "$(usage)"
  fi

  echo "add your main here"
}

somefunction() {
  # If a programmer calls with the wrong number of arguments
  # print terser help
  local my_param="${1:?"Expected myparam in call to somefunction"}"
  local my_other_param="${2:-"a handy default"}"

  echo "My first parameter was definitely $my_param,"
  echo "while my second may have defaulted to $my_other_param."
}

fail() {
  MESSAGE="$1"
  echo "$MESSAGE" >&2
  exit 1
}

main "$@"
