.PHONY: deploy init clean

DOTFILES := config local/bin mackup.cfg zshrc

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

init:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle --file $HOME/.local/share/ghq/github.com/blooper05/dotfiles/Brewfile
	mackup restore

clean:
	@-$(foreach val,$(DOTFILES), rm -rfv $(HOME)/.$(val);)
