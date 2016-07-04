function! neoterm#window#create(handlers, source)
  if !has_key(g:neoterm, "term")
    exec "source " . globpath(&rtp, "autoload/neoterm.term.vim")
  end

  if a:source == 'tnew' && !g:neoterm_split_on_tnew
    call s:term_creator(a:handlers)
  else
    call s:new_window()
    call s:term_creator(a:handlers)
  end

  if a:source == 'test' && g:neoterm_run_tests_bg
    hide
  elseif g:neoterm_autoinsert
    startinsert
  elseif g:neoterm_keep_term_open
    wincmd p
  else
    startinsert
  end
endfunction

function! s:new_window()
  execute get(g:, 'neoterm_window', 'botright new')
endfunction

function! s:term_creator(handlers)
  let instance = g:neoterm.term.new(a:handlers)
  call instance.mappings()
  let b:neoterm_id = instance.id
endfunction

function! neoterm#window#reopen(buffer_id)
  call s:new_window()
  exec "buffer ".a:buffer_id
  wincmd p
endfunction
