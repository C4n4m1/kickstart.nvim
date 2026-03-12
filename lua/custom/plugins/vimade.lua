return {
  'tadaa/vimade',
  opts = {
    recipe = { 'default', { animate = false } },
    fadelevel = 0.4,
    tint = {
      fg = { rgb = { 255, 0, 0 }, intensity = 0.5 },
      bg = { rgb = { 0, 0, 0 }, intensity = 0.6 },
    },
    blocklist = {
      demo_tutorial = function(win, current)
        -- current can be nil
        if (win.win_config.relative == '') and (current and current.win_config.relative ~= '') then
          return false
        end
        return true
      end,
    },
  },
}
