# Makefile for dotfile configs

.PHONY: all config clean requirements build_essential build_zplug build_vimplug

all: clean config link build_zplug build_vimplug
bootstrap: build_essential requirements

build_vimplug:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim -u $(PWD)/config/confign.tiny.vim +PlugInstall +qall
	nvim -u $(PWD)/config/confign.vim +UpdateRemotePlugins +qall

build_zplug:
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | \
		ZPLUG_HOME=$(HOME)/.config/zplug TERM=screen-256color zsh

link:
	@echo 'mkdir for config.d'
	mkdir -p $(HOME)/.config/nvim
	@echo 'create symbolic links...'
	ln -s $(PWD)/config/config.vim $(HOME)/.vimrc
	ln -s $(PWD)/config/config.zsh $(HOME)/.zshrc
	ln -s $(PWD)/config/config.tmux $(HOME)/.tmux.conf
	ln -s $(PWD)/config/confign.vim $(HOME)/.config/nvim/init.vim
	@echo 'done'

clean:
	@echo 'remove symbolic links'
	rm -f $(HOME)/.vimrc
	rm -f $(HOME)/.zshrc
	rm -f $(HOME)/.bashrc
	rm -f $(HOME)/.tmux.conf
	rm -f $(HOME)/.latexmkrc
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.config/zplug
	@echo 'done'

build_essential:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# if you have installed linuxbrew or homebrew,
# you can use this target
requirements: build_essential
	brew bundle --file=package/Brewfile
