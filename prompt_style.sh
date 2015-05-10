#!/usr/bin/env bash

# This improved version of the prompt shows the return value of the last command,
# what time the command was run, the git branch name and status if in a repo folder
# and the working directory as usual.
# Source the ANSI color codes before sourcing this file, otherwise it won't work.

get_git_branch() {
    local branch

    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
        if [[ "$branch" == "HEAD" ]]; then
            branch='detached*'
        fi
    else
        # Not in a git repository. Show nothing.
        echo ''
        return
    fi
    echo "$branch"
}

get_git_status() {

    if [[ "$(git status --porcelain 2> /dev/null)" != "" ]]; then
        echo "*"
    else
        echo ""
    fi
}

get_return_code() {
    if [ $1 -eq 0 ]; then
        echo "$FGRN$1"
    else
        echo "$FRED$1"
    fi
}

set_bash_prompt() {
    # Grab the return code of the last ran command.
    local ret_code=$?
    local git_branch
    local git_status
    # Run each part of the code in parallel.
    exec 5< <(get_git_status)
    exec 4< <(get_git_branch)
    exec 3< <(get_return_code $ret_code)
    read -r <&3 ret_code
    read -r <&4 git_branch
    read -r <&5 git_status
    if [ "$git_branch" != "" ]; then
        if [ "$git_status" == "*" ]; then
            git_status="$FRED($git_branch *) "
        else
            git_status="$FGRN($git_branch) "
        fi
    else
        if [ "$git_status" == "*" ];then
            git_status="$FRED(Initial commit) "
        fi
    fi
    PS1="$HC- {$ret_code $FYEL\t $FWHT$git_status$FCYN\w$FWHT} \n$FCYN\$$RS "
}

# Only set PROMPT_COMMAND once.
if [ "$PROMPT_COMMAND" == "" ];then
    PROMPT_COMMAND="set_bash_prompt;$PROMPT_COMMAND"
fi
