set nocompatible
filetype off

" Vundle setup {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" Vundle plugins {{{
" All of your Plugins must be added before the following line
Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1
Plugin 'scrooloose/syntastic'
Bundle 'jdonaldson/vaxe'
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'wincent/command-t'
" }}} 

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
" }}}

syntax on

" colorscheme and customizations {{{
colorscheme inkpot
hi CursorLine term=none cterm=none gui=none
" no CursorLine highlighting, just the line number coloring.
" previously used: ctermbg=233 guibg=#121212
hi ColorColumn ctermbg=black guibg=black
hi Folded ctermbg=54 guibg=Purple4
hi MatchParen cterm=none ctermbg=17 ctermfg=cyan
" }}} 

" set variables {{{
set colorcolumn=80
set cursorline
set gdefault
set hidden
set ignorecase
set laststatus=2  " always show status line
set number
set omnifunc=syntaxcomplete#Complete
set smartcase
let g:syntastic_coffee_checkers = ["coffeelint"]
let g:syntastic_js_checkers = ["jshint"]
let g:syntastic_python_checkers = ["python", "flake8"]
" let g:syntastic_python_python_exec = '/usr/bin/python3'
set t_Co=256
set wildignore+=*.pyc,htmlcov
set wildmode=longest,list,full
set wildmenu
" }}}

let mapleader = " "
let maplocalleader = ","
" remap keys {{{
nnoremap <leader># :buffer #<cr>
inoremap ,, <esc>
nnoremap <leader>1 :!!<cr>
nnoremap <leader>b :buffer 
nnoremap <leader>ve :split $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
nnoremap <leader>w :write<cr>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" }}}

" Abbreviations {{{
ab pyft from __future__ import (absolute_import, division, print_function, unicode_literals)<cr>from builtins import (ascii, bytes, chr, dict, filter, hex, input, str, super, zip)
" }}}

" Vimscript file settings {{{
augroup filetype_coffee
    autocmd!
    autocmd FileType coffee compiler cake
    autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=4 expandtab
    autocmd FileType coffee setlocal foldmethod=indent nofoldenable
    autocmd FileType coffee xnoremap <localleader>c :CoffeeCompile<CR>
    autocmd FileType coffee nnoremap <localleader>c :CoffeeCompile<CR>
augroup END
augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim nnoremap <localleader>z O" <esc>i}<esc>..
augroup END
" }}}

" Omni-completion settings {{{
augroup omnicomplete_custom
    autocmd!
    " auto-close tip window on movement in insert mode, or when leaving insert
    " mode
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END
" }}}

" Python PEP 8-compliance settings {{{
set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
" }}}

" Vim Addon Manager setup {{{
fun! SetupVAM()
    let c = get(g:, 'vim_addon_manager', {})
    let g:vim_addon_manager = c
    let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
    let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
    " let g:vim_addon_manager = { your config here see "commented version" example and help
    if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
                \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
    endif
    " VAM addons {{{
    "" call vam#ActivateAddons(["vim-haxe"], {'auto_install' : 0})
    " }}}
    " Also See "plugins-per-line" below
endfun
call SetupVAM()
" }}}
