local M = {}

-- State
M.active = false
M.chars = 'asdfghjklqwertyuiopzxcvbnm1234567890'
M.bufpos2char = {}

-- Count listed buffers
local function count_buffers()
  local count = 0
  for b = 1, vim.fn.bufnr '$' do
    if vim.fn.buflisted(b) ~= 0 and vim.api.nvim_buf_get_option(b, 'buftype') ~= 'quickfix' then
      count = count + 1
    end
  end
  return count
end

-- Generate unique pick characters for buffers
function M.generate_chars()
  local chars = {}
  local buffer_count = count_buffers()
  local char_index = 1

  for i = 1, buffer_count do
    if char_index > #M.chars then
      break
    end
    chars[i] = M.chars:sub(char_index, char_index)
    char_index = char_index + 1
  end

  return chars
end

-- Enter pick mode
function M.enter()
  if M.active then
    return
  end

  M.active = true
  M.bufpos2char = M.generate_chars()
  require('lualine').refresh()

  vim.defer_fn(function()
    M.handle_input()
  end, 100)
end

-- Exit pick mode
function M.exit()
  M.active = false
  M.bufpos2char = {}
  require('lualine').refresh()
end

-- Handle pick character input
function M.handle_input()
  if not M.active then
    return
  end

  local char = vim.fn.getcharstr()

  -- ESC key to cancel
  if char == '\27' or char == '\x1b' then
    M.exit()
    return
  end

  -- Find and jump to buffer
  for buf_pos, pick_char in pairs(M.bufpos2char) do
    if pick_char == char then
      local fb = require('lualine.components.fancybuffers')
      fb.buffer_jump(buf_pos, '')
      M.exit()
      return
    end
  end

  M.exit()
end

-- Get pick character for buffer position
function M.get_char(buf_pos)
  if not M.active then
    return nil
  end
  return M.bufpos2char[buf_pos]
end

return M
