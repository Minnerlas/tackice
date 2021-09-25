" The default vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Oct 27
"
" This is loaded if no vimrc file was found.
" Except when Vim is run with "-u NONE" or "-C".
" Individual settings can be reverted with ":set option&".
" Other commands can be reverted as mentioned below.

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when Vim was compiled with the +eval feature.
if 1

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif



" ==========================================================================
" 								Moje izmene


if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/c.vim'
Plug 'jupyter-vim/jupyter-vim'
Plug 'hellerve/carp-vim'
Plug 'uniquepointer/qbe.vim'
Plug 'kovisoft/slimv'

call plug#end()


let mapleader = ","

set number
map <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <F5> :!~/wm/skripte/pokreni.sh %<CR>
set tabstop=4
set shiftwidth=4
" set background=dark
if has("gui_running")
	colorscheme desert
endif
" set guifont=Consolas:h9
set background=light
hi Visual ctermbg=darkgrey
nmap Y y$

" TODO: Skontati ovo
" vnoremap <C-c> "*y :let @+=@*<CR>
map <C-p> "+p
tnoremap <ESC><ESC> <C-\><C-N>

set splitbelow
set splitright

" set colorcolumn=110
" highlight ColorColumn ctermbg=darkgray

let g:Tex_PromptedEnvironments = ""
let NERDTreeHijackNetrw=0
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

let scheme_repl_command = "tcc-csi"

" Scheme REPL
" http://www.foldling.org/hacking.html#2012-08-05
nmap <C-c><C-s> :!st -e start-repl.sh tcc-csi &<CR>
nmap <C-c><C-c> vap:w >> repl<CR>
vmap <C-c><C-v> <ESC>:'<,'>w >> repl<CR>

" Tabovi
autocmd FileType scheme setlocal shiftwidth=2 softtabstop=2 expandtab

" Tipovi fajlova
autocmd BufRead,BufNewFile *.sld setf scheme

" Visak praznog
autocmd BufRead,BufNewFile *.* highlight TrailingWhiteSp ctermbg=red ctermfg=white guibg=#592929
autocmd BufRead,BufNewFile *.* match TrailingWhiteSp /\s\+$/
autocmd InsertEnter *.* match TrailingWhiteSp /\s\+\%#\@<!$/
autocmd InsertLeave *.* match TrailingWhiteSp /\s\+$/

" 80 karaktera po redu
autocmd BufRead,BufNewFile *.c,*.cpp,*.py,*.rs,*.h,*.sh,*.java,*.tex,*.scm
		\ highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd BufRead,BufNewFile *.c,*.cpp,*.py,*.rs,*.h,*.sh,*.java,*.tex,*.scm
		\ match OverLength /\%81v.\+/

autocmd BufRead,BufNewFile *.c,*.cpp,*.py,*.rs,*.h,*.sh,*.java,*.tex,*.scm
		\ highlight ColorColumn ctermbg=darkgray
autocmd BufRead,BufNewFile *.c,*.cpp,*.py,*.rs,*.h,*.sh,*.java,*.tex,*.scm
		\ setlocal colorcolumn=81


autocmd BufRead,BufNewFile *.qbe,*.ssa setf sh
let g:is_chicken = 1

let g:termdebug_wide=100
noremap <silent> <leader>td :packadd termdebug<cr>:Termdebug<cr>
" Add mappings for :Step and :Over
noremap <silent> <leader>s :Step<cr>
noremap <silent> <leader>o :Over<cr>
noremap <silent> <leader>n :Next<cr>
noremap <silent> <leader>b :Break<cr>
noremap <silent> <leader>r :Run<cr>
noremap <silent> <leader>c :Cont<cr>

" Definisanje okruženja
" :onoremap <silent> i$ :<C-U>normal! T$vt$<CR>
" :onoremap <silent> a$ :<C-U>normal! F$vf$<CR>



" Da bi postavio na određeni programski jezik, ukucaj :setf c

" PlugUpdate
