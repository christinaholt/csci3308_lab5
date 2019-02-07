" vim customizations

set ruler

filetype plugin on
filetype indent on

syntax on               " Syntax highlight is normally nicer

set hlsearch            " Highlight searches.
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and :mak
set undolevels=50       " Undo levels (massive eh?)
"set expandtab          " Expand tabs to be spaces
set tabstop=8           " Tabstop to be 8 charactors
set shiftwidth=2        " Shift Width to match Tab stop
set textwidth=160      " Text width
set fileformat=unix     " EOL char is \n only
set cpoptions+=$        " When editing a word don't delete/redraw
set cino+=(0            " Indent to start of function "("
"set vb                  " Turn on visual bell
set formatoptions=tcqron
set autoindent          " Turn on all the indenting styles
set smartindent
set foldlevelstart=20   " Make sure we don't automatically fold everything
"set titlestring=%<%F%=%c\ \ %l/%L-%P
set titlestring=vim\ %<%F%(\ %)%m%h%w%=%l/%L-%P
set titlelen=70
set nofsync
set nocp
set ttyfast
set laststatus=2
"set background=dark
"set mouse=a
"set ttymouse=xterm2

" Fortran settings
let fortran_free_source=1
"let fortran_more_precise=1
"let fortran_fold=1

" Use my local powerline installation
set  rtp+=~/.local/lib/python3.6/site-packages/powerline/bindings/vim/

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = ['vim-airline']
if v:version < '730'
	call add(g:pathogen_disabled, 'YouCompleteMe')
endif


" Highlight tabs and white spaces at the end of lines in gray
set list listchars=tab:\|_,trail:.
highlight SpecialKey ctermfg=DarkGray

" Highlght search term using
highlight Search ctermfg=202 ctermbg=0
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" My spelling is really shocking!
"setlocal spell spelllang=en_us
set spelllang=en_us
map 1 :w!<CR>:!hunspell --dont-backup check %<CR>:e! %<CR> 

" I don't like having white spaces at the end of lines
map 2 :1,$s/[ <tab>]*$//

" highlight the search term under the cursor on the whole page
map 3 :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" \zz to make scrolling keep at the centre of the screen
:nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Map F6 to create a ctags file in the current directory
map <F6> :ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags=./.tags,.tags;

fun GNUIndent()
        set cindent
        set cindent shiftwidth=4
        set expandtab
        set smarttab
"       set cinoptions+={1s,>2s,e2s,n-1s,^-1s
"       set cinoptions=>2,n-2,{0,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
endfun

" Define how I like editing C code
augroup CCode
  "autocmd!
  autocmd FileType c,cpp    :call GNUIndent()
  set cindent tabstop=2
  "autocmd BufNewFile *.[ch] :call AddCopywrite()
  "autocmd BufNewFile *.[h]  :call AddHeader()
  " Turn folding on when editing C source code
  "autocmd BufReadPost *.c  syn region myFold start="{" end="}" transparent fold
  "autocmd BufReadPost *.c  syn sync fromstart
  autocmd BufReadPost *.c   set foldmethod=syntax
  autocmd BufReadPost *.[ch] set tags+=${HOME}/.vim/tags/libc6
  autocmd BufReadPost *.[ch] set path+=/usr/include/**
  "set foldlevel=0
  ":au BufWinEnter *.c let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
  ":au BufWinEnter *.c let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
augroup END

" Define how I like editing Fortran code
augroup FCode
  autocmd!
  autocmd FileType fortran set cindent
  autocmd FileType fortran set tabstop=4 softtabstop=0
  autocmd FileType fortran set expandtab shiftwidth=4 smarttab
  autocmd FileType fortran set textwidth=80
  "autocmd FileType fortran set cindent shiftwidth=4
  let fortran_free_source=1
  let fortran_more_precise=1
augroup END

" Define
augroup PCode
  "autocmd!
  autocmd FileType python set tabstop=4 expandtab sw=4
  autocmd BufReadPost *.[py]  set foldmethod=syntax
  set nosmartindent
augroup END

" Define what I like when using LaTeX
augroup LaTeX
  autocmd!
  autocmd FileType tex set textwidth=72
  autocmd FileType tex setlocal spell spelllang=en_us
  autocmd FileType tex set tabstop=4 expandtab sw=4
  hi SpellBad    ctermfg=202      ctermbg=000
  "autocmd FuncUndefined * exe 'runtime autoload/' . expand('<afile>') . '.vim'
  map ^F i\begin{frame}<CR>\frametitle{}<CR>\end{frame}<CR><Esc>2k2w
  map ^T i\begin{itemize}<CR>\item<Space><CR>\end{itemize}<CR><Esc>2k2w
  "command L !xelatex -shell-escape "%:p" && xdg-open "%:t:r".pdf
  command L !xelatex -shell-escape "%:p"
augroup END

" Define crappy xml
"augroup XML
"  autocmd!
"  autocmd FileType xml set textwidth=72 tabstop=2 expandtab sw=2
"augroup END

" Press Space to turn off highlighting and clear any message already
" displayed.
":nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Define a group for adding comment boxes
augroup Boxes
  autocmd BufEnter *                nmap ,mc !!boxes -d pound-cmt<CR>
  autocmd BufEnter *                vmap ,mc !boxes -d pound-cmt<CR>
  autocmd BufEnter *                nmap ,xc !!boxes -d pound-cmt -r<CR>
  autocmd BufEnter *                vmap ,xc !boxes -d pound-cmt -r<CR>
  autocmd BufEnter *.[ht|x]ml       nmap ,mc !!boxes -d html-cmt<CR>
  autocmd BufEnter *.[ht|x]ml       vmap ,mc !boxes -d html-cmt<CR>
  autocmd BufEnter *.[ht|x]ml       nmap ,xc !!boxes -d html-cmt -r<CR>
  autocmd BufEnter *.[ht|x]ml       vmap ,xc !boxes -d html-cmt -r<CR>
  autocmd BufEnter *.[chly],*.[pc]c nmap ,mc !!boxes -d c-cmt<CR>
  autocmd BufEnter *.[chly],*.[pc]c vmap ,mc !boxes -d c-cmt<CR>
  autocmd BufEnter *.[chly],*.[pc]c nmap ,xc !!boxes -d c-cmt -r<CR>
  autocmd BufEnter *.[chly],*.[pc]c vmap ,xc !boxes -d c-cmt -r<CR>
  autocmd BufEnter .vimrc*          nmap ,mc !!boxes -d vim-cmt<CR>
  autocmd BufEnter .vimrc*          vmap ,mc !boxes -d vim-cmt<CR>
  autocmd BufEnter .vimrc*          nmap ,xc !!boxes -d vim-cmt -r<CR>
  autocmd BufEnter .vimrc*          vmap ,xc !boxes -d vim-cmt -r<CR>
augroup END

"colorscheme solarized

"if has("autocmd") && exists("+omnifunc")
"  autocmd Filetype *
"  \ if &omnifunc == "" |
"  \   setlocal omnifunc=syntaxcomplete#Complete |
"  \ endif
"endif

