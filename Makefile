.PHONY: deploy init clean

DOTFILES := config gem/credentials local/bin mackup.cfg ssh zshrc

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

init:
	curl -fsSL https://raw.github.com/rcmdnk/homebrew-file/install/install.sh | sh
	brew file install
	brew uninstall --ignore-dependencies node
	mackup restore

clean:
	@-$(foreach val,$(DOTFILES), rm -rfv $(HOME)/.$(val);)
