return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<leader>e", ":NvimTreeToggle<cr>", desc = " File tre[e]" },
  },
  config = function()
    require("nvim-tree").setup({
      disable_netrw = false,
      update_focused_file = {
        enable = true,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
      diagnostics = {
        enable = true,
      },
    })
  end,
}
