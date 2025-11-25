return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        indent = { enabled = false },
        input = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = false },
    },
    keys = {
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>s",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.8,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        }
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd
                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
            end,
        })
    end,
}
