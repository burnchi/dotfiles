-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- find file
keymap.set({ "n", "i" }, "<C-p>", require("telescope.builtin").find_files, opts)

-- movement
keymap.set({ "n", "v", "o" }, "H", "^", { desc = "Use 'H' as '^'" })
keymap.set({ "n", "v", "o" }, "L", "$", { desc = "Use 'L' as '$'" })

-- go to normal
keymap.set("i", "jk", "<Esc>")
-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Delect one line
keymap.set({ "i" }, "<C-d>", "<Esc>dd")

--insert one line // TODO:CR keymap
-- keymap.set({ "n", "i" }, "<A-CR>", "<Esc>o")
-- keymap.set({ "n", "i" }, "<s-CR>", "<Esc>O")

-- Split window
keymap.set("n", "ss", ":vsplit<CR>", opts)
keymap.set("n", "sv", ":split<CR>", opts)

-- insert mode cursor go to next line
-- keymap.set({ "i" }, "<C-Enter>", "<Esc>o", opts)

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")
