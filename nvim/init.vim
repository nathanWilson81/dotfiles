call plug#begin('~/.local/share/nvim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'pangloss/vim-javascript'
Plug 'racer-rust/vim-racer'
Plug 'scrooloose/nerdtree'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
call plug#end()

colorscheme onedark

set termguicolors
set number
set hidden
set mouse=a
set nobackup
set noswapfile
set noshowmode
set foldmethod=indent
set foldlevel=99
set scrolloff=10
set clipboard=unnamed
set inccommand=nosplit
set ignorecase

let mapleader = " "

nnoremap <leader>p :GFiles <cr>
nnoremap <leader>b :Buffers <cr>
nnoremap <leader>d :TernDef <cr>
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>fs :w <cr>
nnoremap <leader>/ :Find <cr>
nnoremap <leader>aa :A <cr>
nnoremap <leader>av :AV <cr>
nnoremap j gj
nnoremap k gk

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

inoremap df <Esc>
" Map tab and shift tab for next and previous in deoplete
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

vnoremap <C-F> y:Find <C-R>"<CR>

let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

let g:ale_linters = {
\    'javascript': ['eslint'],
\    'typescript': ['tslint']
\}

let g:ale_fixers = {
\    'javascript': ['eslint', 'prettier'],
\    'typescript': ['tslint', 'prettier']
\}

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

let g:ale_fix_on_save = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

augroup markdown
	autocmd!
	autocmd Filetype markdown,mkd, call SetUpMk()
augroup END

function! SetUpMk()
	if !exists('#goyo')
		Goyo
	endif
endfunction

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!{.git/*,node_modules/*}" --color "always" '.shellescape(<q-args>), 1, <bang>0)
