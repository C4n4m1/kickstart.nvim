local M = {}

-- local bufs = {}

M.state = {
  buf = nil,
  win = nil,
  mode = 'hsplit', -- "float" | "vsplit" | "hsplit"
  fullscreen = false,
}

local function buf_valid()
  return M.state.buf ~= nil and vim.api.nvim_buf_is_valid(M.state.buf)
end

local function win_valid()
  return M.state.win ~= nil and vim.api.nvim_win_is_valid(M.state.win)
end

local function float_config(fs)
  if fs then
    return {
      relative = 'editor',
      width = vim.o.columns,
      height = vim.o.lines - 2,
      row = 0,
      col = 0,
      style = 'minimal',
      border = 'none',
    }
  end
  local w = math.floor(vim.o.columns * 0.85)
  local h = math.floor(vim.o.lines * 0.80)
  return {
    relative = 'editor',
    width = w,
    height = h,
    row = math.floor((vim.o.lines - h) / 2),
    col = math.floor((vim.o.columns - w) / 2),
    style = 'minimal',
    border = 'rounded',
  }
end

local function open_win()
  if M.state.mode == 'float' then
    M.state.win = vim.api.nvim_open_win(M.state.buf, true, float_config(M.state.fullscreen))
  elseif M.state.mode == 'vsplit' then
    vim.cmd 'botright vsplit'
    M.state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(M.state.win, M.state.buf)
    local w = M.state.fullscreen and vim.o.columns or math.floor(vim.o.columns * 0.40)
    vim.api.nvim_win_set_width(M.state.win, w)
  elseif M.state.mode == 'hsplit' then
    vim.cmd 'botright split'
    M.state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(M.state.win, M.state.buf)
    local h = M.state.fullscreen and (vim.o.lines - 2) or math.floor(vim.o.lines * 0.35)
    vim.api.nvim_win_set_height(M.state.win, h)
  end

  if vim.bo[M.state.buf].buftype ~= 'terminal' then
    vim.cmd 'term'
    -- vim.fn.termopen(vim.o.shell)
    -- vim.bo[M.state.buf].buflisted = false
  end
  vim.cmd 'startinsert'
end

function M.new(opts)
  local cmd = (opts and opts.cmd) or ''
  local term_cmd = cmd ~= '' and ('term ' .. cmd) or 'term'
  if not win_valid() then
    if M.state.mode == 'float' then
      M.state.buf = vim.api.nvim_create_buf(false, false)
      M.state.win = vim.api.nvim_open_win(M.state.buf, true, float_config(M.state.fullscreen))
      vim.cmd(term_cmd)
    elseif M.state.mode == 'vsplit' then
      vim.cmd 'botright vsplit'
      M.state.win = vim.api.nvim_get_current_win()
      vim.cmd(term_cmd)
      local w = M.state.fullscreen and vim.o.columns or math.floor(vim.o.columns * 0.40)
      vim.api.nvim_win_set_width(M.state.win, w)
    elseif M.state.mode == 'hsplit' then
      vim.cmd 'botright split'
      M.state.win = vim.api.nvim_get_current_win()
      vim.cmd(term_cmd)
      local h = M.state.fullscreen and (vim.o.lines - 2) or math.floor(vim.o.lines * 0.35)
      vim.api.nvim_win_set_height(M.state.win, h)
    end
  else
    vim.cmd(term_cmd)
  end
end

function M.toggle(opts)
  local new_mode = opts and opts.mode

  if win_valid() then
    vim.api.nvim_win_hide(M.state.win)
    M.state.win = nil
    if not new_mode or new_mode == M.state.mode then
      return
    end
  end

  if new_mode then
    M.state.mode = new_mode
  end
  if not buf_valid() then
    M.state.buf = vim.api.nvim_create_buf(false, false)
  end
  open_win()
end

function M.toggle_fullscreen()
  if not win_valid() then
    return
  end
  M.state.fullscreen = not M.state.fullscreen

  if M.state.mode == 'float' then
    vim.api.nvim_win_set_config(M.state.win, float_config(M.state.fullscreen))
  elseif M.state.mode == 'vsplit' then
    local w = M.state.fullscreen and vim.o.columns or math.floor(vim.o.columns * 0.40)
    vim.api.nvim_win_set_width(M.state.win, w)
  elseif M.state.mode == 'hsplit' then
    local h = M.state.fullscreen and (vim.o.lines - 2) or math.floor(vim.o.lines * 0.35)
    vim.api.nvim_win_set_height(M.state.win, h)
  end
end

return M
