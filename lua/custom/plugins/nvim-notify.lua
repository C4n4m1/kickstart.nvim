return {
  'rcarriga/nvim-notify',
  opts = function()
    require('notify').setup {
      background_colour = 'NotifyBackground',
      fps = 30,
      icons = {
        DEBUG = '',
        ERROR = '',
        INFO = '',
        TRACE = '✎',
        WARN = '',
      },
      level = 1,
      minimum_width = 30,
      render = 'minimal',
      stages = 'fade',
      time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
      },
      timeout = 3000,
      top_down = true,
    }
  end,
}
