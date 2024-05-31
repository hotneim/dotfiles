return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'hrsh7th/nvim-cmp' },  -- Added nvim-cmp
    { 'hrsh7th/cmp-nvim-lsp' },  -- Added cmp-nvim-lsp
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local util = require 'lspconfig.util'

    require('mason').setup()
    require('mason-lspconfig').setup {
      automatic_installation = true,
    }
    require('mason-tool-installer').setup {
      ensure_installed = {
        'black',
        'isort',
        'tree-sitter-cli',
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local telescope = require 'telescope.builtin'
        local function map(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        assert(client, 'LSP client not found')

        map('gd', telescope.lsp_definitions, '[g]o to [d]efinition')
        map('K', vim.lsp.buf.hover, '[K] hover documentation')
        map('gr', telescope.lsp_references, '[g]o to [r]eferences')
        map('<leader>lr', vim.lsp.buf.rename, '[l]sp [r]ename')
        map('<leader>lf', vim.lsp.buf.format, '[l]sp [f]ormat')
      end,
    })

    local lsp_flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150,
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.marksman.setup {
      capabilities = capabilities,
      filetypes = { 'markdown', 'quarto' },
      root_dir = util.root_pattern('.git', '.marksman.toml', '_quarto.yml'),
    }

    lspconfig.pyright.setup {
      capabilities = capabilities,
      flags = lsp_flags,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
          },
        },
      },
      root_dir = function(fname)
        return util.root_pattern('.git', 'setup.py', 'setup.cfg', 'pyproject.toml', 'requirements.txt')(fname) or
        util.path.dirname(fname)
      end,
    }
  end,
}

