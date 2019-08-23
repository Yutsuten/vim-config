all: links

links: link_bash link_git link_tmux link_nvim link_lint
	@echo 'Done.'

link_bash:
	@echo '## Bash links'
	$(eval LINE='source $(CURDIR)/bash/mylibrary.sh')
	grep -qF -- ${LINE} ~/.bashrc || echo ${LINE} >> ~/.bashrc
	$(eval LINE='source $(CURDIR)/bash/bash.sh')
	grep -qF -- ${LINE} ~/.bashrc || echo ${LINE} >> ~/.bashrc
	ln -sf $(CURDIR)/bash/dircolors-solarized/dircolors.ansi-dark ~/.dircolors

link_git:
	@echo '## Git links'
	ln -sf $(CURDIR)/git/global.gitignore ~/.gitignore
	git config --global core.excludesfile ~/.gitignore

link_tmux:
	@echo '## Tmux links'
	ln -snf $(CURDIR)/tmux ~/.tmux
	ln -sf ~/.tmux/tmux.conf ~/.tmux.conf

link_nvim:
	@echo '## Neovim links'
	mkdir -p ~/.config/nvim
	rm -rf ~/.config/nvim/init.vim
	ln -sf $(CURDIR)/nvim/init.vim ~/.config/nvim/init.vim
	mkdir -p ~/.local/share/nvim/site/pack/plugins
	ln -snf $(CURDIR)/nvim/plugins ~/.local/share/nvim/site/pack/plugins/start

link_lint:
	@echo '## Lint links'
	mkdir -p ~/.config
	ln -sf $(CURDIR)/lint/flake8 ~/.config/flake8
	ln -sf $(CURDIR)/lint/pylint ~/.config/pylintrc
	ln -sf $(CURDIR)/lint/jshint.json ~/.jshintrc
