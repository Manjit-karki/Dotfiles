return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
      vim.keymap.set("n", "G", builtin.live_grep, {})

      -- Function for searching and scoping into a directory
      function search_and_scope_into_directory()
        builtin.find_files({
          prompt_title = "Search Directories",
          find_command = {"fd", "--type", "d", "--hidden", "--follow"},
          attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            actions.select_default:replace(function()
              local selection = require("telescope.actions.state").get_selected_entry()
              local selected_dir = selection.path

              -- Change the current working directory to the selected directory
              vim.cmd("cd " .. selected_dir)
              actions.close(prompt_bufnr)
            end)
            return true
          end,
        })
      end

      -- Keybinding to trigger directory search and scoping
      vim.keymap.set("n", "F", search_and_scope_into_directory)
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        defaults = {
          layout_strategy = "horizontal",
          layout_config ={
            horizontal = {
              prompt_position = "top",
              prompt_width = 1,
              preview_width = 0.50,
              results_width = 0.50,
              mirror = false,
            },
            vertical = {
              prompt_position = "top",
              preview_height = 0.4,
            },
          },
          sorting_strategy = "ascending",
          path_display = {"smart"},
          prompt_prefix = "    ",
          selection_caret = "    ",
          file_ignore_patterns = {
            "node_modules", "build", "dist", "yarn.lock"
          },
          mappings = {
            n = {
              ["q"] = require("telescope.actions").close,
            },
          },
          vimgrep_arguments = {
            "rg",
            "--follow",
            "--hidden",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/.vscode/*",
            "--glob=!**/build/*",
            "--glob=!**/dist/*",
            "--glob=!**/yarn.lock",
            "--glob=!**/package-lock.json",
          },
        },

        pickers = {
          find_files = {
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob=!**/.git/*",
              "--glob=!**/.idea/*",
              "--glob=!**/.vscode/*",
              "--glob=!**/build/*",
              "--glob=!**/dist/*",
              "--glob=!**/yarn.lock",
              "--glob=!**/package-lock.json",
            },
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
