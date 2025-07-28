local function getPath()
  --check hostname for different paths
  local path
  local hostname = vim.loop.os_gethostname()
  if hostname == 'pop-os' then
    path = '~/Obsidian/Home'
  else
    path = '/tmp/obsidian'
  end
  -- print(path)
  return path
end

return {
  -- 'epwalsh/obsidian.nvim',
  'obsidian-nvim/obsidian.nvim',
  cmd = { 'Obsidian' },
  -- version = '*', -- recommended, use latest release instead of latest commit
  keys = {
    -- { '<leader>of', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Obsidan Quick Switch' },
    -- { '<leader>og', '<cmd>ObsidianSearch<cr>', desc = 'Obsidian Search' },
    {
      '<leader>on',
      function()
        local note_name = vim.fn.input 'Note name: '
        vim.cmd('Obsidian new ' .. note_name)
      end,
      desc = 'Obsidian New',
    },
    { '<leader>oo', '<cmd>Obsidian open<cr>', desc = 'Obsidian Open' },
    { '<leader>ot', '<cmd>Obsidian tags<cr>', desc = 'Obsidian Tags' },
    {
      '<leader>of',
      function()
        Snacks.picker.files { cwd = getPath(), follow = true }
      end,
    },
    {
      '<leader>og',
      function()
        Snacks.picker.grep { cwd = getPath(), follow = true }
      end,
    },
  },
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    legacy_commands = false,
    completion = {
      blink = true,
      nvim_cmp = false,
      min_chars = 0,
    },
    ui = { enable = false },
    workspaces = {
      {
        name = 'Home',
        path = getPath(),
      },
    },
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,
  },
}
