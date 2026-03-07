return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --
  -- MELLOW
  -- 'mellow-theme/mellow.nvim',
  -- priority = 1000, -- Make sure to load this before all the other start plugins.
  -- config = function()
  --   vim.g.mellow_italic_functions = true
  --   vim.g.mellow_bold_functions = true
  --   vim.g.mellow_transparent = true
  --   vim.g.mellow_italic_comments = true
  --   vim.cmd 'colorscheme mellow'
  -- end,

  -- VAGUE
  -- 'vague2k/vague.nvim',
  -- priority = 1000,
  -- config = function()
  --   require('vague').setup {
  --     transparent = true,
  --     style = {
  --       functions = 'bold',
  --     },
  --   }
  --   -- Add any theme-specific options here
  --   vim.cmd 'colorscheme vague'
  -- end,
  --
  --
  -- TOKYO NIGHT
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('tokyonight').setup {
  --       transparent = true,
  --       -- style = {
  --       --   functions = { italic = true, bold = true },
  --       -- },
  --     }
  --     vim.cmd 'colorscheme tokyonight'
  --   end,
  --
  --
  --   NORD
  -- Colored version : NORDIC

  -- 'AlexvZyl/nordic.nvim',
  -- lazy = false,
  -- priority = 1000,
  -- config = function()
  --   require('nordic').setup {
  --     italic_comments = true,
  --     transparent = {
  --       bg = true,
  --       float = true,
  --     },
  --     -- telescope = 'classic',
  --   }
  --   vim.cmd.colorscheme 'nordic'
  -- end,

  -- OLDWORLD
  'dgox16/oldworld.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('oldworld').setup {
      variant = 'default',
      styles = {
        comments = { italic = true },
        functions = { italic = true, bold = true },
      },
      highlight_overrides = {
        -- Comments
        Comment = { fg = '#5d797c' },
        -- Booleans
        Boolean = { fg = '#E6B99D' },
        -- Constants
        Constant = { fg = '#F5A191' },
        -- Constructors
        Constructor = { fg = '#EA83A5' },
        -- Emphasis (mapped to Italic groups if applicable, but ignoring styles)
        -- Functions
        Function = { fg = '#92A2D5' },
        -- Keywords
        Keyword = { fg = '#E29ECA' },
        -- Labels
        Label = { fg = '#c0caf5' },
        -- Links (text and uri)
        -- No direct standard highlight group, can be linked to 'Underlined' or custom
        -- Numbers
        Number = { fg = '#F5A191' },
        -- Operators
        Operator = { fg = '#92A2D5' },
        -- Preprocessor
        PreProc = { fg = '#73daca' },
        -- Punctuation (and subtypes)
        Delimiter = { fg = '#8dc1d5' },
        -- Strings and related
        String = { fg = '#90B99F' },
        -- Tags
        Tag = { fg = '#92A2D5' },
        -- Titles
        Title = { fg = '#F5A191' },
        -- Types
        Type = { fg = '#70a6b0' },
        -- Variables
        Identifier = { fg = '#ACA1CF' },
        Variable = { fg = '#ACA1CF' },
        -- Special variables
        Special = { fg = '#EA83A5' },
      },
    }
    vim.cmd.colorscheme 'oldworld'
  end,
}
