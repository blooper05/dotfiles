.PHONY: deploy init clean

DOTFILES := config local/bin zshenv

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

init:
	@local/bin/init-macos
	@local/bin/init-homebrew
	@local/bin/init-mackup
	@local/bin/init-zsh
	@local/bin/init-mise
	@local/bin/init-nvim

clean:
	@-$(foreach val, $(DOTFILES), rm -rfv $(HOME)/.$(val);)
