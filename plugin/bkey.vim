"        ____
"       / __ )  __
"      / __  | / /_____ __ __
"     / /_/ / /  '_/ -_) // /
"    /_____/ /_/\_\\__/\_, /
"                     /___/

" File:         bkey.vim
" Description:  Vim key-binding that SuperB
" Author:       Sakashi_NNB
"                 └─ https://github.com/SakashiNNB
" URL:
" License:      GPLv3

"    This program is free software: you can redistribute it and/or modify
"    it under the terms of the GNU General Public License as published by
"    the Free Software Foundation, either version 3 of the License, or
"    (at your option) any later version.
"
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
"
"    You should have received a copy of the GNU General Public License
"    along with this program.  If not, see <https://www.gnu.org/licenses/>.


" Setting {{{

" Auto and smart tab
set autoindent
set smarttab

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Configure so it acts as it should act
set whichwrap=<,>,h,l,[,]
set list listchars=tab:▏\ ,trail:·
set formatoptions+=j
setglobal tags-=./tags tags-=./tags; tags^=./tags;

" Limit the files searched for auto-completes
set complete-=i

" Display a confirmation dialog when closing an unsaved file
set confirm
set viewoptions-=options

" No timeout
set notimeout

" Mouse support
set mouse=a

" Clipboard support
set clipboard=unnamedplus

" Prevent escape from moving the cursor one character to the left
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" Set free-range cursor in V-Block mode
set virtualedit=onemore,block

" make cursor in visual mode mode to wright place
set selection=exclusive

" }}}

" Values {{{

