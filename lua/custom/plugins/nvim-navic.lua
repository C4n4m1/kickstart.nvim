return {
  'SmiteshP/nvim-navic',
  dependencies = 'neovim/nvim-lspconfig',
  lazy = false,
  config = function()
    local ok, navic = pcall(require, 'nvim-navic')
    if not ok then
      return
    end
    navic.setup {
      icons = {
        File = '󰈙 ',
        Module = '󰆧 ',
        Namespace = '󰌗 ',
        Package = '󰏗 ',
        Class = '󰌗 ',
        Method = '󰆧 ',
        Property = '󰇽 ',
        Field = '󰇽 ',
        Constructor = '󰌗 ',
        Enum = '󰅻 ',
        EnumMember = '󰘦 ',
        Constant = '󰏿 ',
        Function = '󰊕 ',
        Variable = '󰀫 ',
        String = '󰀬 ',
        Number = '󰀠 ',
        Boolean = '󰀡 ',
        Array = '󰅡 ',
        Object = '󰅩 ',
        Key = '󰌋 ',
        Null = '󰀤 ',
        TypeParameter = '󰅲 ',
      },
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      lazy_update_context = false,
      click = true,
      format_text = function(text)
        local max_len = 40
        if #text > max_len then
          return '...' .. text:sub(-(max_len - 3))
        end
        return text
      end,
    }
  end,
}
