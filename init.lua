require 'options'
require 'keymaps'
require 'workflow'

-- Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end 
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
    require 'plugins.colorscheme',
    require 'plugins.neo-tree',
    require 'plugins.lsp',
    require 'plugins.tmux_navigator',
    require 'plugins.telescope',
    require 'plugins.autocompletion',
    require 'plugins.comment',
    require 'plugins.delimitmate',
    require 'plugins.r-nvim',
    require 'plugins.treesitter',
    require 'plugins.which-key',
    require 'plugins.conform',
    require 'plugins.todo-comment',
    require 'plugins.mini',
    require 'plugins.aerial',
    require 'plugins.bookmarks',
    require 'plugins.vimtex',
    require 'plugins.obsidian',
    require 'plugins.gitsigns'
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Start-up loads
  -- Load neo-tree 
  vim.cmd([[
    autocmd VimEnter * Neotree
  ]])
  
  -- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Over SSH (e.g. HPC): send yanks to the local PC clipboard via OSC 52.
-- Paste reads the local register (OSC 52 read is blocked/slow in most terminals).
-- Locally (no SSH_TTY) Neovim's built-in provider (wl-copy/xclip) is used.
if vim.env.SSH_TTY then
  local function copy(lines, _)
    require('vim.ui.clipboard.osc52').copy('+')(lines)
  end
  local function paste()
    return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') }
  end
  vim.g.clipboard = {
    name = 'osc52',
    copy = { ['+'] = copy, ['*'] = copy },
    paste = { ['+'] = paste, ['*'] = paste },
    cache_enabled = true,
  }
end
