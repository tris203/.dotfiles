return {
"vim-test/vim-test",
  event = "VeryLazy",
  dependencies = {
    "preservim/vimux",
  },
  config = function()
    vim.cmd("let test#strategy = 'vimux'")
  end,
}
