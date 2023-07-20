set nocompatible
call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'pwntester/octo.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting
Plug 'williamboman/nvim-lsp-installer' " lsp installer
Plug 'neovim/nvim-lspconfig' " lsp config
Plug 'tomtom/tcomment_vim'
Plug 'Townk/vim-autoclose'
" Plug 'autozimu/LanguageClient-neovim'
" Plug 'neoclide/coc.nvim', {'branch': 'main', 'do': 'yarn install --frozen-lockfile'} TODO remove or remove lsp
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-markdown'
Plug 'machakann/vim-highlightedyank'
Plug 'michaeljsmith/vim-indent-object'
Plug 'airblade/vim-gitgutter'
Plug 'thoughtbot/vim-rspec'
" themes
Plug 'doums/darcula'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'
Plug 'kaicataldo/material.vim'
Plug 'embark-theme/vim'
call plug#end()

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

" todo files helpers
nnoremap <Leader>D :ClearTodoItemStatus<CR>A => DONE<ESC><CR>:noh<CR>
nnoremap <Leader>W :ClearTodoItemStatus<CR>A => WIP<ESC>:noh<CR>
nnoremap <Leader>U :ClearTodoItemStatus<CR>:noh<CR>0

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

set clipboard+=unnamed            " Copy and Paste from the system clipboard

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

command GitGutterDiffMaster :execute 'let g:gitgutter_diff_base = "main" | GitGutterAll'
command GitGutterDiffIndex :execute 'let g:gitgutter_diff_base = "" | GitGutterAll'

" todo helper
command ClearTodoItemStatus :execute ':silent! :s/\ \+=> \(DONE\|WIP\).*//g'

" exclude filename matches while searching in files
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

command Gc G commit
command Gca G commit --amend
command Gp G push
command Gpf G push --force

command Opr :call OctoEditCurrentPR()
command Oc :execute ':Octo pr checks'

function OctoEditCurrentPR()
  let prNumber = system("echo $(gh pr view --json number -t '{{.number}}')")
  :execute "Octo pr edit " . prNumber
endfunction

lua << EOF
  local lsp_installer = require("nvim-lsp-installer")

  lsp_installer.on_server_ready(function(server)
      local opts = { }
      return server:setup(opts)
  end)

  require"octo".setup()
EOF
