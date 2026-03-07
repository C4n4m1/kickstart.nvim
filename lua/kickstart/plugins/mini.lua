  return { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }
      require('mini.indentscope').setup {
        draw = {
          delay = 100,
          animation = require('mini.indentscope').gen_animation.quadratic { duration = 10, unit = 'step' },
        },
        options = {
          border = 'both',

          -- Whether to use cursor column when computing reference indent.
          -- Useful to see incremental scopes with horizontal cursor movements.
          indent_at_cursor = true,
          try_as_border = true,
        },
        symbol = '│',
      }
    end,
  }
