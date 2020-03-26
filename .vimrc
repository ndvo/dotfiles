" Set leaders
" Vamos ver o que da
let mapleader = " "
let maplocaleader = "\\"

" Preserve undo history 
set undofile

packloadall           " Load all plugins.
silent! helptags ALL  " Load help files for all plugins.
    
if &t_Co > 2 || has("gui_running")
  syntax on
endif

set mouse=a
set nocompatible

filetype plugin indent on

" NativoBr mapping to normal mode
:inoremap <leader><leader> <esc>

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

augroup customJS
	autocmd!

	autocmd FileType javascript,js onoremap if :<c-u>normal! ?function<cr>f{vi{
	autocmd FileType javascript,js onoremap af :<c-u>normal! ?function<cr>f{va{
augroup END

augroup customGeneralSettings
	autocmd!

	" General settings
	autocmd FileType * nnoremap <leader>ve :vsplit $MYVIMRC<cr>
	autocmd FileType * nnoremap <leader>vs :source $MYVIMRC<cr>

	" Easy Tabs
	autocmd FileType * nnoremap <Right> gt
	autocmd FileType * nnoremap <Left> gT

	" Easy Buffers
	autocmd FileType * set hidden
	autocmd FileType * nnoremap <PageUp> :bprevious<CR>
	autocmd FileType * nnoremap <PageDown> :bnext<CR>

	" Surround
	autocmd FileType * vnoremap <leader>s" <esc>`<i"<esc>`>la"
	autocmd FileType * vnoremap <leader>s' <esc>`<i'<esc>`>la'
	" Replace surround
	autocmd FileType * vnoremap <leader>r" <esc>`<r"<esc>`>hr"
	autocmd FileType * vnoremap <leader>r' <esc>`<hr'<esc>`>lr'

augroup END

augroup customStartup
	autocmd!
	

	" Python files
	autocmd FileType python,java set tabstop=4|set shiftwidth=4|set noexpandtab
	au BufEnter *.py,*java set ai sw=4 ts=4  et 

	" PHP files
	autocmd FileType php,html,js,ts,shell,dot,awkr set tabstop=2|set shiftwidth=2|set noexpandtab
	au BufEnter *.php,*.html,*.js,*.ts,*.sh,*.dot,*.awk set ai sw=2 ts=2 et

	" Graphviz dot files
	autocmd FileType dot nnoremap <buffer> <leader>cl osubgraph cluster_NOME{<CR>}<ESC>^kfN

	" Go files
	autocmd FileType go set tabstop=2|set shiftwidth=2|set noexpandtab
	au BufEnter *.go set ai sw=2 ts=2 et
	autocmd FileType dot map <buffer> <leader>cl osubgraph cluster_NOME{<CR>}<ESC>^k

	" Javascript
	autocmd FileType javascript  nnoremap <leader>dg yiWoconsole.debug()<esc>P

	" Importing libraries
	autocmd FileType go nnoremap <buffer> <leader>imp Oimport (<CR>)<ESC>hi""<ESC>h
	autocmd FileType ts nnoremap <buffer> <leader>imp  Oimport {  } from '';<ESC>F{lli


	" Creating functions
	autocmd FileType go nnoremap <buffer> <leader>f ofunc (r *Receiver) name (p Parameter) (r Return){<CR>}<ESC>k^f(l
	autocmd FileType python nnoremap <buffer> <leader>f odef name(parameter):<CR>pass<ESC>k^fn
	autocmd FileType javascript,js nnoremap <buffer> <leader>f ofunction name(parameter){<CR>}<ESC>kf l
	autocmd FileType php nnoremap <buffer> <leader>f ofunction <C-R>=expand("%:t:r")<CR>_Name($parameter){<CR>}<ESC>k$F_l
	" Abbreviations
	autocmd FileType go,php,python,java,js,typescript,javascript nnoremap <buffer> <leader>r oreturn 

	" Creating if empty
	autocmd FileType php nnoremap <buffer> <leader>ifem iif (empty()){<CR>}<ESC>k^f(f(a
	autocmd FileType php nnoremap <buffer> <leader>toem ^f=wyt;iempty(<ESC>pa) ? "" : <ESC>
augroup END


augroup customMarkup
	" HTML Files
	"
	" Break up a tag
	autocmd FileType html let @b='cit'

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
augroup END

augroup customNerdTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	autocmd FileType * nnoremap <C-n> :NERDTreeToggle<cr>
augroup END
