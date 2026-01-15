------ DelimitMate -- autoclose brackets
return {
    'Raimondi/delimitMate',
    config = function()
      -- Optional: Add your custom configuration here
      vim.g.delimitMate_expand_cr = 1
      vim.g.delimitMate_jump_expansion = 1
    end,
  }
