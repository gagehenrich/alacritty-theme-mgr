
PREFIX ?= /usr

POWERSHELL_CMD	= "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"

.PHONY: config install

OS = $(shell uname -r | grep -qiE 'wsl|microsoft' && echo "wsl" \
|| echo "$$(awk -F= '/ID_LIKE/ { print $$2 }' /etc/os-release)")

config:
	-@if [ "$(OS)" == "wsl" ] ; then \
	    home_dir=$$( \
			$(POWERSHELL_CMD) "ls \$$HOME" | awk -F\\ ' \
			/Directory/ { \
				print "/mnt/c/Users/" $$NF \
			}' | sed 's/\r//g' \
			); \
		alacritty_dir="$$home_dir/AppData/Roaming/alacritty"; \
		mkdir -p "$$alacritty_dir"; \
	else \
		alacritty_dir="$$HOME/.config/alacritty"; \
	fi; \
	mkdir -p "$$HOME/.config/alacritty"; \
	conf_file="$${alacritty_dir}/alacritty.toml"; \
	if [ -f "$$conf_file" ] ; then \
		cp "$$conf_file" "$${conf_file}.bak"; \
	fi; \
	cp -rf ./alacritty.toml ./themes "$${alacritty_dir}"; \
	cp ./.autocomplete.sh "$$HOME/.config/alacritty/"; \
	sed "s|%PLACEHOLDER%|$${alacritty_dir}|g" ./theme.sh > theme; \
	sed -i "s|%PLACEHOLDER%|$${alacritty_dir}|g" "$$HOME/.config/alacritty/.autocomplete.sh"; \
	echo source "$$HOME/.config/alacritty/.autocomplete.sh" | sudo tee -a $$HOME/.bashrc

install: config
	@sudo install -Dm755 theme $(PREFIX)/bin/theme
	@rm ./theme

uninstall:
	@sudo rm -f $(PREFIX)/bin/theme
