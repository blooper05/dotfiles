.PHONY: deploy init

DOTFILES      := config local/bin mackup.cfg zshrc
XDG_DATA_HOME := ${HOME}/.local/share

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

init:
	mkdir -p $(XDG_DATA_HOME)/less
	mkdir -p $(XDG_DATA_HOME)/pry
	mkdir -p $(XDG_DATA_HOME)/zsh
	curl -fsSL https://raw.github.com/rcmdnk/homebrew-file/install/install.sh | sh
	brew file install
	brew uninstall --ignore-dependencies node
	mackup restore

clean:
	@-$(foreach val,$(DOTFILES), rm -rfv $(HOME)/.$(val);)
