return {
  dir = '/home/tris/code/hawtkeys.nvim',
  cmd = { 'Hawtkeys', 'HawtkeysAll', 'HawtkeysDupes' },
  config = {
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
