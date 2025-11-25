local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.cmd("set number")
vim.cmd("set relativenumber")
require("vim-options")
require("lazy").setup("plugins")
vim.opt.termguicolors = true
vim.g.loaded_matchparen = 1
vim.opt.fillchars:append { eob = " "}


vim.keymap.set('n', 'L', ':bnext<CR>', { silent = true })
vim.keymap.set('n', 'H', ':bprevious<CR>', { silent = true })
vim.keymap.set('n', 'Q', ':bdelete<CR>', { silent = true })
