"TODO:  call gdb/valgrind from within vim
"       common template files in .vim, could use :read
"       autocomplete dictionaries for languages + other completion tricks
"       plugins needed?
"       vimgrep and copen

"VUNDLE
"set nocompatible
"set updatetime=0
"filetype off
"set rtp+=~/.vim/bundle/Vundle.vim
"
"call vundle#begin()
"Plugin 'gmarik/Vundle.vim'
"Plugin 'scrooloose/syntastic'
"Plugin 'scrooloose/nerdcommenter.git'
"Plugin 'majutsushi/tagbar.git'
"Plugin 'tpope/vim-fugitive.git'
"Plugin 'tpope/vim-surround.git'
"call vundle#end()
"
"filetype plugin indent on
"""""""""""""""""""""""""

let mapleader=","
nnoremap ; :
noremap 0 ^
nnoremap Y y$

"TEXT
colorscheme solarized
syntax enable
set t_Co=256
set background=dark
set number
set relativenumber
set shiftwidth=4
set softtabstop=4
set expandtab
set nojoinspaces
set smartindent
set fileformat=unix
" Use new regular expression engine
set re=0
"Show whitespace
set list
"Highlight problematic whitespace
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
"Toggle spell checking
nnoremap <leader>s :set spell!<cr>
"Highlight column
nnoremap <leader><bslash> :set cursorcolumn!<cr>
highlight cursorcolumn ctermbg=cyan
""""""""""""""""""""""""""""""""""""""""""""""""

"SYNTASTIC
"nnoremap [e :lprev<CR>
"nnoremap ]e :lnext<CR>
""TODO: syntastic html, js(jslint?) and other langs used
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_java_javac_config_file_enabled = 1
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
""""""""""""""""""""""""""""""""

"FUGITIVE
" Gstatus [- (add/reset highlighted), cc (commit), r (reload status)]
" Gpush
nnoremap <leader>` :Gstatus<CR>
nnoremap <leader><Tab> :Gdiff<CR>
""""""""""""""""""""""""""""""""""

"UTIL
set noswapfile
"Toggle modifiable
nnoremap <leader><space> :set modifiable!<cr>
"Open temporary terminal shell
nnoremap <leader>t :shell<cr>
"Save file on escape
inoremap <esc> <esc>:write<cr>
"Increment int under cursor
nnoremap <leader>x <c-a>
"Decrement int under cursor
nnoremap <leader>z <c-x>
"Applies the macro to the visual selection
"   otherwise, use :1,3norm! @q for instance
vnoremap @ :norm! @
"Run prog (TODO: extend to other languages: bash, python, node, autodetect)
nnoremap <leader>p :! ./%.out<cr>
"Toggle paste mode
nnoremap <leader>w :set invpaste paste?<cr>
"List registers and marks
noremap <silent> <leader>rl :registers<cr>
noremap <silent> <leader>ml :marks<cr>
"Statusline
set laststatus=2 statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
""""""""""""""""""""""""""""""""""""""

"COMMAND LINE
set history=1000
"Show list of completion options
set wildmenu
"Command <Tab> completion, match order
set wildmode=list:longest,full
set wildignorecase
""""""""""""""""""

"AUTOCMDS
au FileType html setlocal shiftwidth=2 softtabstop=2
""""""""""""""""""""""""""""""""""""""""""""""""""""

"SEARCH / NAVIGATION
set path+=**
set gdefault
set incsearch
nnoremap / /\v
vnoremap / /\v
"Find again <left right>
nnoremap <leader>. ;
nnoremap <leader>, ,
"Display number of matches from previous search
nnoremap <leader>n :%s///gn <CR>
"Highlight search matches
nnoremap <leader>h :set hlsearch!<cr>
"Navigate tags
map <c-n> :TagbarToggle<cr>
"Display all lines with keyword under cursor
"   and ask which one to jump to
nmap <leader>j [I:let nr = input("Select: ")<bar>exe "normal " . nr ."[\t"<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"LAYOUT
set splitbelow
set splitright
"Window splits
nnoremap <bar> :vsplit<cr>
nnoremap _ :split<cr>
"""""""""""""""""""""""""

"BUFFERS
"Tip: use :b substring to jump to matching buffer
nnoremap <leader>l :ls<cr>:buffer<space>
nnoremap <leader>b :bprevious<cr>
nnoremap <leader>f :bnext<cr>
"Go to last used buffer
nnoremap <leader>g :edit#<cr>
"Close current buffer and save path to last closed file
nnoremap <leader>d :let lastClosed=expand('%:p')<cr>:bdelete<cr>
"Open last closed file
nnoremap <leader>o :execute ":edit " lastClosed<cr>
"Allow buffer switching without saving
set hidden
"""""""""""""""""""""""""""""""""""""""""

"Uniform switch between tmux and vim splits
"(adapted from aaronjensen to wrap around when reach last window)
"See .tmux.conf
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

    nnoremap <silent> <c-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    nnoremap <silent> <c-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    nnoremap <silent> <c-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    nnoremap <silent> <c-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
    map <c-h> <c-w>h
    map <c-j> <c-w>j
    map <c-k> <c-w>k
    map <c-l> <c-w>l
endif
