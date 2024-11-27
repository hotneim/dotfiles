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
  -- Folding
  -- {
  --   'kevinhwang91/nvim-ufo',
  --   dependencies = { 'kevinhwang91/promise-async' },
  --   config = function()
  --     -- Basic settings for folding
  --     vim.o.foldcolumn = '1' -- '0' is also acceptable
  --     vim.o.foldlevel = 99 -- Required for ufo; feel free to decrease the value
  --     vim.o.foldlevelstart = 99
  --     vim.o.foldenable = true
  --
  --     -- Key mappings for fold management
  --     vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  --     vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
  --
  --     -- Option 3: Treesitter as the main provider
  --     require('ufo').setup({
  --       provider_selector = function(bufnr, filetype, buftype)
  --         if filetype == "markdown" then
  --           return { "indent" }
  --         end
  --         return { "treesitter", "indent" }
  --       end,
  --     })
  --
  --     -- Initialize ufo with its default setup
  --     require('ufo').setup()
  --   end,
  -- },
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   build = "cd app && npm install",
  --   ft = { "markdown" },
  --   config = function()
  --     -- Define the browser function for Markdown Preview
  --     vim.g.mkdp_browserfunc = function(url)
  --       vim.fn.jobstart({ "open", "-a", "Firefox", "-n", "--args", "--new-window", url }, { detach = true })
  --     end
  --   end,
  -- },
}

