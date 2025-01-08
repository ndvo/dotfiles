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
""" leader g - comandos relacionados ao git
""" leader gh - comandos relacionados ao git hub
""" leader c - comandos relacionados a copiar
""" leader t - toggles
""" leader l - comandos relacionados a limpar o vim

""" leader wz fecha preview
set t_Co=256

set exrc " lê .vimrc local ao diretório
"set hidden " mantém buffers abertos ao fechar
set visualbell " sinal visual ao invés de sonoro
set list " mostra caracteres invisíveis

" Teclas líder
let mapleader = " "
let maplocaleader = "\\"
packloadall           " Carrega os plugins disponíveis.

" Navegação entre buffers
" Este atalho permite que todos os comandos C-w sejam acessados sem precisar
" do ctrl
nnoremap <leader>w <c-w>
nnoremap <leader>wwq :windo q<cr>

" Saltos
" nnoremap <leader>jbp <c-^>
" Mantém a centralização
nnoremap n nzzzv
nnoremap N Nzzzv
" Move por blocos
nnoremap H :SidewaysJumpLeft<cr>
nnoremap L :SidewaysJumpRight<cr>

" Toggles
nnoremap <leader>thl :set hlsearch!<cr>
nnoremap <leader>ted :set ma!<cr>
nnoremap <leader>tna :set number!<cr>
nnoremap <leader>tnr :set relativenumber!<cr>
nnoremap <leader>tal :ALEToggle<cr>
nnoremap <leader>tsl :call ToggleSyntaxHL()<cr>

" Limpeza
nnoremap <leader>lh :call DeleteHiddenBuffers()
nnoremap <leader>le :call DeleteEmptyBuffers()

" Tagbar
nnoremap <right> :TagbarToggle<cr>

" Netrw {{{ ----

augroup NetRW
  autocmd!
  let g:netrw_preview = 1
  autocmd FileType netrw nnoremap <buffer> <silent> zc <Plug>NetrwTreeSqueeze
augroup END

" let g:netrw_list_hide= netrw_gitignore#Hide().'.*\.swp$'
let g:netrw_winsize = -40
nnoremap <left> :Lex<cr>
nnoremap <down> :UndotreeToggle<cr>

" Git {{{ ----
" mnemônicos:
"   Os mnemônicos usados por enquanto são os seguintes:
"   (manter esta lista ajuda a reorganizar os comandos e fazer com que façam
"   mais sentido).
"" s -> status
"" v -> vertical
"" l -> log
"" b -> blame/branch
"" d -> diff
"" p -> pull/push
"" c -> checkout
"" r -> reset
"" h -> gh GitHub Command Line
"" /? -> branch
" Mostra o estado do Git em uma nova aba
nnoremap <leader>gs :tab Git<cr>
" Mostra o estado do Git como uma divisão vertical
nnoremap <leader>gv :vert Git<cr>
" Mostra o log, versão simples
nnoremap <leader>gl :vert Git log --oneline<cr>
" Mostra o log, versão completa
nnoremap <leader>gL :vert Git log --graph<cr>
" Mostra o Git Blame
nnoremap <leader>gbl :Git blame --date short <cr>
" Lista branches locais
nnoremap <leader>g/ :call CheckoutBranch()<cr>
" Lista branches ordenadas por data de commit
nnoremap <leader>g? :Git branch -vv --sort=-committerdate<cr>
" Compara o arquivo atual com a versão estagiada
nnoremap <leader>gd :vert Gdiff 
" Compara o arquivo atual com a versão development
nnoremap <leader>gdd :execute "vert Gdiff " g:dev <cr>
nnoremap <leader>gdl :call DiffPreviousVersion() <cr>
" Baixa as alterações da branch do servidor remoto
nnoremap <leader>gp :Git! pull<cr>
" Salva as alterações da branch no servidor remoto
nnoremap <leader>gP :Git! push
" Volta para a branch anterior
nnoremap <leader>gc- :Git checkout -<cr>
" Abre a branch g:dev
nnoremap <leader>gcd :execute "Git checkout " g:dev <cr>
" Abre a branch g:master
nnoremap <leader>gcm :execute "Git checkout " g:master <cr>
" Abre a branch g:staging
nnoremap <leader>gcs :execute "Git checkout " g:staging <cr>
" Abre a branch g:sandbox
nnoremap <leader>gcn :execute "Git checkout " g:sandbox <cr>
" Torna branch atual igual a master
nnoremap <leader>grhom :Git reset --hard origin/master
" Torna branch atual igual a develop
nnoremap <leader>grhod :Git reset --hard origin/develop
" Torna branch atual igual a staging
nnoremap <leader>grhos :Git reset --hard origin/staging
" Torna branch atual igual a $staging
nnoremap <leader>grhs :Git reset --hard $staging
" Rebase com staging
nnoremap <leader>grbi :Git rebase  -i
" Rebase com staging
nnoremap <leader>grbs :Git rebase  origin/staging
" Rebase com develop
nnoremap <leader>grbd :Git rebase  origin/develop
" Rebase com master
nnoremap <leader>grbm :Git rebase  origin/master
" Reseta a branch sob o cursor
nnoremap <leader>grw :Git reset <C-r><C-w>^
" Prepara um comando para criar uma branch de backup
nnoremap <leader>gbkp :Git checkout -b bkp-
" Faz um git fetch
nnoremap <leader>gf :Git! fetch<cr>
" Faz um cherry pick do commit sob o cursor
nnoremap <leader>gg :Git cherry-pick <cword>
" Atualiza a branch development
nnoremap <leader>gfd :execute "Git fetch origin " g:dev ":" g:dev
" Faz checkout de um commit usando o número do PR
nnoremap <leader>ghc :!gh pr checkout 
nnoremap <leader>ghs :call GhStatus() <cr>
nnoremap <leader>ghv :call GhVertStatus() <cr>
nnoremap <leader>ghd :call PRChanges() <cr>
nnoremap <leader>ghw :!gh pr checkout <C-r><C-w>
" Cria um commit 'Work in Progress'
nnoremap <leader>gwip : Git commit -m 'wip'
" Prepara a criação de uma nova branch
nnoremap <leader>gbn :!createbranch 
" Deleta/remove/apaga a branch sobre a qual o cursor está (a ser usado do <leader>g/
nnoremap <leader>gbd :Git branch -D <C-r><C-l><cr>
vnoremap <leader>gbd :<C-U>call RemoveBranches() <cr>
" ---- }}}

" Básicos {{{--------
" Easier Omnicomplete Ctrl x
inoremap <C-Space> <C-x>
inoremap <S-Space> <Esc>
inoremap <Tab> =
inoremap <S-Tab> +

" Switch
nnoremap <leader>sw :Switch<CR>

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

" Colar
nnoremap gp "0p
nnoremap gP "0P

" Salvar
nnoremap <leader>bw :w<cr>
nnoremap <leader>bW :wa<cr>
inoremap <s-space>bw <c-o>:w<cr>
nnoremap <leader>ba :arga %<cr>
nnoremap <leader>bd :argd %<cr>


" Substitui seleção pelo conteúdo do registro
vnoremap <leader>p "_dP

" Consistência
nnoremap Y y$

" }}}

" ALE ------------ {{{
"
" Completion
let g:ale_hover_to_preview = 0
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 1
set omnifunc=ale#completion#OmniFunc
"set omnifunc=syntaxcomplete#Complete
" prefiro rodar o linter sob comando
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
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
      \  'c++': ['g++'],
      \  'ruby': ['rubocop']
      \}
let g:ale_linter_aliases = {
      \ 'jsx': ['css', 'javascript'],
      \ 'mdx': ['css', 'javascript'],
      \}
 "}}}

" Usar cedilha mesmo que o sistema operacional não queira
inoremap ć ç
inoremap Ç :
nnoremap ç :
nnoremap Ç :

" Não quebrar visualmente as linhas
set nowrap
" Destaca coluna 80
set colorcolumn=80
" Destaca linha atual
set cursorline
set formatoptions-=t

set wildmode=longest,list   "Complete longest string, then list alternatives
set wildmenu

" Desfazer persistente
set undofile
set undodir=$HOME/.vim/undo/

silent! helptags ALL  " Carregar arquivos de ajuda de todos os pluging

"if &t_Co > 2 || has("gui_running")
"  syntax on
"endif
syntax manual
augroup PatchDiffHighlight
  autocmd!
  autocmd Filetype diff,fugitive,git set syntax=ON
