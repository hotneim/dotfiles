return {
  -- "ellisonleao/gruvbox.nvim",
  "projekt0n/github-nvim-theme",
  priority = 1000,
  config = function()
    -- require('gruvbox').setup()
    require('github-theme').setup()
    -- vim.api.nvim_command("colorscheme gruvbox")
    vim.api.nvim_command("colorscheme github_dark_default")

    -- Function that toggles light and dark theme
    function _G.toggle_light_dark_theme()
      if vim.o.background == 'light' then
        vim.o.background = 'dark'
        -- vim.cmd([[colorscheme gruvbox]])
        vim.cmd([[colorscheme github_dark_default]])
      else
        vim.o.background = 'light'
        -- vim.cmd([[colorscheme gruvbox]])
        vim.cmd([[colorscheme github_light_default]])
      end
    end

  end
}
