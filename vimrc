set autoread
set background=dark
set colorcolumn=100
set encoding=utf8
set expandtab
set exrc
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:\ \ ,
set mouse=a
set nocp
set noshowmode
set number
set secure
set shiftwidth=4
set showcmd
set smartcase
set softtabstop=4
set splitbelow
set t_Co=16
set tabstop=4
set fileencodings=utf8,iso-2022-jp,euc-jp,cp932,default,latin1
set ttimeoutlen=20
set updatetime=250

let g:lightline = {
\   'colorscheme': 'solarized',
\   'active': {
\     'left': [
\       ['mode', 'paste'],
\       ['readonly', 'filename']
\     ],
\     'right': [
\       ['linterstatus'],
\       ['lineinfo'],
\       ['fileinfo', 'filetype'],
\     ]
\   },
\   'component_function': {
\     'fileinfo': 'LightlineFileinfo',
\     'filename': 'LightlineFilename',
\     'linterstatus': 'LinterStatus'
\   }
\ }

function! LightlineFileinfo()
  if &filetype ==# 'netrw' || (&fileencoding ==# 'utf-8' && &fileformat ==# 'unix')
    return ''
  endif
  return &fileencoding . '[' . &fileformat . ']'
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? '+' : ''
  return filename . modified
endfunction

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? 'OK' : printf('%dW %dE', all_non_errors, all_errors)
endfunction

colorscheme solarized
filetype plugin indent on
highlight SpecialKey ctermbg=0
syntax enable

autocmd BufEnter * EnableStripWhitespaceOnSave
autocmd BufNewFile,BufRead *.es6 setlocal filetype=javascript
autocmd BufNewFile,BufRead *.mako setlocal filetype=html
autocmd CompleteDone * pclose
autocmd FileType vue syntax sync fromstart
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Explore | endif

let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

function! Setguifont(...)
  set guifont=Meslo\ LG\ S\ for\ Powerline:h14
endfunction

if has('gui_running')
  if has('macunix')
    call Setguifont()
    nnoremap <F9> :call Setguifont()<CR>
  elseif has('unix')
    set guifont=Liberation\ Mono\ for\ Powerline\ 12
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
  endif
endif