augroup END

set mouse=a " Permite usar o mouse
set nocompatible

filetype plugin indent on

" Mostrar o comando que está sendo usado
set showcmd

" Show lines above and bellow current line
set scrolloff=6
set backspace=eol,start,indent

packadd! matchit
set foldmethod=indent

" Vimscript file settings ------------------- {{{
augroup customVim
  autocmd! 
  autocmd FileType vim set foldlevelstart=0
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Pesquisar ----------
nnoremap <leader>rt :call ReadTemplate()<cr>
nnoremap <leader>rg :Rg -g '!tags' <cword> 
nnoremap <leader>RG :Rg -g '!tags' 
nnoremap <leader>rgjs :Rg -g '!tags' -g '*.{jsx,js}' 
nnoremap <leader>rgrb :Rg -g '!tags' -g '*.rb' 
nnoremap <leader>rgpy :Rg -g '!tags' -g '*.py' 

" navega para o próximo item na change list
nnoremap <leader>cn :cn<cr>

" Vim - Abre ferramentas auxiliares-----{{{{
augroup OpenAuxiliaryTools
  " A ideia de ter uma tecla específica para "abrir" é estranha porque pode se
  " aplicar a praticamente qualquer ferramenta, mas é mais ou menos assim que
  " minha cabeça tem funcionado. "Abra o netrw" é mais ou menos o pensamento
  " que me vem quando penso em navegar por arquivos, por isso <leader>on. Ter
  " uma seção específica para cada ferramenta poderia ser interessante, mas ao
  " menos por enquanto eu uso as ferramentas listadas abaixo de forma
  " limitada, quase só para ver algo rapidamente e em seguida fechá-las. Por
  " isso não parece valer a pena ter uma seção para cada uma.
  nnoremap <leader>of :Files<CR>
  nnoremap <leader>og :GFiles<CR>
  nnoremap <leader>od :call OpenChangedFile() <cr>
  nnoremap <leader>old :call OpenChangedFileByLine() <cr>
  nnoremap <leader>oa :call OpenArglist() <cr>
  nnoremap <leader>ob :Buffers<CR>
  nnoremap <leader>oh :History<CR>
  nnoremap <leader>on :Lex<cr>
  nnoremap <leader>ou :UndotreeToggle<cr>
  nnoremap <leader>ot :TagbarToggle<cr>
  nnoremap <leader>op <c-w>}
  nnoremap <leader>oP <c-w><c-z><c-w>}
  nnoremap <leader>o. :Explore<cr>
  nnoremap <leader>os :call EditSchema()<cr>
  nnoremap <leader>or :call EditRoutes()<cr>
  nnoremap <leader>ov2 :call Editv2()<cr>
  nnoremap <leader>ov3 :call Editv3()<cr>
  nnoremap <leader>ow :e ~/subscribe/wiki/<cr>
  nnoremap <leader>omd :call EditMdTemplate()<cr>
  nnoremap <leader>ol :Lines<cr>
  nnoremap <leader>oll :Lines<cr>
  nnoremap <leader>olrb :call OpenRubyByLine() <cr>
  nnoremap <leader>oljs :call OpenJsByLine() <cr>
  nnoremap <leader>olps :call OpenOpsJsByLine() <cr>
  nnoremap <leader>o- <C-^>
augroup END
" }}}}

" Vim - melhoria continua do vim -----{{{{
augroup aprimoramentoVim
  autocmd!
  " Edição e carregamento rápido de configurações
  autocmd FileType * nnoremap <leader>ve :vsplit $MYVIMRC<cr>
  autocmd FileType * nnoremap <leader>VE :vsplit .vimrc<cr>
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
  autocmd FileType * nnoremap <leader>al :ALELint<CR>
  " Surround
  autocmd FileType * vnoremap <leader>s" <esc>`<i"<esc>`>la"
  autocmd FileType * vnoremap <leader>s' <esc>`<i'<esc>`>la'
  " Replace surround
  autocmd FileType * vnoremap <leader>r" <esc>`<r"<esc>`>hr"
  autocmd FileType * vnoremap <leader>r' <esc>`<hr'<esc>`>lr'
augroup END
" }}}
  "
  " Quando no modo de inserção, usa o shift-space para inicializar comandos
  tnoremap <s-space>n <c-w><s-n>
  tnoremap <s-space>w <c-w><s-n><c-w>
  inoremap <s-space>n <esc>
  inoremap <s-space>w <esc><c-w>
  " avoid silly error of using insert leader in normal mode
  nnoremap <s-space>w <c-w>

" Tabstop -------------- {{{
" General tabstop settings
set tabstop=2
set smartindent
set autoindent
set shiftwidth=2
set expandtab
" }}}

" Configura inicialização -------------- {{{
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
  autocmd FileType javascript  nnoremap <leader>dg yiWoconsole.debug({ <esc>pa })<esc>
  autocmd FileType typescript  nnoremap <leader>dg yiWoconsole.debug({ <esc>pa })<esc>
  autocmd FileType python  nnoremap <leader>dg yiWoprint('<esc>pa')<esc>2F'<cr>l
  autocmd FileType python  nnoremap <leader>dG oimport pdb; pdb.set_trace()<esc>

augroup END
" }}}

" Creating functions ------------ {{{
augroup customFunctions
  " Declare function
  autocmd!
  autocmd FileType go nnoremap <buffer> <leader>if ofunc (r *Receiver) name (p Parameter) (r Return){<CR>}<ESC>k^f(l
  autocmd FileType python nnoremap <buffer> <leader>if odef name(parameter):<CR>pass<ESC>k^fn
  autocmd FileType python nnoremap <buffer> <leader>il ilambda x: x<ESC>
  autocmd FileType javascript,js,jsx,typescript,ts nnoremap <buffer> <leader>if ofunction name() {<CR>}<ESC>kf l
  autocmd FileType javascript,js,jsx,typescript,ts nnoremap <buffer> <leader>iF oconst name = () => {<CR>}<ESC>kf l
  autocmd FileType javascript,js,jsx,typescript,ts nnoremap <buffer> <leader>il afunction () {}<ESC>F(l
  autocmd FileType javascript,js,jsx,typescript,ts nnoremap <buffer> <leader>iL a() => {}<ESC>F(l
  autocmd FileType php nnoremap <buffer> <leader>if ofunction <C-R>=expand("%:t:r")<CR>_Name($parameter){<CR>}<ESC>k$F_l
  autocmd FileType go inoremap <buffer> <s-space>if ofunc (r *Receiver) name (p Parameter) (r Return){<CR>}<ESC>k^f(l
  autocmd FileType python inoremap <buffer> <s-space>if odef name(parameter):<CR>pass<ESC>k^fn
  autocmd FileType python inoremap <buffer> <s-space>il ilambda x: x<ESC>
  autocmd FileType javascript,js,jsx,typescript,ts inoremap <buffer> <s-space>if function name() {<CR>}<ESC>kf l
  autocmd FileType javascript,js,jsx,typescript,ts inoremap <buffer> <s-space>iF const name = () => {<CR>}<ESC>kf l
  autocmd FileType javascript,js,jsx,typescript,ts inoremap <buffer> <s-space>il function () {}<ESC>F(l
  autocmd FileType javascript,js,jsx,typescript,ts inoremap <buffer> <s-space>iL () => {}<ESC>F(l
  autocmd FileType php inoremap <buffer> <s-space>f ofunction <C-R>=expand("%:t:r")<CR>_Name($parameter){<CR>}<ESC>k$F_l
  " Abbreviation for return
  autocmd FileType go,php,python,java,js,jsx,typescript,javascript nnoremap <buffer> <leader>ir oreturn 
augroup END
" }}}

" Creating tests ------------ {{{
augroup customTests
  " Declare tests
  autocmd!
  autocmd FileType javascript,js,jsx,typescript,ts nnoremap <buffer> <leader>des odescribe("description", function() {<CR>});<ESC>k^f(l
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
  autocmd!
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
  autocmd!
  autocmd FileType javascript,js,jsx,typescript,ts inoremap <buffer> $$ ${}<ESC>i
  autocmd FileType ruby inoremap <buffer> $$ #{}<ESC>i
  autocmd FileType eruby inoremap <buffer> $$ <%=  %><ESC>kki
  autocmd FileType python inoremap <buffer> $$ {}<ESC>i
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

" colorscheme Atelier_SulphurpoolDark
" colorscheme nord
" colorscheme gruvbox
" colorscheme gotham256
" colorscheme nofrils-dark
" colorscheme happy_hacking
" colorscheme railscasts
" colorscheme minimalist
" colorscheme apprentice

" Em uma pesquisa online encontrei artigos afirmando que o preto no branco é
" menos prejudicial para as vistas. Não encontrei artigos contestando.
colorscheme PaperColor
set background=light

if &term =~ '256color'
    " disable Background Color Erase for tmux
    " see: sunaku.github.io/vim-256color-bce.html
    set t_ut=
endif

" Igual ao windo, mas restaura a janela atual ao final
function! WinDo(command)
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" Igual ao windo, mas desabilita autocommands para melhor performance
com! -nargs=+ -complete=command Windofast noautocmd call WinDo(<q-args>)

" Igual ao bufdo, mas restaura a janela atual ao final
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

" set nrformats+=alpha " permite ao vim incrementar texto
let g:ale_python_auto_pipenv = 1

let g:ale_python_pylint_change_directory=0
let g:ale_python_flake8_change_directory=0


set synmaxcol=300

" copia arquivo e linha atual
nnoremap <leader>cfn :let @"=expand("%").":".line(".")<CR>


function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction

" Abre um arquivo a partir de uma variável definida em uma string.
function FileEdit(path)
  execute "e ".fnameescape(a:path)
endfunction

function CascadeVariable(variable)
  let l:possibilities = [ 
        \ get(b:, a:variable),
        \ get(w:, a:variable),
        \ get(t:, a:variable),
        \ get(g:, a:variable) ]
  echo l:possibilities
  for i in l:possibilities
    if type(i)
      return i
    endif
  endfor
endfunction

function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        exe 'bd '.join(buffers, ' ')
    else
        echo 'No buffer deleted'
    endif
endfunction

" Abre o arquivo que define o Esquema do projeto
" 
" O esquema é o arquivo (ou diretório) que define as entidades do projeto em
" questão.
" 
" No rails seria o schema.rb, mas podemos pensar em qualquer arquivo que
" define um esquema, tal como um arquivo com interfaces typescript.
"
" Esta função presume que haverá uma variável global g:schema
" defina esta variável no .vimrc do diretório do projeto
" 
function EditSchema()
  let l:filename = CascadeVariable('schema')
  call FileEdit(l:filename)
endfunction

function Editv2()
  let l:filename = CascadeVariable('v2')
  call FileEdit(l:filename)
endfunction

function Editv3()
  let l:filename = CascadeVariable('v3')
  call FileEdit(l:filename)
endfunction

function EditRoutes()
  let l:filename = CascadeVariable('routes')
  call FileEdit(l:filename)
endfunction

function ToggleSyntaxHL()
  if exists("g:syntax_on")
    syntax off
  else
    syntax enable
  endif
endfunction

function GhStatus()
  execute 'tabnew'
  call GhStatusExecute()
endfunction

function GhVertStatus()
  execute 'vnew'
  call GhStatusExecute()
endfunction

function PRChanges()
  let wordUnderCursor = expand("<cword>")
  execute 'vnew'
  call SetTopLine("Changes from PR ".wordUnderCursor)
  execute "r !gh pr diff --name-only ".wordUnderCursor
endfunction

function GhStatusExecute()
  execute "r !gh pr list --search \"-author:@me draft:false label:account -label:merge is:open sort:created-asc\" | column -t -s '\t' "
endfunction

function OpenChangedFile()
  call fzf#run({ 'source': 'git diff --name-only origin/development', 'sink': 'e', 'window': {'width': 0.9, 'height': 0.6}, 'options': '--preview "cat {}"'})
endfunction

function OpenChangedFileByLine()
  let l:changed_files = system('git diff --name-only origin/development')
  let l:rg_command = 'rg -n '
  call fzf#run({
        \ 'source': "rg -n '.'  $(git diff --name-only origin/development)",
        \ 'window': {'width': 0.9, 'height': 0.8},
        \ 'options': '--ansi --delimiter : --nth 3.. --preview "echo {} | sed -e \"s/:.*//\" | xargs batcat " ',
        \ 'sink*': function('s:sinkFileLine')
        \ })
endfunction

function OpenRubyByLine()
  call fzf#run({
        \ 'source': "rg -n -g 'saf-api/*.rb' -g 'saf-api/**/*rb' --color always . ",
        \ 'window': {'width': 0.9, 'height': 0.8},
        \ 'options': '--ansi --delimiter : --nth 3.. --preview "echo {} | sed -e \"s/:.*//\" | xargs batcat " ',
        \ 'sink*': function('s:sinkFileLine')
        \ })
endfunction

function OpenJsByLine()
  call fzf#run({
        \ 'source': "rg -n -g 'frontend/web/*.{js,jsx}' -g 'frontend/web/**/*.{js,jsx}' --color always . ",
        \ 'window': {'width': 0.9, 'height': 0.8},
        \ 'options': '--ansi --delimiter : --nth 3.. --preview "echo {} | sed -e \"s/:.*//\" | xargs batcat " ',
        \ 'sink*': function('s:sinkFileLine')
        \ })
endfunction

function OpenOpsJsByLine()
  call fzf#run({
        \ 'source': "rg -n -g 'frontend/ops/*.{js,jsx}' -g 'frontend/ops/**/*.{js,jsx}' --color always . ",
        \ 'window': {'width': 0.9, 'height': 0.8},
        \ 'options': '--ansi --delimiter : --nth 3.. --preview "echo {} | sed -e \"s/:.*//\" | xargs batcat " ',
        \ 'sink*': function('s:sinkFileLine')
        \ })
endfunction

function! ReadTemplate()
  let l:template_dir = '~/dotfiles/templates/'.expand("%:e")
  echo l:template_dir

  call fzf#run({
        \ 'dir': l:template_dir,
        \ 'sink': 'read',
        \ 'window': {'width': 0.9, 'height': 0.8},
        \ 'options': '--ansi --delimiter : --nth 3.. --preview "echo {} | sed -e \"s/:.*//\" | xargs batcat " ',
        \ })
endfunction

function! CheckoutBranch() abort
  let l:branches = systemlist('git branch -a')
  
  call fzf#run({
    \ 'source': l:branches,
    \ 'sink': function('<SID>checkout_branch'),
    \ 'window': {'width': 0.9, 'height': 0.8},
    \ 'options': [
      \ '--prompt', 'Branch> ',
      \ '--preview', 'echo {} | sed "s/^ *//;s/ *$//" | xargs git log -n 5 --oneline',
      \ '--bind', 'ctrl-d:page-down,ctrl-u:page-up',
    \ ],
    \ })
endfunction

function s:checkout_branch(item)
  execute 'Git! checkout '.substitute(a:item, '^ *', '', '')
endfunction

function SetTopLine(text)
  call setline(1, add(line('$') == 1 && col('$') == 1 ? [] : getline(0, '$'), a:text))
endfunction

let g:switch_custom_definitions = [
      \   {
      \     '\<[a-z0-9]\+_\k\+\>': {
      \       '_\(.\)': '\U\1'
      \     },
      \     '\<[a-z0-9]\+[A-Z]\k\+\>': {
      \       '\([A-Z]\)': '_\l\1'
      \     },
      \   }
      \ ]
set spellfile=$HOME/.vim-spell-en.utf-8.add
" set complete+=kspell
set backupdir=~/tmp

function! s:sinkFileLine(lines) abort
  echo a:lines

  let filename = a:lines[0]
  execute 'edit ' . substitute(filename, '\([^:]*\):\([0-9]*\).*', '+\2 \1', '')
endfunction

function EditMdTemplate()
  call FileEdit(CurrentTemplateName())
endfunction

function CurrentTemplateName()
  return '.github/pr-descriptions/'.GitBranch().'.template.md'
endfunction

function GitBranch()
  return substitute(system('git branch --show-current'), '\n$', '', '')
endfunction

set tags=./tags;,tags;

function! UseNearestParentTagsFile()
  let l:path = "%:p"
  while expand(l:path) != "/"
    let l:path = l:path . ":h"
    if filereadable(expand(l:path) . "/tags")
      exe "set tags=" . expand(l:path) . "/tags"
      return
    endif
  endwhile
  echom "No tags file found in path."
endfunction

