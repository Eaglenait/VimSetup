source $VIMRUNTIME/mswin.vim
source $VIMRUNTIME/scripts.vim

behave mswin

" Sets how many lines of history VIM has to remember
set history=500

let mapleader = ","

" Enable filetype plugins
filetype plugin on
filetype indent on

set runtimepath^=~/bundle/ctrlp.vim
set runtimepath^=~/bundle/omnisharp-vim-master
"set runtimepath^=~/bundle/syntastic-master
set runtimepath^=~/bundle/vim-signature
set runtimepath^=~/bundle/vim-angular
set runtimepath^=~/bundle/vim-javascript
set runtimepath^=~/bundle/javascript-syntax
set runtimepath^=~/bundle/nerdtree-git-plugin
set runtimepath^=~/bundle/auto-pairs
"set runtimepath^=~/bundle/

" ===============
" Misc custom options

"toggle line wrap
map <F6> :set wrap!<CR>
"toggle whitespace chars
map <F7> :set list!<CR>
"copy current file path to clipboard
map <leader>cp :let @* = expand("%")<cr>
"force make session
nmap <leader>ms :mksession! ~\session.vim<cr>
map <leader>aa :tabe ~\_vimrc<cr>

"whitespaces config
set listchars=tab:>-,space:-,trail:.

" Tab headings 
function! SetGuiTabLabel()     
    let label = ''     
    let bufnrlist = tabpagebuflist(v:lnum)      
    " Add '+' if one of the buffers in the tab page is modified     
    for bufnr in bufnrlist         
        if getbufvar(bufnr, "&modified")             
            let label = '+'             
            break         
        endif     
    endfor      
    " Append the number of windows in the tab page if more than one     
    let wincount = tabpagewinnr(v:lnum, '$')     
    if wincount > 1         
        let label .= wincount     
    endif     
    if label != ''         
        let label .= ' '     
    endif      
    " Append the buffer name (not full path)     
    return label . "%t" 
endfunction  

set guitablabel=%SetGuiTabLabel()

" ===============

"""""""""""""""""""
"Doesn't work
"nerdtree git indicator Config
let g:NERDTreeIndicatorMapCustom = {     
            \ "Modified"  : "✹",     
            \ "Staged"    : "✚",     
            \ "Untracked" : "✭",     
            \ "Renamed"   : "➜",     
            \ "Unmerged"  : "═",     
            \ "Deleted"   : "✖",     
            \ "Dirty"     : "✗",     
            \ "Clean"     : "✔︎",     
            \ 'Ignored'   : '☒',     
            \ "Unknown"   : "?"     
            \ }

"""""""""""""""""""
"javascript syntax Config
let g:used_javascript_libs = 'underscore,backbone'
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 0
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1 
autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 0 
autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0 
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1

"""""""""""""""""""
"vim-javascript Config
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

"""""""""""""""""""
"vim-angular Config
let g:angular_find_ignore = ['build/', 'dist/', 'bin/', 'node_modules/', 'bower_components/']

"let g:syntastic_always_populate_loc_list = 1 
"let g:syntastic_auto_loc_list = 1 
"let g:syntastic_check_on_open = 0 
"let g:syntastic_check_on_wq = 0
"let g:syntastic_html_tidy_ignore_errors=['proprietary attribute \"ng-']

"""""""""""""""""""
"OmniSharp Config
let g:OmniSharp_server_stdio=1
"let g:syntastic_cs_checkers=['code_checker']
let g:OmniSharp_timeout=5
let g:OmniSharp_selector_ui='ctrlp'
let g:OmniSharp_highlight_types=2
let g:omnicomplete_fetch_full_documentation=1

set updatetime=200

set completeopt=longest,menuone,preview
set previewheight=5
augroup omnisharp_commands     
    autocmd!      
    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.     
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>     
    autocmd FileType cs nnoremap <buffer> <leader>fi :OmniSharpFindImplementations<CR>     
    autocmd FileType cs nnoremap <buffer> <leader>kd :OmniSharpGetCodeActions<CR>     
    autocmd FileType cs nnoremap <buffer> <leader>fs :OmniSharpFindSymbol<CR>     
    " Finds members in the current buffer     
    autocmd FileType cs nnoremap <buffer> <leader>fu :OmniSharpFindUsages<CR>      
    autocmd FileType cs nnoremap <buffer> <leader>fm :OmniSharpFindMembers<CR>      
    autocmd FileType cs nnoremap <buffer> <leader>fx :OmniSharpFixUsings<CR>     
    autocmd FileType cs nnoremap <buffer> <leader>tt :OmniSharpTypeLookup<CR>     
    autocmd FileType cs nnoremap <buffer> <leader>dc :OmniSharpDocumentation<CR>     
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>     
    " Navigate up and down by method/property/field     
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>      
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>     
    " Find all code errors/warnings for the current solution and populate the quickfix window     
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>      
    autocmd FileType cs nnoremap <buffer> <leader>cc :OmniSharpGlobalCodeCheck<CR> 
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available) 
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR> 

" Run code actions with text selected in visual mode to extract method 
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>  

" Rename with dialog 
nnoremap <Leader>nm :OmniSharpRename<CR> 
nnoremap <F2> :OmniSharpRename<CR> 

" Rename without dialog - with cursor on the symbol to rename: `:Rename newname` 
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")  

" Start the omnisharp server for the current solution 
nnoremap <Leader>cf :OmniSharpCodeFormat<CR>  
nnoremap <Leader>ss :OmniSharpStartServer<CR> 
nnoremap <Leader>sp :OmniSharpStopServer<CR>


" ===============
" Nerdtree options
" ===============

"map F2 to toggle nerdtree
map <F2> :NERDTreeToggle<CR>

"close vim if nerdtree is only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ===============

" Set to auto read when a file is changed from the outside
set autoread


" Fast saving
nmap <leader>w :w!<cr>

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

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
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Set line numbers
set nu

try
    colorscheme slate
catch
endtry

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Ctrl+P configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'

"excludes
set wildignore+=*\\.tmp\\*,*.zip,*.exe,*\\.nuget\\*,*\\.vscode\\*,*\\node_modules\\*,*\\bin\\*,*\\obj\\*,*\\build\\*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|tmp)$'
let g:ctrlp_switch_buffer = 'et'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /

" Disable highlight when <leader><cr> is pressed
map <silent> <leader>no :noh<cr>


" Window size appearance
augroup guiappearance
  au!
  :map <F9> :vertical resize +5<CR>
  :map <F8> :vertical resize -5<CR>
  :map <F10> :resize +5<CR>
  :map <F11> :resize -5<CR>
augroup END

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :tabn<cr>
map <leader>h :tabp<cr>

"open explorer on current dir
map <leader>od :!start .<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ PWD:\ %r%{getcwd()}%h\ \ p:\ %p\ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

"comment uncomment line
"
map <C-k>c :call Comment()<CR>
map <C-k>u :call Uncomment()<CR>

function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^/\#/
  elseif ext == 'js' || ext == 'cs'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^\#//
  elseif ext == 'js' || ext == 'cs'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  endif
endfunction


