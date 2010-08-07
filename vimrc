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
