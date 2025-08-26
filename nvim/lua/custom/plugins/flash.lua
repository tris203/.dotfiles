return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    vscode = true,
    ---@type Flash.Config
    opts = {
      jump = {
        autojump = true,
      },
      modes = {
        -- search = {
        --   enabled = true,
        -- },
        char = {
          jump_labels = true,
        },
      },
    },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
  },
}
