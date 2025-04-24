require "nvchad.options"

-- add yours here!

vim.g.clipboard = {
  name = "win32yank",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = 0,
}

vim.opt.clipboard = "unnamedplus"

vim.filetype.add({
  extension = {
    sv  = "systemverilog",
    svh = "systemverilog",
  },
})


-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
