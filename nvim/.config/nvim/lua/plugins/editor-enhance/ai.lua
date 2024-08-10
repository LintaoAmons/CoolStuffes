return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
        require("supermaven-nvim").setup({
            disable_keymaps = true,
            log_level = "error",
        })

        local completion_preview = require("supermaven-nvim.completion_preview")
        vim.keymap.set('i', '<c-a>', completion_preview.on_accept_suggestion,
            { noremap = true, silent = true })
        vim.keymap.set('i', '<c-j>', completion_preview.on_accept_suggestion_word,
            { noremap = true, silent = true })
    end,
  },
  {
    dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
    opts = function()
      require("context-menu").setup({
        close_menu = { "q", "<ESC>", "<M-l>" },
        menu_items = {
          {
            order = 1,
            cmd = "AI",
            keymap = "a",
            action = {
              type = "sub_cmds",
              sub_cmds = {
                {
                  order = 1,
                  keymap = "a",
                  cmd = "New",
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[GpChatNew vsplit]])
                    end,
                  },
                },
                {
                  cmd = "Find",
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[GpChatFinder]])
                    end,
                  },
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        -- For customization, refer to Install > Configuration in the Documentation/Readme
        --
        providers = {
          -- openai = {
          --   endpoint = "http://43.207.87.59:3000/v1/chat/completions",
          --   secret = "sk-FsmTWnwWmMX5YPnh74DdCbAb0dA94306BfDa4c18578944E6",
          -- },
          anthropic = {
            endpoint = "https://api.anthropic.com/v1/messages",
            secret = os.getenv("ANTHROPIC_API_KEY"),
          },
        },
        agents = {
          -- {
          --   provider = "openai",
          --   name = "ChatGPT4o-mini-lintao",
          --   chat = true,
          --   command = false,
          --   -- string with model name or table with model name and parameters
          --   model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          --   -- system prompt (use this to specify the persona/role of the AI)
          --   system_prompt = require("gp.defaults").chat_system_prompt,
          -- },
          {
            provider = "anthropic",
            name = "ChatClaude-3-Haiku",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "claude-3-haiku-20240307", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
        },
        hooks = {
          EnglishPractice = function(gp, params)
            local template = [[
              我希望你扮演我的英语老师，给我出一些适用于日常交流的中文到英文翻译题目。
              在我提供翻译答案后，请分析并指出我的错误，同时提出实用的改进建议，
              以帮助我提高我的英语表达能力，而不是单纯的考试翻译技巧。
              同时还需要给出你觉得更简练自然的句子，不局限于我给出的翻译，并给出解释.
              题目的话题或主题应该在大范围内随机生成，
              题目的句型与语法特点也应有变化,并在解释的时候说明考察的句型和语法特点.
              我发出start指令后，从你开始给出随机的题目,句子构成以及难度应该偏难，以长句为主,
              每一轮解释结束后直接给出下一轮的句子
            ]]
            gp.cmd.ChatNew(params, template)
          end,
        },
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },
}
