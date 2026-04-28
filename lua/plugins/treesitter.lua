-- Highlight, edit, and navigate code
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "bash", "c", "cpp", "fortran", "python", "r", "rnoweb",
      "rust", "markdown", "markdown_inline", "csv",
      "yaml", "diff", "html", "lua", "luadoc",
      "query", "vim", "vimdoc",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
