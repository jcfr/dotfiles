.PHONY: all bin dotfiles etc test shellcheck

all: bin dotdirs dotfiles etc

bin:
	# add symlinks for things in bin
	for file in $(shell find $(CURDIR)/bin -type f -not -name "*-backlight" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		echo "[bin] /usr/local/bin/$$f"; \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done

generate_bash_aliases_ssh:
	$(CURDIR)/generate_bash_aliases_ssh.sh

dotfiles: generate_bash_aliases_ssh
	# add symlinks for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".config" -not -name ".vim" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp" -not -name ".irssi" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		echo "[dotfile] $(HOME)/$$f"; \
		ln -sfn $$file $(HOME)/$$f; \
	done;

dotdirs:
	for file in $(shell find ".config/" ".vim/" -type f -not -name ".*.swp" -not -path "*/.git*"); do \
		f=$$file; \
		mkdir -p $$(dirname $(HOME)/$$f); \
		echo "[dotdir] $(HOME)/$$f <- $(CURDIR)/$$f"; \
		ln -sfn $(CURDIR)/$$f $(HOME)/$$f; \
	done;

etc:
	# add symlinks for etc
	# Note (jc): since hard-link can't be created between filesystem (home and system are different partition)
	#            let's use symbolic link
	for file in $(shell find $(CURDIR)/etc -type f -not -name ".*.swp"); do \
		f=$$(echo $$file | sed -e 's|$(CURDIR)||'); \
		echo "[etc] $$f"; \
		sudo ln -sfn $$file $$f; \
	done;
	systemctl --user daemon-reload
	sudo systemctl daemon-reload

test: shellcheck

shellcheck:
	docker run --rm -it \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh

