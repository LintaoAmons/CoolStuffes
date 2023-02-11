-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

local function closeWindowOrBuffer()
  local isOk, _ = pcall(vim.cmd, "close")

  if not isOk then vim.cmd "bd" end
end

-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- add your own keymapping
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

local function unmapLvimDefault()
  lvim.keys.normal_mode["<M-w>"] = false

  lvim.builtin.which_key.mappings['w'] = {}
  lvim.builtin.which_key.mappings['f'] = {}
end

local function bufferLineKeybindings()
  lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"
  lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
end

local function explorer()
  lvim.keys.normal_mode["<C-n>"] = "<cmd>NvimTreeToggle<cr>"
  lvim.keys.normal_mode["<leader>fl"] = "<cmd>NvimTreeFocus<cr>" -- find location
end

local function leap()
  lvim.keys.normal_mode["s"] = function()
    require("leap").leap {
      target_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
      ),
    }
  end
end

local function tab()
  lvim.keys.normal_mode["tm"] = "<cmd>tabclose<cr>"
  lvim.keys.normal_mode["tn"] = "<cmd>tabnew<cr>"
  lvim.keys.normal_mode["tl"] = "<cmd> tabnext <CR>"
  lvim.keys.normal_mode["th"] = "<cmd> tabprevious <CR>"
end

local function telescopeMappings()
  lvim.keys.normal_mode["<leader>fE"] = { "<cmd>Telescope oldfiles<cr>" }
  lvim.keys.normal_mode["<C-p>"] = { "<cmd> Telescope find_files <CR>" }
  lvim.keys.normal_mode["<C-M-p>"] = { "<cmd>Telescope keymaps<cr>" }
  lvim.keys.normal_mode["<M-e>"] = { "<cmd>Telescope oldfiles<cr>" }
  lvim.keys.normal_mode["<leader>fk"] = { "<cmd>Telescope keymaps<cr>" }
  lvim.keys.normal_mode["gr"] = { "<CMD>lua require'telescope.builtin'.lsp_references{}<CR>" }
  lvim.keys.normal_mode["gd"] = { "<CMD>Telescope lsp_definitions<CR>" }
  lvim.keys.normal_mode["<leader>fw"] = { ":Telescope live_grep<cr>" }
  lvim.keys.normal_mode["<C-M-f>"] = { ":Telescope live_grep<cr>" }
end

local function window()
  lvim.keys.normal_mode["<leader>wl"] = { "<cmd>vsplit<cr>", desc = "Split window vertically" }
  lvim.keys.normal_mode["<leader>wo"] = { "<c-w>o", desc = "Maximize window" }
  lvim.keys.normal_mode["<leader>wc"] = { "<c-w>c", desc = "Close window" }
  -- windowResize
  lvim.keys.normal_mode["<C-M-j>"] = { "<CMD>vertical resize +5<CR>" }
  lvim.keys.normal_mode["<C-M-k>"] = { "<CMD>vertical resize -5<CR>" }
end

local function lspsaga()
  lvim.keys.normal_mode["ge"] = { "<CMD>Lspsaga diagnostic_jump_next<CR>" }
  lvim.keys.normal_mode["gt"] = { "<CMD>GoAlt<CR>" }
  lvim.keys.normal_mode["K"] = { "<CMD>Lspsaga hover_doc<CR>" }
  lvim.keys.normal_mode["<M-k>"] = { "<CMD>Lspsaga code_action<CR>" }
  lvim.keys.normal_mode["<leader>lf"] = { "<CMD>Lspsaga lsp_finder<CR>" }
  lvim.keys.normal_mode["gl"] = { "<CMD>Lspsaga lsp_finder<CR>" }
  lvim.keys.normal_mode["<M-l>"] = { "<CMD>Lspsaga lsp_finder<CR>" }
  lvim.keys.normal_mode["<leader>rn"] = { "<CMD>Lspsaga rename<CR>" }
end

local function git()
  lvim.keys.normal_mode["gj"] = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>" }
  lvim.keys.normal_mode["gk"] = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>" }
  lvim.keys.normal_mode["<leader>gf"] = { "<CMD>DiffviewFileHistory %<CR>" }
  lvim.keys.normal_mode["<leader>gh"] = { "<CMD>DiffviewFileHistory<CR>" }
  lvim.keys.normal_mode["<leader>gd"] = { "<CMD>DiffviewOpen<CR>" }
  lvim.keys.normal_mode["<leader>cc"] = { "<CMD>Git commit<CR>" }
