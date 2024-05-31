return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require('gruvbox').setup()
    vim.api.nvim_command("colorscheme gruvbox")

    -- Function that toggles light and dark theme
    function _G.toggle_light_dark_theme()
      if vim.o.background == 'light' then
        vim.o.background = 'dark'
        vim.cmd([[colorscheme gruvbox]])
      else
        vim.o.background = 'light'
        vim.cmd([[colorscheme gruvbox]])
      end
    end

  end
}
