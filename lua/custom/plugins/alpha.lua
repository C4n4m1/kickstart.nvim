return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Alpha.nvim configuration
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      -- local ascii = require 'ascii'

      dashboard.section.header.val = {
        '███    ██ ███████  ██████  ██    ██ ██ ███    ███ ',
        '████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ',
        '██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ',
        '██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ',
        '██   ████ ███████  ██████    ████   ██ ██      ██ ',
        '                                                  ',
        '                                                  ',
      }

      -- '███    ██ ███████  ██████  ██    ██ ██ ███    ███ ',
      -- '████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ',
      -- '██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ',
      -- '██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ',
      -- '██   ████ ███████  ██████    ████   ██ ██      ██ ',
      -- '                                                  ',
      -- '                                                  ',
      --
      -- ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
      -- ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
      -- ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
      -- ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
      -- ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
      -- ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
      --

      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find File', ':Telescope find_files<CR>'),
        dashboard.button('g', '  Grep search', ':Telescope live_grep<CR>'),
        -- dashboard.button('c', '  config', ':Telescope find_files /home/credo/.config/nvim/'),
        dashboard.button('r', '  Recent Files', ':Telescope oldfiles<CR>'),
        dashboard.button('q', '󰈆  Quit Neovim', ':qa<CR>'),
      }

      local function footer()
        local version = ' Neovim v' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
        local stats = require('lazy').stats()
        return version .. '  󰂕 ' .. stats.loaded .. '/' .. stats.count .. ' plugins'
      end

      dashboard.section.footer.val = footer()

      dashboard.config.layout = {
        { type = 'padding', val = 10 },
        dashboard.section.header,
        { type = 'padding', val = 2 },
        dashboard.section.buttons,
        { type = 'padding', val = 1 },
        dashboard.section.footer,
      }

      alpha.setup(dashboard.config)

      -- Alpha-specific settings
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'alpha',
        callback = function()
          vim.opt_local.laststatus = 0
          vim.opt_local.fillchars:append { eob = ' ' }
        end,
      })
    end,
  },
}
