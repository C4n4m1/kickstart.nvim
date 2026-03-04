return {
  {
    'leblocks/toggle.nvim',
    event = 'VeryLazy',
    config = function()
      local toggle = require 'toggle'

      toggle.setup {
        defaults = true,
        keep_cursor_position = true,
        mappings = {
          { 'yes', 'no' },
          { 'on', 'off' },
          { 'True', 'False' },
          { 'True,', 'False,' },
          { 'true,', 'false,' },
          { 'True;', 'False;' },
          { 'true;', 'false;' },
          { 'foo', 'bar', 'baz' },
        },
      }

      vim.keymap.set('n', '<C-t>', require('toggle').toggle, { desc = 'Toggle word' })
    end,
  },
}
