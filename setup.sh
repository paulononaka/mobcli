#!/bin/bash

# Exit on error
set -e

setColors() {

    # Use colors, but only if connected to a terminal, and that terminal supports them.
    if which tput >/dev/null 2>&1; then
        ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        NORMAL="$(tput sgr0)"
    else
        RED=""
        GREEN=""
        YELLOW=""
        NORMAL=""
    fi
}

checkRubyInstalled() {

    ruby_version="$(ruby --version)"

    if ! [[ $ruby_version =~ .*2.6.0.* ]]; then
        printf "\n%s*** I have being built over Ruby 2.6.0 but it's not installed. Can't make sure I work on other versions :). ***%s\n\n" "$RED" "$NORMAL"
        read -srp "Press any key to start..." -n1 -s
    fi
}

makeScriptAvailableAnywhere() {

    ln -sf `pwd`/mobcli.rb /usr/local/bin/mobcli
}

installDependencies() {

    bundle install
}

successful() {

    printf "\n%sMobcli successfully setup.%s\n" "$GREEN" "$NORMAL"

    printf "\n%sMake sure you run mobcli build-android in a Gradle multi-project folder.\n\n" "$YELLOW"
}

setColors
checkRubyInstalled
makeScriptAvailableAnywhere
installDependencies
successful
