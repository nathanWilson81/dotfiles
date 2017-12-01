call plug#begin('~/.local/share/nvim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'carlitux/deoplete-ternjs'
Plug 'chriskempson/base16-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'leshill/vim-json'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'ternjs/tern_for_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
call plug#end()

set termguicolors
set number
set mouse=a
set nobackup
set noswapfile
set foldmethod=indent
set foldlevel=99
set scrolloff=10

colorscheme base16-ocean

let mapleader = " "

nnoremap <c-p> :Files <cr>
nnoremap <leader>d :TernDef <cr>
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>w :w <cr>
nnoremap j gj
nnoremap k gk

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

inoremap kj <Esc>
" Map tab and shift tab for next and previous in deoplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

vnoremap <C-F> y:Find <C-R>"<CR>

let g:neosnippet#expand_word_boundry = 1
imap <C-k>    <Plug>(neosnippet_expand_or_jump)
smap <C-k>    <Plug>(neosnippet_expand_or_jump)
xmap <C-k>    <Plug>(neosnippet_expand_target)

let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

let g:ale_linters = {
\    'javascript': ['eslint'],
\}

let g:ale_fixers = {
\    'javascript': ['eslint', 'prettier'],
\}

let g:ale_fix_on_save = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:tern#filetypes = ["js"]
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
