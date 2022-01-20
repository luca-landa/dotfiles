set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'sheerun/vim-polyglot'
Plugin 'tomtom/tcomment_vim'
Plugin 'Townk/vim-autoclose'
Plugin 'autozimu/LanguageClient-neovim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-markdown'
Plugin 'machakann/vim-highlightedyank'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'airblade/vim-gitgutter'
Plugin 'thoughtbot/vim-rspec'
" themes
Plugin 'doums/darcula'
Plugin 'arcticicestudio/nord-vim'
Plugin 'rakr/vim-one'
Plugin 'kaicataldo/material.vim'
Plugin 'embark-theme/vim'
call vundle#end()

execute pathogen#infect()

" BEGIN solargraph config
" Tell the language client to use the default IP and port
" that Solargraph runs on
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['tcp://localhost:7658']
    \ }

" Don't send a stop signal to the server when exiting vim.
" This is optional, but I don't like having to restart Solargraph
" every time I restart vim.
let g:LanguageClient_autoStop = 0

" Configure ruby omni-completion to use the language client:
autocmd FileType ruby setlocal omnifunc=LanguageClient#complete
" END solargraph config

syntax enable
filetype plugin indent on

" set theme colorscheme
"set background=dark
"let g:airline_theme='material'
colorscheme embark

let mapleader = "," " change leader button
noremap <Leader>e :NERDTreeToggle<CR>
" search for files
nnoremap <silent> <Leader>o :Files<CR>
" search in files
nnoremap <silent> <Leader>f :Rg<CR>
" show currently edited git files
nnoremap <silent> <Leader>gf :GFiles?<CR>
" see current commits
nnoremap <silent> <Leader>c :Commits<CR>
" show commits history for current file
noremap <silent> <Leader>b :BCommits<CR>
" fuzzy search lines in current file/buffer
noremap <silent> <Leader>/ :BLines<CR> 

" go to next buffer
nnoremap <silent> <C-h> :bp<CR>
" go to previous buffer
nnoremap <silent> <C-l> :bn<CR>
" close current buffer without closing the window
noremap <Leader>w :CloseCurrentBufferAndSwitchToPreviousOne<CR>

" set gitgutter to show diff with master
nnoremap ggdm :GitGutterDiffMaster<CR>
" set gitgutter to show diff with index
nnoremap ggdi :GitGutterDiffIndex<CR>

nnoremap <Leader>rsf :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rsn :call RunNearestSpec()<CR>
nnoremap <Leader>rsl :call RunLastSpec()<CR>
nnoremap <Leader>rsa :call RunAllSpecs()<CR>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" clear highlighting
nnoremap <Leader>h :noh<CR>

if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

set ma " allow vim to create/modify/delete files
set ruler " show the ruler
set number   " show line numbers
set showcmd " Show (partial) command in status line.
set showmatch " Show matching brackets.
set incsearch " Incremental search
set mouse=a " Enable mouse usage (all modes)
set hlsearch " Enable all occurrences of current search
set encoding=utf-8 " Use Utf-8 enconding
set termguicolors " improve theme colors
set hidden " hide unsaved buffer warnings on buffer switch
set autoread " automatically read a file if modified outside of Vim

" set terminal title to working dir
set title " autoset terminal title
let g:session_title=expand("%:p:h:t")
set titlestring=%{g:session_title} " if set directly w/o a variable, the value changes at every file opening

" Use 2 characters space only indentation
set expandtab
set shiftwidth=2
set softtabstop=2

" replace vim grep usage with a custom rg command, case insensitively and
" following symbolic links 
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:NERDTreeWinSize = 40
let g:NERDTreeAutoDeleteBuffer = 1 " automatically delete related buffer when deleting a file via NERDTree
let g:highlightedyank_highlight_duration = 200
let g:airline#extensions#tabline#enabled = 1 "enable buffers showing as tabs

:au FocusLost * silent! wa " autosave titled buffers on focus lost
:au BufLeave * silent! wa " autosave titled buffers on buffer leave
:au FocusGained * checktime  " autoread file on focus gain, works with 'set autoread'

autocmd VimEnter * NERDTreePassiveFocus
autocmd VimEnter * SyncNERDTreeWithFileOpens " If set directly in the script, on the first open the window focus doesn't revert correctly

command NERDTreePassiveFocus :execute ':NERDTreeFind | wincmd p'
command SyncNERDTreeWithFileOpens :execute ':au BufWinEnter * :silent NERDTreePassiveFocus'
command W :execute ':silent w !sudo tee % > /dev/null' | :edit! " Add :W command to save as root (sudo write)
command CloseCurrentBufferAndSwitchToPreviousOne :execute ':b#|:bd#' 

command GitGutterDiffMaster :execute 'let g:gitgutter_diff_base = "master" | GitGutterAll'
command GitGutterDiffIndex :execute 'let g:gitgutter_diff_base = "" | GitGutterAll'

" exclude filename matches while searching in files
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
