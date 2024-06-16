
return {
  'Vigemus/iron.nvim',
  config = function()
    local iron = require('iron.core')
    local view = require('iron.view')

    iron.setup {
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            command = {"zsh"}
          },
          r = {
            command = {"R"}
          },
          python = {
            command = {"python3"}
          }
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = view.split.vertical.botright("50%"),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_paragraph = "<space>sp",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    }

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
    vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
    vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

 -- -- Register keymaps with which-key and provide descriptions
    local wk = require("which-key")
    wk.register({
      ["r"] = { name = " start [r]epl", 
        s = {"<cmd>IronRepl<cr>", "Start REPL"},
        r = {"<cmd>IronRestart<cr>", "Restart REPL"},
        f = {"<cmd>IronFocus<cr>", "Focus on REPL"},
        h = {"<cmd>IronHide<cr>", "Hide REPL"},
        w = {"<cmd>IronFocus<cr>", "Focus on REPL"}
      },
      ["s"] = { name = " [s]end to repl", 
 --        c = {"<cmd>lua require('iron.core').send_motion()", "Send motion to REPL"},
 --        v = {"<cmd>lua require('iron.core').visual_send()<CR>", "Send visual selection to REPL"},
 --        f = {"<cmd>lua require('iron.core').send_file()<CR>", "Send file to REPL"},
 --        l = {"<cmd>lua require('iron.core').send_line()<CR>", "Send line to REPL"},
 --        p = {"<cmd>lua require('iron.core').send_paragraph()<CR>", "Send paragraph to REPL"},
 --        u = {"<cmd>lua require('iron.core').send_until_cursor()<CR>", "Send until cursor to REPL"},
 --        m = {"<cmd>lua require('iron.core').send_mark()<CR>", "Send mark to REPL"},
 --        [" "] = {"<cmd>lua require('iron.core').interrupt()<CR>", "Interrupt REPL"},
 --        q = {"<cmd>lua require('iron.core').exit()<CR>", "Exit REPL"},
      }
    }, { prefix = "<space>" })
 --    --
 --    -- Keybinding to exit the REPL and return to the script window
    vim.api.nvim_set_keymap('t', '<Esc><Esc>', [[<C-\><C-n><C-w>p]], {noremap = true, silent = true})
 --
    -- Set up keybindings for better interaction with the REPL window
    vim.api.nvim_exec([[
      augroup IronRepl
        autocmd!
        " Enter normal mode from terminal mode
        autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
        " Enter insert mode from normal mode
        autocmd TermOpen * nnoremap <buffer> i i
        " Exit insert mode to normal mode
        autocmd TermOpen * inoremap <buffer> <Esc> <C-\><C-n>
        " Exit visual mode to normal mode
        autocmd TermOpen * vnoremap <buffer> <Esc> <Esc>
      augroup END
    ]], false)

  end
}

