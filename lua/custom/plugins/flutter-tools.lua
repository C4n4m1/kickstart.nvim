return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  ft = 'dart', -- only load when a dart file is opened
  cond = function()
    -- extra check: only activate if pubspec.yaml exists at root
    return vim.fn.filereadable(vim.fn.getcwd() .. '/pubspec.yaml') == 1
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('flutter-tools').setup {
      closing_tags = {
        highlight = 'NavicText', -- highlight for the closing tag
        prefix = '', -- character to use for close tag e.g. > Widget
        priority = 10, -- priority of virtual text in current line
        -- consider to configure this when there is a possibility of multiple virtual text items in one line
        -- see `priority` option in |:help nvim_buf_set_extmark| for more info
        enabled = true, -- set to false to disable
      },
      dev_log = {
        enabled = true,
        filter = nil, -- optional callback to filter the log
        -- takes a log_line as string argument; returns a boolean or nil;
        -- the log_line is only added to the output if the function returns true
        notify_errors = true, -- if there is an error whilst running then notify the user
        open_cmd = '15split', -- command to use to open the log buffer
        focus_on_open = false, -- focus on the newly opened log window
      },
      lsp = {
        on_attach = function()
          pcall(require('telescope').load_extension 'flutter')
          vim.keymap.set('n', '<C-S-p>', function()
            require('telescope').extensions.flutter.commands()
          end, { noremap = true, desc = 'Cmdline' })
        end,
      },
    }
  end,
}
