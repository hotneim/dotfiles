-- Plugins for creating a zen mode while writing
return {
  {
    "junegunn/goyo.vim",
    config = function()
      -- Set keymap for entering and leaving
      vim.keymap.set("n", "<leader>z", ":Goyo<cr>", { desc = " toggle [z]en" })

      -- Function for entering Goyo mode
      local function goyo_enter()
        -- Check if 'tmux' is executable and TMUX environment variable is set
        if vim.fn.executable('tmux') == 1 and vim.fn.strlen(vim.env.TMUX) > 0 then
          -- Turn off tmux status bar
          vim.fn.system('tmux set status off')
          -- Get the focus status of tmux panes to check if currently zoomed
          local pane_status = vim.fn.system('tmux list-panes -F \'#F\'')
        end
        -- Hide mode indicator in command line
        vim.o.showmode = false
        -- Hide command line feedback (like which command you are typing)
        vim.o.showcmd = false
        -- Set vertical scroll offset to a high number to keep cursor centered
        vim.o.scrolloff = 999
        -- Activate Limelight plugin to highlight the current paragraph/block
        vim.cmd('Limelight')
        -- Additional commands can be added here for further customization
        require("barbecue.ui").toggle()
        require('lualine').hide()
        vim.cmd('LspStop')
      end

      -- Function for leaving Goyo mode
      local function goyo_leave()
        -- Check if 'tmux' is executable and TMUX environment variable is set
        if vim.fn.executable('tmux') == 1 and vim.fn.strlen(vim.env.TMUX) > 0 then
          -- Turn on tmux status bar
          vim.fn.system('tmux set status on')
          -- Get the focus status of tmux panes to check if currently zoomed
          local pane_status = vim.fn.system('tmux list-panes -F \'#F\'')
        end
        -- Show mode indicator in command line
        vim.o.showmode = true
        -- Show command line feedback
        vim.o.showcmd = true
        -- Reset vertical scroll offset to a smaller number
        vim.o.scrolloff = 5
        -- Deactivate Limelight plugin to remove highlighting
        vim.cmd('Limelight!')
        -- Additional commands can be added here for further customization
        require("barbecue.ui").toggle()
        require('lualine').hide({unhide=true})
        vim.cmd('LspStart')
      end

      -- Create an autocommand that triggers when entering Goyo mode
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoEnter",
        nested = true,         -- Allow nested commands to be triggered by this autocommand
        callback = goyo_enter, -- Call the goyo_enter function
      })

      -- Create an autocommand that triggers when leaving Goyo mode
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoLeave",
        nested = true,         -- Allow nested commands to be triggered by this autocommand
        callback = goyo_leave, -- Call the goyo_leave function
      })
    end
  },
  {
    "junegunn/limelight.vim"
  }
}
