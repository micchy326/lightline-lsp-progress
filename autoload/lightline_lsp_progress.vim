let s:lsp_progress = []
function! lightline_lsp_progress#progress() abort
  if exists('*lsp#get_progress')
    let s:lsp_progress = lsp#get_progress()

    if len(s:lsp_progress) == 0 | return '' | endif

    " show only most new progress
    let s:lsp_progress = s:lsp_progress[0]
    if s:lsp_progress['message'] != '' && has_key(s:lsp_progress, 'percentage') && s:lsp_progress['percentage'] != 100
      let percent = ''
      if s:lsp_progress['percentage'] >= 0
        let percent = ' ' . string(s:lsp_progress['percentage']) . '%'
      endif
      let s:title = s:lsp_progress['title']
      let message = s:lsp_progress['message'] . percent
      return s:lsp_progress['server'] . ':' . s:title . ' ' . message
    endif
    return ''
  endif
endfunction

let s:timer = 0
let s:ignore_time = 0
function! lightline_lsp_progress#update() abort
  if reltimefloat(reltime()) - s:ignore_time >=
        \ get(g:, 'lightline_lsp_progress_skip_time', 0.3)
        \ || len(s:lsp_progress) == 0
    call lightline#update()
    let s:ignore_time = reltimefloat(reltime())
  endif
endfunction

