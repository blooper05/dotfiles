.PHONY: deploy init clean

DOTFILES := config gem/credentials local/bin mackup.cfg ssh zshrc

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

init:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install rcmdnk/file/brew-file
	brew file install
	mackup restore

clean:
	@-$(foreach val,$(DOTFILES), rm -rfv $(HOME)/.$(val);)
