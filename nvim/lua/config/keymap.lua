-- required in which-key plugin spec in plugins/ui.lua as `require 'config.keymap'`
local wk = require 'which-key'

-- Functions for quick keymap settings
local nmap = function(key, effect)
  vim.keymap.set('n', key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
  vim.keymap.set('v', key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
  vim.keymap.set('i', key, effect, { silent = true, noremap = true })
end

local cmap = function(key, effect)
  vim.keymap.set('c', key, effect, { silent = true, noremap = true })
end

-- keep selection after indent/dedent
vmap('>', '>gv')
vmap('<', '<gv')

-- Move between windows using <ctrl> direction
nmap('<C-j>', '<C-W>j')
nmap('<C-k>', '<C-W>k')
nmap('<C-h>', '<C-W>h')
nmap('<C-l>', '<C-W>l')

-- Resize window using <shift> arrow keys
nmap('<S-Up>', '<cmd>resize +2<CR>')
nmap('<S-Down>', '<cmd>resize -2<CR>')
nmap('<S-Left>', '<cmd>vertical resize -2<CR>')
nmap('<S-Right>', '<cmd>vertical resize +2<CR>')

-- wk.register({
--   p = { '"_dP', 'replace without overwriting reg' },
--   d = { '"_d', 'delete without overwriting reg' },
-- }, { mode = 'v', prefix = '<leader>' })

wk.add({
  { "<leader>d", '"_d', desc = "delete without overwriting reg", mode = "v" },
  { "<leader>p", '"_dP', desc = "replace without overwriting reg", mode = "v" },
})


-- R shortcuts
imap('”', '%>%')

-- Function to open terminal windows with specified split mode
local function new_terminal(lang, mode)
  local split_flag = (mode == 'horizontal') and '-h' or '-v'
  vim.fn.system('tmux split-window ' .. split_flag .. ' ' .. lang)
end


-- Functions for opening terminal windows
local function new_terminal(lang)
  -- vim.cmd('vsplit term://' .. lang)
  vim.fn.system('tmux split-window -h ' .. lang)
end

local function new_terminal_python()
  new_terminal 'python3'
end

local function new_terminal_r()
  new_terminal 'R'
end

local function new_terminal_shell()
  new_terminal '$SHELL'
end

wk.add(
  {
    { "<leader>f", group = " [f]ind (telescope)" },
    { "<leader>f<space>", "<cmd>Telescope buffers<cr>", desc = "[ ] buffers" },
    { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "[M]an pages" },
    { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[b]uffer fuzzy find" },
    { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "git [c]ommits" },
    { "<leader>fd", "<cmd>Telescope buffers<cr>", desc = "[d] buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[f]iles" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "[g]rep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "[h]elp" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "[j]umplist" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "[k]eymaps" },
    { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "[l]oclist" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "[m]arks" },
    { "<leader>fn", group = "[n]otes" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "[q]uickfix" },
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "[r]eferences" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "document [s]ymbols" },
    { "<leader>fz", search_notes, desc = "search [z]k" }, 
    { "<leader>fZ", live_grep_notes, desc = "grep [Z]k" }, 
    { "<leader>l", group = " [l]anguage/lsp" },
    { "<leader>ld", group = " [d]iagnostics" },
    { "<leader>ldd", vim.diagnostic.disable, desc = "[d]isable" },
    { "<leader>lde", vim.diagnostic.enable, desc = "[e]nable" },
    { "<leader>le", vim.diagnostic.open_float, desc = "diagnostics (show hover [e]rror)" },
    { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "[r]eferences" },
    { "<leader>m", group = " [m]arkdown" },
    { "<leader>ms", ":lua _G.strip_wikilink()<CR>", desc = "strip link" },
    { "<leader>n", group = " [n]otes" },
    { "<leader>t", group = " [t]erminal" },
    { "<leader>tp", new_terminal_python, desc = " python" },
    { "<leader>tr", new_terminal_python, desc = " R" },
    { "<leader>tt", new_terminal_shell, desc = " shell" },
    { "<leader>v", group = " neo[v]im" },
    { "<leader>vt", toggle_light_dark_theme, desc = "[t]oggle light/dark theme" },
    { "<leader>w", ":set wrap!<cr>", desc = "󰯟 toggle soft [w]rap" },
    { "<leader>z", ":Goyo<cr>", desc = " toggle [z]en" },
  }
)


