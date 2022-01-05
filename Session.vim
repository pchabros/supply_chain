let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/WorkingDirectory/solidity_tutorial/supply_chain
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd contracts/Greeter.sol
edit contracts/ItemManager.sol
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 109 + 165) / 330)
exe 'vert 2resize ' . ((&columns * 110 + 165) / 330)
exe 'vert 3resize ' . ((&columns * 109 + 165) / 330)
argglobal
balt client/src/contracts/ItemManager.sol/ItemManager.json
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 9 - ((8 * winheight(0) + 39) / 78)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 9
normal! 0
wincmd w
argglobal
if bufexists("client/src/contracts/ItemManager.sol/ItemManager.json") | buffer client/src/contracts/ItemManager.sol/ItemManager.json | else | edit client/src/contracts/ItemManager.sol/ItemManager.json | endif
if &buftype ==# 'terminal'
  silent file client/src/contracts/ItemManager.sol/ItemManager.json
endif
balt scripts/deploy.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 105 - ((38 * winheight(0) + 39) / 78)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 105
normal! 05|
wincmd w
argglobal
if bufexists("client/src/App.js") | buffer client/src/App.js | else | edit client/src/App.js | endif
if &buftype ==# 'terminal'
  silent file client/src/App.js
endif
balt contracts/ItemManager.sol
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 24 - ((23 * winheight(0) + 39) / 78)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 24
normal! 013|
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 109 + 165) / 330)
exe 'vert 2resize ' . ((&columns * 110 + 165) / 330)
exe 'vert 3resize ' . ((&columns * 109 + 165) / 330)
tabnext 1
badd +14 contracts/ItemManager.sol
badd +1 contracts/Greeter.sol
badd +105 client/src/contracts/ItemManager.sol/ItemManager.json
badd +22 scripts/deploy.js
badd +0 client/src/App.js
badd +1 hardhat.config.js
badd +11 contracts/Item.sol
badd +1 artifacts/contracts/ItemManager.sol/ItemManager.json
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
