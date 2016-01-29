"
" NOTE: use ":so %" to reload this file
"
" Necesary  for lots of cool vim things
set nocompatible

"filetype off  "needed by Vundle?

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" Tmux integration
Plugin 'christoomey/vim-tmux-navigator'

" Vimux - vim+tmux split window
"Plugin 'benmills/vimus'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" pathogen is another package manager
execute pathogen#infect()

" disable visual bell
set noeb vb t_vb=
set nu

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

" ~/.vimrc
" Make Vim recognize XTerm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
"if &term =~ '^screen'
"  " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
"  execute "set t_kP=\e[5;*~"
"  execute "set t_kN=\e[6;*~"
"
"  " Arrow keys http://unix.stackexchange.com/a/34723
"  execute "set <xUp>=\e[1;*A"
"  execute "set <xDown>=\e[1;*B"
"  execute "set <xRight>=\e[1;*C"
"  execute "set <xLeft>=\e[1;*D"
"endif

" Sets how many lines of history VIM has to remember
set history=1000

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

let mapleader = ","

" load vim-plug plugin manager -- https://github.com/junegunn/vim-plug

" Enable syntax highlighting
syntax enable
set background=dark
"colorscheme elflord
colorscheme desert

"colorscheme base16-railscasts
"
"highlight clear SignColumn
"highlight VertSplit    ctermbg=236
"highlight ColorColumn  ctermbg=237
"highlight LineNr       ctermbg=236 ctermfg=240
"highlight CursorLineNr ctermbg=236 ctermfg=240
"highlight CursorLine   ctermbg=236
"highlight StatusLineNC ctermbg=238 ctermfg=0
"highlight StatusLine   ctermbg=240 ctermfg=12
"highlight IncSearch    ctermbg=3   ctermfg=1
"highlight Search       ctermbg=1   ctermfg=3
"highlight Visual       ctermbg=3   ctermfg=0
"highlight Pmenu        ctermbg=240 ctermfg=12
"highlight PmenuSel     ctermbg=3   ctermfg=1
"highlight SpellBad     ctermbg=0   ctermfg=1

"colorscheme gotham
au BufNewFile,BufRead *.cxx set syntax=cpp11
au BufNewFile,BufRead *.ixx set syntax=cpp11
au BufNewFile,BufRead *.hxx set syntax=cpp11

if &diff
  colorscheme pablo
  " other good cs for vimdiff: murphy pablo slate

  " diff mode : ignore spaces
  "set diffopt+=iwhite
endif



" Turn on the WiLd menu
set wildmenu

" On the first tab it will act as longest:full, showing the wildmenu but only
" populating the longest string found. The second tab will populate the first
" full match, which happens to be the first in the wildmenu
set wildmode=longest:full,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
"set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Always keep cursor 2 lines from screen edge
set scrolloff=2

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells visualbell t_vb=
set tm=500



" Use tabs instead of spaces :(
set noexpandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4


set ai "Auto indent
set si "Smart indent
"set wrap "Wrap lines



" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"

" Enable mouse support in console
"set mouse=nvch
set mouse=a

" Saves undo's after file closes
set undofile

" red line indicating column 100
set cc=100

set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%1*\ [%3.3n]%*            "buffer number
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%r%w%h%*                "modified flag
set statusline +=%1*%=%*                    " separator
set statusline +=%1*L:\ %5l%*             "current line
set statusline +=%1*/%L\ (%2p%%),%*               "total lines
set statusline +=%1*\ \ C:\ %4v,\ %*             "virtual column number
set statusline +=%1*0x%04B\ [%3.3b]\ %*          "character under cursor

hi User1 ctermfg=yellow ctermbg=darkgray guifg=yellow guibg=darkgray
hi User2 ctermfg=red ctermbg=darkgray guifg=red guibg=darkgray
hi User3 ctermfg=cyan ctermbg=darkgray guifg=cyan guibg=darkgray
hi User4 ctermfg=green ctermbg=darkgray guifg=green guibg=darkgray
hi User5 ctermfg=yellow ctermbg=darkgray guifg=yellow guibg=darkgray


if has("cscope")

    "set cscopeverbose

    if has('quickfix')
      set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    "cnoreabbrev csa cs add
    "cnoreabbrev csf cs find
    "cnoreabbrev csk cs kill
    "cnoreabbrev csr cs reset
    "cnoreabbrev css cs show
    "cnoreabbrev csh cs help

    cscope add $MS_SRC_BASE/../cscope.out  $MS_SRC_BASE/..
    cscope add $MS_SRC_BASE/../src/cscope.out  $MS_SRC_BASE/../src

    cscope add $HOME/dev/cscope.out $HOME/dev
    cscope add $HOME/tp/cscope.out $HOME/tp

    "cscope add /usr/include/cscope.out /usr/include
    "cscope add /usr/local/include/cscope.out /usr/local/include

    nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " Using 'CTRL-spacebar' then a search type makes the vim window
    " split horizontally, with search result displayed in
    " the new window.

    nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

    "nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    "
    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one

    "nmap <C-Space><C-Space>s
    "      \:vert scs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>g
    "      \:vert scs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>c
    "      \:vert scs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>t
    "      \:vert scs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>e
    "      \:vert scs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>i
    "      \:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-Space><C-Space>d
    "      \:vert scs find d <C-R>=expand("<cword>")<CR><CR>

    set cst " use cscope as default tags handler
    " set cscopetag " the same as above
    set csto=0 " do not search ctags before cscope
    set csprg=$HOME/gentoo/usr/bin/cscope

    map <F8> :set csto=0<CR>
endif

map <F7> :set csto=1<CR>

" disable default key/mouse mapping
"let g:GtagsCscope_Auto_Map = 0

" this will reset csprg to point to gtags-cscope
" and it will try to set path to GTAGS
"let g:GtagsCscope_Auto_Load = 1
" auto update GTAGS on buffer write
"let g:Gtags_Auto_Update = 1

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
"au BufEnter /* call LoadCscope()

"function! LoadGtags()
"  let db = findfile("GTAGS", ".;")
"  if (!empty(db))
"    let path = strpart(db, 0, match(db, "/GTAGS$"))
"    set nocscopeverbose " suppress 'duplicate connection' error
"    exe "cs add " . db . " " . path
"    set cscopeverbose
"  endif
"endfunction
"au BufEnter /* call LoadGtags()

" search for the tags in the current directory and recurse up 4 levels:
set tags+=./tags;../../../../
"set tags+=./tags;../../

" fix locations:
set tags+=$MS_SRC_BASE/../tags
set tags+=$MS_SRC_BASE/../src/tags
set tags+=$HOME/dev/tags
set tags+=$HOME/tp/tags

set path^=$HOME/dev/**5/src
set path^=$HOME/dev/**5/include

"let g:alternateExtensions_hxx = "cpp,cc,CC,c"
"let g:alternateExtensions_cxx = "h,hpp"

"let g:alternateSearchPath = 'sfr:../src,sfr:../../src'
let g:alternateSearchPath = 'sfr:.'

map  <F4> :set hls!<CR>
imap <F4> <ESC>:set hls!<CR>a
vmap <F4> <ESC>:set hls!<CR>gv


" Disable mouse on console
map <F5> :set mouse=<CR>
imap <F5> <ESC>:set mouse=<CR>a
vmap <F5> <ESC>:set mouse=<CR>gv

" Enable mouse
map <F6> :set mouse=a<CR>
imap <F6> <ESC>:set mouse=a<CR>a
vmap <F6> <ESC>:set mouse=a<CR>gv

highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
au ColorScheme * highlight ExtraWhitespace guibg=darkgray
"au BufEnter * match ExtraWhitespace /[\t]\|\s\+$/
"au InsertEnter * match ExtraWhitespace /[\t]\|\s\+\%#\@<!$/
"au InsertLeave * match ExtraWhiteSpace /[\t]\|\s\+$/
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"let g:miniBufExplMapWindowNavArrows = 0
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapCTabSwitchWindows = 0

"nmap <Tab> :wincmd w<CR>
"nmap <S-Tab> :wincmd W<CR>
"
"nmap <F12> :TagbarToggle<CR>
"nmap <F12> :TagExplorer<CR>

nmap <F10> :cprev<CR>
nmap <F11> :cnext<CR>


" enable modelines in the top 3 lines
set modeline
set modelines=3

" Append modeline in the first line
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d sts=%d %set :",
        \ &tabstop, &shiftwidth, &softtabstop, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("0"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

if has("spell")
  " turn spelling on by default
  set spell

  " toggle spelling with F3 key
  map <F3> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

  " they were using white on white
  "highlight SpellBad ctermfg=black ctermbg=lightgray
  highlight clear SpellBad
  highlight clear SpellCap
  highlight clear SpellRare
  highlight SpellBad cterm=undercurl
  highlight SpellCap cterm=underline
  highlight SpellRare cterm=underline

  " limit it to just the top 10 items
  set sps=best,10
  "  ]s       - forward to misspelled/rare/wrong cap word
  "  [s       - backwards
  "
  "  ]S       - only stop at misspellings
  "  [S       - in other direction
  "
  "  zG       - accept spelling for this session
  "  zg       - accept spelling and add to personal dictionary
  "
  "  zW       - treat as misspelling for this session
  "  zw       - treat as misspelling and add to personal dictionary
  "
  "  z=       - show spelling suggestions
  "
  "  :spellr  - repeat last spell replacement for all words in window
endif

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" Tmux will translate A-Arrows into C-[hjkl] and execute the commands above
" Unfortunately, the following mappings wouldn't work natively in vim (and putty)
"nnoremap <silent> <A-Left> :TmuxNavigateLeft<cr>
"nnoremap <silent> <A-Down> :TmuxNavigateDown<cr>
"nnoremap <silent> <A-Up> :TmuxNavigateUp<cr>
"nnoremap <silent> <A-Right> :TmuxNavigateRight<cr>
"nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>

" fakeclip plugin, if loaded, should allow you to use a new register to
" copy-paste from/into tmux clipboard using "&" registry name, e.g.
"  yank:  "&y
"  paste: "&p
"
" Note also, that "* and "+ are system registers in vim, but they don't
" cooperate with tmux
"

" Automatically load *.bin files in binary mode
" Manually enter binary mode: :%!xxd
" exit: :%!xxd -r
augroup Binary
	au!
	au BufReadPre *.bin let &bin=1
	au BufReadPost *.bin if &bin | %!xxd
	au BufReadPost *.bin set ft=xxd | endif
	au BufWritePre *.bin if &bin | %!xxd -r
	au BufWritePre *.bin endif
	au BufWritePost *.bin if &bin | %!xxd
	au BufWritePost *.bin set nomod | endif
augroup END

" enable digraphs, type
"  :digraphs
" for the list; and
"  CTRL-K + <char1> <char2>
" to insert special char
set digraph
