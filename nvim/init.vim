let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'hrsh7th/nvim-compe'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'justinmk/vim-sneak'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'neovim/nvim-lspconfig'
Plug 'pangloss/vim-javascript'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'weilbith/nvim-lsp-smag'
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
set shortmess+=c
set lazyredraw
set completeopt=menuone,noinsert,noselect

let mapleader = " "

nnoremap <leader>p :Files <cr>
nnoremap <leader>b :Buffers <cr>
nnoremap <leader>g :Tags <cr>
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>fs :w <cr>
nnoremap <leader>/ :Find <cr>
nnoremap <leader>aa :A <cr>
nnoremap <leader>av :AV <cr>
nnoremap <leader>d :lua vim.lsp.buf.definition() <cr>
nnoremap <leader>h :lua vim.lsp.buf.hover() <cr>
nnoremap <leader>r :lua vim.lsp.buf.rename() <cr>
nnoremap <leader>fo :lua vim.lsp.buf.formatting() <cr>
nnoremap j gj
nnoremap k gk

inoremap df <Esc>

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

vnoremap <C-F> y:Find <C-R>"<CR>

let g:jsx_ext_required = 0

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

lua require'lspconfig'.tsserver.setup{}
"
" lua require'lspconfig'.reason.setup{}
" lua require'nvim_lsp'.ocamllsp.setup{}
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true

let g:completion_enable_auto_hover = 0
let g:completion_enable_auto_signature = 0

command! -nargs=* FormatReason :silent !npx bsrefmt --in-place % 

augroup Linting
  autocmd!
  autocmd FileType javascript,javascriptreact,javascript.jsx setlocal makeprg=npx\ prettier\ --write\ %
  autocmd BufWritePost *.js silent make! <afile> | silent redraw!
  autocmd QuickFixCmdPost [^l]* cwindow
augroup END


command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!{.git/*,lib/*,**/node_modules/**}" --color "always" '.shellescape(<q-args>), 1, <bang>0)
