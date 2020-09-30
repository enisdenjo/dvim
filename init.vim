" Install plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sleuth'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-commentary'

Plug 'dense-analysis/ale'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ncm2/float-preview.nvim'
Plug 'Shougo/echodoc.vim'

call plug#end()

" Standard
"set title " keep the PWD as the title of the terminal
syntax on
set number relativenumber
set scrolloff=15
set mouse=a
set termguicolors
set showtabline=2
set cursorline
set autoread

" Style
colorscheme dracula

" With this, you can enter ":Config" in normal mode to open the Vim
" configuration.
command! Config execute ":e $MYVIMRC"

" Call ":Reload" to apply the latest .vimrc contents
command! Reload execute "source $MYVIMRC"

" Yank to end of line
map Y y$

" Git
autocmd BufWritePost * GitGutter

" ALE
let g:ale_linters_explicit = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'go': ['goimports'],
\}
let g:ale_linters = {
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescript': ['tsserver', 'prettier'],
\   'typescriptreact': ['tsserver', 'prettier'],
\   'go': ['gopls'],
\}
nnoremap <silent> gd :ALEGoToDefinition<CR>

" Use deoplete with ALE
let g:ale_completion_enabled = 1
call deoplete#custom#option('sources', { '_': ['ale'] })
let g:deoplete#enable_at_startup = 1
let g:float_preview#docked = 0
set completeopt-=preview
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
imap <expr> <C-Space> deoplete#manual_complete()

" Fix files when you save
let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1

" Simple tab navigation with <C-h> and <C-l> to intuitively go left and right
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

" Let The :Files command show all files in the repo (including dotfiles)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

" Bind "//" to a fzf-powered buffer search
" nmap // :BLines<CR> " lets see if I can live without it

" Bind "??" to a fzf-powered project search
nmap ?? :Rg<CR>

" Bind Ctrl-P to a fzf-powered filename search
map <C-p> :Files<CR>

" Bind "::" to a fzf-powered command search
nmap :: :Commands<CR>

" Add line numbers to netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Macro over visual range
xmap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "go", "typescript", "tsx", "javascript" },
	highlight = { enable = true },
}
EOF
