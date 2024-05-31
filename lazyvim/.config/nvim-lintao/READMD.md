# 去到 https://lintao-index.pages.dev/docs/Vim/Neovim/explain-my-config 查看更多详细解释

# 我的配置解析
> 去这里看看我的 [配置](https://github.com/LintaoAmons/CoolStuffes/tree/main/lazyvim/.config/nvim)

## 配置结构

### 插件

使用了 [lazy.nvim](./plugin-manager.md) 作为插件管理器，`lua/plugins` 文件夹下所有的lua 文件 return 出来的 table 都会被lazy.nvim 拿去解析下载插件

- `lua/plugins` 文件夹下有我用的插件的配置，为了更好地组织这些插件配置，又分成了几个子文件夹
    - [lua/plugins/init.lua](./lua/plugins/init) 是很重要的一个文件，里面用到了`import` 来引入这些子文件夹中的插件配置
    - lua/plugins/editor-core 有这几个插件就可以像个不错的编辑器用了
    - lua/plugins/editor-enhance 根据我的需求增强编辑器
    - lua/plugins/lang-core 配置各种编程语言的基础核心插件，包括自动补全，LSP，TreeSitter（语法高亮），自动格式化，Debug的通用配置
    - lua/plugins/lang 各种语言特定的配置项
    - lua/plugins/ui 把 neovim 搞好看
    - lua/plugins/git 集成 git
- `lua/config` 下的配置全是 neovim 自己的配置，不依赖插件

<details>
<summary>点击展开详细结构</summary>
```sh
.
├── init.lua
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   └── options.lua
│   ├── plugins
│   │   ├── init.lua
│   │   ├── editor-core
│   │   │   ├── commands.lua
│   │   │   ├── neo-tree.lua
│   │   │   ├── telescope.lua
│   │   │   └── vim-tmux-navigator.lua
│   │   ├── editor-enhance
│   │   │   ├── bookmarks.lua
│   │   │   ├── multi-cursor.lua
│   │   │   ├── ...
│   │   │   └── which-key.lua
│   │   ├── git
│   │   │   ├── diffview.lua
│   │   │   └── gitsign.lua
│   │   ├── lang
│   │   │   ├── example.lua
│   │   │   ├── ...
│   │   │   └── tsjs.lua
│   │   ├── lang-core
│   │   │   ├── cmp.lua
│   │   │   ├── debug.lua
│   │   │   ├── formatting.lua
│   │   │   ├── lsp.lua
│   │   │   ├── snippet.lua
│   │   │   └── treesitter.lua
│   │   └── ui
│   │       ├── ...
│   │       └── themes.lua
│   └── snippets
│       ├── ...
│       └── typescript.json
└── scratch_config.json
```
</details>

## TODO

- [ ] Format
