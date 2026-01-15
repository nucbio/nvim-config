-- R script commands
return {
  'R-nvim/R.nvim',
  lazy = false,  -- Only required if you also set defaults.lazy = true
  version = '0.99.1',  -- Pin to the latest minor version
  config = function()
    -- Create a table with the options to be passed to setup()
    ---@type RConfigUserOpts
    local opts = {
      hook = {
        on_filetype = function()
          vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
          vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
        end
      },
      R_args = {'--quiet', '--no-save'},
      min_editor_width = 72,
      -- rconsole_height = 15
      rconsole_width = 0,  -- Mark set to open horizontally (was 78)
      objbr_mappings = {  -- Object browser keymap
        c = 'class',  -- Call R functions
        ['<localleader>gg'] = 'head({object}, n = 15)',  -- Use {object} notation to write arbitrary R code.
        v = function()
          -- Run lua functions
          require('r.browser').toggle_view()
        end
      },
      disable_cmds = {
        'RClearConsole',
        'RCustomStart',
        'RSPlot',
        'RSaveClose',
      },
    }
    -- Check if the environment variable "R_AUTO_START" exists.
    -- If using fish shell, you could put in your config.fish:
    -- alias r "R_AUTO_START=true nvim"
--    local opts = {}           -- Mark added to have split/size options
--    opts.split = "horizontal" -- Mark added to open R terminal bellow
--    opts.size = 15            -- Mark added to make R terminal smaller
    if vim.env.R_AUTO_START == 'true' then
      opts.auto_start = 'on startup'
      opts.objbr_auto_start = true
    end
    require('r').setup(opts)
  end,
}