command! UseNearestParentTagsFile call UseNearestParentTagsFile()
nnoremap <leader>ct :UseNearestParentTagsFile<cr>

let g:gutentags_project_root = ['.vimrc']
" Create a .vimrc for each subproject in the folder
" such a folder should contain the executables for ALE
" run ALEInfo to learn what variables should be set
" create a script to replace each of those and reach to docker to run the
" script

let $BAT_THEME = 'gruvbox-light'

" Executa comando no terminal e põe o resultado na próxima linha
vnoremap <leader>exec yPgv:!


nnoremap <leader>rmd :call <SID>FuzzyTestChecklist()<cr>
nnoremap <leader>rjs :call <SID>FuzzyJs()<cr>
nnoremap <leader>rrb :call <SID>FuzzyRb()<cr>

function! <SID>FuzzyTestChecklist()
    let tempfile=tempname()
    execute '!~/dotfiles/scripts/subscribe/taskdescriptionlines.sh >' . shellescape(tempfile)
    try
        silent execute 'read' tempfile
    finally
        call delete(tempfile)
    endtry
endfunction

function! <SID>FuzzyJs()
    let tempfile=tempname()
    execute '!~/subscribe/dev/saf/ndvo/scripts/fuzzyjs.sh >' . shellescape(tempfile)
    try
        silent execute 'read' tempfile
    finally
        call delete(tempfile)
    endtry
endfunction

function! <SID>FuzzyRb()
    let tempfile=tempname()
    execute '!~/subscribe/dev/saf/ndvo/scripts/fuzzyrb.sh >' . shellescape(tempfile)
    try
        silent execute 'read' tempfile
    finally
        call delete(tempfile)
    endtry
endfunction


command! -nargs=0 InteractiveFZFCommand call <SID>InteractiveFZFCommand()


function! DiffPreviousVersion()
  " Get the current quickfix list
  let qflist = getqflist()
  let current_index = getqflist({'idx': 0}).idx

  let fillqf = len(qflist) == 0

  if current_index < len(qflist)
    " Get the next item
    let next_item = qflist[current_index]
    
    " Extract the filename, line number, and text from the next item
    "let filename = next_item.filename
    "let line_number = next_item.lnum
    let is_commit_message = match(next_item.text, '^\w\{10} .*\(\#\d\+\)$')
    if is_commit_message
      let commit = matchstr(next_item.text, '^\w\+')
      echo next_item.text
      echo commit
      let cmd = 'Gvdiffsplit '.commit.':% | cnext'
      echo cmd
      execute cmd
    else
      fillqf = true
    endif
  else
    if fillqf
      echo "Preparing list of changes to this file"
      execute 'Gclog --oneline %'
    else
      echo "no previous version to show"
    endif
  endif
endfunction


function! OpenArglist()
 call fzf#run({'source': argv(), 'sink*': 'e', 'window': {'width': 0.9, 'height': 0.6}, 'options': '--preview "batcat {}"'})
endfunction

function! OpenTestFile()
  execute 'e ' . substitute(substitute(expand('%'), '/app/', '/spec/', ''), '\.rb$', '_spec.rb', '')
endfunction
function! EnsureDirExists()
    let dir = expand('%:p:h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
endfunction

function! RemoveBranches()
    let l:selectedLines = join(getline("'<", "'>"), ' ')
    echo "Removing ".l:selectedLines
    execute 'Git branch -D '.l:selectedLines
endfunction

" autocmd BufEnter * call LoadLocalVimrc()

function! LoadLocalVimrc()
  let filepath = expand('%')

  if filepath =~ '^saf-api/'
    if filereadable("/home/nelson/subscribe/vim/api/.vimrc")
      execute 'source /home/nelson/subscribe/vim/api/.vimrc'
    endif
  endif
  if matchstr(filepath, '^frontend/web/')
    if filereadable("/home/nelson/subscribe/vim/web/.vimrc")
      execute 'source /home/nelson/subscribe/vim/web/.vimrc'
    endif
  endif
  if matchstr(filepath, '^frontend/ops/')
    if filereadable("/home/nelson/subscribe/vim/ops/.vimrc")
      execute 'source /home/nelson/subscribe/vim/ops/.vimrc'
    endif
  endif
endfunction

