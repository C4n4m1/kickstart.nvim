-- keymap for ctrl tab behavior
vim.keymap.set('n', '<leader><leader>', '<C-^>', { desc = ' [_] Open last buffer' })

local function get_ordered_buffers()
  local buffers = vim.api.nvim_list_bufs()
  local filtered = {}
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      table.insert(filtered, buf)
    end
  end
  table.sort(filtered)
  local result = {}
  for i = 1, 9 do
    if filtered[i] then
      result[i] = filtered[i]
    else
      result[i] = -1
    end
  end
  return result
end

local function go_to_buffer(index)
  local buffers = get_ordered_buffers()
  local buf_nr = buffers[index]
  if buf_nr and buf_nr ~= -1 then
    vim.api.nvim_set_current_buf(buf_nr)
  end
end

vim.keymap.set('n', '<M-&>', function()
  go_to_buffer(1)
end, { desc = ' [_] Go to buffer 1' })
vim.keymap.set('n', '<M-é>', function()
  go_to_buffer(2)
end, { desc = ' [_] Go to buffer 2' })
vim.keymap.set('n', '<M-">', function()
  go_to_buffer(3)
end, { desc = ' [_] Go to buffer 3' })
vim.keymap.set('n', "<M-'>", function()
  go_to_buffer(4)
end, { desc = ' [_] Go to buffer 4' })
vim.keymap.set('n', '<M-(>', function()
  go_to_buffer(5)
end, { desc = ' [_] Go to buffer 5' })
vim.keymap.set('n', '<M-->', function()
  go_to_buffer(6)
end, { desc = ' [_] Go to buffer 6' })
vim.keymap.set('n', '<M-è>', function()
  go_to_buffer(7)
end, { desc = ' [_] Go to buffer 7' })
vim.keymap.set('n', '<M-_>', function()
  go_to_buffer(8)
end, { desc = ' [_] Go to buffer 8' })
vim.keymap.set('n', '<M-ç>', function()
  go_to_buffer(9)
end, { desc = ' [_] Go to buffer 9' })

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
vim.keymap.set('n', '<leader>e', function()
  vim.cmd.Otree()
end, { desc = 'Toggle Otree file explorer' })
vim.keymap.set('n', '<C-S-E>', function()
  vim.cmd.OtreeFocus()
end, { desc = 'Toggle Otree file explorer' })

local inline_diag_enabled = true

vim.keymap.set('n', '<leader>td', function()
  inline_diag_enabled = not inline_diag_enabled
  if inline_diag_enabled then
    require('tiny-inline-diagnostic').enable()
  else
    require('tiny-inline-diagnostic').disable()
  end
end, { desc = 'Toggle inline diagnostics' })
