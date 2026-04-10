-- keymap for ctrl tab behavior
vim.keymap.set('n', '<leader><leader>', '<C-^>', { desc = ' [_] Open last buffer' })
local term = require 'custom.terminal'

local function get_ordered_buffers(terminals)
  terminals = terminals or false
  local buffers = vim.api.nvim_list_bufs()
  local filtered = {}
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      if terminals then
        if vim.bo[buf].buftype == 'terminal' then
          table.insert(filtered, buf)
        end
      else
        if vim.bo[buf].buftype ~= 'terminal' then
          table.insert(filtered, buf)
        end
      end
    end
  end
  table.sort(filtered)
  return filtered
end

local function go_to_buffer(index, terminal)
  terminal = terminal or false
  local buffers = get_ordered_buffers(terminal)
  local buf_nr = buffers[index]
  if buf_nr then
    vim.api.nvim_set_current_buf(buf_nr)
  end
  if terminal then
    term.state.buf = buffers[index]
  end
end

-- vim.keymap.set('n', '<M-space>', function()
--   require('telescope.builtin').buffers(require('telescope.themes').get_dropdown {
--     winblend = 0,
--     previewer = false,
--   })
-- end, { desc = 'Buffers search' })

vim.keymap.set('n', '<M-space>', function()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local themes = require 'telescope.themes'
  local entry_display = require 'telescope.pickers.entry_display'

  local buffers = get_ordered_buffers()
  local buffs_with_infos = {}
  for _, buf_nb in ipairs(buffers) do
    local element = {
      buf_nb = buf_nb,
      info = vim.fn.getbufinfo(buf_nb)[1],
    }
    table.insert(buffs_with_infos, element)
  end

  local function editor_picker()
    local opts = themes.get_dropdown(opts or {})
    pickers
      .new(opts, {
        prompt_title = 'Editor buffers',
        finder = finders.new_table {
          results = buffs_with_infos,
          entry_maker = function(entry)
            local info = entry.info or {}
            local name = (info.name and info.name ~= '') and info.name or '[No Name]'
            local short = vim.fn.fnamemodify(name, ':~:.')
            local basename = vim.fn.fnamemodify(short, ':t')
            local dir = vim.fn.fnamemodify(short, ':h')
            local dir_display = (dir == '.' or dir == '') and '' or (dir .. '/')

            local displayer = entry_display.create {
              separator = ' ',
              items = {
                { width = 3 }, -- buffer number
                { width = #dir_display }, -- directory prefix
                { remaining = true }, -- basename
              },
            }

            return {
              value = entry.buf_nb,
              ordinal = short,
              display = function()
                return displayer {
                  { tostring(entry.buf_nb), 'TelescopeResultsNumber' }, -- colored number
                  { dir_display, 'TelescopeResultsComment' }, -- dim dir
                  { basename, 'TelescopeResultsIdentifier' }, -- bright basename
                }
              end,
            }
          end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          map('i', '<C-d>', function()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if not selection then
              return
            end
            vim.api.nvim_buf_delete(selection.value, { force = false }) -- false = respect unsaved warning
            picker:delete_selection(function(sel)
              return sel.value == selection.value
            end)
          end)

          map('n', '<C-d>', function()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if not selection then
              return
            end
            vim.api.nvim_buf_delete(selection.value, { force = false })
            picker:delete_selection(function(sel)
              return sel.value == selection.value
            end)
          end)

          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.api.nvim_win_set_buf(0, selection.value)
          end)

          return true
        end,
      })
      :find()
  end
  editor_picker()
end, { desc = 'Buffers search' })

vim.keymap.set('t', '<M-space>', function()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local themes = require 'telescope.themes'
  local entry_display = require 'telescope.pickers.entry_display'
  local function get_term_process(buf_nb)
    local shell_pid = vim.b[buf_nb].terminal_job_pid
    if not shell_pid then
      return '?'
    end

    -- read children directly from /proc, no subprocess
    local f = io.open('/proc/' .. shell_pid .. '/task/' .. shell_pid .. '/children', 'r')
    local child_pid = nil
    if f then
      local line = f:read '*l'
      f:close()
      child_pid = line and line:match '^%s*(%d+)'
    end

    local pid = child_pid or shell_pid
    local cf = io.open('/proc/' .. pid .. '/comm', 'r')
    if not cf then
      return '?'
    end
    local name = cf:read '*l'
    cf:close()
    return name or '?'
  end

  local terminal = true
  local buffers = get_ordered_buffers(terminal)
  local buffs_with_infos = {}
  for _, buf_nb in ipairs(buffers) do
    local element = {
      buf_nb = buf_nb,
      info = vim.fn.getbufinfo(buf_nb)[1],
    }
    table.insert(buffs_with_infos, element)
  end

  local function editor_picker()
    local opts = themes.get_dropdown(opts or {})
    pickers
      .new(opts, {
        prompt_title = 'Terminal buffers',
        finder = finders.new_table {
          results = buffs_with_infos,
          entry_maker = function(entry)
            local process_name = get_term_process(entry.buf_nb)

            local displayer = entry_display.create {
              separator = ' ',
              items = {
                { width = 3 },
                { remaining = true },
              },
            }

            return {
              value = entry.buf_nb,
              ordinal = process_name,
              display = function()
                return displayer {
                  { tostring(entry.buf_nb), 'TelescopeResultsNumber' },
                  { process_name, 'TelescopeResultsIdentifier' },
                }
              end,
            }
          end,
        },
        sorter = conf.generic_sorter(opts),
        -- after attach_mappings, inside pickers.new opts:
        attach_mappings = function(prompt_bufnr, map)
          map('i', '<Esc>', function()
            actions.close(prompt_bufnr)
            vim.schedule(function()
              vim.wo.number = false
              vim.wo.relativenumber = false
              if vim.bo.buftype == 'terminal' then
                vim.cmd 'startinsert'
              end
            end)
          end)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.api.nvim_win_set_buf(0, selection.value)
            vim.schedule(function()
              vim.wo.number = false
              vim.wo.relativenumber = false
              if vim.bo.buftype == 'terminal' then
                vim.cmd 'startinsert'
              end
            end)
          end)
          map('n', '<C-d>', function()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if not selection then
              return
            end
            vim.api.nvim_buf_delete(selection.value, { force = true })
            picker:delete_selection(function(sel)
              return sel.value == selection.value
            end)
          end)
          return true
        end,
      })
      :find()
  end
  editor_picker()
end, { desc = 'Terminal search' })

