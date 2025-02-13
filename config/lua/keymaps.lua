local keymap = vim.keymap.set

-- Disable Arrows
keymap({ "n", "v", "i", "c" }, "<Up>", "<Nop>")
keymap({ "n", "v", "i", "c" }, "<Down>", "<Nop>")
keymap({ "n", "v", "i", "c" }, "<Left>", "<Nop>")
keymap({ "n", "v", "i", "c" }, "<Right>", "<Nop>")

-- Tab
keymap("n", "<Tab>", ">>")
keymap("n", "<S-Tab>", "<<")
keymap("v", "<Tab>", ">gv")
keymap("v", "<S-Tab>", "<gv")