" #FIXME add ' key
let s:bkeyu = map(range(char2nr('a'), char2nr('x')), 'nr2char(v:val)')
let s:bkeyl = map(range(char2nr('A'), char2nr('Z')), 'nr2char(v:val)')
let s:bkeynum = map(range(char2nr('0'), char2nr('9')), 'nr2char(v:val)')
let s:bkeyctrl = ['z', 'x', 'c', 'v', 'y', 'a', 'f', 'n', 'p', 'u', 'e', 'g', 'l', 'k', 'r', 'w', 'd', 'q', 't', 'o', 's', ']']
let s:bkeys = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', ',', '<', '.', '>', ';', ':', '"', '/', '?', '-', '_', '=', '+', '[', '{', ']', '}', '`', '~']
let s:bkeymove = ['Up', 'Down', 'Left', 'Right', 'Home', 'End', 'Pageup', 'Pagedown']
let s:bkeyact = ['Space', 'Bslash', 'Bar', 'Esc', 'CR', 'Tab', 'BS', 'Del', 'Insert', 'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'F10', 'F11', 'F12']
let s:bkeykey = s:bkeymove + s:bkeyact
let s:bkeyc = s:bkeyu + s:bkeyl
let s:bkeycn = s:bkeyc + s:bkeynum
let s:bkeya = s:bkeycn + s:bkeys
let s:bkeyreg = s:bkeycn+['"', '-', ':', '.', '%', '#', '=', '*', '+', '~', '_', '/']

" User settings
let g:bkey_insertmode = 0
let g:bkey_keepsele_copy = 0
let g:bkey_keepsele_move = 1
let g:bkey_keepsele_case = 0
let g:bkey_keepsele_math = 1
let g:bkey_info = 0
let g:bkey_seek = 1

  " }}}

" Functions {{{

" BKeyInsertmode {{{

" Toggle
function! BKeyInsertmode()
	if ( g:bkey_insertmode == '0' )
		call BKeyInsertmodeOn()
	else
		call BKeyInsertmodeOff()
	endif
endfunction

"On
function! BKeyInsertmodeOn()
	let g:bkey_insertmode = 1
	set insertmode
	nnoremap <Space> :set<Space>insertmode<CR>
	nnoremap <M-Space> :set<Space>insertmode<CR>
	inoremap <M-Space> <C-o>:set<Space>noinsertmode<CR>
	nnoremap <Esc> :set<Space>insertmode<CR>
endfunction

"Off
function! BKeyInsertmodeOff()
	let g:bkey_insertmode = 0
	set noinsertmode
	nnoremap <Space> <Insert>
	nnoremap <M-Space> <Insert>
	inoremap <M-Space> <Esc>
	nnoremap <Esc> <Esc>
endfunction

" }}}

" BKeyInsertone #TODO
function! BKeyInsertone()
	execute 'call feedkeys("\' . v:count . '<Insert>' . getchar() . '<Esc>","n")'
endfunction

" Bol #TODO
function! BKeyBol()
  if ( col('.') != '1' )
    let l:bkeybol_old = getpos('.')
    "call feedkeys("\^",'n')
    normal! ^
    let l:bkeybol_new = getpos('.')
    if ( l:bkeybol_old == l:bkeybol_new )
      call feedkeys("\<Home>",'n')
    else
      call feedkeys("\^",'n')
    endif
  endif
endfunction

" Font size
if has("unix")
	function! BKeyFontSizePlus()
		let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
		let l:gf_size_whole = l:gf_size_whole + 1
		let l:new_font_size = ' '.l:gf_size_whole
		let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
	endfunction
	function! BKeyFontSizeMinus()
		let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
		let l:gf_size_whole = l:gf_size_whole - 1
		let l:new_font_size = ' '.l:gf_size_whole
		let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
	endfunction
else
	function! BKeyFontSizePlus()
		let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
		let l:gf_size_whole = l:gf_size_whole + 1
		let l:new_font_size = ':h'.l:gf_size_whole
		let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
	endfunction
	function! BKeyFontSizeMinus()
		let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
		let l:gf_size_whole = l:gf_size_whole - 1
		let l:new_font_size = ':h'.l:gf_size_whole
		let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
	endfunction
endif

" Info
function! BKeyInfo()
	if ( g:bkey_info == '0' )
		let g:bkey_info = 1
		set laststatus=2
		set noshowmode
		set cmdheight=2
		set signcolumn=yes
	else
		let g:bkey_info = 0
		set laststatus=0
		set showmode
		set cmdheight=1
		set signcolumn=auto
	endif
	execute "normal! \<C-l>"
endfunction

" }}}

" Unmap {{{

for key in s:bkeykey
	for modemap in ['', '!']
		for holding in ['', 'S-', 'C-']
			execute 'noremap' . modemap . '<' . holding  . key . '> <Nop>'
		endfor
	endfor
endfor

for key in s:bkeya
	execute 'noremap ' . key . ' <Nop>'
endfor

for key in s:bkeyctrl
	for modemap in ['', '!']
		execute 'noremap' . modemap . ' <C-' . key . '> <Nop>'
	endfor
endfor

noremap <Leader> <Nop>

noremap ' <Nop>

" Plug-ins
let g:no_plugin_maps = 1

" }}}

" Operation {{{

" Numbers
noremap 0 99999
noremap 1 1
noremap 2 2
noremap 3 3
noremap 4 4
noremap 5 5
noremap 6 6
noremap 7 7
noremap 8 8
noremap 9 9

" Leader
let mapleader = "t"
let maplocalleader = "T"

" Text objects {{{

" Inner
onoremap aJ iw
onoremap aL iw
onoremap aI ip
onoremap aK ip
onoremap au iW
onoremap ao iW
onoremap a/ it
onoremap a" i"
onoremap a' i'
onoremap a` i`
onoremap a( ib
onoremap a) ib
onoremap a[ i[
onoremap a] i]
onoremap a{ i{
onoremap a} i}
onoremap a< i<
onoremap a< i>
vnoremap aJ iw
vnoremap aL iw
vnoremap aI ip
vnoremap aK ip
vnoremap au iW
vnoremap ao iW
vnoremap a/ it
vnoremap a" i"
vnoremap a' i'
vnoremap a` i`
vnoremap a( ib
vnoremap a) ib
vnoremap a[ i[
vnoremap a] i]
vnoremap a{ i{
vnoremap a} i}
vnoremap a< i<
vnoremap a< i>
vnoremap aN gn

" Outer
onoremap AJ aw
onoremap AL aw
onoremap AI ap
onoremap AK ap
onoremap Au aW
onoremap Ao aW
onoremap A/ at
onoremap A" a"
onoremap A' a'
onoremap A` a`
onoremap A( ab
onoremap A) ab
onoremap A[ a[
onoremap A] a]
onoremap A{ a{
onoremap A} a}
onoremap A< a<
onoremap A< a>
vnoremap AJ aw
vnoremap AL aw
vnoremap AI ap
vnoremap AK ap
vnoremap Au aW
vnoremap Ao aW
vnoremap A/ at
vnoremap A" a"
vnoremap A' a'
vnoremap A` a`
vnoremap A( ab
vnoremap A) ab
vnoremap A[ a[
vnoremap A] a]
vnoremap A{ a{
vnoremap A} a}
vnoremap A< a<
vnoremap A< a>
vnoremap aM gN

" }}}

" }}}

" Modes {{{

" Normal
noremap <Esc> <Esc>

" Command
noremap ; :
noremap : Q

" Terminal
noremap ` :!
noremap ~ <C-z>

" Find & Replace
noremap h /
vnoremap h /\%V
noremap <Leader>h #*
vnoremap <Leader>h ""y/<C-r>"<CR>N
noremap H :.,$s///gc<Left><Left><Left><Left>
vnoremap H :s/\%V//gc<Left><Left><Left><Left>
noremap <Leader>H :%s/<C-r><C-w>//gc<Left><Left><Left>
vnoremap <Leader>H ""y:%s/<C-r>"//gc<Left><Left><Left>

" Insert
noremap <Space> <Insert>
vnoremap <Space> ""c
noremap r<Space> :call<Space>BKeyInsertmode()<CR>
nnoremap <CR> <Insert>_<Esc>r
vnoremap <CR> r

" Replace
noremap <S-Space> R
vnoremap <S-Space> ""c
noremap <S-CR> r
noremap <Insert> R
vnoremap <Insert> ""c
noremap <C-Insert> r

" Visual
noremap s v
vnoremap s V
noremap S <C-v>

" }}}

" Movements {{{

" Industry {{{

noremap <Up> g<Up>
noremap <Down> g<Down>
noremap <Left> <Left>
noremap <Right> <Right>
noremap <C-Up> <Up>
noremap <C-Down> <Down>
noremap <C-Left> b
noremap <C-Right> e
nnoremap <C-Right> e<Right>

inoremap <Up> <C-o>g<Up>
inoremap <Down> <C-o>g<Down>
inoremap <Left> <Left>
inoremap <Right> <Right>
inoremap <C-Up> <Up>
inoremap <C-Down> <Down>
inoremap <C-Left> <S-Left>
inoremap <C-Right> <C-o>e<Right>

noremap <Home> <Home>
noremap <End> <End>
noremap <Pageup> <Pageup>
noremap <Pagedown> <Pagedown>
noremap <C-Home> <C-Home>
noremap <C-End> <C-End>
vnoremap <C-End> <C-End><Right>
noremap <C-Pageup> <C-Pageup>
noremap <C-Pagedown> <C-Pagedown>

noremap <M-Left> <<
vnoremap <M-Left> <gv
noremap <M-Right> >>
vnoremap <M-Right> >gv
noremap <silent> <M-Up> :m<Space>.-2<CR>
vnoremap <silent> <M-Up> :m<Space>'<-2<CR>gv
noremap <silent> <M-Down> :m<Space>.+1<CR>
vnoremap <silent> <M-Down> :m<Space>'>+1<CR>gv

for key in s:bkeymove
	execute 'nnoremap <S-' . key . '> v<' . key . '>'
	execute 'vnoremap <' . key . '> <Esc><' . key . '>'
	execute 'vnoremap <S-' . key . '> <' . key . '>'
	execute 'nmap <S-C-' . key . '> s<C-' . key . '>'
	execute 'vmap <C-' . key . '> <Esc><C-' . key . '>'
	execute 'vmap <S-C-' . key . '> <C-' . key . '>'
	execute 'noremap! <' . key . '> <' . key . '>'
	execute 'noremap! <C-' . key . '> <S-' . key . '>'
	execute 'noremap! <S-' . key . '> <S-' . key . '>'
	execute 'imap <S-' . key . '> <M-CR><S-' . key . '>'
	execute 'imap <S-C-' . key . '> <M-CR>s<C-' . key . '>'
	execute 'imap <M-' . key . '> <M-CR><M-' . key . '>'
endfor

noremap <F1> K
noremap <F3> N
noremap <F4> n
noremap <F9> :tabedit<Space>$HOME/.config/nvim/init.vim<CR>

" }}}

" Simple {{{

" #FIXME line-wrap move left to upper line true far right
"        visual mode cursor befor selection
noremap i g<Up>
noremap <Leader>i <Up>
noremap k g<Down>
noremap <Leader>k <Down>
noremap j <Left>
noremap l <Right>
noremap I {
noremap K }
noremap J b
noremap L e
nnoremap L e<Right>

" }}}

" Advance {{{

noremap u B
noremap o E
nnoremap o E<Right>
noremap U <Pageup>
noremap O <Pagedown>
noremap n n
noremap N N
noremap m ^
noremap M <End>
nnoremap M <End>g<End>
noremap <Leader>m g<Home>
noremap <Leader>M g<End>

" }}}

" Goto {{{

" Simple
noremap gg <C-Home>
noremap G <C-End>
nnoremap G <C-End><Right>

" Advance
noremap gI (
noremap gK )
noremap gJ <Left>ge
nnoremap gJ <Left>ge<Right>
noremap gL w
nnoremap gL w<Right>
noremap gu <Left>gE
nnoremap gu <Left>gE<Right>
noremap go W
noremap gm <Home>
noremap gM <End>
noremap gd [c
noremap gD ]c
noremap gf g;
noremap gF g,

" Visual
noremap gs gv
vnoremap gs o
noremap gS gv
vnoremap gS O

" Folds
noremap g'm [z
noremap g'M ]z

" Quick jump
nmap g<Space> f
nmap g<S-Space> F
nmap g<Insert> F
nmap g<CR> t
nmap g<S-CR> T
nmap g<C-Insert> T

" }}}

" Next & previous {{{

noremap [d [c
noremap ]d ]c
noremap [h N
noremap ]h n
noremap [, [`
noremap ], ]`
noremap <Leader>[, ['
noremap <Leader>], ]'
noremap [' [z
noremap ]' ]z
noremap [" [*
noremap ]" ]*
noremap [/ [#
noremap ]/ ]#
noremap [? [s
noremap ]? ]s

noremap { ,
noremap } ;

" }}}

" Mark {{{

noremap , `
noremap <Leader>, '
noremap ,, '
noremap < m

