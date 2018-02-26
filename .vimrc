" vim: set ts=4 sw=4 sts=4 noet :
"
" =====================================
" NOTE: use ":so %" to reload this file
" =====================================
"
" Necesary  for lots of cool vim things (always set for nvim)
set nocompatible

"filetype off  "needed by Vundle?

" General hints:
" CTRL-R CTRL-W   : pull word under the cursor into a command line or search
" CTRL-R CTRL-A   : pull whole word including punctuation
" CTRL-R -        : pull small register
" CTRL-R [0-9a-z] : pull named registers
" CTRL-R %        : pull file name (also #)

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

Plugin 'mhinz/vim-grepper'

" Optional: used for repeating operator actions via "."
Plugin 'tpope/vim-repeat'
" syntax highlight for git diff
Plugin 'tpope/vim-git'
" integration with git:
Plugin 'tpope/vim-fugitive'

" async compilations
Plugin 'tpope/vim-dispatch'

" surroungings: https://vim.sourceforge.io/scripts/script.php?script_id=1697
Plugin 'tpope/vim-surround'

" git browser (like tig) in vim
Plugin 'xaizek/vim-extradite'

" rtags - llvm tags
" need to start rdm and load compilation db (rc -c / rc -J)
"Plugin 'lyuts/vim-rtags'


" displaying thin vertical lines at each indentation level for code indented
" with spaces
Plugin 'Yggdroot/indentLine'

" allows you to configure % to match more than just single characters
Plugin 'tmhedberg/matchit'

"
"[count]<leader>cc |NERDComComment|				Comment out the current line or text selected in visual mode.
"[count]<leader>cn |NERDComNestedComment|		Same as cc but forces nesting.
"[count]<leader>c<space> |NERDComToggleComment| Toggles the comment state of the selected line(s).
"[count]<leader>cm |NERDComMinimalComment|		Comments the given lines using only one set of multipart delimiters.
"[count]<leader>ci |NERDComInvertComment|		Toggles the comment state of the selected line(s) individually.
"[count]<leader>cs |NERDComSexyComment|			Comments out the selected lines with a pretty block formatted layout.
"[count]<leader>cy |NERDComYankComment|			Same as cc except that the commented line(s) are yanked first.
"<leader>c$ |NERDComEOLComment|					Comments the current line from the cursor to the end of line.
"<leader>cA |NERDComAppendComment|				Adds comment delimiters to the end of line and goes into insert mode between them.
"|NERDComInsertComment|							Adds comment delimiters at the current cursor position and inserts between (disabled by default)
"<leader>ca |NERDComAltDelim|					Switches to the alternative set of delimiters.
"[count]<leader>cl								Same as |NERDComComment| except that the delimiters are aligned down the left side
"[count]<leader>cb |NERDComAlignedComment|		Same as |NERDComComment| except that the delimiters are aligned down the both sides.
"[count]<leader>cu |NERDComUncommentLine|		Uncomments the selected line(s).
"
"Simple visual comment:
" <Ctrl+v>, select block, <Shift+I>, insert comment chars (e.g. //), <Esc>
Plugin 'scrooloose/nerdcommenter'

" The Most Recently Used (MRU) plugin provides an easy access to a list of
" recently opened/edited files in Vim
Plugin 'yegappan/mru'

Plugin 'Yggdroot/LeaderF'

"Plugin 'L9'
"Plugin 'FuzzyFinder'
"Plugin 'SkidanovAlex/CtrlK'

Plugin 'wincent/command-t'

" more colorschemes
Plugin 'rafi/awesome-vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required

"" pathogen is another package manager
"execute pathogen#infect()
"
"
"call plug#begin('~/.vim/plugged')
"
"" On-demand loading
""Plug 'mathstuf/vim-fugitive', { 'branch':  'git-workdir-support' }
""Plug 'mathstuf/vim-fugitive'
""
"" " Add plugins to &runtimepath
"call plug#end()

" Also Recommended:
"  2) extradite.vim: a git commit browser,
"		http://int3.github.io/vim-extradite/
"

" NOTE: when error occurs (typically after full partition)
"  Error detected while processing function <SNR>25_updateData..fuf#updateMruList
" Solution:
"  remove  ~/.vim-fuf-data/mrufile/items

