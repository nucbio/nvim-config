require 'options'
require 'keymaps'

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
    require 'plugins.cmp-r',
    require 'plugins.comment',
    require 'plugins.delimitmate',
    require 'plugins.r-nvim',
    require 'plugins.treesitter',
    require 'plugins.which-key',
    require 'plugins.conform',
    require 'plugins.todo-comment',
    require 'plugins.mini'
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

