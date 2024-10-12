return {
  "robitx/gp.nvim",
  config = function()
    local conf = {
      -- For customization, refer to Install > Configuration in the Documentation/Readme
      providers = {
        anthropic = {
          endpoint = "your_endpoint",
          secret = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
      agents = {
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
      hooks = {},
    }
    require("gp").setup(conf)

    -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
  end,
}
