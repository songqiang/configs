" .vimrc configure file
" Song Qiang <tsiangsung@gmail.com>
"

" use vim as vim
set nocompatible 

syntax on
filetype on
set tabstop=4 
set shiftwidth=4 
set nowrap 

" indent
set autoindent
set smartindent

" search
set hlsearch 
set incsearch 
set backspace=indent,eol,start whichwrap+=<,>,[,] 

"-------------------------------------------------------------------------------------
" folding
"-------------------------------------------------------------------------------------
set foldenable " turn on folding
set foldmethod=indent " make folding indent sensitive
set foldlevel=100 " don't autofold anything (but I can still fold manually)
set foldopen -=search " don't open folds when you search into them
set foldopen -=undo " don't open folds when you undo stuff

" Vim
" An example for a vimrc file.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc

"let mysyntaxfile = "~/share/vim.syntax/mysyntax.vim"

" for resize gvim
set sessionoptions+=resize,winpos
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  winpos 50 50
  set lines=60
  set columns=90
endif


set incsearch
set wildmode=longest,list
set nostartofline            " Keep the same column number when scrolling

" set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=
" set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~
set isfname=@,48-57,/,.,-,_,+,,,#,$,~

runtime plugin/matchit.vim

set nocompatible        " Use Vim defaults (much better!)
set bs=2                " allow backspacing over everything in insert mode
set ai                  " always set autoindenting on
" set backup            " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set noequalalways
set number              " To display line number on the left

" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=72

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &term=="xterm-r6"
  se term=xterm
endif
if &t_Co > 2 || has("gui_running")
  colorscheme darkblue
  syntax on
  set hlsearch
  hi Search term=reverse cterm=reverse ctermfg=1 ctermbg=7 guifg=#b0ffff guibg=#2050d0 gui=reverse
endif


augroup filetypedetect
  au! BufRead,BufNewFile,BufWritePost *.mac setfiletype sas
  au! BufRead,BufNewFile,BufWritePost *.inc setfiletype sas
  au! BufRead,BufNewFile,BufWritePost *.log setfiletype log
augroup END


augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  " autocmd BufRead *       set formatoptions=tcql nocindent comments&
  " autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
  autocmd BufRead,BufNewFile,BufWritePost *              set formatoptions=2tcqrol nocindent
  autocmd BufRead,BufNewFile,BufWritePost *              com! Make make|cw
  autocmd BufRead,BufNewFile,BufWritePost *.c,*.h,*.java,*.var,*.pl set formatoptions=cqrol cindent
  autocmd BufRead,BufNewFile,BufWritePost *.c            set makeprg=gcc\ -Wall\ -o\ %<\ %
  " autocmd BufNewFile,BufRead,BufWritePost *.c            com! Run !`dirname %`/`basename % .c`
  autocmd BufNewFile,BufRead,BufWritePost *.c            com! Run !%:p:h/%:t:r
  autocmd BufRead,BufNewFile,BufWritePost *.java         set makeprg=javac\ %
  autocmd BufNewFile,BufRead,BufWritePost *.java         com! Run !java -classpath %:p:h %:t:r
  " autocmd BufNewFile,BufRead,BufWritePost *.java         com! Run !java -classpath `dirname %` `basename % .java`
  autocmd BufNewFile,BufRead,BufWritePost *.sas          set makeprg=sas913\ %
  " autocmd BufNewFile,BufRead,BufWritePost *.sas          set shellpipe=" -log "
  " autocmd BufNewFile,BufRead,BufWritePost *.sas          set makeef=%<.log
  " autocmd BufNewFile,BufRead,BufWritePost *.sas          com! Run !sas913 %
  autocmd BufNewFile,BufRead,BufWritePost *.sas          com! Run !sas913 %;egrep '^(ERROR|WARN)' %<.log
  autocmd BufNewFile,BufRead,BufWritePost *.sas          set errorformat=^ERROR:^WARNING
  autocmd BufNewFile,BufRead,BufWritePost *.sas,*.inc,*.mac   let b:match_words='%do\>:%end\>,%macro\>:%mend\>,\<do\>\|\<select\>:\<end\>'
 autocmd BufNewFile,BufRead,BufWritePost *.sas          ab #o options pagesize=max linesize=132 nocenter obs=max compress=binary <CR>          /* missing="." mlogic mprint symbolgen source2 */ ;

augroup END


augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "       read: set binary mode before reading the file
  "             uncompress text in buffer after reading
  "      write: compress file after writing
  "     append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre        *.gz set bin
  autocmd BufReadPost,FileReadPost      *.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost      *.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost      *.gz set nobin
  autocmd BufReadPost,FileReadPost      *.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost      *.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost    *.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost    *.gz !gzip <afile>:r

  autocmd FileAppendPre                 *.gz !gunzip <afile>
  autocmd FileAppendPre                 *.gz !mv <afile>:r <afile>
  autocmd FileAppendPost                *.gz !mv <afile> <afile>:r
  autocmd FileAppendPost                *.gz !gzip <afile>:r
augroup END


" my old .vimrc file from version 4
set mouse=a
set autoindent
set backspace=2
set nobackup
set noendofline
set expandtab
set tabstop=8
set ignorecase
set joinspaces
set laststatus=2
set shiftwidth=2
set showmatch
set showmode
set nosmartindent
"set textwidth=132
set textwidth=72
set tw=0

set ruler


" set comments=sr:/*,mb:*,el:*/,://,b:#,n:%,:XCOMM,n:>,fb:-,nb:C,nb:c,b:!
set comments=sr:/*,mb:*,el:*/,://,b:#,:XCOMM,n:>,fb:-,nb:C,nb:c,b:!
set formatoptions=2qctrlo

" set cinoptions=>2s,e-s,n-s,f0,{s,}0,^-s,:2s,=s,ps,t0,+s,(0,)80,*30
" set cinoptions=>2s,e0,n0,f0,{0,}0,^0,:s,=s,ps,ts,c3,+s,(0,)80,*30,gs,hs
" set cinoptions=>2s,e-s,n-s,f0,{s,}0,^-s,:2s,=s,ps,t0,+s,(0,)20,*30
" set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,ps,ts,c3,+s,(2s,us,)20,*30,gs,hs
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,ps,ts,c3,+s,(0,u0,)70,*70,gs,hs
" set cinwords=IF,ELSE,DO,if,else,while,do,for,switch
" set cinkeys=0{,0},:,!^F,o,O,e
set cinwords=if,else,while,do,for,switch,select,proc,macro,data,IF,ELSE,WHILE,DO,FOR,SWITCH,SELECT,PROC,MACRO,DATA
set cinkeys=0{,0},:,!^F,o,O,e,=~run,=~end

autocmd BufEnter  *          let b:match_words='%do\>:%end\>,%macro\>:%mend\>,\<do\>\|\<select\>:\<end\> *;'

autocmd BufEnter  *.c,*.h,*.java    set cindent noignorecase formatoptions=qctrlo
autocmd BufLeave  *.c,*.h,*.java    set nocindent ignorecase formatoptions=2qctrlo

autocmd BufEnter  *.f,*.F    set formatoptions=qctrlo  smartindent tw=72
autocmd BufLeave  *.f,*.F    set formatoptions=2qctrlo nosmartindent
"autocmd BufLeave  *.f,*.F    set formatoptions=2qctr nosmartindent tw=72

map <silent> <S-S><S-S> :if filereadable(expand("%:r") . ".sas")==1<Bar>:hide edit %<.sas<Bar>:elseif filereadable(expand("%:h") . "/../" . expand("%:t:r") . ".sas")==1<BAR>:hide edit %:h/../%:t:r.sas<BAR>:endif<CR>
map <silent> <S-L><S-L> :if filereadable(expand("%:r") . ".log")==1<Bar>:hide edit %<.log<Bar>:elseif filereadable(expand("%:h") . "/logNlst/" . expand("%:t:r") . ".log")==1<BAR>:hide edit %:h/logNlst/%:t:r.log<BAR>:endif<CR>
map <silent> <S-T><S-T> :if filereadable(expand("%:r") . ".lst")==1<Bar>:hide edit %<.lst<Bar>:elseif filereadable(expand("%:h") . "/logNlst/" . expand("%:t:r") . ".lst")==1<BAR>:hide edit %:h/logNlst/%:t:r.lst<BAR>:endif<CR>
map <silent> bash :if filereadable(expand("%:r") . ".bash")==1<Bar>:hide edit %<.bash<Bar>:elseif filereadable(expand("%:h") . "/../" . expand("%:t:r") . ".bash")==1<BAR>:hide edit %:h/../%:t:r.bash<BAR>:endif<CR>

hi Search term=reverse ctermbg=DarkBlue  ctermfg=Red guibg=Yellow guifg=NONE



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  vimLaTeX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REQUIRED. This makes vim invoke latex-suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if version >= 700
  command! -nargs=* -complete=file Te tabedit <args>
  command! -nargs=* -complete=file TE tabedit <args>
  command! -nargs=0 TN tabnext
endif

