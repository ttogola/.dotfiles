"TODO: markdown-> headings, italic/bold, lists/ordered, block quotes...
"       auto-next item when in list, ...
"       update compile to allow linking..
"       indicate intermediate binding value
"       auto resize splits when coming back to vim pane (mksession,winfocus)
"       easier scroll through cmd history
"       call gdb/valgrind from within vim
"       syntastic html, js
"       surround plugin

""Vundle plugin manager""
set nocompatible
set updatetime=0
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'tmux-plugins/vim-tmux' "for .tmux.conf editing
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/ShowMarks'
Plugin 'majutsushi/tagbar.git'
Plugin 'tpope/vim-fugitive.git'
call vundle#end()
filetype plugin indent on
"""""""""""""""""""""""""

set history=1000
"set spell      "Spell checking, or use aspell
set hidden      "Allow buffer switching without saving
set wildmenu    "Show list instead of just completing
"Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
set wildignorecase
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
set shiftwidth=4
set softtabstop=4
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

"autocmds
au FileType html set shiftwidth=2 softtabstop=2
au FileType javascript set shiftwidth=4 softtabstop=4
""""""""""""""""""""""""
"Syntastic basic settings
"TODO bindings for :lnext :lprev
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"""""""""""""""""""""""""
"Fugitive
" Gstatus [- (add/reset highlighted), cc (commit), r (reload status)]
" Gdiff, Gpush
nnoremap <leader>` :Gstatus<CR>
"""""""""""""""""""""""""

"search file names
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"navigate files
map <C-n> :NERDTreeToggle<CR>
"navigate tags
map <C-t> :TagbarToggle<CR>

let mapleader=","
nnoremap ; :
noremap 0 ^
nnoremap Y y$
nnoremap / /\v
vnoremap / /\v

"open temp shell
nnoremap <leader>s :shell<CR>
"save file upon return to normal mode
inoremap <Esc> <Esc>:w<CR>
",x and ,z to increment and decrement int under cursor
nnoremap <leader>x <C-a>
nnoremap <leader>z <C-x>
"find again <left right>
nnoremap <leader>. ;
nnoremap <leader>, ,
"window splits
nnoremap <bar> :vsp<CR>
nnoremap _ :sp<CR>

"display all lines with keyword under cursor
"and ask which one to jump to
nmap <leader>j [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

"TODO: needs fixin'
"zoom current buffer
nnoremap <C-w>o :mksession!<CR>:wincmd o<CR>
"restore previous session
nnoremap <C-w>u :source ~/Session.vim<CR>

"applies the macro to the visual selection
"otherwise, use :1,3norm! @q for instance
vnoremap @ :norm! @

noremap <C-w>r :source ~/.vimrc<CR>
"rotate window layout
noremap <C-w><C-o> <C-w>r

"highlight search matches
nnoremap <leader>h :set hlsearch!<CR>
"highlight column
nnoremap <leader><Bslash> :set cursorcolumn!<CR>

"run prog (extend to other languages: bash, python, node)
nnoremap <leader>p :! ./%.out<CR>
"compile current C/C++ program (use make for bigger projects)
nnoremap <leader>w :!cd %:p:h; g++ -Wall -g -std=c++11 %:t -o %:t.out<CR>
"compile current Java program (use Ant for bigger projects)
nnoremap <leader>v :!cd %:p:h; javac %:t<CR>

"list registers and marks
noremap <silent> <leader>rl :reg<cr>
noremap <silent> <leader>ml :marks<cr>

""""""""""""buffers"""""""""""""""
nnoremap <leader>l :ls<CR>
nnoremap <leader>b :bp<CR>
nnoremap <leader>f :bn<CR>
"close current buffer and save path to last closed file
nnoremap <leader>d :let lastClosed=expand('%:p')<CR>:bd<CR>
"open last closed file
nnoremap <leader>o :exe ":e " lastClosed<CR>

"go to last used buffer
nnoremap <leader>g :e#<CR>
"move to buffer number
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
""""""""""""""""""""""""""""""""""

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
