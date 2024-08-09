return {
  'jpalardy/vim-slime',
  init = function()
    -- send visual selection
    vim.api.nvim_set_keymap('x', '<leader>s', '<Plug>SlimeRegionSend', {})

    -- send based on motion or text object
    vim.api.nvim_set_keymap('n', '<leader>s', '<Plug>SlimeMotionSend', {})

    -- send line
    vim.api.nvim_set_keymap('n', '<leader>ss', '<Plug>SlimeLineSend', {})

    -- sets target
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = {socket_name = "default", target_pane = "1"}
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_bracketed_paste = 1


  end
}

