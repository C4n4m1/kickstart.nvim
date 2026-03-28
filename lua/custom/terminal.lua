local M = {}

local state = {
  buf = nil,
  win = nil,
  mode = 'vsplit', -- "float" | "vsplit" | "hsplit"
  fullscreen = false,
}

local function buf_valid()
  return state.buf ~= nil and vim.api.nvim_buf_is_valid(state.buf)
end

local function win_valid()
  return state.win ~= nil and vim.api.nvim_win_is_valid(state.win)
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
  if state.mode == 'float' then
    state.win = vim.api.nvim_open_win(state.buf, true, float_config(state.fullscreen))
  elseif state.mode == 'vsplit' then
    vim.cmd 'botright vsplit'
    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(state.win, state.buf)
    local w = state.fullscreen and vim.o.columns or math.floor(vim.o.columns * 0.40)
    vim.api.nvim_win_set_width(state.win, w)
  elseif state.mode == 'hsplit' then
    vim.cmd 'botright split'
    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(state.win, state.buf)
    local h = state.fullscreen and (vim.o.lines - 2) or math.floor(vim.o.lines * 0.35)
    vim.api.nvim_win_set_height(state.win, h)
  end

  if vim.bo[state.buf].buftype ~= 'terminal' then
    vim.fn.termopen(vim.o.shell)
    vim.bo[state.buf].buflisted = false
  end
  vim.cmd 'startinsert'
end

function M.toggle(opts)
  local new_mode = opts and opts.mode

  if win_valid() then
    vim.api.nvim_win_hide(state.win)
    state.win = nil
    if not new_mode or new_mode == state.mode then
      return
    end
  end

  if new_mode then
    state.mode = new_mode
  end
  if not buf_valid() then
    state.buf = vim.api.nvim_create_buf(false, false)
  end
  open_win()
end

function M.toggle_fullscreen()
  if not win_valid() then
    return
  end
  state.fullscreen = not state.fullscreen

  if state.mode == 'float' then
    vim.api.nvim_win_set_config(state.win, float_config(state.fullscreen))
  elseif state.mode == 'vsplit' then
    local w = state.fullscreen and vim.o.columns or math.floor(vim.o.columns * 0.40)
    vim.api.nvim_win_set_width(state.win, w)
  elseif state.mode == 'hsplit' then
    local h = state.fullscreen and (vim.o.lines - 2) or math.floor(vim.o.lines * 0.35)
    vim.api.nvim_win_set_height(state.win, h)
  end
end

return M
