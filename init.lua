--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Correct way to set termguicolors in Lua
vim.opt.termguicolors = true
vim.g.have_nerd_font = true

-- See `:help vim.opt`
--  border on floating window
-- vim.opt.winborder = 'rounded'
require 'custom.keymap'

-- Transparency
vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
  callback = function()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'Folded', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'WinBar', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'WinBarNC', { bg = 'none' })

    -- Gutter line number colors
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#505050', bg = 'none' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#eeeeee', bg = 'none', bold = true })

    -- lsp message ( fidget plugins )
    vim.api.nvim_set_hl(0, 'FidgetTitle', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'FidgetTask', { bg = 'none' })

    -- mini ident line color
    vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#707070' })

    -- Navic colors for breadcrumbs customization
    local navic_icon_fg = '#808080'
    local navic_text_fg = '#646464'
    local navic_sep_fg = '#404040'

    vim.api.nvim_set_hl(0, 'NavicIconsFile', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsModule', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsNamespace', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsPackage', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsClass', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsMethod', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsProperty', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsField', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsConstructor', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsEnum', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsInterface', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsFunction', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsVariable', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsConstant', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsString', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsNumber', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsBoolean', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsArray', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsObject', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsKey', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsNull', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsEnumMember', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsStruct', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsEvent', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsOperator', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicIconsTypeParameter', { bg = '#151518', fg = navic_icon_fg })
    vim.api.nvim_set_hl(0, 'NavicText', { bg = '#151518', fg = navic_text_fg })
    vim.api.nvim_set_hl(0, 'NavicSeparator', { bg = '#151518', fg = navic_sep_fg })
  end,
})

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- auto switch for classic line number in insert mode
vim.api.nvim_create_autocmd({ 'InsertEnter', 'InsertLeave' }, {
  pattern = '*',
  callback = function(args)
    if args.event == 'InsertEnter' then
      vim.opt.relativenumber = false
    else
      vim.opt.relativenumber = true
    end
  end,
})

-- The famous runner to eexecute any script with just one keypam !
vim.keymap.set('n', '<leader><CR>', ':terminal /home/credo/runner.sh % "%:p" <CR>', { desc = ' run code' })
-- open the terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert',
})

-- FISH LSP CONFIG --
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fish',
  callback = function()
    vim.lsp.start {
      name = 'fish-lsp',
      cmd = { 'fish-lsp', 'start' },
      cmd_env = { fish_lsp_show_client_popups = false },
    }
  end,
})

vim.opt.mouse = 'a'

vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local file = 'config.statusline'
local success = pcall(require, file)
if not success then
  vim.notify('Failed to load a config file ' .. vim.log.levels.ERROR)
end

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
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

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

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
      vim.keymap.set('n', '<C-Space>', builtin.buffers, { desc = '[S]earch existing [B]uffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

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
  },

  -- LSP Plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',

      -- Useful status updates for LSP.
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0, -- 0 = fully opaque bg color, but...
              border = 'none',
              normal_hl = 'Comment', -- inherit from a transparent-bg group
            },
          },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.server_capabilities.documentSymbolProvider then
            local ok, navic = pcall(require, 'nvim-navic')
            if ok then
              navic.attach(client, event.buf)
              -- Navic colors for breadcrumbs customization
              local navic_icon_fg = '#808080'
              local navic_text_fg = '#646464'
              local navic_sep_fg = '#404040'

              vim.api.nvim_set_hl(0, 'NavicIconsFile', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsModule', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsNamespace', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsPackage', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsClass', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsMethod', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsProperty', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsField', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsConstructor', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsEnum', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsInterface', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsFunction', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsVariable', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsConstant', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsString', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsNumber', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsBoolean', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsArray', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsObject', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsKey', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsNull', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsEnumMember', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsStruct', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsEvent', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsOperator', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicIconsTypeParameter', { bg = '#151518', fg = navic_icon_fg })
              vim.api.nvim_set_hl(0, 'NavicText', { bg = '#151518', fg = navic_text_fg })
              vim.api.nvim_set_hl(0, 'NavicSeparator', { bg = '#151518', fg = navic_sep_fg })
            end
          end

          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local servers = {
        clangd = {},
        -- gopls = {},
        pyright = {},
        jdtls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

      -- You can press `g?` for help in this menu.
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      local lsp_servers = vim.tbl_keys(servers or {})
      require('mason-tool-installer').setup { ensure_installed = lsp_servers }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[C]ode : [F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        c = { 'prettier' },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  {
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
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
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
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
-- Oil.nvim recipes
-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require('oil').get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

require('oil').setup {
  win_options = {
    winbar = '%!v:lua.get_oil_winbar()',
  },
}

local vimade_base = {
  recipe = { 'default', { animate = true } },
  blocklist = {
    demo_tutorial = function(win, current)
      if (win.win_config.relative == '') and (current and current.win_config.relative ~= '') then
        return false
      end
      return true
    end,
  },
}

require('vimade').setup(vim.tbl_extend('force', vimade_base, { fadelevel = 0.4 }, { animate = false }))

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'namu_prompt',
  callback = function()
    require('vimade').setup(vim.tbl_extend('force', vimade_base, { fadelevel = 0.8 }))
  end,
})

vim.api.nvim_create_autocmd('BufLeave', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'namu_prompt' then
      require('vimade').setup(vim.tbl_extend('force', vimade_base, { fadelevel = 0.4 }))
    end
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
