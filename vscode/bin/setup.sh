#!/bin/bash

echo 'Deploy settings'
LINK_FILE=settings.json

unlink ~/Library/Application\ Support/Code/User/settings.json &> /dev/null
ln -sf $PWD/vscode/config.d/settings.json ~/Library/Application\ Support/Code/User/settings.json

unlink ~/Library/Application\ Support/Code/User/keybindings.json &> /dev/null
ln -sf $PWD/vscode/config.d/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

unlink ~/Library/Application Support/Code/User/snippets &> /dev/null
ln -sf $PWD/vscode/snippet.d ~/Library/Application\ Support/Code/User/snippets

echo 'Install extensions'
EXTENSIONS=$(cat ./vscode/config.d/extensions.list)

for extension in ${EXTENSIONS[@]}; do \
  code --install-extension $extension; \
done
