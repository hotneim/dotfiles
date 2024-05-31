
return { 
  "bullets-vim/bullets.vim",
  config = function()
    -- Make promotion respect the indentation level of 2
    vim.g.vim_markdown_new_list_item_indent = 2
    vim.g.bullets_outline_levels = { 'num', 'num', 'num', 'num' }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
      end,
    })
  end
}

