return {
  'tris203/hawtkeys.nvim',
  dev = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'Hawtkeys', 'HawtkeysAll', 'HawtkeysDupes' },
  opts = {
    -- keyboardLayout = "colemak",
    customMaps = {
      ['nmap'] = {
        modeIndex = 'n',
        lhsIndex = 1,
        rhsIndex = 2,
        method = 'function_call',
      },
      ['lazy'] = {
        method = 'lazy',
      },
    },
  },
}
