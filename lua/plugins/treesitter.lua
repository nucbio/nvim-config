-- Highlight, edit, and navigate code
-- Uses the `main` branch (required for nvim >= 0.11); needs the `tree-sitter` CLI to build parsers.
local parsers = {
  "bash", "c", "cpp", "fortran", "python", "r", "rnoweb",
  "rust", "markdown", "markdown_inline", "csv",
  "yaml", "diff", "html", "lua", "luadoc", "groovy",
  "query", "vim", "vimdoc",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.install(parsers)

    -- Nextflow / nf-core: no dedicated parser, the DSL is a Groovy superset
    vim.filetype.add({
      extension = { nf = "nextflow" },
      filename = { ["nextflow.config"] = "nextflow" },
      pattern = {
        [".*%.nf%.test"] = "nextflow",
        [".*/conf/.*%.config"] = "nextflow", -- nf-core conf/base.config, conf/modules.config, ...
      },
    })
    vim.treesitter.language.register("groovy", "nextflow")
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user-nextflow", { clear = true }),
      pattern = "nextflow",
      callback = function(args)
        vim.bo[args.buf].commentstring = "// %s"
      end,
    })

    -- Replaces the old `highlight`/`indent`/`auto_install` modules
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end
        local ok, added = pcall(vim.treesitter.language.add, lang)
        if ok and added then
          pcall(vim.treesitter.start, args.buf, lang)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        elseif vim.tbl_contains(ts.get_available(), lang) then
          -- parser missing: install it; highlighting applies on next open
          ts.install(lang)
        end
      end,
    })
  end,
}