" }}}

" }}}

" Actions {{{

" Deletes {{{

noremap <BS> ""X
vnoremap <BS> ""<Del>
noremap <Del> ""x
vnoremap <Del> ""<Del>
noremap d ""X
vnoremap d ""<Del>
noremap D ""x
vnoremap D ""<Del>
noremap e ""d
onoremap e d
noremap E ""d
nnoremap E ""d<End>
onoremap E d<End>

" Change {{{

noremap w ""c
nnoremap W ""c<End>
onoremap w c
onoremap W c<End>

" Register
for char in s:bkeyreg
	execute 'noremap R' . char . 'w "' . char . 'c'
	execute 'noremap R' . char . 'W "' . char . 'c'
	execute 'nnoremap R' . char . 'W "' . char . 'c<End>'
	execute 'vnoremap W' . char . ' "' . char . 'c'
endfor

" }}}

" }}}

" Clipboards {{{

" Register
noremap R "

" Copy {{{

noremap c y
nnoremap C y<End>
onoremap C y<End>

" Register
for char in s:bkeyreg
	execute 'vnoremap C' . char . ' "' . char . 'y'
endfor

" Keep selection
if (g:bkey_keepsele_copy == '1')
  vnoremap c ygv
	for char in s:bkeyreg
		execute 'vnoremap C' . char . ' "' . char . 'ygv'
	endfor
