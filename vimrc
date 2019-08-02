set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'  " Git plugin, e.g. :Gblame and other useful commands
Plugin 'tpope/vim-surround'  " Useful tricks to change surrounding parentheses, quotes etc
Plugin 'rbgrouleff/bclose.vim'  " Close buffers with C-x etc
Plugin 'weynhamz/vim-plugin-minibufexpl'  " Show all open buffers and their state
Plugin 'ctrlpvim/ctrlp.vim'  " Fast fuzzy file finder
Plugin 'klen/python-mode'  " Python helper with automatic checks on save
Plugin 'flazz/vim-colorschemes'  " Easy change of color schemes
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}  " Beautiful statusline - might require extra fonts, see further below
Plugin 'google/yapf', { 'rtp': 'plugins/vim' }  " Show yapf style issues
Plugin 'zxqfl/tabnine-vim'
" Plugin 'Konfekt/FastFold'  " Create automatic folds in code - disabled due to perf issues

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif

let g:ctrlp_working_path_mode = 'ra'

if has("gui_gtk2")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h14,Droid\ Sans\ Mono\ 10,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
else
    set guifont=Source\ Code\ Pro\ for\ Powerline:h14,Andale\ Mono\ Regular:h12,Menlo\ Regular:h15,Consolas\ Regular:h12,Courier\ New\ Regular:h14
endif
set guioptions-=T

" For 'jump to definition' etc, install Ctags (e.g. in Ubuntu):
"     sudo apt-get install ctags
" You can setup periodic tag updates to your crontab e.g. like this:
"     */10 * * * * /usr/bin/ctags -R -o ~/sg_tags --exclude=*/build/* --exclude=*/node_modules/* ~/Code/Softagram
"     1 * * * * /usr/bin/ctags -R -f ~/pythontags `python -c \"from distutils.sysconfig import get_python_lib; print get_python_lib()\"` 2>/dev/null
" To jump to definition, use '<leader>g'
set tags=~/sg_tags;/,~/.vimtags,~/.pythontags,~/.vim/phptags/plustool

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

" Search for selected text using * and #, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" disable arrow keys in command mode - saves you from RSI and makes for a better Vim citizen ;)
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

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" Press <A7> to switch between two last buffers
:nnoremap <Char-167> :e#<CR>
:map <C-x> :Bclose<CR>
:map <A-C-x> :Bclose!<CR>
cnoreabbrev W w
cnoreabbrev bd Bclose
cnoreabbrev Bd Bclose

:map <Leader>f :CtrlP<CR>
:map <Leader>d :CtrlPBuffer<CR>
:map <Leader>F :CtrlP %:p:h<CR>
:map <C-p> :CtrlP<CR>

" Navigation inside file (functions, classes etc)
map <leader>2 [M
map <leader>3 ]M
map <leader>1 [C
map <leader>4 ]C

" Switch to prev/next buffer
map <leader>5 :bp<CR>
map <leader>6 :bn<CR>

" Surround string with ''s
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

colorscheme fruity
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Higlight trailing whitespaces
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!
highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+idonotcareforwhitespces$/
au InsertLeave * match ExtraWhitespace /\s\+$/

set foldlevel=99
let g:pymode_lint_ignore = ["E501"]

" FastFold config
" nmap zuz <Plug>(FastFoldUpdate)
" let g:fastfold_savehook = 1
" let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
" let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
" let g:tex_fold_enabled=1
" let g:vimsyn_folding='af'
" let g:xml_syntax_folding = 1
" let g:python_folding = 1
let g:pymode_python = 'python3'
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
let g:pymode_options_max_line_length = 99

autocmd FileType python set colorcolumn=100
highlight ColorColumn ctermbg=LightGreen
