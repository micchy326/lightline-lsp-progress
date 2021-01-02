if exists('g:loaded_lightline_lsp_progress')
  finish
endif
let g:loaded_lightline_lsp_progress = 1

augroup lightline_lsp_progress
  autocmd!
  autocmd User lsp_progress_updated call lightline_lsp_progress#update()
augroup END

