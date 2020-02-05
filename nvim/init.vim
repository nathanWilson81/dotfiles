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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'justinmk/vim-sneak'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
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
Plug 'vimwiki/vimwiki'
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
set autoread

let mapleader = " "

nnoremap <leader>p :Files <cr>
nnoremap <leader>b :Buffers <cr>
nnoremap <leader>d :CocList diagnostics<cr>
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

inoremap df <Esc>
" Map tab and shift tab for next and previous in deoplete
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

vnoremap <C-F> y:Find <C-R>"<CR>

let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }


let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

command! -nargs=0 Format :call CocAction('format')


augroup markdown
	autocmd!
	autocmd Filetype markdown,mkd, call SetUpMk()
augroup END

augroup AutoFormatReason
      au!
      au BufWritePost *.re,*.rei nested silent :Format
augroup end

function! SetUpMk()
	if !exists('#goyo')
		Goyo
	endif
endfunction

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!{.git/*,lib/*,**/node_modules/**}" --color "always" '.shellescape(<q-args>), 1, <bang>0)
