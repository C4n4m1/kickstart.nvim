return {
  'norcalli/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    '*', -- Enable colors on all filetype
    -- Exclusion rules
    '!TelescopePrompt',
    '!TelescopeResults',
    '!namu_prompt',
    css = { rgb_fn = true }, -- Enable parsing of CSS rgb(...) functions
    c = { names = false }, -- Disable name highlighting for HTML files if desired
  },
}
