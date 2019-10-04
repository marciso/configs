" vim: set ts=4 sw=4 sts=4 noet :
"
" =====================================
" NOTE: use ":so %" to reload this file
" =====================================
"
" Necesary  for lots of cool vim things (always set for nvim)
set nocompatible

"filetype off  "needed by Vundle?

" General Hints:
" CTRL-R CTRL-W   : pull word under the cursor into a command line or search
" CTRL-R CTRL-A   : pull whole word including punctuation
" CTRL-R /        : pull last searched patter
" CTRL-R -        : pull small register
" CTRL-R [0-9a-z] : pull named registers
" CTRL-R %        : pull file name (also #)
"
"
" Hint Substitution:
"  * Limit substitution to the visually selected text using \%V
"    :s/\%Vpattern/text/gc
"  * Searching in visual mode will extend it, use \%V to avoid it
"    /\%Vpattern
"
" Hint Marks:
"
"`.	jump to position where last change occurred in current buffer
"`"	jump to position where last exited current buffer
"`0	jump to position in last file edited (when exited Vim)
"`1	like `0 but the previous file (also `2 etc)"
"''	jump back (to line in current buffer where jumped from)
"``	jump back (to position in current buffer where jumped from)
"`[ or `]	jump to beginning/end of previously changed or yanked text
"`< or `>	jump to beginning/end of last visual selection


" Vundle Plugins:
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'vim-scripts/a.vim'

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Tmux integration
Plugin 'christoomey/vim-tmux-navigator'

" Vimux - vim+tmux split window
"Plugin 'benmills/vimus'
"
" drop into tmux from inside the vim
Plugin 'benmills/vimux'

Plugin 'mhinz/vim-grepper'

" provides Subvert command, e.g.:
"	%Subvert/facilit{y,ies}/building{,s}/g
Plugin 'tpope/vim-abolish'

" Optional: used for repeating operator actions via "."
Plugin 'tpope/vim-repeat'
" syntax highlight for git diff
Plugin 'tpope/vim-git'
" integration with git:
Plugin 'tpope/vim-fugitive'
" Shows git diff in the gatter
"Plugin 'airblade/vim-gitgutter'

" gtiv - extension to vim-fugitive
Plugin 'gregsexton/gitv'

" async compilations
Plugin 'tpope/vim-dispatch'

" surroungings: https://vim.sourceforge.io/scripts/script.php?script_id=1697
Plugin 'tpope/vim-surround'

" git browser (like tig) in vim
Plugin 'int3/vim-extradite'

" rtags - llvm tags
" need to start rdm and load compilation db (rc -c / rc -J)
" Plugin 'lyuts/vim-rtags'


" gtags, global tags
"Plugin 'jsfaint/gen_tags.vim'

" displaying thin vertical lines at each indentation level for code indented
" with spaces
Plugin 'Yggdroot/indentLine'

" allows you to configure % to match more than just single characters
Plugin 'tmhedberg/matchit'

Plugin 'fholgado/minibufexpl.vim'
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
"Plugin 'scrooloose/nerdcommenter' NOTE: use tcomment for easier commenting

"  TComment: http://www.vim.org/scripts/script.php?script_id=1173
Plugin 'tomtom/tcomment_vim'

" Check syntax of different files
"Plugin 'scrooloose/syntastic'

" Asynchronous Lint Engine
" Better option to syntastic ?
Plugin 'w0rp/ale'

" The Most Recently Used (MRU) plugin provides an easy access to a list of
" recently opened/edited files in Vim
" use command: :MRU
Plugin 'yegappan/mru'

" Press CTRL-P to start LeaderF - file mode
" <leader>b - buffer mode
"  In window: <C-F> for full name, and <C-R> regex
"  <C-C> : quit from LeaderF.
"  <C-R> : switch between fuzzy search mode and regex mode.
"  <C-F> : switch between full path search mode and name only search mode.
"  <ESC> : switch to normal mode.
"  <C-V> : paste from clipboard.
"  <C-U> : clear the prompt.
"  <C-J>, <Down>, <C-K>, <Up> : navigate the result list.
"  <2-LeftMouse> or <CR> : open the file under cursor or selected (when multiple files are selected).
"  <C-X> : open in horizontal split window.
"  <C-]> : open in vertical split window.
"  <C-T> : open in new tabpage.
"  <F5> : refresh the cache.
"  <C-LeftMouse> or <C-Z> : select multiple files.
Plugin 'Yggdroot/LeaderF'

