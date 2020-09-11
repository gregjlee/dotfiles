
let mapleader = " "
set showcmd
inoremap jk <ESC>
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
"set hybrid relative with absolute number on the cursor line
set relativenumber
set number

"yank -> system clipboard
set clipboard=unnamed

"ignore case when searching
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
"turn off highlight 
nnoremap <silent> <CR> :noh<CR><CR>    
"replace all(with prompt) of current word
nnoremap <leader>r yiw:%s/\<<C-r>"\>//gc<left><left><left>
vnoremap <leader>r y:%s/<C-r>"//gc<left><left><left>


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
"use <tab> for trigger completion and navigate to the next complete item
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

"commenting out code 
Plug 'tpope/vim-commentary'

"Git
Plug 'tpope/vim-fugitive'

"Github
Plug 'tpope/vim-rhubarb'
"Plug 'tpope/vim-rset smartcasehubarb'

"a collection of language packs
Plug 'sheerun/vim-polyglot'

"rails tools
Plug 'tpope/vim-rails'
"Plug 'tpope/vim-bundler' -slow?
"Plug 'tpope/vim-dispatch' - slow?
Plug 'thoughtbot/vim-rspec'
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "!bundle exec rspec {spec}"


"intellisense with language extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" make sure to use nodejs version 11 or higher for speed


"linting
Plug 'dense-analysis/ale'
" {{{
  let g:ale_fixers = {
        \ 'javascript': ['eslint']
        \}
  let g:ale_sign_error = '❌'
  let g:ale_sign_warning = '⚠️'
  " for performance only lint on save
  let g:ale_fix_on_save = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_insert_leave = 0
" You can disable this option too
" if you don't want linters to run on opening a file
  let g:ale_lint_on_enter = 0

" }}}

"Prettier js code styling
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'for': ['css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

"auto add closing brackets, parenthesis, and tags
"Plug 'tpope/vim-surround' - manipulate surroundings, too advanced for now
"Plug 'jiangmiao/auto-pairs' - not using

"Project wide fuzzy file and code search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>a :Buffers<CR>
  nnoremap <silent> <leader>A :Windows<CR>
  nnoremap <silent> <leader>f :BLines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>F :Rg<CR> 

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = {'window': 'vertical new'}
" }}}

"todo add vim-commentary for commenting
"Plug 'altercation/vim-colors-solarized' "color theme
"color theme
Plug 'rakr/vim-one' "color theme
" {{{
" use true colors
  if (has("termguicolors"))
    set termguicolors
  endif
"set background=dark 
 set background=light 
" }}}
call plug#end()

colorscheme one

"NerdTree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"open/close nerdtree window
nnoremap <Leader>n :NERDTreeToggle<CR> 
"this is the key to jump to the nerdtree window from any other window
nnoremap <Leader>N :NERDTreeFind<CR> 

"fzf

"Enable Autosave
let g:auto_save = 0 "turned off autosave as it was going to slow with auto formatting
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

" Keep search results at the center of screen
nmap n nzz
nmap N Nzz

" Quick way to save file
nnoremap <leader>w :w<CR>
