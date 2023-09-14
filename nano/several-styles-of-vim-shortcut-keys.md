# Several styles of vim shortcut keys
> You can find all my keybindings at 
> https://github.com/LintaoAmons/CoolStuffes/blob/main/lazyvim-from-scratch/.config/nvim/lua/config/keymaps.lua

## Leader + key sequence

- 好处:
  - 通常是有意义的首字母按键
  - 组合多
- 坏处: 比较慢

```
["GitDiff"] = "<leader>df"
```

## Modifier + key
> Modifier: Ctrl, Meta, Ctrl+Meta, Shift

- 好处: 按的快
- 坏处: 
  - 一般会没有意义
  - 组合少

- 使用场景: 一般用在常用的功能上

```
["FindFiles"] = "<C-p>"
["FindCommands"] = { mode = "niv", keys = "<C-M-p>" }
["Scratch"] = "<M-C-n>"
["QuitNvim"] = "<M-q>"
```

> TODO: [[How to use cmd as meta in mac terminal]]

## <Modifier+Key> + Key

- 好处:
  - 更多组合
  - Group keybindings
  - 我感觉会比 `Leader` 快一点
- 坏处: 
  - 吃掉一个简单的 `<Modifier + Key>` 的组合
  - 稍微慢一点

```
["PeekDefinition"] = "<M-k>k",
["PeekTypeDefinition"] = "<M-k>l",
["PeekGitChange"] = "<M-k>j",
["GitCommit"] = "<M-k>c",
["LspFinder"] = "<M-k>f",
```
