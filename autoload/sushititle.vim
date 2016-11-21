" original plugin) https://github.com/pocke/sushibar.vim
" customized to titlestring version

let s:sushi_count = 0
let s:sushis =
  \ reverse([
  \ "🍣　　　　　　　",
  \ "　🍣　　　　　　",
  \ "　　🍣　　　　　",
  \ "　　　🍣　　　　",
  \ "　　　　🍣　　　",
  \ "　　　　　🍣　　",
  \ "　　　　　　🍣　",
  \ "　　　　　　　🍣"])

let s:string = ""
let s:timer = 0

function! s:makestring()
  if s:sushi_count == 8
    let s:sushi_count = 0
  endif

  let ret = repeat(s:sushis[s:sushi_count], 8)

  let s:sushi_count += 1
  return ret
endfunction

function! sushititle#_internal_getstring()
  return s:string
endfunction

function! s:updatestring()
  let s:string = s:makestring()
endfunction

function! s:loop(timer)
  call s:updatestring()
  set titlestring=%{sushititle#_internal_getstring()}
  redraw
endfunction

function! sushititle#start(...)
  let interval = get(a:, 1, 500)
  if s:timer != 0
	  call timer_stop(s:timer)
  endif
  let s:timer = timer_start(interval, function('s:loop'), {'repeat': -1})
endfunction


" -----------
" example ---

function! s:done(channel) abort
  call sushititle#start()
endfunction

function! sushititle#example()
  " sample) speed up while executing command
  call sushititle#start(32)
  let job = job_start('sleep 3', {'close_cb': function('s:done')})
endfunction
