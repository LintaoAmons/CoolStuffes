local ls = require("luasnip")

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

require("luasnip.loaders.from_vscode").load_standalone({
  path = "~/.config/nvim/snippets/NeogitCommitMessage.code-snippets",
})

return {}
