return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'jonarrien/telescope-cmdline.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      defaults = {
        mappings = {
          i = { ['<Esc>'] = 'close', ['<M-p>'] = require('telescope.actions.layout').toggle_preview },
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ['<c-d>'] = require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top,
              ['<c-h>'] = function(prompt_bufnr)
                local action_state = require 'telescope.actions.state'
                local entry = action_state.get_selected_entry()
                if entry and entry.bufnr then
                  require('telescope.actions').close(prompt_bufnr)
                  vim.cmd('vert lefta sb' .. tostring(entry.bufnr))
                end
              end,
              ['<c-j>'] = function(prompt_bufnr)
                local action_state = require 'telescope.actions.state'
                local entry = action_state.get_selected_entry()
                if entry and entry.bufnr then
                  require('telescope.actions').close(prompt_bufnr)
                  vim.cmd('sb ' .. tostring(entry.bufnr))
                end
              end,
              ['<c-k>'] = function(prompt_bufnr)
                local action_state = require 'telescope.actions.state'
                local entry = action_state.get_selected_entry()
                if entry and entry.bufnr then
                  require('telescope.actions').close(prompt_bufnr)
                  vim.cmd('sba ' .. tostring(entry.bufnr))
                end
              end,
              ['<c-l>'] = function(prompt_bufnr)
                local action_state = require 'telescope.actions.state'
                local entry = action_state.get_selected_entry()
                if entry and entry.bufnr then
                  require('telescope.actions').close(prompt_bufnr)
                  vim.cmd('vert sb' .. tostring(entry.bufnr))
                end
              end,
            },
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        cmdline = {
          -- Adjust telescope picker size and layout
          picker = {
            layout_config = {
              width = 80,
              height = 20,
            },
          },
          -- Adjust your mappings
          mappings = {
            complete = '<Tab>',
            run_selection = '<C-CR>',
            run_input = '<CR>',
          },
          -- Triggers any shell command using overseer.nvim (`:!`)
          overseer = {
            enabled = true,
          },
        },
        undo = {
          mappings = {
            i = {
              ['<cr>'] = require('telescope-undo.actions').yank_additions,
              ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
              ['<C-cr>'] = require('telescope-undo.actions').restore,
              -- alternative defaults, for users whose terminals do questionable things with modified <cr>
              ['<C-y>'] = require('telescope-undo.actions').yank_deletions,
              ['<C-r>'] = require('telescope-undo.actions').restore,
            },
            n = {
              ['y'] = require('telescope-undo.actions').yank_additions,
              ['Y'] = require('telescope-undo.actions').yank_deletions,
              ['u'] = require('telescope-undo.actions').restore,
            },
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension 'cmdline')
    vim.api.nvim_set_keymap('n', '<C-S-p>', '<cmd>Telescope cmdline<CR>', { noremap = true, desc = 'Cmdline' })
    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Search [F]iles' })
    vim.keymap.set({ 'n', 'v' }, '<C-p>', builtin.find_files, { desc = 'Search files' })
    vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch Select [T]elescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Search by [G]rep' })
    vim.keymap.set('n', '<C-S-F>', builtin.live_grep, { desc = 'search in projects' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>s.', builtin.resume, { desc = '[S]earch [.]resume' })
    vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[S]earch [R]ecent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch existing [B]uffers' })
    -- vim.keymap.set('n', '<C-Space>', builtin.buffers, { desc = '[S]earch existing [B]uffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<M-space>', function()
      builtin.buffers(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
      })
    end, { desc = 'Buffers search' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
