return {
  'Jezda1337/nvim-html-css',
  -- dependencies = { 'hrsh7th/nvim-cmp', 'nvim-treesitter/nvim-treesitter' }, -- Use this if you're using nvim-cmp
  dependencies = { 'saghen/blink.cmp', 'nvim-treesitter/nvim-treesitter' }, -- Use this if you're using blink.cmp
  opts = {
    enable_on = { -- Example file types
      'html',
      'htmldjango',
      'tsx',
      'jsx',
      'erb',
      'svelte',
      'vue',
      'blade',
      'php',
      'templ',
      'astro',
    },
    handlers = {
      definition = {
        bind = 'gd',
      },
      hover = {
        bind = 'K',
        wrap = true,
        border = 'none',
        position = 'cursor',
      },
    },
    documentation = {
      auto_show = true,
    },
    style_sheets = {
      -- '/home/credo/Documents/IAI/WebS2/bootstrap_practice/style.css', -- `./` refers to the current working directory.
      -- '/home/credo/Documents/IAI/WebS2/JPO/style.css', -- `./` refers to the current working directory.
      -- '/home/credo/Documents/IAI/WebS2/web1-L1B/learn_bootstrap/style.css', -- `./` refers to the current working directory.
      -- '/home/credo/Documents/IAI/WebS2/bootstrap_practice/bootstrap/css/bootstrap.css', -- `./` refers to the current working directory.
      -- '/home/credo/Documents/IAI/WebS2/JPO/bootstrap/css/bootstrap.css',
      -- '/home/credo/Documents/IAI/WebS2/web1-L1B/learn_bootstrap/bootstrap/css/bootstrap.css', -- `./` refers to the current working directory.
      -- './style.css',
    },
  },
}
