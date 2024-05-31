return {
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup {}
    require('nvim-autopairs').remove_rule '`'
  end,
}
