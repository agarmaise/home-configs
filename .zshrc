export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys-avery" # set by `omz`
plugins=(git aliases alias-finder)
source $ZSH/oh-my-zsh.sh

zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

export EDITOR=vim
export MSYS=winsymlinks:nativestrict
export DISABLE_AUTO_TITLE=true
export LESS='-RFX'

alias vz="vim ~/.zshrc"
alias sz="source ~/.zshrc"

alias ghopen="start \`git remote -v | grep fetch | sed -r 's/.*git@(.*):(.*)\.git.*/http:\/\/\1\/\2/' | head -n1\`"
alias chrome-dev="open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir='/tmp/chrome_dev_test' --disable-web-security"

alias gitf="git status -s | sed s/...//"
alias gitfr='gitf | awk '\''{ print ($3 == "") ? $1 : $3; }'\'
alias gitd="git diff $(git_main_branch) --merge-base --name-only"
alias clorig="git clean -fdx --exclude node_modules -- '*.orig'"
alias gitnm="git for-each-ref refs/heads --exclude='**/$(git_main_branch)' --format='%(authorname)%09%09%(refname)' | grep -iv avery | grep -oP '(?<=refs/heads/)(.*)'"
alias gitbv="git branch -vv"
alias gitr="git hash-object -t tree /dev/null"
gitum () {
    git checkout $(git_develop_branch) && git push && git checkout $(git_main_branch) && git merge $(git_develop_branch) && git push && git checkout $(git_develop_branch)
}

alias tspec="sed -r -e 's/^([^.]*)(\.spec)?(\.\w+)$/\1\3\n\1.spec\3/' | sort | uniq | paste -sd\| - | sed -r -e 's/^|$/'\''/g'"
alias spec="sed -r -e 's/^([^.]*)(\.spec)?(\.\w+)$/\1.spec\3/' | sort | uniq | paste -sd\| - | sed -r -e 's/^|$/'\''/g'"

alias jtest="xargs yarn test --colors --noStackTrace --"
alias jtestcov="xargs -I{} yarn test --noStackTrace --coverage --collectCoverageFrom={} -- {}"
alias jtesta="yarn test --colors --noStackTrace -- app/services/assets"

alias gitmm="git checkout $(git_main_branch) && git pull && git checkout - && git merge $(git_main_branch) --no-edit"
alias gitrb="git checkout $(git_main_branch) && git pull && git checkout - && git rebase $(git_main_branch)"

gitcb () {
	git remote update origin --prune > /dev/null 2>&1
    gone_branches=(${(f)"$(< <(git branch -vv | grep ': gone]' | awk '{ print $1 }'))"})

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
