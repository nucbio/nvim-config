--return {
--    'folke/tokyonight.nvim',
--    priority = 1000,
--    init = function()
--        vim.cmd.colorscheme 'tokyonight-night'
--        vim.cmd.hi 'Comment gui=none'
--    end,
--}

return {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "night",
            on_highlights = function(hl, c)
                -- keeps your Comment tweak
                hl.Comment = { fg = c.comment, italic = false }
            end,
            plugins = {
                tmux = true
            }
        })

        vim.cmd.colorscheme "tokyonight-night"
    end
}

