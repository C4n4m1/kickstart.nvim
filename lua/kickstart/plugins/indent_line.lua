return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    version = '*',
    config = function()
      require('ibl').setup({})
    end,
  },
}
