-- Function to open all folds and set fold settings
local function open_all_folds()
  vim.cmd('normal! zR')
  -- Explicitly set fold settings again
  vim.o.foldmethod = 'manual'
  vim.o.foldlevel = 99
  vim.wo.foldmethod = 'manual'
  vim.wo.foldlevel = 99
end

-- Autocommand to open all folds when entering a buffer
vim.api.nvim_create_autocmd({"BufReadPost", "FileReadPost"}, {
  pattern = "*",
  callback = open_all_folds,
})

-- Delay fold opening to ensure all plugins have loaded
vim.defer_fn(function()
  -- Explicitly set fold settings and open folds
  vim.o.foldmethod = 'manual'
  vim.o.foldlevel = 99
  vim.wo.foldmethod = 'manual'
  vim.wo.foldlevel = 99
  vim.cmd('normal! zR')
end, 100)

-- Ensure folds are open when entering Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "normal! zR"
})

