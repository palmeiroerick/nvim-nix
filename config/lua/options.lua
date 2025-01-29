local options = {
  backup = false,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  softtabstop = 2,
  tabstop = 2,
  cursorline = true,
  mouse = "",
  number = true,
  relativenumber = true,
  scrolloff = 8,
  sidescrolloff = 16,
  showmode = false,
  termguicolors = true,
  wrap = false,
  fillchars = { eob = " " },
  splitbelow = true,
  splitright = true,
  swapfile = false,
  clipboard = "unnamedplus",
  signcolumn = "yes",
  ignorecase = true,
  updatetime = 250,
  smartcase = true,
  statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s",
  cmdheight = 0,
  timeout = true,
  timeoutlen = 300,
  whichwrap = "h,l",
}

vim.g.markdown_recommended_style = 0
vim.g.loaded_matchparen = 1
vim.g.mapleader = " "

for key, value in pairs(options) do
  vim.opt[key] = value
end