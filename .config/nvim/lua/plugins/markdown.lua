return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  vim.api.nvim_set_keymap("n", "mp", "<CMD>Markview<CR>", { desc = "Toggle `markview` globally" });
}
