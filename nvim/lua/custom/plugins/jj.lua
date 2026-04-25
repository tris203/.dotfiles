return {
  -- 'nicolasgb/jj.nvim',
  -- 'jceb/jiejie.nvim',
  'NicholasZolton/neojj',
  event = 'VeryLazy',
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'jjcommit',
      callback = function(ev)
        vim.bo[ev.buf].filetype = 'jjdescription'
      end,
    })
  end,
}
