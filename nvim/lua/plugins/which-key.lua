return {
  {
    "folke/which-key.nvim",
    enabled = true,
    config = function()
      require("which-key").setup({
        icons = {
          separator = " ",
          group = "",
        },
        -- Derecated:
        -- hidden = { 
        --  "<silent>", "<cmd>", "<Cmd>", "<CR>", 
        --  "^:", "^ ", "^call ", "^lua ", "<Plug>" }
      })
      require("config.keymap")
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*", -- Use the latest stable version
  },
}
