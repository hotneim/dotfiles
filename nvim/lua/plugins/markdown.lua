return {
  {
    "preservim/vim-markdown",
    config = function()
      vim.g.vim_marksown_new_list_item_indent = 2
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_math = 1

      -- Add shortcuts for inserting code blocks
      vim.keymap.set("n", "<leader>mr", function()
        vim.api.nvim_put({ "```{r}", "", "```" }, "l", true, true)
        vim.cmd("startinsert!")
        vim.api.nvim_win_set_cursor(0, { vim.fn.line('.') - 2, 0 }) -- Move cursor inside the block
      end, { noremap = true, silent = true, desc = "Insert R code block" })

      vim.keymap.set("n", "<leader>mp", function()
        vim.api.nvim_put({ "```python", "", "```" }, "l", true, true)
        vim.cmd("startinsert!")
        vim.api.nvim_win_set_cursor(0, { vim.fn.line('.') - 2, 0 }) -- Move cursor inside the block
      end, { noremap = true, silent = true, desc = "Insert Python code block" })
    end
  },
  {
    'iamcco/markdown-preview.nvim',
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      -- Define a Vim function to open Brave Browser
      vim.cmd([[
      function! OpenInBrave(url) abort
      call jobstart(['open', '-a', 'Brave Browser', '--new', '--args', '--new-window', a:url], {'detach': v:true})
      endfunction
      ]])
      -- Set the browser function for Markdown Preview
      vim.g.mkdp_browserfunc = "OpenInBrave"
    end,
  },
}

