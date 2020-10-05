" Enter ":Config" in normal mode to open the config
command! Config execute ":e $MYVIMRC"

" Call ":Reload" to apply the latest config contents
command! Reload execute "source $MYVIMRC"

" Standard
set number relativenumber
set scrolloff=15
set mouse=a
set termguicolors
set showtabline=2
set cursorline
set autoread
set splitright

" Theme
packadd dracula
syntax on
colorscheme dracula

" Treesitter
packadd nvim-treesitter
lua require("treesitter")
highlight link TSConstBuiltin Constant
highlight link TSFuncBuiltin FuncBuiltIn

" LSP
packadd nvim-lspconfig
packadd lsp-status.nvim
packadd diagnostic-nvim
packadd completion-nvim
lua require("lsp")

" Diagnostic
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1
autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

" Statusline
packadd vim-airline
" TODO: integrate with lsp-status or diagnostic-nvim

" Completion
set completeopt=menuone,noinsert
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_ignore_case = 1
set wildignorecase

" Avoid showing message extra message when using completion
set shortmess+=c

" ALE
packadd ale
let g:ale_sign_error = 'L' " in order to differentiate LSP and Linter problems
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'go': ['goimports'],
\}
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\}

" Yank to end of line
map Y y$

" Refresh GitGutter on every save
autocmd BufWritePost * GitGutter

" Bind ":W" to show window palette immediately
nmap :W :W<CR>

" Let The ":Files" command show all files in the repo (including dotfiles)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

" Bind ":F" to a fzf-powered filename search
map :F :Files<CR>

" Bind "//" to a fzf-powered buffer search
nmap // :BLines<CR>

" Bind "??" to a fzf-powered project search
nmap ?? :Rg<CR>

" Bind "::" to a fzf-powered command search
nmap :: :Commands<CR>

" Add line numbers to netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Macro over visual range
xmap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