-- Buffers navigation
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

-- From Kickstart
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

local inline_diag_enabled = true
local annoying_diag_filetype = { 'qml' }

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    if vim.tbl_contains(annoying_diag_filetype, vim.bo.filetype) then
      inline_diag_enabled = false
      require('tiny-inline-diagnostic').disable()
    end
  end,
})

vim.keymap.set('n', '<leader>td', function()
  inline_diag_enabled = not inline_diag_enabled
  if inline_diag_enabled then
    require('tiny-inline-diagnostic').enable()
  else
    require('tiny-inline-diagnostic').disable()
  end
end, { desc = 'Toggle inline diagnostics' })

-- Generic toggle (uses whatever mode was last set)
vim.keymap.set({ 'n', 't' }, '<M-t>', function()
  term.toggle()
end, { desc = 'Toggle terminal' })
-- Force a specific mode (also switches if the other mode is currently open)
vim.keymap.set('n', '<leader>tf', function()
  term.toggle { mode = 'float' }
end, { desc = 'Terminal (float)' })
vim.keymap.set('n', '<leader>tv', function()
  term.toggle { mode = 'vsplit' }
end, { desc = 'Terminal (vsplit)' })
vim.keymap.set('n', '<leader>ts', function()
  term.toggle { mode = 'hsplit' }
end, { desc = 'Terminal (hsplit)' })
vim.keymap.set({ 'n', 't' }, '<M-n>', function()
  term.new()
end, { desc = 'Terminal (hsplit)' })
-- Fullscreen toggle while open
vim.keymap.set({ 'n', 't' }, '<C-f>', function()
  term.toggle_fullscreen()
end, { desc = 'Terminal fullscreen' })

-- Terminal navigation
vim.keymap.set('t', '<M-&>', function()
  go_to_buffer(1, true)
end, { desc = ' [_] Go to terminal 1' })
vim.keymap.set('t', '<M-é>', function()
  go_to_buffer(2, true)
end, { desc = ' [_] Go to terminal 2' })
vim.keymap.set('t', '<M-">', function()
  go_to_buffer(3, true)
end, { desc = ' [_] Go to terminal 3' })
vim.keymap.set('t', "<M-'>", function()
  go_to_buffer(4, true)
end, { desc = ' [_] Go to terminal 4' })
vim.keymap.set('t', '<M-(>', function()
  go_to_buffer(5, true)
end, { desc = ' [_] Go to terminal 5' })
vim.keymap.set('t', '<M-->', function()
  go_to_buffer(6, true)
end, { desc = ' [_] Go to terminal 6' })
vim.keymap.set('t', '<M-è>', function()
  go_to_buffer(7, true)
end, { desc = ' [_] Go to terminal 7' })
vim.keymap.set('t', '<M-_>', function()
  go_to_buffer(8, true)
end, { desc = ' [_] Go to terminal 8' })
vim.keymap.set('t', '<M-ç>', function()
  go_to_buffer(9, true)
end, { desc = ' [_] Go to terminal 9' })