" Additional stuff:
"  * CSV support with https://github.com/chrisbra/csv.vim
"    Some useful commands:
"     :%ArrangeColumn		-- align visually
"     :%UnArrangeColumn
"     :HiColumn				-- highlight column
"     :VertFold 2			-- hide column
"     :VertFold!			-- unhide
"
"     :%MoveColumn from to
"     :DeleteColumn pattern -- e.g. "DeleteColumn 2" or "DeleteColumn /foobar"
"
"     :%Substitute 1,4/foobar/baz/gce -- Substitutes in the whole file in
"				columns 1 till 4 the pattern foobar by baz for every match ('g' flag)
"				and asks for confirmation ('c' flag).
"	  :%S 3,$/(\d\+)/\1 EUR/g	-- Substitutes in each column starting from the
"				third each number and appends the EURO suffix to it.
"
"     :1,10Sort 3
"	  :1,10Sort! 3			-- reverse sort
"
"     :NrColumns			-- count number of columns
"     :WhatColumn			-- current column number
"
"     :Analyze 3			-- distribution of top 5 values in column 3
"     :Transpose

" automatically highlight current column in CSV
let g:csv_highlight_column = 'y'


set nu

if !has('nvim')
	set t_vb=
	if &term =~ '256color'
		" disable Background Color Erase (BCE) so that color schemes
		" render properly when inside 256-color tmux and GNU screen.
		" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
		set t_ut=
	endif
	" set title of the terminal (always set for nvim)
	set ttyfast
endif

if has('nvim')
	" Esc to exit terminal mode:
    tnoremap <Esc> <C-\><C-n>

	" Map keys to navigate windows
    "tnoremap <A-h> <C-\><C-n><C-w>h
    "tnoremap <A-j> <C-\><C-n><C-w>j
    "tnoremap <A-k> <C-\><C-n><C-w>k
    "tnoremap <A-l> <C-\><C-n><C-w>l

    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l
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

" TIP: change one line into multiply lines and indent
" %s/[{;}]/&\r/g|norm! =gg

" set leader key to colon
let mapleader = ","

" load vim-plug plugin manager -- https://github.com/junegunn/vim-plug

" enable 256 colors:
set t_Co=256

" terminal codes for colors
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

" Enable syntax highlighting
syntax enable
set background=dark
"colorscheme elflord
"colorscheme desert
"colorscheme materialbox
colorscheme solarized8
" OceanicNext default  atom deep-space deus gruvbox materialbox jellybeans
" pablo solarized8


hi Search cterm=NONE ctermfg=grey ctermbg=darkblue
hi Visual term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE

"DiffAdd - line was added
"DiffDelete - line was removed
"DiffChange - part of the line was changed (highlights the whole line)
"DiffText - the exact part of the line that changed
"
"hi DiffAdd term=bold ctermbg=4
hi DiffAdd term=bold ctermbg=30
"hi DiffDelete term=bold ctermfg=12 ctermbg=6
hi DiffDelete term=bold ctermfg=43 ctermbg=6
"hi DiffChange term=bold ctermbg=5
hi DiffChange term=bold ctermbg=128
"hi DiffText term=reverse cterm=NONE ctermfg=Gray ctermbg=red
hi DiffText term=reverse cterm=NONE ctermfg=Gray ctermbg=161

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

"if &diff
"  colorscheme pablo
  " other good cs for vimdiff: murphy pablo slate

  " diff mode : ignore spaces
  "set diffopt+=iwhite
"endif


" Show title in xterm window
set title

" Turn on the WiLd menu (tab completion on opening a file)
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
" set noeb vb t_vb=
set tm=500


" for more unicode symbols go to: http://www.utf8-chartable.de/unicode-utf8-table.pl
let g:indentLine_char = '┊'
let g:indentLine_setColors = 0
						
                           "
                          
"set showbreak=
"set listchars=tab:→\ ,eol:↲,nbsp:,␣trail:•,extends:›,precedes:‹
"set listchars=tab:»∶,eol:‸,trail:•,extends:›,precedes:‹
"set listchars=tab:»∶,eol:˫,trail:•,extends:›,precedes:‹
"set listchars=tab:»∶,eol:˭,trail:•,extends:›,precedes:‹
"set listchars=tab:»∶,eol:·,trail:•,extends:›,precedes:‹
"ˍˈ↙⌟⌏⌇⌘┊␣◃▿ˣ▫▖▂◻♮♯♭♬♫♪♩♢♔♕☼♁☸☐☇☆◿◰⟧⟦⨁⨂⨀
set listchars=tab:»∶,eol:⌟,trail:ˍ,extends:›,precedes:‹
hi NonText ctermfg=22 guifg=#4a4a59
hi SpecialKey ctermfg=22 guifg=#4a4a59
set list
"set listchars=tab:»\ ,trail:·,extends:\#,nbsp:.
"set listchars=tab:▶\ ,trail:·,extends:\#,nbsp:.
" Use tabs instead of spaces :(
"set noexpandtab
" Use spaces instead of tabs :>
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4


