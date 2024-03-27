return {
	{
		"mzlogin/vim-markdown-toc",
		ft = { "markdown" },
		-- GenTocGitLab, GenTocMarded
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
        branch = 'fix/insert-base64-markup',
		opts = {
			default = {
				dir_path = "static", -- directory path to save images to, can be relative (cwd or current file) or absolute
				file_name = "%Y-%m-%d-%H-%M-%S", -- file name format (see lua.org/pil/22.1.html)
				url_encode_path = false, -- encode spaces and special characters in file path
				use_absolute_path = false, -- expands dir_path to an absolute path
				relative_to_current_file = false, -- make dir_path relative to current file rather than the cwd
				relative_template_path = true, -- make file path in the template relative to current file rather than the cwd
				prompt_for_file_name = true, -- ask user for file name before saving, leave empty to use default
				show_dir_path_in_prompt = false, -- show dir_path in prompt when prompting for file name
				use_cursor_in_template = true, -- jump to cursor position in template after pasting
				insert_mode_after_paste = true, -- enter insert mode after pasting the markup code
				embed_image_as_base64 = true, -- paste image as base64 string instead of saving to file
                process_cmd = "convert -quality 25 - -",
				max_base64_size = 1000, -- max size of base64 string in KB
				template = "$FILE_PATH", -- default template

				drag_and_drop = {
					enabled = true, -- enable drag and drop mode
					insert_mode = false, -- enable drag and drop in insert mode
					copy_images = false, -- copy images instead of using the original file
					download_images = true, -- download images and save them to dir_path instead of using the URL
				},
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
