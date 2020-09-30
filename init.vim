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
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction
set statusline+=\ %{LspStatus()}

" Set completeopt and omnifunc to have a better completion experience
set completeopt=menuone,noinsert
set omnifunc=v:lua.vim.lsp.omnifunc

" Avoid showing message extra message when using completion
set shortmess+=c

" Yank to end of line
map Y y$

" Refresh GitGutter on every save
autocmd BufWritePost * GitGutter

" Simple tab navigation with <C-h> and <C-l> to intuitively go left and right
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

" Let The :Files command show all files in the repo (including dotfiles)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

" Bind Ctrl-P to a fzf-powered filename search
map <C-p> :Files<CR>

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
