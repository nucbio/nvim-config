-- Highlight, edit, and navigate code
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,  -- Load immediately
  priority = 100,  -- Load early
  opts = {
    ensure_installed = {
      "bash", 
      "c", 
      "cpp", 
      "fortran", 
      "python", 
      "r", 
      "rnoweb", 
      "rust", 
      "markdown",
      "markdown_inline",
      "rnoweb",
      "latex",
      "csv",
      "yaml", 
      "diff", 
      "html", 
      "lua", 
      "luadoc",
      "markdown", 
      "markdown_inline", 
      "query", 
      "vim", 
      "vimdoc", 
      "query"
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { 
      enable = false, 
    },
  },
}

