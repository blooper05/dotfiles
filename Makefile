.PHONY: deploy init clean

DOTFILES := config local/bin mackup mackup.cfg zshenv

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

init:
	"$$HOME/.local/bin/init-macos"
	"$$HOME/.local/bin/init-homebrew"
	"$$HOME/.local/bin/init-mackup"
	"$$HOME/.local/bin/init-asdf"
	mkdir -p "$$HOME/.local/share/zsh"
	mkdir -p "$$HOME/.local/state/zsh"
	rm -rf "$$HOME/.zcompcache" "$$HOME/.zsh_history" "$$HOME/.zsh_sessions"

clean:
	@-$(foreach val, $(DOTFILES), rm -rfv $(HOME)/.$(val);)
