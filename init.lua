-- OPTIONS
-- See `:help vim.opt`
--  border on floating window
vim.opt.winborder = 'none'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Correct way to set termguicolors in Lua
vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.opt.swapfile = false

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

-- open the terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert',
})

-- fish lsp config
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
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

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
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- KEYMAPS
require 'custom.keymap'

-- COLORS CONFIG
function _G.navic_hl()
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

    -- mini ident line color
    vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#707070' })

    -- custom highlights group
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopup', { bg = '#252528' })
    vim.api.nvim_set_hl(0, 'NoicePopup', { bg = '#252528' })
    vim.api.nvim_set_hl(0, 'NoiceMenu', { bg = '#252528' })

    navic_hl()
  end,
})

-- LAZY.NVIM PLUGIN MANAGER
--
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
  require 'kickstart.plugins.which-key',
  require 'kickstart.plugins.telescope',

  -- LSP Plugins
  require 'kickstart.plugins.lsp-config',
  require 'kickstart.plugins.lazy-dev',

  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.colorscheme',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.todo-comments',
  require 'kickstart.plugins.nvim-treesitter',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  require 'kickstart.plugins.autoformat',

  { import = 'custom.plugins' },
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

local vimade_default_fade = 0.4
require('vimade').setup(vim.tbl_extend('force', vimade_base, { fadelevel = vimade_default_fade }, { animate = false }))

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
      require('vimade').setup(vim.tbl_extend('force', vimade_base, { fadelevel = vimade_default_fade }))
    end
  end,
})

vim.api.nvim_create_autocmd('CmdlineEnter', {
  callback = function()
    require('vimade').setup {
      recipe = { 'default', { animate = false } },
      fadelevel = 0.7,
      blocklist = {},
      -- ncmode = 'focus',
    }
    vim.cmd 'VimadeFadeActive'
  end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
  callback = function()
    vim.cmd 'VimadeUnfadeActive' -- restore it
    vim.cmd 'VimadeRedraw'
    require('vimade').setup(vim.tbl_extend('force', vimade_base, { fadelevel = vimade_default_fade }))
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
