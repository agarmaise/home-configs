# ~/.bash_aliases

# Edit/load
alias vz="vim ~/.bash_aliases"
alias sz="source ~/.bash_aliases"

# Piping
alias xvim="xargs -o vim"

awkp() { awk -v i=$1 '{ print (i == "NF" ? $NF : $i) }'; }

shh() { "$@" &> /dev/null; }

tlog () {
  tlog_output=~/logs/$1-$(date +%s%3N).log
  tee $tlog_output
}

xsi() { xargs sed -i "$@"; }

# Fix up last command
ins() {
  last_cmd=(${=$(fc -ln -1)})
  n=$1
  words=${@:2}
  new_cmd=("${last_cmd[@]:0:$n}" "$words" "${last_cmd[@]:$n}")

  read -s -k 1 "input?$new_cmd"

  if [[ $input == $'\e' ]]; then
    should_execute=1
    next_cmd=$last_cmd
  else
    should_execute=0
    next_cmd=${new_cmd[*]}
    if [[ $input != $'\n' ]]; then
      echo -n $input
      next_cmd+=$input
      read input
      next_cmd+=$input
    else
      echo
    fi
  fi

  print -s $next_cmd

  if [[ $should_execute -eq 0 ]]; then
    eval $next_cmd
  fi
}

# Git
alias git_develop_branch="echo dev"
alias git_main_branch="echo main"

alias cljs="git clean -fdx --exclude node_modules -- '*.js'"
alias clorig="git clean -fdx --exclude node_modules -- '*.orig'"

alias gitbv="git branch -vv"
alias gitcg="git checkout --guess"
alias gitf="git status -s | sed s/...//"
alias gitfr='gitf | awk '\''{ print ($3 == "") ? $1 : $3; }'\'
alias gitgr="git grep --recurse-submodules"
alias gitr="git hash-object -t tree /dev/null"

gitd() { git diff $(git_main_branch) --merge-base --name-only; }
gitmi() { git for-each-ref refs/heads --exclude='**/$(git_main_branch)' --format='%(authorname)%09%(refname:short)' | grep -i avery | awk -F\t '{ print $2 }'; }
gitmm() { git checkout $(git_main_branch) && git pull && git checkout - && git merge $(git_main_branch) --no-edit; }
gitnm() { git for-each-ref refs/heads --exclude='**/$(git_main_branch)' --format='%(authorname)%09%(refname)' | grep -iv avery | grep -oP '(?<=refs/heads/)(.*)'; }
gitrb() { git checkout $(git_main_branch) && git pull && git checkout - && git rebase $(git_main_branch); }
gitrba() { git checkout $(git_main_branch) && git pull && gitmi | xargs -i sh -c 'git checkout {} && git rebase $(git_main_branch)'; }
gitum () { git checkout $(git_develop_branch) && git push && git checkout $(git_main_branch) && git merge $(git_develop_branch) && git push && git checkout $(git_develop_branch); }

gitcb () {
  git remote update origin --prune > /dev/null 2>&1
  mapfile -t gone_branches <(git branch -vv | grep ': gone]' | awk '{ print $1 }')

  if [ ${#gone_branches[@]} -gt 0 ]; then
    echo 'Branches to be deleted:'
    printf '%s\n' "${gone_branches[@]}"
    read 'response?'$'\n''Remove branches? (y/n) '
    if [[ "$response" =~ ^[yY]$ ]]; then
      printf '%s\n' "${gone_branches[@]}" | xargs -r git branch -D
    else
      echo 'Goodbye'
    fi
  else
    echo 'No branches deleted on remote'
  fi
}

# Jest
alias spec="sed -r -e 's/^([^.]*)(\.spec)?(\.\w+)$/\1.spec\3/' | sort | uniq | paste -sd\| - | sed -r -e 's/^|$/'\''/g'"
alias tspec="sed -r -e 's/^([^.]*)(\.spec)?(\.\w+)$/\1\3\n\1.spec\3/' | sort | uniq | paste -sd\| - | sed -r -e 's/^|$/'\''/g'"

alias jtest="xargs yarn test --noStackTrace --"
alias jtestcov="xargs -I{} yarn test --noStackTrace --coverage --collectCoverageFrom={} -- {}"

jtestcovf () { yarn test --noStackTrace --coverage --collectCoverageFrom="$1"'/**/*' -- "$1"; }

# Todo
alias todo="todo.sh"

_todo() {
  source .todo.cfg
  local projects=$(grep -oP '[+@]\S+' $TODO_FILE | sort -u | tr '\n' ' ')
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W $projects -- $cur) )
}

complete -F _todo todo
