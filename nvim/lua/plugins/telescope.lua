return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local previewers = require("telescope.previewers")
    local new_maker = function(filepath, bufnr, opts)
      opts = opts or {}
      filepath = vim.fn.expand(filepath)
      vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then
          return
        end
        if stat.size > 100000 then
          return
        else
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
      end)
    end
    telescope.setup({
      defaults = {
        buffer_previewer_maker = new_maker,
        file_ignore_patterns = {
          "node_modules",
          "%_files/*.html",
          "%_cache",
          ".git/",
          "site_libs",
          ".venv",
          "zk",
        },
        layout_strategy = "flex",
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<esc>"] = actions.close,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = false,
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!.git/*",
            "--glob",
            "!**/.Rpro.user/*",
            "--glob",
            "!_site/*",
            "--glob",
            "!docs/**/*.html",
            "-L",
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}
