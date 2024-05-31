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

wk.register({
  p = { '"_dP', 'replace without overwriting reg' },
  d = { '"_d', 'delete without overwriting reg' },
}, { mode = 'v', prefix = '<leader>' })


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

-- Keybindings in normal mode
wk.register({
  f = {
    name = ' [f]ind (telescope)',
    f = { '<cmd>Telescope find_files<cr>', '[f]iles' },
    h = { '<cmd>Telescope help_tags<cr>', '[h]elp' },
    k = { '<cmd>Telescope keymaps<cr>', '[k]eymaps' },
    r = { '<cmd>Telescope lsp_references<cr>', '[r]eferences' },
    g = { '<cmd>Telescope live_grep<cr>', '[g]rep' },
    b = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', '[b]uffer fuzzy find' },
    m = { '<cmd>Telescope marks<cr>', '[m]arks' },
    M = { '<cmd>Telescope man_pages<cr>', '[M]an pages' },
    c = { '<cmd>Telescope git_commits<cr>', 'git [c]ommits' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'document [s]ymbols' },
    ['<space>'] = { '<cmd>Telescope buffers<cr>', '[ ] buffers' },
    d = { '<cmd>Telescope buffers<cr>', '[d] buffers' },
    q = { '<cmd>Telescope quickfix<cr>', '[q]uickfix' },
    l = { '<cmd>Telescope loclist<cr>', '[l]oclist' },
    j = { '<cmd>Telescope jumplist<cr>', '[j]umplist' },
    n = {
      name = '[n]otes',
      m = { '<cmd>TelescopeLiveGrepMeetings<cr>', '[m]eetings' },
      d = { '<cmd>TelescopeLiveGrepDaily<cr>', '[d]aily' },
      r = { '<cmd>TelescopeLiveGrepReading<cr>', '[r]eading' },
      n = { '<cmd>TelescopeLiveGrepNotes<cr>', 'all [n]otes' },
    },
  },
  l = {
    name = ' [l]anguage/lsp',
    r = { '<cmd>Telescope lsp_references<cr>', '[r]eferences' },
    e = { vim.diagnostic.open_float, 'diagnostics (show hover [e]rror)' },
    d = {
      name = ' [d]iagnostics',
      d = { vim.diagnostic.disable, '[d]isable' },
      e = { vim.diagnostic.enable, '[e]nable' },
    },
  },
  n = {
    name = ' [n]otes',
  },
  t = {
    name = ' [t]erminal',
    r = { new_terminal_r, ' R' },
    p = { new_terminal_python, ' python' },
    t = { new_terminal_shell, ' shell' },
  },
  v = {
    name =' neo[v]im',
    t = {toggle_light_dark_theme, '[t]oggle light/dark theme'},
  },
  w = { ':set wrap!<cr>', '󰯟 toggle soft [w]rap'},
  z = { ':Goyo<cr>', ' toggle [z]en'},
}, { mode = 'n', prefix = '<leader>' })
