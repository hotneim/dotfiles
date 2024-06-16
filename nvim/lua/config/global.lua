-- Proper colors
vim.opt.termguicolors = true

-- Show linenumbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Ability to use mouse
vim.opt.mouse = 'a'
vim.opt.mousefocus = true

-- Use system clipboard
vim.opt.clipboard:append 'unnamedplus'

-- Timeout until which-key pops up
vim.opt.timeoutlen = 300

-- Tabs, indentation
vim.opt.tabstop = 2       -- Number of spaces in a tab
vim.opt.softtabstop = 2   -- Same?
vim.opt.shiftwidth = 2    -- Spaces for autoindent
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.autoindent = true -- Auto indentation
vim.opt.list = true       -- Show tab chars and trailing white
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- consistent number column
vim.opt.signcolumn = 'yes:1'

-- Soft wrapping of all files
vim.o.wrap = true                                -- Enable
vim.o.linebreak = true                           -- Navigation of wrapped lines
vim.o.whichwrap = vim.o.whichwrap .. "<,>,h,l"   -- Cursor movement in wrapped lines

-- Map 'j' and 'k' to 'gj' and 'gk' to navigate wrapped lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })

-- split right and below by default
vim.opt.splitright = true
vim.opt.splitbelow = true

-- scroll before end of window
vim.opt.scrolloff = 5

-- Show diagnostics
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
}

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

