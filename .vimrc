let mapleader = " "
let maplocaleader = "\\"


set undofile

packloadall           " Load all plugins.
silent! helptags ALL  " Load help files for all plugins.
    
if &t_Co > 2 || has("gui_running")
  syntax on
endif
set mouse=a
set nocompatible
filetype plugin indent on

" automatically leave insert mode after 'updatetime' milliseconds of inaction
" au CursorHoldI * stopinsert

" set 'updatetime' to 15 seconds when in insert mode
"au InsertEnter * let updaterestore=&updatetime | set updatetime=2000
"au InsertLeave * let &updatetime=updaterestore

" Line numbers
set number
set relativenumber

set autoindent
set smartindent
set showcmd

" Show lines above and bellow current line
set scrolloff=15
set background=dark
set backspace=eol,start,indent
packadd! matchit
colorscheme solarized

" General settings
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" Easy Tabs
nnoremap <Right> gt
nnoremap <Left> gT

" Easy Buffers
set hidden
nnoremap <PageUp> :bprevious<CR>
nnoremap <PageDown> :bnext<CR>

" Surround
vnoremap <leader>s" <esc>`<i"<esc>`>la"
vnoremap <leader>s' <esc>`<i'<esc>`>la'
" Replace surround
vnoremap <leader>r" <esc>`<r"<esc>`>hr"
vnoremap <leader>r' <esc>`<hr'<esc>`>lr'


" Python files
autocmd FileType python set tabstop=4|set shiftwidth=4|set noexpandtab
au BufEnter *.py set ai sw=4 ts=4  et 

" PHP files
autocmd FileType  php,html,js,ts,shell,dot,awkr set tabstop=2|set shiftwidth=2|set noexpandtab
au BufEnter *.php,*.html,*.js,*.ts,*.sh,*.dot,*.awk set ai sw=2 ts=2 et

" Graphviz dot files
autocmd FileType dot map <buffer> <leader>cl osubgraph cluster_NOME{<CR>}<ESC>^kfN

" Go files
autocmd FileType go set tabstop=2|set shiftwidth=2|set noexpandtab
au BufEnter *.go set ai sw=2 ts=2 et
autocmd FileType dot map <buffer> <leader>cl osubgraph cluster_NOME{<CR>}<ESC>^k


" HTML Files
"
" Break up a tag
autocmd FileType html let @b='cit'



" Importing libraries
autocmd FileType go map <buffer> <leader>imp Oimport (<CR>)<ESC>hi""<ESC>h
autocmd FileType ts map <buffer> <leader>imp  Oimport {  } from '';<ESC>F{lli


" Creating functions
autocmd FileType go map <buffer> <leader>f ofunc (r *Receiver) name (p Parameter) (r Return){<CR>}<ESC>k^f(l
autocmd FileType python map <buffer> <leader>f odef name(parameter):<CR>pass<ESC>k^fn
autocmd FileType javascript,js map <buffer> <leader>f ofunction name(parameter){<CR>}<ESC>kf l
autocmd FileType php map <buffer> <leader>f ofunction <C-R>=expand("%:t:r")<CR>_Name($parameter){<CR>}<ESC>k$F_l

" Creating if empty
autocmd FileType php noremap <buffer> <leader>ifem iif (empty()){<CR>}<ESC>k^f(f(a
autocmd FileType php noremap <buffer> <leader>toem ^f=wyt;iempty(<ESC>pa) ? "" : <ESC>

" Creating lists
" 	unordered
autocmd FileType tex,latex map <buffer> <leader>lu o\begin{itemize}<CR>\item<CR>\end{itemize}<ESC>k
autocmd FileType html map <buffer> <leader>lu o<ul><CR><li></li><CR></ul><ESC>k
" 	ordered
autocmd FileType tex,latex map <buffer> <leader>lo o\begin{enumerate}<CR>\item<CR>\end{enumerate}<ESC>k
autocmd FileType html map <buffer> <leader>lo o<ol><CR><li></li><CR></ol><ESC>k

" Surrounding with tags
autocmd FileType html map <buffer> <leader>stp I<p><ESC>A</p><ESC>
autocmd FileType html map <buffer> <leader>stdt I<dt><ESC>A</dt><ESC>
autocmd FileType html map <buffer> <leader>stdd I<dd><ESC>A</dd><ESC>
autocmd FileType html map <buffer> <leader>stdiv I<div><ESC>A</div><ESC>
autocmd FileType html map <buffer> <leader>start I<article><ESC>A</article><ESC>
autocmd FileType html map <buffer> <leader>stsec I<section><ESC>A</section><ESC>
autocmd FileType html map <buffer> <leader>stli I<li><ESC>A</li><ESC>

