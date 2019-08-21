# DOTFILES

My collection of dotfiles.

You can install them with `make`:

```
% make
# OR
% make install
```

And use the `clean` rule to uninstall them:

```
% make clean
```

If you want to install only one set of dotfiles, for example `neovim`, run:

```
% make neovim
# To clean
% make clean_neovim
```

To see the configuration files that will be installed you can run `list`:

```
% make list
```

## Makefile

If you check the `Makefile` you'll see that it's quite small. In fact, there is no rules to install anything. The trick is in this line:

```make
include **/*.mk
```

What the `Makefile` is doing here is searching for any `.mk` file in the directories' tree and if it finds one it includes all of the file's rules.

The dotfiles for each app/module are in their own directory (e.g: `neovim` or `zsh`), and inside those directories there is a `.mk` file (e.g: `neovim.mk` or `zsh.mk`).

Each of these `.mk` files is a new `Makefile` with the rules to install that module. In order to make these `.mk` files to work with the main `Makefile`, they need to be created with a structure. This could be a template for a new module:

```make
MODULE := $(shell command -v module 2>/dev/null)

ifdef MODULE
INSTALLERS += module
CLEANERS   += clean_module

MODULE_SRC_DIR := $(DOTFILES)/module
MODULE_DST_DIR := $(CONFIG_DIR)/module

.PHONY: module clean_module

module: banner_install_module

clean_module: banner_clean_module

else
IGNORED += module

endif
```

The most importan part of this file is when we append values to `INSTALLERS`, `CLEANERS` and `IGNORED` variables. These variables are the main registries of rules for installation and cleaning. They are used by the main `Makefile` to know what rules it should call when running the `install`, `clean` and `list` rules.

The `banner_install_%` and `banner_clean_%` rules are a way to show when a module starts its installation and cleaning rules. Add them as the first prerequisite of your rules to use them.

The idea is to keep each set of dotfiles modular, so if you need to add or remove something it shouldn't affect other files or the main installation process.
