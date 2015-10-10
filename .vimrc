"TODO: prevent tab from doing increments
"
"required for Vundle
set nocompatible
set updatetime=0
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/ShowMarks'
call vundle#end()
filetype plugin indent on

set history=1000
"set spell      "Spell checking, or use aspell
set hidden      "Allow buffer switching without saving
set wildmenu    "Show list instead of just completing
"Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
set list
"Highlight problematic whitespace
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

set t_Co=256
set background=dark
colorscheme solarized
syntax enable

"show current line number in addition to relative line numbers
set number
set relativenumber
set cursorline
highlight clear SignColumn
hi cursorcolumn ctermbg=0

set fo=cqt
set wm=0
set tw=0
set shiftwidth=2
set softtabstop=2
set expandtab
set nojoinspaces
set smartindent
set foldcolumn=1

set noswapfile
set pastetoggle=<C-w>p

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

noremap 0 ^
"noremap j gj
"noremap k gk
"display all lines with keyword under cursor
"and ask which one to jump to
nmap <leader>j [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

"applies the macro to the visual selection
"otherwise, use :1,3norm! @q for instance
vnoremap @ :norm! @

noremap <C-w><C-o> <C-w>r
noremap <C-w>r :so ~/.vimrc<CR>

nnoremap <bar> :vsp<CR>
nnoremap _ :sp<CR>

nnoremap <leader>h :set hlsearch!<CR>
nnoremap <leader><Bslash> :set cursorcolumn!<CR>
nnoremap / /\v
vnoremap / /\v

"find again <left right>
nnoremap <leader>. ;
nnoremap <leader>, ,
nnoremap Y y$
"compile current program (use make for bigger projects)
nnoremap <leader>w :!cd %:p:h; g++ -Wall -g -std=c++11 %:t -o %:t.out<CR>

"list registers and marks
noremap <silent> <leader>rl :reg<cr>
noremap <silent> <leader>ml :marks<cr>

"buffers
nnoremap <leader>l :ls<CR>
nnoremap <leader>b :bp<CR>
nnoremap <leader>f :bn<CR>
nnoremap <leader>d :bd<CR>
"go to last used buffer
nnoremap <leader>g :e#<CR>
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>
nnoremap <leader>5 :5b<CR>
nnoremap <leader>6 :6b<CR>
nnoremap <leader>7 :7b<CR>
nnoremap <leader>8 :8b<CR>
nnoremap <leader>9 :9b<CR>
nnoremap <leader>0 :10b<CR>
"show buffer number in status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

"uniform switch between tmux and vim splits
"(adapted from aaronjensen to wrap around when reach last window)
"see .tmux.conf
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let prev_winnr = winnr()
    let prev_tmuxp = system("tmux display-message -p '#p'")
    silent! execute "wincmd " . a:wincmd
    if prev_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
      """
      if prev_tmuxp == system("tmux display-message -p '#p'")
        if (winnr() == 1)
          silent! execute winnr("$") . "wincmd w"
        else
          silent! execute 1 . "wincmd w"
        endif
      endif
      """
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
