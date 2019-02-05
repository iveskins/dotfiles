# Makefile for dotfile configs
.PHONY: all config clean requirements reset


all: clean config

build_vimplug:
	echo 'install vim-plug'
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

build_zplug:
	echo 'install zplug'
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | \
		ZPLUG_HOME=$(HOME)/.config/zplug zsh

config: build_vimplug build_zplug
	echo 'mkdir'
	mkdir -p $(HOME)/.config/nvim
	echo 'create symbolic links...'
	ln -s $(HOME)/.dotfiles/config/config.vim $(HOME)/.vimrc
	ln -s $(HOME)/.dotfiles/config/config.zsh $(HOME)/.zshrc
	ln -s $(HOME)/.dotfiles/config/config.tmux $(HOME)/.tmux.conf
	ln -s $(HOME)/.dotfiles/config/confign.vim $(HOME)/.config/nvim/init.vim
	echo 'done'

clean:
	rm -f $(HOME)/.vimrc
	rm -f $(HOME)/.zshrc
	rm -f $(HOME)/.bashrc
	rm -f $(HOME)/.tmux.conf
	rm -f $(HOME)/.latexmkrc
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.config/zplug

# if you have installed linuxbrew or homebrew,
# you can use this target
requirements:
	brew bundle --file=package/Brewfile
