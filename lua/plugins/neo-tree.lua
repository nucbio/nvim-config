--- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,  -- Show hidden files
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = {
      mappings = {
        -- Custom keybinding: Press 't' to open file in new tmux window
        ["t"] = function(state)
          local node = state.tree:get_node()
          if node.type == "file" then
            local filepath = node:get_id()
            -- Check if we're inside tmux
            if vim.env.TMUX then
              vim.fn.system(string.format("tmux new-window 'nvim \"%s\"'", filepath))
            else
              print("Not in a tmux session")
            end
          end
        end,
      },
    },
  },
}

