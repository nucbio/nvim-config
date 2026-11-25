-- Git change indicators in the sign column (added / changed / deleted lines
-- relative to the index), plus hunk navigation, preview, stage/reset and blame.
-- Keymaps live under <leader>g (<leader>h is already the horizontal split).
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '┆' },
    },
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
    },
    signs_staged_enable = true,
    attach_to_untracked = true,
    current_line_blame = false, -- toggle with <leader>gb
    current_line_blame_opts = { delay = 300, virt_text_pos = 'eol' },
    preview_config = { border = 'rounded' },

    on_attach = function(bufnr)
      local gs = require 'gitsigns'
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Navigation (falls back to native ]c/[c inside :diff windows)
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gs.nav_hunk 'next'
        end
      end, 'Next git hunk')
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gs.nav_hunk 'prev'
        end
      end, 'Previous git hunk')

      -- Actions
      map('n', '<leader>gs', gs.stage_hunk, '[G]it [s]tage/unstage hunk')
      map('n', '<leader>gr', gs.reset_hunk, '[G]it [r]eset hunk')
      map('v', '<leader>gs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, '[G]it [s]tage selected lines')
      map('v', '<leader>gr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, '[G]it [r]eset selected lines')
      map('n', '<leader>gS', gs.stage_buffer, '[G]it [S]tage buffer')
      map('n', '<leader>gR', gs.reset_buffer, '[G]it [R]eset buffer')
      map('n', '<leader>gp', gs.preview_hunk, '[G]it [p]review hunk')
      map('n', '<leader>gi', gs.preview_hunk_inline, '[G]it preview hunk [i]nline')
      map('n', '<leader>gB', function()
        gs.blame_line { full = true }
      end, '[G]it [B]lame line (full)')
      map('n', '<leader>gb', gs.toggle_current_line_blame, '[G]it toggle inline [b]lame')
      map('n', '<leader>gd', gs.diffthis, '[G]it [d]iff against index')
      map('n', '<leader>gD', function()
        gs.diffthis '~'
      end, '[G]it [D]iff against last commit')
      map('n', '<leader>gw', gs.toggle_word_diff, '[G]it toggle [w]ord diff')
      map('n', '<leader>gl', gs.toggle_linehl, '[G]it toggle [l]ine highlight')

      -- Text object: ih = inner hunk (e.g. `dih`, `vih`)
      map({ 'o', 'x' }, 'ih', gs.select_hunk, 'Select git hunk')
    end,
  },
}
