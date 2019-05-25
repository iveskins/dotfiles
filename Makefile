# Makefile for dotfile configs
ZPLUG_HOME := $(HOME)/.config/zplug
TERM       := screen-256color
UNAME_S    := $(shell uname -s)
BREW       := $(shell which brew 2> /dev/null)
RED        := $(shell tput setaf 1)
NOCOLOR    := $(shell tput sgr0)

ifeq ($(UNAME_S),Darwin)
	BREW_COMPILER := /usr/bin/ruby -e
	BREW_SOURCE := https://raw.githubusercontent.com/Homebrew/install/master/install
else
	BREW_COMPILER := sh -c
	BREW_SOURCE := https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh
endif

ifeq ($(BREW),)
	BREW_COMMAND := yes ' '| $(BREW_COMPILER) "$$(curl -fsSL $(BREW_SOURCE))"
endif

.PHONY: all mkdir plugins link clean done \
	build_brew brew_bundle_tiny brew_bundle_tiny

all: clean mkdir plugins link done

mkdir:
	@echo 'mkdir for config.d'
	mkdir -p $(HOME)/.config/nvim

plugins:
	@echo 'download plugins'
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	git clone https://github.com/zplug/zplug $(ZPLUG_HOME)

link:
	@echo 'create symbolic links...'
	ln -s $(PWD)/vim/config.d/vimrc $(HOME)/.vimrc
	ln -s $(PWD)/nvim/config.d/init.vim $(HOME)/.config/nvim/init.vim
	ln -s $(PWD)/zsh/config.d/zshrc $(HOME)/.zshrc
	ln -s $(PWD)/tmux/config.d/tmux.conf $(HOME)/.tmux.conf

done:
	@echo ""
	@echo "### Finish installing dotfiles!"
	@echo "Please run $(RED)source $HOME/.zshrc$(NOCOLOR) on zsh to enable configures."
	@echo "- If you want to use neovim with extensions,"
	@echo "  please run $(RED)make requirements$(NOCOLOR) (which needs pyenv)."
	@echo " If you want to install pyenv using brew, please read the Python section below."
	@echo ""
	@echo "---"
	@echo ""
	@echo "### Packages"
	@echo "- If you want to use linuxbrew/homebrew,"
	@echo "  please run $(RED)make brew_bundle$(NOCOLOR)."
	@echo "  Please run $(RED)make build_brew$(NOCOLOR) before"
	@echo "  if you have not installed brew yet"
	@echo ""
	@echo "---"
	@echo "### Python"
	@echo "- After $(RED)make build_brew, make brew_bundle, source $HOME/.zshrc$(NOCOLOR)"
	@echo "  you can run $(RED)make requirements$(NOCOLOR) to install Python and the neovim library"
	@echo ""

clean:
	@echo 'remove symbolic links'
	rm -f $(HOME)/.vimrc
	rm -f $(HOME)/.zshrc
	rm -f $(HOME)/.tmux.conf
	rm -f $(HOME)/.latexmkrc
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.config/zplug
	@echo 'done'

requirements:
	$(PWD)/nvim/bin/setup.sh

build_brew:
	$(BREW_COMMAND)

brew_bundle:
	brew bundle --file=package/Brewfile
