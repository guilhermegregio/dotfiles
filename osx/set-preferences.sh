#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -a PROCESSES_TO_TERMINATE=(
        "SystemUIServer"
        "cfprefsd"
    )

    ./preferences/dashboard.sh
    ./preferences/dock.sh
    ./preferences/finder.sh
    ./preferences/keyboard.sh
    ./preferences/ui-and-ux.sh

    for i in ${PROCESSES_TO_TERMINATE[*]}; do
        killall "$i" &> /dev/null
    done

}

main
