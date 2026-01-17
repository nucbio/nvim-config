vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 2        -- Number of spaces for each indentation level
vim.opt.softtabstop = 2       -- Number of spaces a Tab key press inserts
vim.opt.tabstop = 2           -- Number of spaces for a tab character

-- Line Numbering
vim.opt.number = true         -- Make line numbers default
vim.o.relativenumber = true   -- Enable relative line numbers
vim.o.number = true           -- Show absolute number for the current line

vim.opt.mouse = 'a'           -- Enable mouse mode
vim.opt.showmode = false      -- Do not show mode (already shown in statusbar)

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true    -- Enable break indent
vim.opt.undofile = true       -- Save undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'    -- Keep signcolumn on by default
vim.opt.updatetime = 250      -- Decrease update time

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Set color column at column 80
vim.o.colorcolumn = "80"
-- Optional: Set the color for the color column (default is pale)
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "darkgray", bg = "lightgray" })


-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Need for Obsidian
vim.opt.conceallevel = 2
