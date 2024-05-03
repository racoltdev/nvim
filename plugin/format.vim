filetype on
syntax on

" Show mode you are on the last line
set showmode

" Show line numbers
set number
set relativenumber

" Tab = 4 spaces
set tabstop=4
set shiftwidth=4

" Disable files from executing code
set nomodeline

" Give more space for displaying messages
set cmdheight=2

set signcolumn=number

" Disable auto comment insertion
autocmd FileType * setlocal formatoptions-=cro

" Never autoselect autocompletion
set completeopt=menuone
