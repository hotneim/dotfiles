return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'f3fora/cmp-spell',
    'ray-x/cmp-treesitter',
    'kdheepak/cmp-latex-symbols',
    'jmbuhr/cmp-pandoc-references',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind-nvim',
    'jmbuhr/otter.nvim',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
    end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      mapping = {
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-a>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol',
          menu = {
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            path = '[Path]',
            luasnip = '[Snippet]',
            spell = '[Spell]',
            pandoc_references = '[Ref]',
            tags = '[Tag]',
            treesitter = '[TS]',
            latex_symbols = '[Tex]',
          },
        },
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip', keyword_length = 3, max_item_count = 3 },
        { name = 'buffer', keyword_length = 5, max_item_count = 3 },
        { name = 'path' },
        { name = 'spell' },
        { name = 'treesitter', keyword_length = 5, max_item_count = 3 },
        { name = 'latex_symbols' },
        { name = 'pandoc_references' },
      },
      view = {
        entries = 'native',
      },
    }

    -- Link quarto and rmarkdown to markdown snippets
    luasnip.filetype_extend('quarto', { 'markdown' })
    luasnip.filetype_extend('rmarkdown', { 'markdown' })
  end,
}

