-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)
-- Slecet all
keymap.set("n", "<C-a>", "<cmd>normal! ggVG<CR>", { noremap = true, silent = true })
