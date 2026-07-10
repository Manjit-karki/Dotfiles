return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Logo
    local logo = {
      [[                                                        ]],
      [[██╗  ██╗ █████╗ ████████╗███████╗██╗   ██╗███╗   ███╗██╗]],
      [[██║ ██╔╝██╔══██╗╚══██╔══╝██╔════╝██║   ██║████╗ ████║██║]],
      [[█████╔╝ ███████║   ██║   ███████╗██║   ██║██╔████╔██║██║]],
      [[██╔═██╗ ██╔══██║   ██║   ╚════██║██║   ██║██║╚██╔╝██║██║]],
      [[██║  ██╗██║  ██║   ██║   ███████║╚██████╔╝██║ ╚═╝ ██║██║]],
      [[╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝]],
      [[                  Manjit's Workspace                    ]],
    }
    dashboard.section.header.val = logo

    -- Buttons
    dashboard.section.buttons.val = {
      dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰱼  > Find file", ":lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files' } })<CR>"),
      dashboard.button("F", "󰥨  > Find folder",":lua search_and_scope_into_directory()<CR>"),
      dashboard.button("c", "  > Config", ":cd ~/.config/nvim | Telescope find_files<CR>"),
      dashboard.button("l", "󰒲  > Lazy", ":Lazy<CR>"),
      dashboard.button("h", "  > Settings", ":cd ~/.config/hypr | Telescope find_files<CR>"),
      dashboard.button("q", "  > Quit", ":qa<CR>"),
    }

    -- Footer
    dashboard.section.footer.val = {
      "",
      "Welcome, Katsumi!",
    }

    -- Dynamically calculate top padding to center the dashboard
    local function center_layout()
      local total_height = #dashboard.section.header.val
          + #dashboard.section.buttons.val * 2
          + #dashboard.section.footer.val
          + 6 -- extra padding between sections

      local win_height = vim.o.lines
      local top_padding = math.max(0, math.floor((win_height - total_height) / 2))

      return {
        { type = "padding", val = top_padding },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 2 },
        dashboard.section.footer,
      }
    end

    dashboard.config.layout = center_layout()

    -- Load pywal colors
    local wal_colors_file = vim.fn.expand("~/.cache/wal/colors.json")
    if vim.fn.filereadable(wal_colors_file) == 1 then
      local file = io.open(wal_colors_file, "r")
      if file then
        local content = file:read("*a")
        file:close()
        local ok, colors = pcall(vim.fn.json_decode, content)
        if ok and colors then
          vim.api.nvim_set_hl(0, "AlphaHeader", { fg = colors.colors.color2 })
          vim.api.nvim_set_hl(0, "AlphaButtons", { fg = colors.colors.color4 })
          vim.api.nvim_set_hl(0, "AlphaFooter", { fg = colors.colors.color5, italic = true })

          dashboard.section.header.opts.hl = "AlphaHeader"
          dashboard.section.buttons.opts.hl = "AlphaButtons"
          dashboard.section.footer.opts.hl = "AlphaFooter"
        end
      end
    end

    -- Setup alpha
    alpha.setup(dashboard.opts)

    -- Disable mouse in alpha dashboard
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.mouse = ""
      end,
    })

    -- Re-enable mouse when leaving alpha
    vim.api.nvim_create_autocmd("BufUnload", {
      callback = function(args)
        if vim.bo[args.buf].filetype == "alpha" then
          vim.opt.mouse = "a"
        end
      end,
    })


  end,
}
