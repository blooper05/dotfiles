.PHONY: deploy init clean

DOTFILES := config local/bin mackup mackup.cfg zshenv

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

init:
	"$$HOME/.local/bin/init-macos"
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	/opt/homebrew/bin/brew bundle --file="$$HOME/.config/homebrew/Brewfile"
	mackup restore
	cut -d ' ' -f 1 "$$HOME/.config/asdf/tool-versions" | while read plugin; do asdf plugin-add "$${plugin}"; done
	asdf install
	mkdir -p "$$HOME/.local/share/zsh"
	mkdir -p "$$HOME/.local/state/zsh"
	rm -rf "$$HOME/.zcompcache" "$$HOME/.zsh_history" "$$HOME/.zsh_sessions"

clean:
	@-$(foreach val, $(DOTFILES), rm -rfv $(HOME)/.$(val);)
