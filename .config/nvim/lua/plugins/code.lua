return {

  -- 注释
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
      keywords = {
        TODO = { icon = " ", color = "info", alt = { "todo" } },
        FIX = { icon = " ", color = "error", alt = { "TOFIX", "FIXME" } },
        NOTE = { icon = " ", color = "hint", alt = { "NOTE" } },
        HACK = { icon = " ", color = "warning", alt = { "HACK" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        PERF = { icon = " ", color = "default", alt = { "OPTIMIZE" } },
        DEBUG = { icon = " ", color = "debug", alt = { "DEBUG" } },
        IMPORTANT = { icon = " ", color = "error", alt = { "IMPORTANT" } },
        SUCCESS = { icon = " ", color = "success", alt = { "SUCCESS" } },
      },
      colors = {
        error = "DiagnosticError",
        warning = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        default = "Identifier",
        success = "String",
        debug = "Debug",
      },
      highlight = {
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", or empty
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- match keywords like `// TODO:`
        comments_only = true, -- highlight only inside comments
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    })
  end,
}