endif

" }}}

" Cut " {{{

noremap x d
nnoremap X d<End>
onoremap X d<End>

" Register
for char in s:bkeyreg
	execute 'vnoremap X' . char . ' "' . char . 'd'
endfor

" }}}

" Paste {{{

noremap v gP
vnoremap v ""<Del>gP
noremap V gP`[
vnoremap V ""<Del>gP`[

" Register
for char in s:bkeyreg
	execute 'vnoremap R' . char . 'v ""<Del>"' . char . 'gP'
	execute 'vnoremap R' . char . 'V ""<Del>"' . char . 'gP`['
endfor

" }}}

" }}}

" Line edits {{{

" Open Lines
noremap p o
vnoremap p ""c<CR>
noremap P O
vnoremap P p ""c<CR>

" Join lines
noremap aa J
noremap a<Space> I
noremap AA gJ
noremap A<Space> A

" Moves {{{

" #FIXME move with count
noremap bi :m<Space>.-2<CR>
vnoremap bi :m<Space>'<-2<CR>
noremap bk :m<Space>.+1<CR>
vnoremap bk :m<Space>'>+1<CR>
noremap bj <<
vnoremap bj <
noremap bl >>
vnoremap bl >
noremap br ==
vnoremap br =

" Keep selection
if (g:bkey_keepsele_move == '1')
	vnoremap br =gv
	vnoremap bi :m<Space>'<-2<CR>gv
	vnoremap bk :m<Space>'>+1<CR>gv
	vnoremap bj <gv
	vnoremap bl >gv
endif

" }}}

" }}}

" Case {{{

noremap B g~<Right>
noremap <Leader>bi gU
noremap <Leader>bk gu
noremap <Leader>br g~
noremap <Leader>bbi <Home>gU<End>
noremap <Leader>bbk <Home>gu<End>
noremap <Leader>bbr <Home>g~<End>
noremap <Leader>Bi gU<End>
noremap <Leader>Bk gu<End>
noremap <Leader>Br g~<End>
vnoremap Bi U
vnoremap Bk u
vnoremap Br ~
vnoremap <Leader>bi U
vnoremap <Leader>bk u
vnoremap <Leader>br ~
vnoremap <Leader>bbi U
vnoremap <Leader>bbk u
vnoremap <Leader>bbr ~
vnoremap <Leader>Bi U
vnoremap <Leader>Bk u
vnoremap <Leader>Br ~

" Keep selection
if (g:bkey_keepsele_case == '1')
	vnoremap Bi Ugv
	vnoremap Bk ugv
	vnoremap Br ~gv
	vnoremap <Leader>bi Ugv
	vnoremap <Leader>bk ugv
	vnoremap <Leader>br ~gv
	vnoremap <Leader>bbi Ugv
	vnoremap <Leader>bbk ugv
	vnoremap <Leader>bbr ~gv
	vnoremap <Leader>Bi Ugv
	vnoremap <Leader>Bk ugv
	vnoremap <Leader>Br ~gv
endif

" }}}

" Comments
map " <plug>NERDCommenterToggle

" Codes
noremap / <C-]>

" Spell-checks
noremap ?? z=
noremap ?n ]s
noremap ?N [s
noremap ?[ [s
noremap ?] ]s
noremap ?d zg
noremap ?D zG
noremap ?f zw
noremap ?F zW
noremap ?zd zug
noremap ?zD zuG
noremap ?zf zuw
noremap ?zF zuW

" Math {{{

noremap _ <C-x>
noremap + <C-a>

" Keep selection
if (g:bkey_keepsele_math == '1')
	vnoremap _ <C-x>gv
	vnoremap + <C-a>gv
endif

" }}}

" }}}

" Environment {{{

" Undo
noremap z <Undo>
noremap Z <C-r>
noremap f <Undo>
noremap F <C-r>

" Repeat
noremap rr .
noremap r; @:
noremap rH g&
noremap ry @@

" Macros
noremap y @
noremap Y q

" Files
noremap <Leader>, :e<Space>
noremap . :w<CR>
noremap > :w<Space>

" }}}

" Views {{{

" Info
" #TODO q key
noremap Q :call<Space>BKeyInfo()<CR>

" Fold
noremap '' za
noremap <Leader>'' zA
noremap 'm [z
noremap 'M ]z
noremap 'd zv
noremap <Leader>'d zO
noremap 'D zR
noremap 'f zc
noremap <Leader>'f zC
noremap 'F zM
noremap 'u zx
noremap <Leader>'u zX
noremap '- zm
noremap '_ zm
noremap '= zr
noremap '+ zr
noremap 'p zf
noremap 'P zF
noremap 'x zd
noremap 'X zD
noremap <Leader>'X zE
noremap '<BS> zd
noremap <Leader>'<BS> zE
noremap '<Del> zd
noremap <Leader>'<Del> zE

" Advance {{{

noremap <Bslash><Bslash> zz
noremap <Bar> :set<Space>wrap!<CR>
noremap <Bslash>' zi
noremap <Leader>'' zi

noremap <Bslash>Q :call<Space>BKeyInfo()<CR>
noremap <Leader><Bslash>, :Lexplore<CR>
noremap <Bslash>h :nohlsearch<CR>
noremap <Bslash>, :marks<CR>
noremap <Bslash>? :set<Space>spell!<CR>
noremap <Bslash>i <C-y>
noremap <Bslash>I <C-u>
noremap <Bslash>k <C-e>
noremap <Bslash>K <C-d>
noremap <Bslash>j z<Left>
noremap <Bslash>J zH
noremap <Bslash>l z<Right>
noremap <Bslash>L zL
noremap <Bslash>u ze
noremap <Bslash>o zs
noremap <Bslash>U zb
noremap <Bslash>O zt
noremap <Bslash>g zz
noremap <Bslash>G :set<Space>wrap!<CR>

" Seek
if (g:bkey_seek == '1')
	noremap 'Q :call<Space>BKeyInfo()<CR>
	noremap '. :Lexplore<CR>
	noremap 'h :nohlsearch<CR>
	noremap ', :marks<CR>
	noremap '? :set<Space>spell!<CR>
	noremap 'i <C-y>
	noremap 'I <C-u>
	noremap 'k <C-e>
	noremap 'K <C-d>
	noremap 'j z<Left>
	noremap 'J zH
	noremap 'l z<Right>
	noremap 'L zL
	noremap '<Up> <C-y>
	noremap '<S-Up> <C-u>
	noremap '<Down> <C-e>
	noremap '<S-Down> <C-d>
	noremap '<Left> z<Left>
	noremap '<S-Left> zH
	noremap '<Right> z<Right>
	noremap '<S-Right> zL
	noremap 'u ze
	noremap 'o zs
	noremap 'U zb
	noremap 'O zt
	noremap 'g zz
	noremap 'G :set<Space>wrap!<CR>
endif

" }}}

" Font-size
if has("gui_running")
	noremap - :call<Space>BKeyFontSizeMinus()<CR>
	noremap = :call<Space>BKeyFontSizePlus()<CR>
else
	noremap - <C-x>
	noremap = <C-a>
	if (g:bkey_keepsele_math == '1')
		vnoremap - <C-x>gv
		vnoremap = <C-a>gv
	endif
endif

" }}}

" Ctrl {{{

" Movements {{{

noremap <C-n> n
noremap <C-p> N
noremap <C-u> <C-y>
noremap <C-e> <C-e>
nmap <C-g> <Plug>(easymotion-overwin-f)
nmap <C-l> <Plug>(easymotion-overwin-line)

" }}}

" Actions {{{

" 4 horsemen of shortcut
noremap <C-z> <Undo>
noremap <C-x> :echo<Space>"Select<Space>something<Space>first"<CR>
vnoremap <C-x> "+d
noremap <C-c> <C-c>
vnoremap <C-c> ygv
noremap <C-v> "+gP
vnoremap <C-v> ""<Del>gP

" Other horsemen of shortcut
noremap <C-y> <C-r>
noremap <C-a> <C-Home>v<C-End>
vnoremap <C-a> <C-Home>gv<C-End>

" Find
noremap <C-f> /
vnoremap <C-f> /\%V
noremap <Leader><C-f> #*
vnoremap <Leader><C-f> y/<C-r>"<CR>N

" }}}

" Application {{{

noremap <C-k> K
noremap <C-r> <C-l>
noremap <C-d> <C-c>
noremap <C-q> <C-w>q

" Tab manager {{{

noremap <C-w>i <C-w><Up>
noremap <C-w>k <C-w><Down>
noremap <C-w>j <C-w><Left>
noremap <C-w>l <C-w><Right>
noremap <C-w><Up> <C-w><Up>
noremap <C-w><Down> <C-w><Down>
noremap <C-w><Left> <C-w><Left>
noremap <C-w><Right> <C-w><Right>

noremap <C-w>n gt
noremap <C-w>N gT
noremap <Tab> gt
noremap <S-Tab> gT

noremap <C-w>bi <C-w>K
noremap <C-w>bk <C-w>J
noremap <C-w>bj <C-w>H
noremap <C-w>bl <C-w>L

noremap <C-w>b<Up> <C-w>K
noremap <C-w>b<Down> <C-w>J
noremap <C-w>b<Left> <C-w>H
noremap <C-w>b<Right> <C-w>L

noremap <C-w>y <C-w>g<C-]>

noremap <C-w>r <C-w>=

noremap <Leader><C-w>/ <C-w>g}
noremap <C-w>- <C-w><
noremap <C-w>_ <C-w>-
noremap <C-w>= <C-w>>
noremap <C-w>+ <C-w>+

noremap <C-w>q <C-w>c
noremap <C-w>Q <C-w>o

" }}}

" Files {{{

noremap <C-t> :tabedit<Space>
noremap <C-o> :e
noremap <C-s> :w<CR>

" }}}

" Views {{{

noremap <C-b> :Lexplore<CR>

" }}}

" }}}

" }}}

" Alt {{{

for key in s:bkeya
	execute 'map <M-' . key . '> ' . key
	execute 'imap <M-' . key . '> <M-CR>' . key
endfor

map <M-Bar> <Bar>
imap <M-Bar> <M-CR><Bar>
map <M-Bslash> <Bslash>
imap <M-Bslash> <M-CR><Bslash>

map <M-'> '
imap <M-'> <M-CR>'

for key in s:bkeyctrl
	execute 'map <M-C-' . key . '> <C-' . key . '>'
	execute 'imap <M-C-' . key . '> <M-CR><C-' . key . '>'
	execute 'imap <C-' . key . '> <M-CR><C-' . key . '>'
endfor

" }}}

" Insert mode {{{

" Modes
noremap! <CR> <CR>
noremap! <Esc> <Esc>
cunmap <Esc>

inoremap <M-Space> <Esc>
cnoremap <M-Space> <C-f>
inoremap <M-S-Space> <Insert>
cnoremap <M-S-Space> <C-f><Insert><Insert>
inoremap <M-CR> <C-o>
cnoremap <M-CR> <C-f><Insert>

" Movements {{{

noremap! <M-i> <Up>
"inoremap <M-i> <C-o>g<Up>
noremap! <M-k> <Down>
"inoremap <M-k> <C-o>g<Down>
noremap! <M-j> <Left>
noremap! <M-J> <S-Left>
noremap! <M-l> <Right>
cnoremap <M-L> <S-Right>

" Advance
cnoremap <M-m> <Home>
noremap! <M-M> <End>

" }}}

" Actions {{{

" Insert
noremap! <Space> <Space>
noremap! <Tab> <Tab>
cunmap <Tab>
noremap! <Bar> <Bar>
noremap! <Bslash> <Bslash>

" Completion
noremap! <C-Space> <C-n>
noremap! <S-Space> <C-p>
noremap! <Insert> <C-p>

" Deletes
noremap! <M-d> <BS>
noremap! <M-D> <Del>

" Clipboards {{{

" Industry
noremap! <Del> <Del>
noremap! <M-Del> <Del>
noremap! <BS> <BS>
noremap! <M-BS> <BS>

" Paste
noremap! <M-v> <C-r>+
noremap! <M-V> <C-r>
noremap! <C-v> <C-r>+

" }}}

" }}}

" }}}


" vim: set fdm=marker :
