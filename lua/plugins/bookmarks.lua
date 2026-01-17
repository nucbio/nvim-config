-- Bookmarks.lua - Plugin for bookmarks in neotree
return {
  -- The bookmarks plugin itself
  {
    "LintaoAmons/bookmarks.nvim",
    -- Pin the version for stability
    tag = "v4.0.0", -- Check the official GitHub for the latest stable tag
    dependencies = {
      -- 1. Required for persistent storage
      { "kkharji/sqlite.lua" },
      -- 2. Required for the quick selection UI
      { "nvim-telescope/telescope.nvim" },
      { "stevearc/dressing.nvim" }
    },
    -- Configuration (calls setup function)
    config = function()
      local opts = {} 
      require("bookmarks").setup({
        -- Configure the path to the database file
        -- This is where your bookmarks will be stored persistently.
        db_path = vim.fn.stdpath("data") .. "/bookmarks.db",

        -- Set up keymaps here or below the config block
        -- Setting `default_mappings = true` is recommended for beginners.
        default_mappings = true,

        -- Optionally, toggle Git branch scope (bookmarks only visible per branch)
        use_branch_specific = false,
      })

      -- Important: Load the Telescope extension!
      require("telescope").load_extension("bookmarks")
    end,
    -- Define commands for Lazy-loading (optional, but good practice)
    cmd = { "BookmarksMark", "BookmarksGoto", "BookmarksTree", "BookmarksLists" },
    -- Define your keymaps here if you set `default_mappings = false`
    -- keys = { ... }
  },
}
