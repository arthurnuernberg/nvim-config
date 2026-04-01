return {
  "lervag/vimtex",
  ft = { "tex", "bib" },
  lazy = true,
  init = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_skim_sync = 1      -- Synchronisation curseur
    vim.g.vimtex_view_skim_activate = 0  -- Ne pas focus Skim à chaque compile

    vim.g.vimtex_compiler_method = "latexmk"

    vim.g.vimtex_compiler_latexmk = {
      build_dir = "", 
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-pdf",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }

    -- ============================================
    -- QUICKFIX (erreurs/warnings)
    -- ============================================
    vim.g.vimtex_quickfix_mode = 0              -- Ne jamais ouvrir auto
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_quickfix_ignore_filters = {    -- Ignorer ces warnings
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
    }

    -- ============================================
    -- FONCTIONNALITÉS TEXTE
    -- ============================================
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_syntax_conceal_disable = 0     -- Activer conceal

    -- Conceal : affiche α au lieu de \alpha, etc.
    vim.g.vimtex_syntax_conceal = {
      accents = 1,
      ligatures = 1,
      cites = 1,
      fancy = 1,
      spacing = 1,
      greek = 1,
      math_bounds = 1,
      math_delimiters = 1,
      math_fracs = 1,
      math_super_sub = 1,
      math_symbols = 1,
      sections = 0,
      styles = 1,
    }

    -- ============================================
    -- FOLDING (optionnel)
    -- ============================================
    vim.g.vimtex_fold_enabled = 0  -- Désactivé (peut ralentir)
    -- vim.g.vimtex_fold_manual = 1  -- Fold manuel si activé

    -- ============================================
    -- TABLE DES MATIÈRES
    -- ============================================
    vim.g.vimtex_toc_config = {
      split_pos = "vert leftabove",
      split_width = 30,
      show_help = 0,
      show_numbers = 1,
      mode = 1,
    }

    -- ============================================
    -- MAPPINGS LOCAUX (buffer .tex uniquement)
    -- ============================================
    vim.g.vimtex_mappings_enabled = 1
    vim.g.vimtex_imaps_enabled = 1   -- Raccourcis insert mode (` -> accents)
    vim.g.vimtex_text_obj_enabled = 1 -- Text objects (vie, vae, etc.)

    -- ============================================
    -- DIVERS
    -- ============================================
    vim.g.vimtex_log_verbose = 0     -- Logs moins verbeux
    vim.g.vimtex_indent_enabled = 1  -- Indentation auto
  end,

  config = function()
    -- Mappings personnalisés pour .tex
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        local opts = { buffer = true, silent = true }

        -- Compiler
        vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", 
          vim.tbl_extend("force", opts, { desc = "Toggle compile" }))

        -- Voir PDF
        vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", 
          vim.tbl_extend("force", opts, { desc = "View PDF" }))

        -- Voir erreurs (quand TU veux)
        vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", 
          vim.tbl_extend("force", opts, { desc = "Show errors" }))

        -- Table des matières
        vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", 
          vim.tbl_extend("force", opts, { desc = "Toggle TOC" }))

        -- Clean fichiers auxiliaires
        vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>", 
          vim.tbl_extend("force", opts, { desc = "Clean aux files" }))

        -- Infos
        vim.keymap.set("n", "<leader>li", "<cmd>VimtexInfo<CR>", 
          vim.tbl_extend("force", opts, { desc = "VimTeX info" }))

        -- Stop compilation
        vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<CR>", 
          vim.tbl_extend("force", opts, { desc = "Stop compile" }))
      end,
    })
  end,
}
