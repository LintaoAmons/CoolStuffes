local dap = require('dap')

dap.adapters.go = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. 'go/vscode-go/dist/debugAdapter.js' },
}
dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.exepath('/Users/lintao/go/bin/dlv')
  },
}
