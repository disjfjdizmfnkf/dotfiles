-- local cmp = require "cmp"

return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  keys = {
    { "<C-h>", "<CMD>TmuxNavigateLeft<CR>", mode = "n" },
    { "<C-j>", "<CMD>TmuxNavigateDown<CR>", mode = "n" },
    { "<C-k>", "<CMD>TmuxNavigateUp<CR>", mode = "n" },
    { "<C-l>", "<CMD>TmuxNavigateRight<CR>", mode = "n" },
  },
}
