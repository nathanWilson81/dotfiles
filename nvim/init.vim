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
Plug '/usr/local/opt/fzf'
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'haorenW1025/completion-nvim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'justinmk/vim-sneak'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'neovim/nvim-lsp'
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

lua require'nvim_lsp'.tsserver.setup{}
"
lua require'nvim_lsp'.reason.setup{}
" lua require'nvim_lsp'.ocamllsp.setup{}

autocmd BufEnter * lua require'completion'.on_attach()

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
