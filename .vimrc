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
" Plug 'vim-scripts/c.vim'
" Plug 'jupyter-vim/jupyter-vim'
Plug 'hellerve/carp-vim'
Plug 'uniquepointer/qbe.vim'
" Plug 'kovisoft/slimv'
" Plug 'JuliaEditorSupport/julia-vim'
Plug 'https://git.sr.ht/~sircmpwn/hare.vim'
Plug 'https://git.sr.ht/~torresjrjr/vim-haredoc'
Plug 'junegunn/fzf'
Plug 'vhda/verilog_systemverilog.vim'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'sotte/presenting.vim'
Plug 'hughbien/md-vim'
Plug 'tpope/vim-fugitive'

Plug '~/Documents/test2/vim-plugin/test1/test_plugin'

call plug#end()


let mapleader = ","

set number
" map <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <F5> :!pokreni.sh %<CR>
set tabstop=4
set shiftwidth=4
" set expandtab
" set background=dark
if has("gui_running")
	colorscheme desert
endif
" set guifont=Consolas:h9
set background=light
set hlsearch
" noh brise trenutno oznaceno
hi Visual ctermbg=darkgrey
hi Search cterm=NONE ctermfg=grey ctermbg=blue
nmap Y y$

" TODO: Skontati ovo, kopiranje ne radi
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
" TODO: Proveriti cemu ovo sluzi
" set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after


" Scheme REPL
" http://www.foldling.org/hacking.html#2012-08-05
" let scheme_repl_command = "tcc-csi"
nmap <C-c><C-s> :!st -e start-repl.sh tcc-csi &<CR>
nmap <C-c><C-o> :!st -e start-repl.sh ocaml &<CR>
nmap <C-c><C-c> vap:w >> repl<CR>
vmap <C-c><C-v> <ESC>:'<,'>w >> repl<CR>
nmap <C-c><C-r> vapG:'<,'>w >> repl<CR>
nmap <C-c><C-a> :w >> repl<CR>

" nmap <C-c><C-p> di()<Esc>P

command Gs :tab Git

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
autocmd BufRead,BufNewFile *.c,*.cpp,*.py,*.rs,*.h,*.sh,*.java,*.tex,*.scm,*.ml,*.ha
		\ highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd BufRead,BufNewFile *.c,*.cpp,*.py,*.rs,*.h,*.sh,*.java,*.tex,*.scm,*.ml,*.ha
		\ match OverLength /\%81v.\+/

autocmd BufRead,BufNewFile *.c,*.cpp,*.py,*.rs,*.h,*.sh,*.java,*.tex,*.scm,*.ml,*.ha
		\ highlight ColorColumn ctermbg=darkgray
autocmd BufRead,BufNewFile *.c,*.cpp,*.py,*.rs,*.h,*.sh,*.java,*.tex,*.scm,*.ml,*.ha
		\ setlocal colorcolumn=81

autocmd BufRead,BufNewFile *.vl setf verilog

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

set ttymouse=xterm2

" Definisanje okruženja
" :onoremap <silent> i$ :<C-U>normal! T$vt$<CR>
" :onoremap <silent> a$ :<C-U>normal! F$vf$<CR>


" Sledeca i prethodna pretraga
nnoremap <silent> cn :cn<cr>
" noremap <silent> co :co<cr>

" Fuzzy search for a file
nnoremap <silent> <C-l> :FZF<cr>

" TODO
" " Commenting blocks of code.
" augroup commenting_blocks_of_code
" 	autocmd!
" 	autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
" 	autocmd FileType sh,ruby,python   let b:comment_leader = '# '
" 	autocmd FileType conf,fstab       let b:comment_leader = '# '
" 	autocmd FileType tex              let b:comment_leader = '% '
" 	autocmd FileType mail             let b:comment_leader = '> '
" 	autocmd FileType vim              let b:comment_leader = '" '
" 	autocmd FileType julia            let b:comment_leader = '# '
" augroup END
" noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" v<izaberi tekst>p => menja izabrani tekst sadrzajem "
" Da bi postavio na određeni programski jezik, ukucaj :setf c
" Da bi birao koji pogodak se menja, dodati c na kraju, npr: s/a/b/gc

" PlugUpdate

" " TODO Coc Stuff

" " Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" " unicode characters in the file autoload/float.vim
" set encoding=utf-8
"
" " TextEdit might fail if hidden is not set.
" set hidden
"
" " Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup
"
" " Give more space for displaying messages.
" " set cmdheight=2
"
" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
" set updatetime=300
"
" " Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
"
" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif
"
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ CheckBackspace() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif
"
" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"
" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call ShowDocumentation()<CR>
"
" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction
"
" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
"
" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
"
" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
"
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
"
" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
"
" " Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)
"
" " Run the Code Lens action on the current line.
" nmap <leader>cl  <Plug>(coc-codelens-action)
"
" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)
"
" " Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif
"
" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)
"
" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocActionAsync('format')
"
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"
" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
