return {
  {
    "robitx/gp.nvim",
    event = "VeryLazy",
    config = function()
      require("gp").setup({
        openai_api_key = os.getenv("OPENAI_API_KEY"),
        hooks = {
          InspectPlugin = function(plugin, params)
            print(string.format("Plugin structure:\n%s", vim.inspect(plugin)))
            print(string.format("Command params:\n%s", vim.inspect(params)))
          end,
          -- example of adding commands which implements curent buffer based on comments
          Implement = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by finishing the code above according to comment instructions."
              .. "Please respond only the code, nothing else."
            gp.Prompt(
              params,
              gp.Target.rewrite,
              nil,
              gp.config.command_model,
              template,
              gp.config.command_system_prompt
            )
          end,
          -- example of adding a custom chat command with non-default parameters
          -- (configured default might be gpt-3 and sometimes you might want to use gpt-4)
          BetterChatNew = function(gp, params)
            local chat_model = { model = "gpt-4", temperature = 0.7, top_p = 1 }
            local chat_system_prompt = "You are a general AI assistant."
            gp.cmd.ChatNew(params, chat_model, chat_system_prompt)
          end,

          Translator = function(gp, params)
            local chat_model = { model = "gpt-4", temperature = 0.7, top_p = 1 }
            local chat_system_prompt = "You are a Translator, help me translate between English and Chinese."
            gp.cmd.ChatNew(params, chat_model, chat_system_prompt)
          end,
          -- example of adding command which writes unit tests for the selected code
          UnitTests = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by writing table driven unit tests for the code above."
            gp.Prompt(params, gp.Target.enew, nil, gp.config.command_model, template, gp.config.command_system_prompt)
          end,
          -- example of adding command which explains the selected code
          Explain = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by explaining the code by adding comments of the code."
            gp.Prompt(params, gp.Target.enew, nil, gp.config.command_model, template, gp.config.chat_system_prompt)
          end,
          -- your own functions can go here, see README for more examples like
          -- :GpExplain, :GpUnitTests.., :GpBetterChatNew, ..
        },
      })
    end,
  },
}
