require "nvchad.options"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.expandtab = false
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.listchars = {
  eol = "↵",
  nbsp = "␣",
  tab = "⟩•",
  lead = "^",
  trail = "␣",
  extends = "⟩",
  precedes = "⟨",
  multispace = "_",
}
vim.opt.list = true
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
