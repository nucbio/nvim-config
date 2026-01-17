return {
  "lervag/vimtex",
  lazy = false, -- lazy-loading will disable inverse search
  config = function()
    -- Viewer settings
    vim.g.vimtex_view_method = "zathura" -- or 'skim' for macOS, 'sioyek', etc.
    
    -- Compiler settings
    vim.g.vimtex_compiler_method = "latexmk"
    
    -- Disable overfull/underfull \hbox and all package warnings
    vim.g.vimtex_quickfix_ignore_filters = {
      'Underfull',
      'Overfull',
      'specifier changed to',
      'Token not allowed in a PDF string',
    }
    
    -- Auto-open quickfix on warnings/errors
    vim.g.vimtex_quickfix_mode = 2
    
    -- Completion settings (if using nvim-cmp)
    vim.g.vimtex_complete_enabled = 1
    
    -- Disable imaps (I prefer using a snippet engine)
    vim.g.vimtex_imaps_enabled = 0
    
    -- Syntax highlighting improvements
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_syntax_conceal_disable = 0
    
    -- TOC settings
    vim.g.vimtex_toc_config = {
      name = 'TOC',
      layers = {'content', 'todo', 'include'},
      split_width = 30,
      todo_sorted = 0,
      show_help = 1,
      show_numbers = 1,
    }
  end,
}
