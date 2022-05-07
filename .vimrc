""" -- Principios ---
""" Consistência
""" - manter e expandir a composibilidade
""" Usar o leader
""" - maior portabilidade entre sistemas
""" - maior portabilidade entre teclados
""" - mantém os dedos nas letras
""" - fácil manutenção
""" Usar mais de uma letra para cada comando
""" - evita colisões entre comandos
""" - facilita a memorização e recuperação
""" Usar comandos expansiveis (como :w ao invés de :w<cr>)
""" - aumenta as oportunidades de uso
""" - facilita a memorização e recuperação

""" leader w - comandos relacionados à janela ou Ctrl-W
""" leader o - comandos relacionados a abrir alguma coisa

set exrc " lê .vimrc local ao diretório
set hidden " mantém buffers abertos ao fechar
set visualbell " sinal visual ao invés de sonoro
set list " mostra caracteres invisíveis

" Teclas líder
let mapleader = " "
let maplocaleader = "\\"
packloadall           " Carrega os plugins disponíveis.

" Navegação entre buffers
nnoremap <leader>w <c-w>

" Saltos
nnoremap <leader>jbp <c-^>
" Mantém a centralização
nnoremap n nzzzv
nnoremap N Nzzzv

" Toggles
nnoremap <leader>thl :set hlsearch!<cr>
nnoremap <leader>ted :set ma!<cr>
nnoremap <leader>tna :set number!<cr>
nnoremap <leader>tnr :set relativenumber!<cr>

" Tagbar
nnoremap <right> :TagbarToggle<cr>

" Netrw {{{ ----
let g:netrw_preview = 1
let g:netrw_liststyle = 3
autocmd FileType netrw nnoremap <buffer> <silent> zc <Plug>NetrwTreeSqueeze

" let g:netrw_list_hide= netrw_gitignore#Hide().'.*\.swp$'
let g:netrw_winsize = -40
nnoremap <left> :Lex<cr>
nnoremap <down> :UndotreeToggle<cr>

" open files from netrw in a previous window, unless we're opening the current dir
if argv(0) ==# '.'
    let g:netrw_browse_split = 0
else
    let g:netrw_browse_split = 4
endif
" }}}

" Git {{{ ----
nnoremap <leader>gs :vert Git<cr>
nnoremap <leader>gl :vert Git log --oneline<cr>
nnoremap <leader>gL :vert Git log --graph<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>g/ :Git branch<cr>
nnoremap <leader>gd :vert Gdiff 
nnoremap <leader>gp :Git pull<cr>
nnoremap <leader>gP :Git push
nnoremap <leader>gc- :Git checkout -<cr>
nnoremap <leader>gcd :Git checkout develop<cr>
nnoremap <leader>gcm :Git checkout master<cr>
nnoremap <leader>gcs :Git checkout staging<cr>
nnoremap <leader>grhom :Git reset --hard origin/master
nnoremap <leader>grhod :Git reset --hard origin/develop
nnoremap <leader>grhos :Git reset --hard origin/staging
nnoremap <leader>grhs :Git reset --hard staging
" ---- }}}

" Básicos {{{--------
" Easier Omnicomplete Ctrl x
inoremap <C-Space> <C-x>

inoremap <S-Space> <Esc>

" ALE
nnoremap <leader>a :ALE
nnoremap <F3> :ALE
nnoremap <leader>adef :ALEGoToDefinition<CR>
nnoremap <leader>aref :ALEFindReferences<CR>
nnoremap <leader>adet :ALEDetail<CR>
nnoremap <leader>adoc :ALEDocumentation<CR>
nnoremap <leader>ay :ALEInfoToClipboard<CR>
nnoremap <leader>as :ALERename<CR>
nnoremap <leader>ai :ALEImport<CR>
nnoremap <leader>ao :ALEOrganizeImports<CR>
nnoremap <leader><leader> :ALEHover<CR>
nnoremap <leader>asug :ALEFixSuggest<CR>
nnoremap <leader>afix :ALEFix<CR>

" Salvar
nnoremap <F2> :w
inoremap <F2> <ESC>:w
nnoremap <F4> :wa
inoremap <F4> <ESC>:wa

" Substitui seleção pelo conteúdo do registro
vnoremap <leader>p "_dP

" Consistência
nnoremap Y y$

" }}}

" ALE ------------ {{{
" Completion
let g:ale_hover_to_preview = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_lint_on_text_changed = 'never'
set omnifunc=ale#completion#OmniFunc
"set omnifunc=syntaxcomplete#Complete
" Run linting only on fie save and file enter
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0