end

local mappings = {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<M-w>"] = { function() closeWindowOrBuffer() end, desc = "Close current window/split" },
    ["<M-q>"] = { "<cmd>qa!<CR>", desc = "quit nvim" },

    ["<leader>df"] = { "<cmd> DiffviewOpen <cr>", desc = "Open diffview" },
    -- ["<leader>dd"] = { "<cmd> DiffviewFileHistory %<cr>", desc = "diff current file" },
    ["<leader>dv"] = { ":call v:lua.compare_to_clipboard()<CR>", desc = "Diff selected with clipboard" },


    ["<leader>fm"] = { "<cmd>lua vim.lsp.buf.format { async = true } <cr>", desc = "Format" },

    ["<leader>gr"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset git hunk" },

    -- Run
    ["<leader>rr"] = { "<cmd>GoTestFile<cr>", desc = "GoTestFile" },
    ["<leader>rt"] = { "<cmd>GoTest<cr>", desc = "RunAllGoTest: GoTestFile" },
    ["<leader>rl"] = { "<cmd>luafile %<cr>", desc = "Source current lua file" },
    ["<M-r>"] = { ":%SnipRun<CR>", desc = "Run current file" },

    ["<leader>zo"] = { "zR", desc = "Unfold all" },
    ["<leader>zc"] = { "zM", desc = "Fold all" },


    -- No
    ["<leader>nl"] = { "<cmd> nohl <CR>", desc = "nohl" },

    -- Show
    ["<leader>ss"] = { "<cmd>AerialToggle<CR>", desc = "Show outline" },

    ["<C-q>"] = { "<cmd>SessionManager load_session<CR>", desc = "Load session" }, -- <!>load_session

    -- Test KeyStroke
    ["<C-M-m>"] = { '<cmd>lua vim.notify("heihei")<CR>' }, -- command+control+m
    ["<M-m>"] = { '<cmd>lua vim.notify("<M> is CMD in Mac, achieve by wezterm")<CR>' }, -- command+m
    ["<M-I>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }, -- alt + shift + i --> tab + i --> by karabiner

    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },

    -- ["<leader>db"] = {
    --   "<cmd>lua require'dap'.toggle_breakpoint(); require'user.dap.dap-util'.store_breakpoints(true)<cr>",
    -- },
    -- ["<leader>dt"] = {"<CMD>GoDebug -t<CR>"},
    -- ["<M-F8>"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>" }, -- command+f8
    -- ["<F4>"] = { "<cmd>lua require'dap'.terminate()<CR>" },
    -- ["<F9>"] = { "<cmd>lua require'dap'.continue()<CR>" },
    -- ["<F7>"] = { "<cmd>lua require'dap'.step_into()<CR>" },
    -- ["<F8>"] = { "<cmd>lua require'dap'.step_over()<CR>" },
  },
  i = {
    ["<C-q>"] = { "<cmd>SessionManager load_session<CR>", desc = "Load session" }, -- <!>load_session
    ["<M-P>"] = { "<cmd>Telescope commands<CR>", desc = "Find commands" },

    [";;"] = { " := ", desc = "golang: assign value" },
    [";a"] = { " != ", desc = "!=" },
    [";s"] = { " += ", desc = "+=" },
    [";d"] = { " == ", desc = "==" },
  },
  v = {
    -- ["<leader>dd"] = { "<cmd> DiffviewFileHistory<cr>", desc = "Diff file history" },
    ["<M-r>"] = { "<Plug>SnipRun" },
    ["<M-k>"] = { "<CMD>Lspsaga code_action<CR>", desc = "Code Action" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', 'uo', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

function Setup()
  unmapLvimDefault()
  bufferLineKeybindings()
  explorer()
  leap()
  tab()
  telescopeMappings()
  lspsaga()
  git()
  window()

  -- migrate my old configs
  for mode, keybinding in pairs(mappings) do
    for key, value in pairs(keybinding) do
      if mode == 'n' then
        lvim.keys.normal_mode[key] = value[1]
      elseif mode == 'i' then
        lvim.keys.insert_mode[key] = value[1]
      elseif mode == 'v' then
        vim.keymap.set("v", key, value[1])
      end
    end
  end
end

Setup()
