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

    require('mason').setup{
      log_level = vim.log.levels.DEBUG,
    }
    require('mason-lspconfig').setup {
      automatic_installation = true,
      ensure_installed = { "r_language_server" }
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
    -- Add configuration for the R language server
    lspconfig.r_language_server.setup {
      capabilities = capabilities,
      cmd = { "R", "--slave", "-e", "languageserver::run()" },
      filetypes = { "r", "rmd" },
      root_dir = util.root_pattern(".git", "."),
      on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>ds', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap("n", "<space>df", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      end,
      flags = lsp_flags,
    }
  end
}