let g:ale_linters = {
      \  'html': ['eslint', 'tsserver'],
      \  'typescript': ['eslint', 'tsserver'],
      \  'javascript': [ 'eslint', 'standard', 'tsserver' ] ,
      \  'python' : [ 'autoimport', 'black', 'flakehell', 'mypy', 'prospector', 'pylama', 'pylsp', 'pyre', 'pyright', 'yapf'],
      \}
let g:ale_fixers = {
      \  'typescript': ['eslint', 'tslint', 'typecheck', 'prettier', 'remove_trailing_lines', 'trim_whitespace'],
      \  'javascript': [ 'eslint', 'standard', 'prettier' ], 
      \  'python': ['black', 'reorder_python_imports', 'yapf'],
      \  'c': ['gcc'],
      \  'c++': ['g++']
      \}
let g:ale_linter_aliases = {
      \ 'jsx': ['css', 'javascript'],
      \ 'mdx': ['css', 'javascript'],
      \}
 "}}}

" Usar cedilha mesmo que o sistema operacional não queira
inoremap ć ç
nnoremap ç :
nnoremap Ç :

set nowrap
set colorcolumn=80
set cursorline
set formatoptions-=t

set wildmode=longest,list   "Complete longest string, then list alternatives
set wildmenu

" Desfazer persistente
set undofile
set undodir=$HOME/.vim/undo/

silent! helptags ALL  " Carregar arquivos de ajuda de todos os pluging

if &t_Co > 2 || has("gui_running")
  syntax on
endif

set mouse=a " Permite usar o mouse
set nocompatible

filetype plugin indent on

" Mostrar o comando que está sendo usado
set showcmd

" Show lines above and bellow current line
set scrolloff=6
set backspace=eol,start,indent

packadd! matchit

" Vimscript file settings ------------------- {{{
augroup customVim
  autocmd! 
  autocmd FileType vim set foldlevelstart=0
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Pesquisar ----------
nnoremap <C-/> :Rg<CR>
nnoremap <leader>of :Files<CR>
nnoremap <leader>ob :Buffers<CR>
nnoremap <leader>rt :call fzf#run({'sink': 'read', 'dir': "~/templates/".&filetype, 'window': {'width': 0.9, 'height': 0.6}, 'options': '--preview "bat {}"'})<cr>
nnoremap <leader>rg :Rg -g '!tags' <cword> <CR>

" Vim - melhoria continua do vim -----{{{{
augroup aprimoramentoVim
  autocmd!
  " Edição e carregamento rápido de configurações
  autocmd FileType * nnoremap <leader>ve :vsplit $MYVIMRC<cr>
  autocmd FileType * nnoremap <leader>vs :source $MYVIMRC<cr>
" }}}}

" General settings -------------------{{{
augroup customGeneralSettings
  autocmd!
  " Easy Tabs
  autocmd FileType * nnoremap <s-right> :tab sp<CR>
  " Easy Buffers
  autocmd FileType * nnoremap <PageUp> :bprevious<CR>
  autocmd FileType * nnoremap <PageDown> :bnext<CR>
  autocmd FileType * tnoremap <PageUp> <C-W>:bprevious<CR>
  autocmd FileType * tnoremap <PageDown> <C-W>:bnext<CR>
  autocmd FileType * inoremap <PageUp> <Esc>:bprevious<CR>
  autocmd FileType * inoremap <PageDown> <Esc>:bnext<CR>
  autocmd FileType * inoremap <c-PageDown> <Esc>:tabNext<CR>
  autocmd FileType * inoremap <c-PageUp> <Esc>:tabprevious<CR>
  autocmd FileType * nnoremap <del> :Bwipeout<CR>
  " Issue navigation
  autocmd FileType * nnoremap <leader>an :ALENext<CR>
  autocmd FileType * nnoremap <leader>ap :ALEPrevious<CR>
  " Surround
  autocmd FileType * vnoremap <leader>s" <esc>`<i"<esc>`>la"
  autocmd FileType * vnoremap <leader>s' <esc>`<i'<esc>`>la'
  " Replace surround
  autocmd FileType * vnoremap <leader>r" <esc>`<r"<esc>`>hr"
  autocmd FileType * vnoremap <leader>r' <esc>`<hr'<esc>`>lr'
augroup END
" }}}