"Plugin 'L9'
"Plugin 'FuzzyFinder' " not that great...
"Plugin 'SkidanovAlex/CtrlK'

" <leader>t - start command-t
" try: :CommandT*
Plugin 'wincent/command-t'
" Note, if you encounter the following error:
"   command-t.vim could not load the C extension
"   Please see INSTALLATION and TROUBLE-SHOOTING in the help              
"   For more information type:    :help command-t
" Go to the pluing directory (e.g. ~/.vim/bundle/command-t) and re-compile:
"   rake make

" more colorschemes
Plugin 'rafi/awesome-vim-colorschemes'

" place, toggle and display marks.
Plugin 'kshenoy/vim-signature'

" relative/hybrid numbers
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

" Different kind of navigation/search
Plugin 'easymotion/vim-easymotion'

" improvement over incsearch
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'

" try :help unimpaired-customization
Plugin 'tpope/vim-unimpaired'

" Preview registers when you hit " or @, or CTRL-R
Plugin 'junegunn/vim-peekaboo'

"Plugin 'neovim/python-client'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'Shougo/deoplete.nvim'

" Aligning plugin
"    Try EasyAlign*=
Plugin 'junegunn/vim-easy-align'

" Fancy status line
Plugin 'vim-airline/vim-airline'


" Mark--Karkat
" Highlight several words in different colors simultaneously.
"
" HIGHLIGHTING
" <Leader>m		Mark the word under the cursor, similar to the star
" 			command. The next free highlight group is used. 
" 			If already on a mark: Clear the mark, like
" 			<Leader>n. 
" {Visual}<Leader>m	Mark or unmark the visual selection. 
"
" <Leader>r		Manually input a regular expression to mark. 
" {Visual}<Leader>r	Ditto, based on the visual selection. 
"
" <Leader>n		Clear the mark under the cursor.
" 			If not on a mark: Disable all marks, similar to
" 			:nohlsearch. 
"
" :Mark {pattern}		Mark or unmark {pattern}. 
" :Mark			Disable all marks, similar to :nohlsearch. Marks
" 			will automatically re-enable when a mark is added or
" 			removed, or a search for marks is performed. 
" :MarkClear		Clear all marks. In contrast to disabling marks, the
" 			actual mark information is cleared, the next mark will
" 			use the first highlight group. This cannot be undone. 
"
" SEARCHING
" [count]*         [count]#
" [count]<Leader>* [count]<Leader>#
" [count]<Leader>/ [count]<Leader>?
" 			Use these six keys to jump to the [count]'th next /
" 			previous occurrence of a mark. 
" 			You could also use Vim's / and ? to search, since the
" 			mark patterns are (optionally, see configuration)
" 			added to the search history, too. 
"
"             Cursor over mark                    Cursor not over mark
"  ---------------------------------------------------------------------------
"   <Leader>* Jump to the next occurrence of      Jump to the next occurrence of
"             current mark, and remember it       "last mark". 
"             as "last mark". 
"
"   <Leader>/ Jump to the next occurrence of      Same as left. 
"             ANY mark. 
"
"    *        If <Leader>* is the most recently   Do Vim's original * command. 
"             used, do a <Leader>*; otherwise
"             (<Leader>/ is the most recently
"             used), do a <Leader>/. 
"
" MARK PERSISTENCE
" The marks can be kept and restored across Vim sessions, using the viminfo
" file. For this to work, the "!" flag must be part of the 'viminfo' setting: 
"     set viminfo+=!  " Save and restore global variables. 
" :MarkLoad		Restore the marks from the previous Vim session. All
" 			current marks are discarded. 
" :MarkSave		Save the currently defined marks (or clear the
" 			persisted marks if no marks are currently defined) for
" 			use in a future Vim session. 
Plugin 'vim-scripts/Mark--Karkat'


