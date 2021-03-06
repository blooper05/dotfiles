.PHONY: deploy init clean

DOTFILES := config local/bin mackup mackup.cfg zshrc

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

init:
	"$$HOME/.local/bin/macos-defaults"
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle --file "$$HOME/.local/share/ghq/github.com/blooper05/dotfiles/config/homebrew/Brewfile"
	compaudit | xargs sudo chmod g-w
	mkdir -p "$$HOME/.local/share/zsh"
	rm -rf "$$HOME/.zcompcache" "$$HOME/.zsh_history" "$$HOME/.zsh_sessions"
	mackup restore

clean:
	@-$(foreach val, $(DOTFILES), rm -rfv $(HOME)/.$(val);)
