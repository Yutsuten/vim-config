filetype plugin indent on
set nocp
set showcmd
set ignorecase
set smartcase
set hlsearch
set incsearch
set updatetime=250
set colorcolumn=100
set number
set noshowmode
set splitbelow
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hidden
set mouse=a
set autoread
set exrc
set secure
set laststatus=2
set ttimeoutlen=20
syntax enable

set fileencodings=utf8,iso-2022-jp,euc-jp,cp932,default,latin1
set encoding=utf8

set t_Co=16
set background=dark
colorscheme solarized

let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z = '%2l/%L ln : %02v'

autocmd BufNewFile,BufRead *.es6 setlocal filetype=javascript
autocmd BufNewFile,BufRead *.mako setlocal filetype=html
autocmd BufEnter * EnableStripWhitespaceOnSave
autocmd CompleteDone * pclose
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Explore | endif
autocmd FileType vue syntax sync fromstart

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
