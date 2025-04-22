return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "markdown",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- Alias MDX to use the markdown parser by adjusting the parser configurations.
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      if not parser_configs.mdx then
        parser_configs.mdx = parser_configs.markdown
      end
    end,
  },

  {
    "xiyaowong/transparent.nvim",
    -- You can load it early (lazy = false) or when Neovim is ready (e.g. event = "VeryLazy")
    lazy = false,
    priority = 1000, -- optional, ensures it loads early if you need transparency from the start
    config = function()
      require("transparent").setup({
        -- A list of default highlight groups to clear for transparency
        groups = {
          "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
          "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
          "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
          "SignColumn", "CursorLine", "CursorLineNr", "StatusLine", "StatusLineNC",
          "EndOfBuffer",
        },
        -- Add extra groups you want to clear (e.g. for floating windows or file tree plugins)
        extra_groups = { "NormalFloat" },
        -- Exclude any groups if you want them to retain their background settings
        exclude_groups = { "StatusLine", "StatusLineNC", "NvimTreeNormal" },
        -- Optional: run any additional command after clearing highlights
        on_clear = function()
          -- For example, make sure the Normal highlight has no background
          vim.cmd("hi Normal guibg=none")
        end,
      })

      require('transparent').toggle(true)
    end,
  },

  {
    "mg979/vim-visual-multi",
    branch = "master",
    config = function()
      -- This plugin uses <C-n> by default to add cursors.
      -- You can review its README for options to customize key mappings.
    end,
  },

  {
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufEnter *.mdx"
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- these options get passed straight into nvim-tree.setup()
    opts = {
      view                               = {
        side  = "right",
        width = 30,
      },
      hijack_netrw                       = true,
      hijack_unnamed_buffer_when_opening = false,
      hijack_directories                 = { enable = true, auto_open = true },
      sync_root_with_cwd                 = true,
      respect_buf_cwd                    = true,
      update_focused_file                = {
        enable      = true,
        update_root = { enable = true },
      },
      actions                            = {
        change_dir = {
          enable = true,
          global = true,
        },
      },
    },
    -- run this after the plugin is loaded
    config = function(_, opts)
      -- apply all the opts
      require("nvim-tree").setup(opts)

      -- if you called `nvim <dir>`, cd into it and open the tree
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local args = vim.fn.argv()
          if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then
            vim.cmd.cd(args[1])
            vim.cmd("NvimTreeOpen")
          end
        end,
      })
    end,
  },

}