" Enhanced diff
" (note: some algos use git, so make sure git >= 1.8.2 is installed)
"
" :PatienceDiff - Use the Patience Diff algorithm for the next diff mode
" :EnhancedDiff <algorithm> - Use <algorithm> to generate the diff. Use any of
"
"	- myers			Default Diff algorithm used
"	- default		Alias for myers algorithm
"	- histogram		Fast version of patience algorithm
"	- minimal		Default diff algorithm, trying harder to minimize the diff
"	- patience		Patience diff algorithm.
"
" :EnhancedDiffDisable - Disable plugin (and use default Vim diff capabilities).
"
" :EnhancedDiffIgnorePat pat
"   -- you can define patterns, that will be ignored before feeding the buffer
"   contents to the diff program. Internally this will be handled by
"   substituting those matches with 'XX' so that the content will look like
"   the same for the diff binary.
Plugin 'chrisbra/vim-diff-enhanced'


" Sublime Text's awesome multiple selection feature
"
" *Quick Start*
" - normal mode / visual mode
"	  start: <C-n> start multicursor and add a virtual cursor + selection on the match
"	  next: <C-n> add a new virtual cursor + selection on the next match
"	  skip: <C-x> skip the next match
"	  prev: <C-p> remove current virtual cursor + selection and go back on previous match
"	  select all: <A-n> start muticursor and directly select all matches
"	  You can now change the virtual cursors + selection with visual mode commands.
"	  For instance: c, s, I, A work without any issues.
"	  You could also go to normal mode by pressing v and use normal commands there.
"	 
"	  At any time, you can press <Esc> to exit back to regular Vim.
"	 
"	  NOTE: start with g<C-n> to match without boundaries (behaves like g* instead of *)
"
" - visual mode when multiple lines are selected
"	  start: <C-n> add virtual cursors on each line
"	  You can now change the virtual cursors with normal mode commands.
"	  For instance: ciw.
"
" - command
"	  The command MultipleCursorsFind accepts a range and a pattern (regexp), it creates a visual cursor at the end of each match.
"	  If no range is passed in, then it defaults to the entire buffer.
"
" *Mapping*
"	If you don't like the plugin taking over your key bindings, you can turn it off and reassign them the way you want:
"
"	let g:multi_cursor_use_default_mapping=0
"
" " Default mapping
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-x>'
" let g:multi_cursor_quit_key            = '<Esc>'
" NOTE: Please make sure to always map something to g:multi_cursor_quit_key, otherwise you'll have a tough time quitting from multicursor mode.
Plugin 'terryma/vim-multiple-cursors'


" Rainbow CSV: CSV query language
"  * Highlight csv columns in different rainbow colors.
"  * Provide SELECT and UPDATE queries in RBQL: SQL-like transprogramming query " language.
Plugin 'mechatroner/rainbow_csv'

" Alternative CSV plugin
Plugin 'chrisbra/csv.vim'

