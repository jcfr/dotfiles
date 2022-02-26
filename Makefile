
.PHONY: all
all: bin dotdirs dotfiles etc

.PHONY: usr-local-bin
usr-local-bin:
	# add symlinks for bin available for all users
	for file in $(shell find $(CURDIR)/usr/local/bin -type f -not -name "*-backlight" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		echo "[bin] /usr/local/bin/$$f"; \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done

.PHONY: bin
bin: usr-local-bin
	# add symlinks for bin private to user
	mkdir -p $(HOME)/bin
	for file in $(shell find $(CURDIR)/bin -type f -not -name "*-backlight" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		echo "[bin] $(HOME)/bin/$$f"; \
		ln -sf $$file $(HOME)/bin/$$f; \
	done

.PHONY: generate_bash_aliases_ssh
generate_bash_aliases_ssh:
	$(CURDIR)/generate_bash_aliases_ssh.sh

.PHONY: dotfiles
dotfiles: generate_bash_aliases_ssh
	# add symlinks for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".config" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp" -not -name ".irssi" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		echo "[dotfile] $(HOME)/$$f"; \
		ln -sfn $$file $(HOME)/$$f; \
	done;

.PHONY: dotdirs
dotdirs:
	for file in $(shell find ".config/" -type f -not -name ".*.swp" -not -path "*/.git*"); do \
		f=$$file; \
		mkdir -p $$(dirname $(HOME)/$$f); \
		echo "[dotdir] $(HOME)/$$f <- $(CURDIR)/$$f"; \
		ln -sfn $(CURDIR)/$$f $(HOME)/$$f; \
	done;

.PHONY: etc
etc:
	# add symlinks for etc
	# Note (jc): since hard-link can't be created between filesystem (home and system are different partition)
	#            let's use symbolic link
	for file in $(shell find $(CURDIR)/etc -type f -not -name ".*.swp"); do \
		f=$$(echo $$file | sed -e 's|$(CURDIR)||'); \
		echo "[etc] $$f"; \
		sudo ln -sfn $$file $$f; \
	done;
	systemctl --user daemon-reload || true
	sudo systemctl daemon-reload

.PHONY: test
test: shellcheck

.PHONY: shellcheck
shellcheck:
	docker run --rm -it \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh

