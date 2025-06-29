"############################################################
set number
set autoindent
set showcmd
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
"set listchars=tab:>-
"set tabstop=5
"set list "set nolist
syntax on
highlight Function ctermfg=10
highlight Include ctermfg=161
se hlsearch
"#######################################################
nnoremap s o<Esc>
nnoremap S O<Esc>
nnoremap K i<Enter><Esc>l
"this is for comment/uncomment with # like in (python, bashscript)
nnoremap c :if getline('.')[0]=='#'<Enter>normal! 0x<Enter>else<Enter>normal! 0i#<Enter>endif<Enter><Enter>
"######
noremap <Tab> i<Tab><Esc>
noremap <BS> i<BS><Esc>
noremap <F1> i############################################################<Esc>
noremap <F2> i##### <Esc>
"#####
"#inoremap <c-h>
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-f> <delete>
inoremap <c-d> <BS>
inoremap <c-w> <c-o>db
noremap <c-w> db
"#inoremap <c-u>
noremap <c-u> d0
inoremap <c-k> <c-o>d$
noremap <c-k> d$ 
inoremap <c-a> <c-o>0
noremap <c-a> 0
inoremap <c-e> <c-o>$
noremap <c-e> $


"#####

"nnoremap <F9> 60i#<Esc>o'''<Enter>intro<Enter>'''<Enter><Esc>60i#<Esc>oimport time<Enter>t0=time.time()<Enter>#####<Enter>import sys,contextlib,os<Enter>#####<Enter>import multiprocessing as mp<Enter>from numba import jit,prange<Enter>#####<Enter>import numpy as np<Enter>import pandas as pd<Enter>import sympy as sym<Enter>import scipy as sp<Enter>import matplotlib.pyplot as plt<Enter>#import sklearn as sk<Enter>#import tensorflow as tf<Enter>#####<Enter>print('import time : {:.2f}'.format(time.time()-t0))<Enter><Esc>60i#<Esc>o<Esc>
"#####

"################
iabbrev im import
iabbrev pr print
iabbrev ti time.time()
"############
" Commenting blocks of code.
filetype on
autocmd BufNewFile,BufRead *.py let b:comment_leader = '// '
" setfiletype octopress

autocmd FileType c,cpp,java,scala :let b:comment_leader = '// '
autocmd FileType sh,ruby,python   :let b:comment_leader = '# '
autocmd FileType conf,fstab       :let b:comment_leader = '# '
autocmd FileType tex              :let b:comment_leader = '% '
autocmd FileType mail             :let b:comment_leader = '> '
autocmd FileType vim              :let b:comment_leader = '" '
noremap c :s/^/\=b:comment_leader<CR>
autocmd BufNewFile *.txt :let b:var = '1'
" autocmd BufRead *.txt :let b:var = '1'