" Paul's
"Plugin 'chrisbra/csv.vim'
"Plugin 'gmarik/Vundle.vim'
"Plugin 'tpope/vim-fugitive'
"Plugin 'jszakmeister/vim-togglecursor'
"Plugin 'bling/vim-airline'
"Plugin 'ntpeters/vim-better-whitespace'
"Plugin 'Valloric/vim-operator-highlight'
"Plugin 'jlanzarotta/bufexplorer'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'christoomey/vim-tmux-navigator'
Plugin 'guns/xterm-color-table.vim'
Plugin 'rhysd/vim-clang-format'
"Plugin 'junegunn/limelight.vim'
"Plugin 'dietsche/vim-lastplace'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Raimondi/delimitMate'
"Plugin 'scrooloose/syntastic'
"Plugin 'edkolev/tmuxline.vim'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'scrooloose/nerdtree'
"Plugin 'majutsushi/tagbar'
"Plugin 'Shougo/vimshell.vim'
"Plugin 'jalcine/cmake.vim'
"Plugin 'tpope/vim-obsession'
"Plugin 'thinca/vim-quickrun'
"Plugin 'Soares/longline.vim'
"Plugin 'honza/vim-snippets'
"Plugin 'tpope/vim-markdown'
"Plugin 'tpope/vim-sensible'
"Plugin 'mbbill/undotree'
"Plugin 'tpope/vim-abolish'
"Plugin 'gilligan/vim-lldb'
"Plugin 'ogier/guessindent'
"Plugin 'SirVer/ultisnips'
"Plugin 'vim-jp/cpp-vim'
"Plugin 'kien/ctrlp.vim'
"Plugin 'bruno-/vim-man.git'
"Plugin 'godlygeek/tabular'
Plugin 'szw/vim-ctrlspace'
"Plugin 'vim-scripts/IndentConsistencyCop'
"Plugin 'ciaranm/detectindent'
Plugin 'jreybert/vimagit'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'rking/ag.vim'
"Plugin 'Chun-Yang/vim-action-ag'
"Plugin 'ntpeters/vim-better-whitespace'

"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags' " causes delays on saving a file

Plugin 'ludovicchabant/vim-gutentags'
Plugin 'skywind3000/gutentags_plus'

" All of your Plugins must be added before the following line
call vundle#end()            " required





set diffopt+=internal
"set diffopt+=algorithm:patience
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


set nu
set rnu " relative numbers
set numberwidth=3 " size of gutter

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
"set t_Co=256

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

if &diff
  colorscheme pablo
  " other good cs for vimdiff: murphy pablo slate

  " diff mode : ignore spaces
  "set diffopt+=iwhite
endif
"if &diff
"  colorscheme pablo
"  " other good cs for vimdiff: murphy pablo slate
"
"	"hi DiffAdd term=bold ctermbg=4
"	hi DiffAdd term=bold ctermbg=30
"	"hi DiffDelete term=bold ctermfg=12 ctermbg=6
"	hi DiffDelete term=bold ctermfg=43 ctermbg=6
"	"hi DiffChange term=bold ctermbg=5
"	hi DiffChange term=bold ctermbg=128
"	"hi DiffText term=reverse cterm=NONE ctermfg=Gray ctermbg=red
"	hi DiffText term=reverse cterm=NONE ctermfg=Gray ctermbg=161
"
"  " diff mode : ignore spaces
"  "set diffopt+=iwhite
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

" A buffer becomes hidden (not closed) when it is abandoned
set hidden

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

" Do not write backup or swap files... useless feature nowadays?
set nobackup
set noswapfile

" become root to write the file!
cmap w!! w !sudo tee % >/dev/null

" for more unicode symbols go to: http://www.utf8-chartable.de/unicode-utf8-table.pl
"let g:indentLine_char = '┊'
"let g:indentLine_setColors = 0
"set showbreak=
"set listchars=tab:→\ ,eol:↲,nbsp:,␣trail:•,extends:›,precedes:‹
"let g:indentLine_char = '¦'
"let g:indentLine_char = '˽'
"let g:indentLine_char = '·'
"let g:indentLine_char = '⁞'
let g:indentLine_char = '˸'
"set listchars=tab:»\ ,trail:·,extends:\#,nbsp:.
"set listchars=tab:▶\ ,trail:·,extends:\#,nbsp:.
"set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:›,precedes:‹
"set listchars=tab:»∶,eol:‸,trail:•,extends:›,precedes:‹
"set listchars=tab:»∶,eol:˫,trail:•,extends:›,precedes:‹
"set listchars=tab:»∶,eol:˭,trail:•,extends:›,precedes:‹
"set listchars=tab:»∶,eol:·,trail:•,extends:›,precedes:‹
"ˍˈ↙⌟⌏⌇⌘┊␣◃▿ˣ▫▖▂◻♮♯♭♬♫♪♩♢♔♕☼♁☸☐☇☆◿◰⟧⟦⨁⨂⨀
" ‐ ․•‡†‥…‧⁚⁝⁞₋₌₊⁼⁻⁺
" ∙∕∖∎∴∵∶∷⋅⋮⋯⋰⋱
" ␀␤␣
"		example  asd   
"         asdf
"   asdfa
"set listchars=tab:»∶,eol:⌟,trail:ˍ,extends:›,precedes:‹
"
" set listchars=tab:»·,eol:·,trail:·,extends:›,precedes:‹
" set listchars=tab:»∶,eol:·,trail:•,extends:›,precedes:‹
" ₌₋₊⁼⁻⁺⁞‹›‧․‥•‡†‐‑Ⅹ↲↵∙⊢⋮⋯␣⣿⠿﹒
set listchars=tab:»⋅,eol:₋,trail:·,extends:›,precedes:‹

