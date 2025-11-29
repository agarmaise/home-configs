export EDITOR=vim

alias todo="todo.sh"
alias xvim="xargs -o vim"

awkp() {
  awk -v i=$1 '{ print (i == "NF" ? $NF : $i) }'
}

alias git_main_branch="echo -n main"
alias git_develop_branch="echo -n dev"

alias gitbv="git branch -vv"
alias gitcg="git checkout --guess"
alias gitd="git diff $(git_main_branch) --merge-base --name-only"
alias gitf="git status -s | sed s/...//"
alias gitfr='gitf | awk '\''{ print ($3 == "") ? $1 : $3; }'\'
alias gitmi="git for-each-ref refs/heads --exclude='**/$(git_main_branch)' --format='%(authorname)%09%(refname:short)' | grep -i avery | awk -F\t '{ print \$2 }'"
alias gitmm="git checkout $(git_main_branch) && git pull && git checkout - && git merge $(git_main_branch) --no-edit"
alias gitnm="git for-each-ref refs/heads --exclude='**/$(git_main_branch)' --format='%(authorname)%09%(refname)' | grep -iv avery | grep -oP '(?<=refs/heads/)(.*)'"
alias gitr="git hash-object -t tree /dev/null"
alias gitrb="git checkout $(git_main_branch) && git pull && git checkout - && git rebase $(git_main_branch)"
alias gitrba="git checkout $(git_main_branch) && git pull && gitmi | xargs -i sh -c 'git checkout {} && git rebase $(git_main_branch)'"

gitcb () {
  git remote update origin --prune > /dev/null 2>&1
  gone_branches=($(git branch -vv | grep ': gone]' | awk '{ print $1 }'))

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

gitum () {
    git checkout $(git_develop_branch) && git push && git checkout $(git_main_branch) && git merge $(git_develop_branch) && git push && git checkout $(git_develop_branch)
}
