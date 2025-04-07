return {
  'norcalli/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    '*', -- Enable color highlighting for all filetypes
    css = { rgb_fn = true }, -- Enable parsing of CSS rgb(...) functions
    -- html = { names = false },  -- Disable name highlighting for HTML files if desired
  },
}