hi NonText ctermfg=22 guifg=#4a4a59
hi SpecialKey ctermfg=22 guifg=#4a4a59

set list
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


set autoindent "Auto indent
"set copyindent "Copy previous indentation in insert mode
set smartindent "Smart indent
"set wrap "Wrap lines
"
" Use tabs only for indentation, formating should use spaces
set cindent
set cinoptions=N-s,g-1
" N-s: do not indent namespaces
" g-1: protecte/private/public at the same level as class/struct



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

	"cscope add $MS_SRC_BASE/cscope.out  $MS_SRC_BASE/
	"cscope add $MS_SRC_BASE/src/cscope.out  $MS_SRC_BASE/src
    cscope add ~/code/cscope.out  ~/code/src

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

    "map <F8> :set csto=0<CR>
endif

set csprg=$HOME/gentoo/usr/bin/gtags-cscope

"map <F7> :set csto=1<CR>

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
set tags+=$HOME/code/tags

set path^=.
set path^=$HOME/code/**5

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
"let g:alternateExtensions_cxx = "h,hh,hpp"

"let g:alternateSearchPath = 'sfr:../src,sfr:../../src'
let g:alternateSearchPath = 'sfr:.'

" toggle highlight search
map  <F4> :set hls!<CR>
imap <F4> <ESC>:set hls!<CR>a
vmap <F4> <ESC>:set hls!<CR>gv

" leave F5 for Leaderf refresh cache
"
" toggle disable/enable list; OPEN: why did we set let g:indentLine_enabled = 0/1
map <F6> :set list!<CR>
imap <F6> <ESC>:set list!<CR>
vmap <F6> <ESC>:set list!<CR>

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

"let &t_Cs = "\e[4:3m"
"let &t_Ce = "\e[4:0m"

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

" c - current working directory, CWD
" a - the nearest ancestor of CWD that contains g:Lf_RootMarkers (e.g. .git)
let g:Lf_WorkingDirectoryMode = 'ac'

let g:Lf_StlSeparator = { 'left': '►', 'right': '◄', 'font': '' }
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewCode = 1
let g:Lf_UseVersionControlTool = 1

" let g:Lf_PreviewResult = {
" 			\ 'File': 0,
" 			\ 'Buffer': 0,
" 			\ 'Mru': 0,
" 			\ 'Tag': 0,
" 			\ 'BufTag': 1,
" 			\ 'Function': 1,
" 			\ 'Line': 0,
" 			\ 'Colorscheme': 0
" 			\}

"highlight Lf_hl_match gui=bold guifg=Blue cterm=bold ctermfg=21
"highlight Lf_hl_matchRefine  gui=bold guifg=Magenta cterm=bold ctermfg=201

" prevents from a warning about the variable not being set
let g:gitgutter_max_signs=9999
"

" configuration for CSV plugin
"
" automatically highlight current column in CSV
" NOTE: this does not work very well if the file type changes
" let g:csv_highlight_column = 'y'

" Do not highlight column when cursor moves:
"let g:csv_no_column_highlight = 1
" Treat lines starting with '#' as comments
let g:csv_comment = '#'

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
"
" Note, arranging the columns can be very slow on large files or many columns
"let b:csv_arrange_use_all_rows = 1

" auto arrange but only for small (1MB) files
let g:csv_autocmd_arrange	   = 1
let g:csv_autocmd_arrange_size = 1024*1024

" disables :CSVTabularize or :CSVTable
let g:csv_disable_table_command = 1

hi CSVDelimiter term=bold cterm=NONE ctermfg=darkgrey ctermbg=NONE

" disable Rainbow by default
let g:disable_rainbow_csv_autodetect = 1

"hi CSVColumnEven cterm=NONE ctermfg=NONE ctermbg=darkblue
"hi CSVColumnOdd  cterm=NONE ctermfg=NONE ctermbg=darkmagenta

" :help cterm-colors

" Configure Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" EasyMotion
" Use uppercase target labels and type as a lower case
"let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L` - works similar to the global option smartcase
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
"let g:EasyMotion_use_smartsign_us = 1

" remap search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
" incsearch.vim x fuzzy x vim-easymotion

" Move to line
" letter L followed by leader
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Configure Peekaboo (registry viewer)
"  (Preview registers when you hit " or @, or CTRL-R)
let g:peekaboo_window = "vert bo 30new"

let g:deoplete#enable_at_startup = 1

" Linting With ALE:
" set error in the status line (uses vim-airline)
let g:airline#extensions#ale#enabled = 1

" jump between the ALE errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_echo_msg_format = '%linter%: %s'

let g:ale_c_build_dir="$MS_SRC_BASE"

" disable ALE by default (too slow). Can be enabled with :ALEToggle
let g:ale_enabled=0


" quickly commenting a block: use TComment, e.g. Ctrl-//
" do not define Leader related mappings
"let g:tcommentMapLeader2=''
let g:tcomment_mapleader2=''

"

" Some support for tab pages
" Tab Page Hints:
" gt - go to next tab
" gT - to to previous tab


let g:multi_cursor_use_default_mapping=0

" Mapping for vim-multiple-cursors
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-\>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-j>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-m>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Default highlighting (see help :highlight and help :highlight-link)
highlight link multiple_cursors_visual ReplaceMode
highlight link multiple_cursors_cursor InsertMode
" IsertMode     cterm=reverse ctermfg=37 ctermbg=230 gui=reverse guifg=#2aa198 guibg=#fdf6e3
" ReplaceMode    cterm=reverse ctermfg=166 ctermbg=230 gui=reverse guifg=#cb4b16 guibg=#fdf6e3
" VisualMode     cterm=reverse ctermfg=162 ctermbg=230 gui=reverse guifg=#d33682 guibg=#fdf6e33 guibg=#202020n

" YouCompleteMe Setup {{{
"set completeopt-=preview
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1   "add keywords to completion database
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_semantic_triggers = {'haskell' : ['.']}
nnoremap <leader>h :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>e :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>d :YcmCompleter GoToDefinition<CR>
hi YcmErrorSection term=reverse cterm=reverse gui=reverse
" }}}

" ClangFormat Setup {{{
let g:clang_format#code_style = "Google"

"Not supported in current clang-format version
"\ "AllowShortLoopsOnASingleLine": "false",
"\ "AllowShortBlocksOnASingleLine" : "false",
"\ "AllowShortFunctionsOnASingleLine": "None",
"\ "AllowShortIfStatementsOnASingleLine": "false",
let g:clang_format#style_options = {
            \ "AccessModifierOffset": -4,
            \ "AlwaysBreakTemplateDeclarations": "true",
            \ "DerivePointerBinding": "false",
            \ "PointerBindsToType": "false",
            \ "BinPackParameters" : "false",
            \ "ColumnLimit": 120,
            \ "TabWidth": 4,
            \ "IndentCaseLabels": "false",
            \ "BreakBeforeBraces": "Allman",
            \ "Standard": "C++11" }
au FileType c,cpp,objc,objcpp noremap  <silent> <buffer> <leader>f :ClangFormat<cr>
au FileType c,cpp,objc,objcpp noremap! <silent> <buffer> <leader>f <c-o>:ClangFormat<cr>
" }}}

