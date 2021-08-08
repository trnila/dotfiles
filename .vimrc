syntax on
filetype off 
filetype plugin indent on
set autoindent
set cindent
set history=7000
set wildignore=*.o,*~,*.pyc
set showmatch
set nobackup
set nowb
set noswapfile
set wildmode=longest,list
set clipboard=unnamedplus
set smarttab
"set completeopt-=preview
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set encoding=utf-8
set nocompatible 
"set mouse=a
packadd termdebug

let mapleader = '\'
let g:ale_fix_on_save = 1
let python_highlight_all = 1


" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }


if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap L :Ag<SPACE>

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
let c_space_errors = 1
let c_curly_error = 1

set undofile                                                " turn on persistent-undo
set undodir=~/.vim/undo//
