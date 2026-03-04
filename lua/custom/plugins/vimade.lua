return {
  'tadaa/vimade',
  opts = {
    recipe = { 'default', { animate = true } },
    fadelevel = 0.3,
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
