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

separator() {
    echo -n "\r"
    if [ $1 -eq 0 ]; then
        echo -n "$FGRN"
    else
        echo -n "$FRED"
    fi
    for i in $(seq 1 $COLUMNS); do
        echo -n "-"
    done
    echo -n "$RS"
}

set_bash_prompt() {
    # Grab the return code of the last ran command.
    local ret_code="$?"
    local git_branch
    local git_status
    # Run each part of the code in parallel.
    exec 5< <(get_git_status)
    exec 4< <(get_git_branch)
    read -r <&5 git_status
    read -r <&4 git_branch
    if [ "${git_branch}" != "" ]; then
        if [ "$git_status" == "*" ]; then
            git_status="($git_branch *) "
        else
            git_status="($git_branch) "
        fi
    else
        git_status=""
    fi

    # Build the prompt.
    local separator
    local user_host
    local prompt_date
    local working_dir
    separator="$(separator $ret_code)"
    user_host="$USER@$HOSTNAME"
    prompt_date="\D{%F %T}"
    working_dir="\w"
    prompt_char="$RS$HC$FCYN$"

    PS1="$separator$HC$FBLK$user_host $prompt_date $git_status\n[$working_dir]\n$prompt_char$RS "
}

# Only set PROMPT_COMMAND once.
if [ "$PROMPT_COMMAND" == "" ];then
    PROMPT_COMMAND="set_bash_prompt;$PROMPT_COMMAND"
fi
