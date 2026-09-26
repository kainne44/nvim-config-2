return {
  {
    'lervag/vimtex',
    lazy = false, -- load on startup so filetype detection just works
    init = function()
      -- <localleader> is \ (init.lua), so vimtex's \ll, \lv, ... work
      -- Use Skim as the PDF viewer
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1 -- jump to Skim on view

      -- Use latexmk as the compiler, with XeLaTeX engine
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_compiler_latexmk = {
        build_dir = '', -- "" = same dir as .tex; set to "build" if you want a build folder
        callback = 1,
        continuous = 1, -- auto-recompile on save
        executable = 'latexmk',
        options = {
          '-xelatex', -- use XeLaTeX (needed for fontspec)
          '-synctex=1',
          '-interaction=nonstopmode',
          '-file-line-error',
          -- '-shell-escape', -- lets any compiled .tex run shell commands; enable only if needed
        },
      }

      -- Quality of life
      vim.g.vimtex_quickfix_mode = 2 -- open quickfix on errors/warnings
      vim.g.vimtex_log_ignore = { 'Underfull', 'Overfull' }
      vim.g.vimtex_complete_enabled = 1 -- simple completion
      vim.g.vimtex_mappings_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
    end,
  },
}
