PACKAGES := nvim wezterm lspmux git

STOW := stow --verbose --target=$(HOME)
.PHONY: all unstow $(PACKAGES)

all: $(PACKAGES)

$(PACKAGES):
	$(STOW) $@

unstow:
	stow -D --verbose --target=$(HOME) $(PACKAGES) 
