set nocompatible              " be iMproved, required
filetype off                  " required

if has("gui_gtk2")
    set guifont=Droid\ Sans\ Mono\ 10,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
else
    set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h15,Consolas\ Regular:h12,Courier\ New\ Regular:h14
endif
set guioptions-=T

set tags=set tags=./tags;/,~/.vimtags,~/.pythontags

syntax on

set hlsearch
set backspace=eol,start,indent
set incsearch
set hidden

set shiftwidth=4
set softtabstop=4
set expandtab
set nu

set backupdir=~/.vimswap,.,/tmp
set directory=.,~/.vimswap,/tmp

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" disable arrow keys in command mode
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
inoremap jk <ESC>
inoremap JK <ESC>
vnoremap > >gv
vnoremap < <gv
:let mapleader = ","
map <leader>g <C-]>
map <F11> :QFix<CR>

" Alt-j/k inserts blank line below/above.
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" Press § to switch between two last buffers
:nnoremap <Char-167> :e#<CR>
:map <C-x> :Bclose<CR>
:map <A-C-x> :Bclose!<CR>
cnoreabbrev W w
cnoreabbrev bd Bclose
cnoreabbrev Bd Bclose

" :map <Leader>f :CtrlP<CR>
" :map <Leader>d :CtrlPBuffer<CR>
" :map <Leader>F :CtrlP %%<CR>
let g:CommandTMaxFiles=50000
let g:CommandTFileScanner="git"
:map <Leader>f :CommandT<CR>
:map <Leader>d :CommandTBuffer<CR>
:map <Leader>F :CommandT %:p:h<CR>
:map <C-p> :CommandT<CR>


map <leader>2 [M
map <leader>3 ]M
map <leader>1 [C
map <leader>4 ]C
map <leader>5 :bp<CR>
map <leader>6 :bn<CR>
map <leader>s ysiw'

" Remove trailing whitespaces
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set foldlevel=99

let g:pymode_lint_checkers=['pyflakes', 'pep8']
let g:pymode_lint_config='~/.pylint.rc'
let g:pymode_lint_ignore="E501,W601,E302,F0401,C0302,I0011,C0301,E251,E221,C0326,C0111,E222,W0201,E128,C,R,W0702,E126,E127,W0511,E0611,W0703,E123,E125,E502"
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'klen/python-mode'
let g:pymode_rope = 0
"Bundle 'pythoncomplete'
Bundle 'python_match.vim'
Bundle 'leshill/vim-json'
Bundle 'groenewege/vim-less'
Bundle 'pangloss/vim-javascript'

"Bundle 'Shougo/neocomplcache'
"Bundle 'Valloric/YouCompleteMe'

"Bundle 'scrooloose/syntastic'
"Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-easymotion'

Bundle 'wincent/Command-T'
let g:CommandTCancelMap = "<Esc>"
"let g:CommandTSelectNextMap = ['<C-j>', '<ESC>OB']
"let g:CommandTSelectPrevMap = ['<C-k>', '<ESC>OA']
Bundle 'flazz/vim-colorschemes'

Bundle 'xolox/vim-misc'
"Bundle 'xolox/vim-easytags'
let g:easytags_async = 1
let g:easytags_syntax_keyword = 'always'

Bundle 'rbgrouleff/bclose.vim'

Bundle 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>

Bundle 'scrooloose/nerdcommenter'

Bundle 'mileszs/ack.vim'

Bundle 'fholgado/minibufexpl.vim'

call vundle#end()            " required
filetype plugin indent on

colorscheme fruity
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Higlight trailing whitespaces foo   
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!
highlight ExtraWhitespace ctermbg=red guibg=red  
au InsertEnter * match ExtraWhitespace /\s\+idonotcareforwhitespces$/
au InsertLeave * match ExtraWhitespace /\s\+$/ 
