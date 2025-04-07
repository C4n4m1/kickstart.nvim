-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = '[E]NeoTree reveal' },
    -- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',
          ['<CR>'] = 'toggle_node',
          ['n'] = 'add',
          ['<CR>'] = 'open',
        },
      },
    },
  },
}
