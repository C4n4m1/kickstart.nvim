return {
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
    {
      '<leader>ct',
      function()
        vim.g.autoformat = not vim.g.autoformat
        vim.notify('Autoformat ' .. (vim.g.autoformat and 'enabled' or 'disabled'))
      end,
      desc = '[Code]: [Toggle] Autoformat',
    },
  },
  init = function()
    vim.g.autoformat = true -- on by default
  end,
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if not vim.g.autoformat then
        return
      end -- ← skip if toggled off
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
      c = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      json = { 'prettier' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
