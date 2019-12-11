
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
"if v:progname =~? "evim"
"  finish
"endif

" Get the defaults that most users want.
"source $VIMRUNTIME/defaults.vim

"color scheme
colorscheme darkblue

let mapleader = " "
set showcmd
inoremap jk <ESC>
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set number

"yank -> system clipboard
set clipboard=unnamed

"central folder for swap files
set directory^=$HOME/.vim/tmp//
set noswapfile "test if this is the cause of the import moved bugs

"set splitbelow
"set splitright
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
" In insert or command mode, move normally by using Ctrl
"inoremap <C-h> <Left> backspace needs to be remapped for this to work
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"cnoremap <C-h> <Left> backspace needs to be remapped for this to work
"https://vi.stackexchange.com/questions/10710/having-issues-maping-c-j-and-c-h-in-vim
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

set mouse=a

"status line
set statusline+=%F

"Autocomplete cocnvim
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" coc.nvim goto definition keys
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


"vim-plug
call plug#begin('~/.vim/plugged')

"automatically save files
Plug 'vim-scripts/vim-auto-save'

"file browsing
Plug 'scrooloose/nerdtree'

"commenting out 
"Plug 'tpope/vim-commentary'

"Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

"a collection of language packs
Plug 'sheerun/vim-polyglot'

"rails tools
Plug 'tpope/vim-rails'
"Plug 'tpope/vim-bundler' -slow?
"Plug 'tpope/vim-dispatch' - slow?

"intellisense with language extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"linting
Plug 'dense-analysis/ale'

"Prettier js code styling
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

"auto add closing brackets, parenthesis, and tags
"Plug 'tpope/vim-surround' - manipulate surroundings, too advanced for now
"Plug 'jiangmiao/auto-pairs' - not using

"Project wide fuzzy file and code search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"todo add vim-commentary for commenting
call plug#end()

"NerdTree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"open/close nerdtree window
nnoremap <Leader>n :NERDTreeToggle<CR> 
"this is the key to jump to the nerdtree window from any other window
nnoremap <Leader>r :NERDTreeFind<CR> 

"fzf
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>F :Rg<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

"Enable Autosave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode


"if has("vms") set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file (restore to previous version)
"  if has('persistent_undo')
"    set undofile	" keep an undo file (undo changes after closing)
"  endif
"endif

"if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
"  set hlsearch
"endif

" Only do this part when compiled with support for autocommands.
"if has("autocmd")
"
"  " Put these in an autocmd group, so that we can delete them easily.
"  augroup vimrcEx
"  au!
"
"  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78
"
"  augroup END

"else
"
"  set autoindent		" always set autoindenting on
"
"endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
"if has('syntax') && has('eval')
"  packadd! matchit
"endif
