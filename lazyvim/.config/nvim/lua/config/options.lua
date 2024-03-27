-- code is stolen from https://github.com/echasnovski/nvim/blob/master/lua/ec/settings.lua
-- stylua: ignore start
-- Leader key =================================================================
vim.g.mapleader    = " "
vim.g.autoformat   = false
local opt = vim.opt

-- General ====================================================================
opt.backup         = false    -- Don't store backup
opt.mouse          = 'a'      -- Enable mouse
opt.switchbuf      = 'usetab' -- Use already opened buffers when switching
opt.writebackup    = false    -- Don't store backup
opt.undofile       = true     -- Enable persistent undo
opt.swapfile       = false
opt.guifont        = 'FiraCode Nerd Font:h16'
opt.cmdheight      = 0
opt.foldenable     = false
opt.clipboard      = ""

-- UI =========================================================================
vim.opt.conceallevel = 0
opt.breakindent      = true     -- Indent wrapped lines to match line start
opt.cursorline       = true     -- Enable highlighting of the current line
opt.laststatus       = 3        -- show statusline in last window
opt.linebreak        = true     -- Wrap long lines at 'breakat' (if 'wrap' is set)
opt.list             = true     -- Show helpful character indicators
opt.relativenumber   = true     -- Show relative line numbers
opt.pumblend         = 0        -- Make builtin completion menus slightly transparent
opt.pumheight        = 10       -- Make popup menu smaller
opt.ruler            = false    -- Don't show cursor position
opt.shortmess        = 'aoOWFc' -- Disable certain messages from |ins-completion-menu|
opt.showmode         = false    -- Don't show mode in command line
opt.signcolumn       = 'yes'    -- Always show signcolumn or it would frequently shift
opt.splitbelow       = true     -- Horizontal splits will be below
opt.splitright       = true     -- Vertical splits will be to the right
opt.termguicolors    = true     -- Enable gui colors
opt.winblend         = 0        -- Make floating windows transparent
opt.wrap             = false    -- Display long lines as just one line

vim.o.fillchars    = table.concat(
    { 'eob: ', 'fold:╌', 'horiz:═', 'horizdown:╦', 'horizup:╩', 'vert:║', 'verthoriz:╬', 'vertleft:╣',
        'vertright:╠' },
    ','
)
vim.o.listchars    = table.concat(
    { 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' },
    ','
)

opt.shortmess:append('C')  -- Don't show "Scanning..." messages
opt.splitkeep     = 'screen' -- Reduce scroll during window split

-- Editing ====================================================================
opt.autoindent    = true                                 -- Use auto indent
opt.expandtab     = true                                 -- Convert tabs to spaces
opt.formatoptions = 'rqnl1j'                             -- Improve comment editing
opt.ignorecase    = true                                 -- Ignore case when searching (use `\C` to force not doing that)
opt.incsearch     = true                                 -- Show search results while typing
opt.infercase     = true                                 -- Infer letter cases for a richer built-in keyword completion
opt.shiftwidth    = 4                                    -- Use this number of spaces for indentation
opt.smartcase     = true                                 -- Don't ignore case when searching if pattern has upper case
opt.smartindent   = true                                 -- Make indenting smart
opt.tabstop       = 4                                    -- Insert 4 spaces for a tab
opt.virtualedit   = 'block'                              -- Allow going past the end of line in visual block mode

opt.iskeyword:append('-')                              -- Treat dash separated words as a word text object

opt.completeopt            = 'menuone,noinsert,noselect' -- Customize completions

-- Define pattern for a start of 'numbered' list. This is responsible for
-- correct formatting of lists when using `gw`. This basically reads as 'at
-- least one special character (digit, -, +, *) possibly followed some
-- punctuation (. or `)`) followed by at least one space is a start of list
-- item'
opt.formatlistpat          = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

--stylua: ignore end
--
opt.clipboard = 'unnamedplus'

