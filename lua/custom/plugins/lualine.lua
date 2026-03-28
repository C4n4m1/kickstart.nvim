return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    config = function()
      local colors = {
        black = '#070709',
        gray = '#252528',
        white = '#C9C7CD',
        darkgray = '#151518',
        lightgray = '#505052',
        inactivegray = '#333335',
      }

      local theme = {
        normal = {
          a = { bg = colors.gray, fg = colors.white, gui = 'bold' },
          b = { bg = colors.inactivegray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        insert = {
          a = { bg = colors.inactivegray, fg = colors.white, gui = 'bold' },
          b = { bg = colors.gray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        visual = {
          a = { bg = colors.lightgray, fg = colors.white, gui = 'bold' },
          b = { bg = colors.inactivegray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        replace = {
          a = { bg = colors.lightgray, fg = colors.white, gui = 'bold' },
          b = { bg = colors.inactivegray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        command = {
          a = { bg = colors.darkgray, fg = colors.white, gui = 'bold' },
          b = { bg = colors.gray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        inactive = {
          a = { bg = colors.darkgray, fg = colors.white, gui = 'bold' },
          b = { bg = colors.darkgray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
      }

      require('lualine').setup {
        options = {
          theme = theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { { 'branch', icon = '' }, 'diff', 'diagnostics' },
          lualine_c = {
            {
              'navic',
              -- max_length = vim.o.columns * 0.1,
              color_correction = 'static',
              navic_opts = {
                depth_limit = 6,
              },
            },
          },
          lualine_x = {
            {
              'filename',
              symbols = {
                modified = ' ●', -- Text to show when the buffer is modified
                alternate_file = '#', -- Text to show to identify the alternate file
                directory = '', -- Text to show when the buffer is a directory
              },
            },
          },
          lualine_y = { 'progress', 'location' },
          lualine_z = { 'filetype' },
        },
      }
    end,
  },
}