" Tabstop -------------- {{{
" General tabstop settings
set tabstop=2
set smartindent
set shiftwidth=2
set expandtab
augroup customStartup
  autocmd!
  " 4 spaces languages
  autocmd FileType python,java set tabstop=4|set shiftwidth=4|set noexpandtab
  au BufEnter *.py,*java set sw=4 ts=4  et 
  " 2 spaces languages
  autocmd FileType njk,sql,cpp,php,html,js,ts,shell,dot,awkr set tabstop=2|set shiftwidth=2|set noexpandtab
  au BufEnter *.njk,*.sql,*.cpp,*.c++,*.php,*.html,*.js,*.ts,*.sh,*.dot,*.awk set sw=2 ts=2 et
augroup END
" }}}

" Importing libraries ----------- {{{
augroup customImport
  autocmd!
  autocmd FileType go nnoremap <buffer> <leader>imp Oimport (<CR>)<ESC>hi""<ESC>h
  autocmd FileType ts nnoremap <buffer> <leader>imp Oimport {  } from '';<ESC>F{lli
augroup END
" }}}

" Graphviz dot files --------------- {{{
augroup custoDotFiles
  autocmd!
  autocmd FileType dot nnoremap <buffer> <leader>cl osubgraph cluster_NOME{<CR>}<ESC>^kfN
augroup END
" }}}

" Javascript --------------- {{{
augroup customJS
  autocmd!
  " operation inside previous (including current) function
  autocmd FileType * onoremap if :<c-u>execute "normal! ?^\[ \t\]*function\rf{:nohlsearch\rvi{"<cr>
  " console.debugs the Word under cursor
  autocmd FileType javascript  nnoremap <leader>dg yiWoconsole.debug('<esc>pa', <esc>pa)<esc>
  autocmd FileType typescript  nnoremap <leader>dg yiWoconsole.debug('<esc>pa', <esc>pa);<esc>
  autocmd FileType python  nnoremap <leader>dg yiWoprint('<esc>pa')<esc>2F'<cr>l
  autocmd FileType python  nnoremap <leader>dG Iimport pdb; pdb.set_trace()<esc>

augroup END
" }}}

" Creating functions ------------ {{{
augroup customFunctions
  " Declare function
  autocmd FileType go nnoremap <buffer> <leader>if ofunc (r *Receiver) name (p Parameter) (r Return){<CR>}<ESC>k^f(l
  autocmd FileType python nnoremap <buffer> <leader>if odef name(parameter):<CR>pass<ESC>k^fn
  autocmd FileType python nnoremap <buffer> <leader>il ilambda x: x<ESC>
  autocmd FileType javascript,js,typescript,ts nnoremap <buffer> <leader>if ofunction name() {<CR>}<ESC>kf l
  autocmd FileType javascript,js,typescript,ts nnoremap <buffer> <leader>iF oconst name = () => {<CR>}<ESC>kf l
  autocmd FileType javascript,js,typescript,ts nnoremap <buffer> <leader>il afunction () {}<ESC>F(l
  autocmd FileType javascript,js,typescript,ts nnoremap <buffer> <leader>iL a() => {}<ESC>F(l
  autocmd FileType php nnoremap <buffer> <leader>if ofunction <C-R>=expand("%:t:r")<CR>_Name($parameter){<CR>}<ESC>k$F_l
  " Abbreviation for return
  autocmd FileType go,php,python,java,js,typescript,javascript nnoremap <buffer> <leader>r oreturn 
augroup END
" }}}

" Creating tests ------------ {{{
augroup customTests
  " Declare tests
  autocmd FileType javascript,js,typescript,ts nnoremap <buffer> <leader>des odescribe("description", function() {<CR>});<ESC>k^f(l
augroup END
" }}}

" If empty ----------------- {{{
augroup custom ifEmpty
  " Create if empty then
  autocmd FileType php nnoremap <buffer> <leader>ifem iif (empty()){<CR>}<ESC>k^f(f(a
  " Create equals if x not empty
  autocmd FileType php nnoremap <buffer> <leader>toem ^f=wyt;iempty(<ESC>pa) ? "" : <ESC>
  autocmd FileType java nnoremap <buffer> <leader>ifem iif (PLACEHOLDER == null){<CR>}<ESC>k^fPciw
  autocmd FileType java nnoremap <buffer> <leader>toem ^f=wyt;Pa == null ? "" : 
augroup END
" }}}

" Markup ----------------- {{{
augroup customMarkup
  " HTML Files
  " Break up a tag
  autocmd FileType html nnoremap <buffer> <leader>brt cit<CR><CR><ESC><UP>PVat=
  " Creating lists
  " - unordered
  autocmd FileType tex,latex nnoremap <buffer> <leader>lu o\begin{itemize}<CR>\item<CR>\end{itemize}<ESC>k
  autocmd FileType html nnoremap <buffer> <leader>lu o<ul><CR><li></li><CR></ul><ESC>k
  " - ordered
  autocmd FileType tex,latex nnoremap <buffer> <leader>lo o\begin{enumerate}<CR>\item<CR>\end{enumerate}<ESC>k
  autocmd FileType html map <buffer> <leader>lo o<ol><CR><li></li><CR></ol><ESC>k
  " Surrounding with tags
  autocmd FileType html nnoremap <buffer> <leader>stp :call SurroundLineWithTag('p')<cr>;
  autocmd FileType html nnoremap <buffer> <leader>stdt :call SurroundLineWithTag('dt')<cr>;
  autocmd FileType html nnoremap <buffer> <leader>stdd :call SurroundLineWithTag('dd')<cr>;
  autocmd FileType html nnoremap <buffer> <leader>sttd :call SurroundLineWithTag('td')<cr>;
  autocmd FileType html nnoremap <buffer> <leader>stdiv :call SurroundLineWithTag('div')<cr>;
  autocmd FileType html nnoremap <buffer> <leader>start :call SurroundLineWithTag('article')<cr>;
  autocmd FileType html nnoremap <buffer> <leader>stsec :call SurroundLineWithTag('section')<cr>;
  autocmd FileType html nnoremap <buffer> <leader>stli :call SurroundLineWithTag('li')<cr>;
  autocmd FileType html nnoremap <buffer> <leader>sth1 :call SurroundLineWithTag('h1')<cr>;
augroup END
" }}}

" Template strings -------- {{{
augroup stringHelpers
      autocmd FileType javascript,js,typescript,ts inoremap <buffer> $$ ${}<ESC>i
augroup END
" }}}

au BufNewFile,BufRead *.njk,*.html,*.htm,*.shtml,*.stm set ft=jinja

" Correções, Formatações e refatoramento

vnoremap <leader>fj :!fixjson<cr>
nnoremap <leader>fj va{:!fixjson<cr>

function! HTMLEncode()
perl << EOF
 use HTML::Entities;
 @pos = $curwin->Cursor();
 $line = $curbuf->Get($pos[0]);
 $encvalue = encode_entities($line);
 $curbuf->Set($pos[0],$encvalue)
EOF
endfunction

function! HTMLDecode()
perl << EOF
 use HTML::Entities;
 @pos = $curwin->Cursor();
 $line = $curbuf->Get($pos[0]);
 $encvalue = decode_entities($line);
 $curbuf->Set($pos[0],$encvalue)
EOF
endfunction

nnoremap <Leader>h :call HTMLEncode()<CR>
nnoremap <Leader>H :call HTMLDecode()<CR>

set termguicolors
"colorscheme gruvbox
colorscheme nord

" Just like windo, but restore the current window when done.
function! WinDo(command)
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" Just like Windo, but disable all autocommands for super fast processing.
com! -nargs=+ -complete=command Windofast noautocmd call WinDo(<q-args>)

" Just like bufdo, but restore the current buffer when done.
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

"set number relativenumber
"augroup numbertoggle
"  autocmd!
"  autocmd BufEnter,FocusGained,InsertLeave,CmdlineLeave * set relativenumber |redraw
"  autocmd BufLeave,FocusLost,InsertEnter,CmdlineEnter   * set norelativenumber |redraw
"augroup END

:onoremap <silent> p :<c-u>execute "normal! ?`\rlv/`<bs>"<cr>
:onoremap <silent> ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" Terminal ------------ {{{
" Completion
nnoremap <s-cr> :vertical terminal<cr>
nnoremap <leader>w<cr> :vertical terminal<cr>
 "}}}
 let g:rooter_manual_only = 1


" let g:opamshare = substitute(system('opam var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Termine o diretório swap com duas barras para usar caminhos absolutos
set directory^=$HOME/.vim/swap//

" Evita reiniciar uma busca a partir do início do arquivo
set nowrapscan

set lazyredraw

set ttyfast

set confirm " pedir confirmação ao invés de bloquear ação por buffer não salvo

function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction

set noma

set nrformats+=alpha " permite ao vim incrementar texto