set ai "Auto indent
set si "Smart indent
"set wrap "Wrap lines
"
" Use tabs only for indentation, formating should use spaces
"set cindent
"set cinoptions=(0,u0,U0



" Do not enable digraphs: they are slowing down processing, and more
" importantly change the meaning of backspace (you can now use backspace to
" insert uincode chars). This also interferes with Tmux keys
"
" enable digraphs, type
"  :digraphs
" for the list; and
"  CTRL-K + <char1> <char2>
" to insert special char
"set digraph

" Enable mouse support in console
"set mouse=nvch
set mouse=a

" Saves undo's after file closes
set undofile

" red line indicating column 100
set cc=100

" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"

set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%1*\ [%3.3n]%*         "buffer number
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%r%w%h%*          "modified flag
set statusline +=%1*%=%*                "separator
set statusline +=%1*L:\ %5l%*           "current line
set statusline +=%1*/%L\ (%2p%%),%*     "total lines
set statusline +=%1*\ \ C:\ %4v,\ %*    "virtual column number
set statusline +=%1*0x%04B\ [%3.3b]\ %* "character under cursor

hi User1 ctermfg=yellow ctermbg=darkgray guifg=yellow guibg=darkgray
hi User2 ctermfg=red ctermbg=darkgray guifg=red guibg=darkgray
hi User3 ctermfg=cyan ctermbg=darkgray guifg=cyan guibg=darkgray
hi User4 ctermfg=green ctermbg=darkgray guifg=green guibg=darkgray
hi User5 ctermfg=yellow ctermbg=darkgray guifg=yellow guibg=darkgray


" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :GrepperAg "\b<C-R><C-W>\b"<CR>:cw<CR>

command! -nargs=+ -complete=file GrepperGit Grepper -noprompt -tool git -query <args>
command! -nargs=+ -complete=file GrepperAg Grepper -noprompt -tool ag -query <args>

" This defines an operator "gs" that takes any {motion} and uses that
" selection to populate the search prompt. The query is quoted automatically.
"Useful examples are gsW, gsiw, or gsi". See |text-objects| for all of them.
"In visual mode, it uses the current selection.
nmap gs  <plug>(GrepperOperator) 
xmap gs  <plug>(GrepperOperator) 

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

    cscope add $MS_SRC_BASE/cscope.out  $MS_SRC_BASE/
    cscope add $MS_SRC_BASE/src/cscope.out  $MS_SRC_BASE/src

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

"if has("rtags")
	set completefunc=RtagsCompleteFunc
    set csto=1 " we actually want to search ctags before cscope because rtags binds to ctags

	" list of default short cuts
	" <Leader>ri	-U	Symbol info
	" <Leader>rj	-f	Follow location
	" <Leader>rJ	-f --declaration-only	Follow declaration location
	" <Leader>rS	-f	Follow location (open in horizontal split)
	" <Leader>rV	-f	Follow location (open in vertical split)
	" <Leader>rT	-f	Follow location open in a new tab
	" <Leader>rp	-U --symbol-info-include-parents	Jump to parent
	" <Leader>rf	-e -r	Find references
	" <Leader>rn	-ae -R	Find references by name
	" <Leader>rs	-a -F	Find symbols by name
	" <Leader>rr	-V	Reindex current file
	" <Leader>rl	-w	List all available projects
	" <Leader>rw	-e -r --rename	Rename symbol under cursor
	" <Leader>rv	-k -r	Find virtuals
	" <Leader>rb	N/A		Jump to previous location
"endif

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
set tags+=$MS_SRC_BASE/tags
set tags+=$MS_SRC_BASE/src/tags

