return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = function()
    require('noice').setup {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      routes = {
        -- Skip yank notifications (e.g. "X lines yanked")
        { filter = { event = 'msg_show', find = 'line' }, opts = { skip = true } },
        -- Skip file save notifications (e.g. "file.lua 42L, 1.2K written")
        { filter = { event = 'msg_show', find = 'written' }, opts = { skip = true } },
        -- Skip generic empty messages
        { filter = { event = 'msg_show', kind = '' }, opts = { skip = true } },
      },
    }
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
}
