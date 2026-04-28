# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Neovim configuration. There is no build, no test suite, no CI. "Running" the code means launching `nvim` and observing behavior. Validation is done from inside the editor via `:checkhealth`, `:Lazy`, `:Mason`, `:ConformInfo`, and `:LspInfo`.

`lazy-lock.json` is gitignored — it is regenerated locally and is not part of the committed config.

## Architecture

Entry point is `init.lua`, which:
1. Requires three flat config modules in order: `options` (vim.opt.\*), `keymaps` (leader is `<Space>`, also localleader), `workflow` (custom user commands like `:On` for dated Obsidian notes).
2. Bootstraps `lazy.nvim` if missing.
3. Loads every plugin spec from `lua/plugins/` by explicit `require 'plugins.<name>'` calls — there is no auto-discovery of the directory.

**Adding a plugin requires two edits**: create `lua/plugins/<name>.lua` returning a lazy.nvim spec table, *and* add `require 'plugins.<name>'` to the list inside `require('lazy').setup({...})` in `init.lua`. Forgetting the second step silently no-ops the new plugin.

Each file in `lua/plugins/` returns one lazy.nvim spec (a table or list of tables). Conventions in use:
- `config = function() ... end` for plugins needing custom setup.
- `opts = { ... }` for plugins where lazy.nvim should call `setup(opts)` automatically.
- `lazy = false` is used where load order matters (e.g. `treesitter`, `r-nvim`, `vimtex` — vimtex disables inverse-search if lazy-loaded).

### Tool installation surfaces (read these before installing tools manually)

- **LSP servers + standalone CLI tools** are installed by Mason via `lua/plugins/lsp.lua`. The `servers` table drives `mason-lspconfig`, and `mason-tool-installer` additionally installs anything appended to `ensure_installed` (currently `stylua`). Add new servers as keys of the `servers` table — they are auto-installed and auto-`setup`'d by the handler at the bottom of the file.
- **Treesitter parsers** are listed in `lua/plugins/treesitter.lua` under `ensure_installed`. `auto_install = true` is also on, so opening an unknown filetype will fetch its parser.
- **Formatters** are configured per-filetype in `lua/plugins/conform.lua` (`formatters_by_ft`). `format_on_save` is enabled with `lsp_format = 'fallback'`, except for `c`/`cpp` which are explicitly disabled. `<leader>f` formats manually.

### R.nvim auto-start is environment-gated

`lua/plugins/r-nvim.lua` only sets `auto_start = 'on startup'` and `objbr_auto_start = true` when the env var `R_AUTO_START=true` is set. Launching `nvim` normally will *not* start an R console — this is intentional. Set the env var when you want R workflows.

### Hard-coded user paths

Two places assume a specific filesystem layout and will silently break if the path doesn't exist:
- `lua/plugins/obsidian.lua` — workspace path `/home/suvar/ObsidianZotero/mark_obsidian`.
- `lua/workflow.lua` — `:On <name>` writes to `/home/suvar/ObsidianZotero/mark_obsidian/notes`.

If editing for portability, these are the spots to parameterize.

### Keymap conventions

- Leader and localleader are both `<Space>`. Spacebar is `<Nop>`'d in normal/visual to avoid conflicts.
- Window navigation `<C-h/j/k/l>` is bound by both `keymaps.lua` and `vim-tmux-navigator` (the tmux plugin overrides via its `keys = {...}`). When debugging window navigation, check both.
- Plugin keymap groups for which-key are declared in `lua/plugins/which-key.lua` under `spec`. Adding a new `<leader>X` group there gives it a label in the popup.

## Working in this repo

- Test changes by reloading nvim (`:source $MYVIMRC` is unreliable for plugin specs — restart the editor).
- After changing plugin specs, run `:Lazy sync` to apply.
- After adding LSP servers or treesitter parsers, run `:Mason` / `:TSUpdate` (or just restart — installers run on startup).
- `stylua` is the formatter for Lua in this repo (auto-installed by Mason). Lua indent is 2 spaces, set in `lua/options.lua`.
