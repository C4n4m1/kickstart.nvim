return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'LspAttach',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup {
      preset = 'simple',
      options = {
        multilines = {
          enabled = false,
        },
      },
    }
    vim.diagnostic.config { virtual_text = false, underline = false } -- Disable Neovim's default virtual text diagnostics
  end,
}
