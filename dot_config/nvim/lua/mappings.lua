require "nvchad.mappings"

local map = vim.keymap.set

map("n", ",", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-l>",":bnext <cr>", { desc = "Next Buffer" })
map("n", "<C-h>",":bprevious <cr>", { desc = "Previous Buffer" })
map("n", "<leader>q",":quit <cr>", { desc = "Close" })

map("n", "<leader>tf", ":TestFile <cr>", { desc = "Test File" })
map("n", "<leader>tn", ":TestFile <cr>", { desc = "Test Nearest" })
map("n", "<leader>tl", ":TestFile <cr>", { desc = "Test Last" })
map("n", "<leader>ts", ":TestFile <cr>", { desc = "Test Suite" })
