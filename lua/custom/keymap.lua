-- keymap for ctrl tab behavior
vim.keymap.set('n', '<leader><leader>', ':bprevious<CR>', { desc = ' [_] Open previous buffer ' })

-- OIL.NVIM keybind
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Parent repository' })

-- The famous runner to execute any script with just one keypam !
vim.keymap.set('n', '<leader><CR>', ':terminal /home/credo/runner.sh % "%:p" <CR>', { desc = ' run code' })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- More LSP keymaps --
vim.keymap.set('n', 'cd', vim.lsp.buf.rename, { desc = 'LSP Rename Symbol' })

-- more keympas , thx primeagen
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv ")
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv ")

vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- paste into void register
vim.keymap.set('x', '<leader>p', '"_dP')

-- delete into void register
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- quickfix nav , maybe we'll use thos feature one day
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader-k>', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader-j>', '<cmd>lprev<CR>zz')

-- File explorer
vim.keymap.set('n', '<leader>e', ':Otree<CR>', { desc = 'Toggle Otree file explorer' })