set path^=.
set path^=$HOME/dev/**5/src
set path^=$HOME/dev/**5/include

" Alternative: working directory is always the same as the file you are editing
"   set autochdir
"
" The above (autochdir) may not work well with scripts that assume cwd does not update;
" this is a workaround:
"   autocmd BufEnter * silent! lcd %:p:h
" But generally cabbr is a better choice

" use a command line abbreviation so %% expands to the full path of the
" directory that contains the current file.
cabbr <expr> %% expand('%:p:h')
cabbr <expr> ~~ expand('%:p:h')

cabbr Ag GrepperAg

"let g:alternateExtensions_hxx = "cpp,cc,CC,c"
"let g:alternateExtensions_cxx = "h,hpp"

"let g:alternateSearchPath = 'sfr:../src,sfr:../../src'
let g:alternateSearchPath = 'sfr:.'

map  <F4> :set hls!<CR>
imap <F4> <ESC>:set hls!<CR>a
vmap <F4> <ESC>:set hls!<CR>gv


" Disable list
map <F5> :set nolist<CR>:let g:indentLine_enabled = 0<CR>
imap <F5> <ESC>:set nolist<CR>:let g:indentLine_enabled = 0<CR>a
vmap <F5> <ESC>:set nolist<CR>:let g:indentLine_enabled = 0<CR>gv

" Enable mouse
map <F6> :set list<CR>:let g:indentLine_enabled = 1<CR>
imap <F6> <ESC>:set list<CR>:let g:indentLine_enabled = 1<CR>a
vmap <F6> <ESC>:set list<CR>:let g:indentLine_enabled = 1<CR>gv


"" Disable mouse on console
"map <F5> :set mouse=<CR>
"imap <F5> <ESC>:set mouse=<CR>a
"vmap <F5> <ESC>:set mouse=<CR>gv
"
"" Enable mouse
"map <F6> :set mouse=a<CR>
"imap <F6> <ESC>:set mouse=a<CR>a
"vmap <F6> <ESC>:set mouse=a<CR>gv

highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
au ColorScheme * highlight ExtraWhitespace guibg=darkgray
"au BufEnter * match ExtraWhitespace /[\t]\|\s\+$/
"au InsertEnter * match ExtraWhitespace /[\t]\|\s\+\%#\@<!$/
"au InsertLeave * match ExtraWhiteSpace /[\t]\|\s\+$/
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

highlight WildMenu cterm=underline

" Make sure you are using recent version of MiniBufferExplorer (MBE), 
"let g:miniBufExplMaxSize = 1
"let g:miniBufExplSplitBelow = 0
"let g:miniBufExplorerAutoUpdate = 0
"let g:miniBufExplMapWindowNavArrows = 0
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapCTabSwitchWindows = 0

"nmap <Tab> :wincmd w<CR>
"nmap <S-Tab> :wincmd W<CR>
"
"nmap <F12> :TagbarToggle<CR>
"nmap <F12> :TagExplorer<CR>

nmap <F9> :Make<CR>
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
  highlight clear SpellBad
  highlight clear SpellCap
  highlight clear SpellRare
  "highlight SpellBad ctermfg=black ctermbg=lightgray
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

nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
"nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

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
"augroup Binary
"	au!
"	au BufReadPre *.bin let &bin=1
"	au BufReadPost *.bin if &bin | %!xxd
"	au BufReadPost *.bin set ft=xxd | endif
"	au BufWritePre *.bin if &bin | %!xxd -r
"	au BufWritePre *.bin endif
"	au BufWritePost *.bin if &bin | %!xxd
"	au BufWritePost *.bin set nomod | endif
"augroup END


" Disable one diff window during a three-way diff allowing you to cut out the
" noise of a three-way diff and focus on just the changes between two versions
" at a time. Inspired by Steve Losh's Splice
function! DiffToggle(window)
  " Save the cursor position and turn on diff for all windows
  let l:save_cursor = getpos('.')
  windo :diffthis
  " Turn off diff for the specified window (but keep scrollbind) and move
  " the cursor to the left-most diff window
  exe a:window . "wincmd w"
  diffoff
  set scrollbind
  set cursorbind
  exe a:window . "wincmd " . (a:window == 1 ? "l" : "h")
  " Update the diff and restore the cursor position
  diffupdate
  call setpos('.', l:save_cursor)
endfunction
" Toggle diff view on the left, center, or right windows
nmap <silent> <leader>dl :call DiffToggle(1)<cr>
nmap <silent> <leader>dc :call DiffToggle(2)<cr>
nmap <silent> <leader>dr :call DiffToggle(3)<cr>

" MRU - Most Recently Used
let MRU_Window_Height = 15

" FuzzyFinder, http://www.vim.org/scripts/script.php?script_id=1984
"let g:fuf_modesDisable = []
"let g:fuf_mrufile_maxItem = 1000
"let g:fuf_mrucmd_maxItem = 400
"let g:fuf_mrufile_exclude = '\v\~$|\.(bak|sw[po])$|^(\/\/|\\\\|\/mnt\/)'
"nnoremap <silent> <C-n>      :FufBuffer<CR>
"nnoremap <silent> <C-p>      :FufFileWithCurrentBufferDir<CR>
"nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
"nnoremap <silent> <C-f>p     :FufFile<CR>
"nnoremap <silent> <C-f><C-d> :FufDirWithCurrentBufferDir<CR>
"nnoremap <silent> <C-f>d     :FufDirWithFullCwd<CR>
"nnoremap <silent> <C-f>D     :FufDir<CR>
"nnoremap <silent> <C-j>      :FufMruFile<CR>
"nnoremap <silent> <C-k>      :FufMruCmd<CR>
"nnoremap <silent> <C-b>      :FufBookmarkDir<CR>
"nnoremap <silent> <C-f><C-t> :FufTag<CR>
"nnoremap <silent> <C-f>t     :FufTag!<CR>
"noremap  <silent> g]         :FufTagWithCursorWord!<CR>
"nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>
"nnoremap <silent> <C-f><C-j> :FufJumpList<CR>
"nnoremap <silent> <C-f><C-g> :FufChangeList<CR>
"nnoremap <silent> <C-f><C-q> :FufQuickfix<CR>
"nnoremap <silent> <C-f><C-l> :FufLine<CR>
"nnoremap <silent> <C-f><C-h> :FufHelp<CR>
"nnoremap <silent> <C-f><C-b> :FufAddBookmark<CR>
"vnoremap <silent> <C-f><C-b> :FufAddBookmarkAsSelectedText<CR>
"nnoremap <silent> <C-f><C-e> :FufEditInfo<CR>
"nnoremap <silent> <C-f><C-r> :FufRenewCache<CR>

"noremap <silent> <C-]> :FufTagWithCursorWord!<CR>

" TODO: try https://github.com/junegunn/fzf
"
" LeaderF config:
"
" <C-R>					switch between fuzzy search mode and regex mode
" <C-F>					switch between full path search mode and name only search mode
" <C-V> <S-Insert>		paste from clipboard
" <C-U>					clear the prompt
" <C-J> <Down>			move the cursor downward in the result window
" <C-K> <Up>			move the cursor upward in the result window
" <2-LeftMouse> <CR>	open the file under cursor or selected(when multiple files are selected)
" <C-X>					open in horizontal split window
" <C-]>					open in vertical split window
" <C-T>					open in new tabpage
" <F5>					refresh the cache
" <C-LeftMouse> <C-S>	select multiple files
" <S-LeftMouse>			select consecutive multiple files
" <C-A>					select all files
" <C-L>					clear all selections
" <BS>					delete the preceding character in the prompt
" <Del>					delete the current character in the prompt
" <Home>				move the cursor to the begin of the prompt
" <End>					move the cursor to the end of the prompt
" <Left>				move the cursor one character to the left in the prompt
" <Right>				move the cursor one character to the right in the prompt
" <C-P>					preview the result
" <C-C>					quit from LeaderF
" <ESC>					switch to normal mode
let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>']}
let g:Lf_ShortcutF = '<C-P>'

" prevents from a warning about the variable not being set
let g:gitgutter_max_signs=9999
"


" configuration for CSV plugin
"
" automatically highlight current column in CSV
"let g:csv_highlight_column = 'y'

" Do not highlight column when cursor moves:
let g:csv_no_column_highlight = 1
" Treat lines starting with '#' as comments
"let g:csv_comment = '#'

" By default, the csv plugin will analyze the whole file to determine which
" delimiter to use. (You can also use :let g:csv_delim=',')
" The following will only read 100 lines to do so.
let g:csv_start = 1
let g:csv_end = 100

" By default, the delimiter will not be displayed, if Vim supports conceal of
" syntax items and instead draws a vertical line. The following disables that:
let g:csv_no_conceal = 1
" set the 'conceallevel' option to control how the concealed chars will be
" displayed.

hi CSVDelimiter term=bold cterm=NONE ctermfg=darkgrey ctermbg=NONE

"hi CSVColumnEven cterm=NONE ctermfg=NONE ctermbg=darkblue
"hi CSVColumnOdd  cterm=NONE ctermfg=NONE ctermbg=darkmagenta

" :help cterm-colors
