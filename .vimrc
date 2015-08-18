"required for Vundle
set nocompatible
set updatetime=0
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'kien/ctrlp.vim'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'vim-scripts/ShowMarks'
call vundle#end()
filetype plugin indent on

set history=1000
"set spell      " Spell checking
set hidden      "Allow buffer switching without saving
set wildmenu    " Show list instead of just completing
"Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
set list
"Highlight problematic whitespace
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

set t_Co=256
set background=dark
colorscheme solarized
syntax enable

set number
set cursorline
highlight clear SignColumn
hi cursorcolumn ctermbg=0

set fo=cqt
set wm=0
set expandtab
set tabstop=4
set autoindent

set noswapfile
set pastetoggle=<F3>

set gdefault
set incsearch

set splitbelow
set splitright

"syntastic basic settings
":lnext and :lprevious
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <C-n> :NERDTreeToggle<CR>

let mapleader=","
nnoremap ; :
"c-i and c-x to increment and decrement integer
map <C-i> <C-a>

noremap <C-w><C-o> <C-w>r
noremap <C-w>r :so ~/.vimrc<CR>

nnoremap <bar> :vsp<CR>
nnoremap _ :sp<CR>

nnoremap <F4> :set hlsearch!<CR>
nnoremap <Leader><Bslash> :set cursorcolumn!<CR>
nnoremap / /\v
vnoremap / /\v

"find again <left right>
nnoremap > ;
nnoremap < ,
nnoremap Y y$

"list registers and marks
noremap <silent> <leader>rl :reg<cr>
noremap <silent> <leader>ml :marks<cr>

"buffers
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
"go to last used buffer
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
"show buffer number in status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

"uniform switch between tmux and vim splits (from aaronjensen)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
