require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- indentation
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })

-- LSP
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<leader>ca', ':lua vim.lsp.buf.range_code_action()<CR>', { noremap = true, silent = true })

-- Custom diagnostic navigation with opening diagnostic float window
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = "single"}})<CR><cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = "single"}})<CR><cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- DEFAULT

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
