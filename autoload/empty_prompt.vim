scriptversion 4

let g:empty_prompt#pattern =
  \ get(g:, 'empty_prompt#pattern', &shell =~# 'sh$' ? '\$ $' : '>\s*$')

function! empty_prompt#is_empty() abort
  let line = term_getline(bufnr(''), '.')
  return line !=# '' && line =~# g:empty_prompt#pattern
endfunction

function! empty_prompt#map(opt) abort
  try
    let raw_lhs = s:get_map(a:opt, 'lhs')
    let rhs = s:get_map(a:opt, 'rhs')->s:eval_map()
    let fallback = s:get_map(a:opt, 'fallback', raw_lhs)->s:eval_map()
  catch /^empty-prompt:/
    echohl ErrorMsg
    echomsg v:exception
    echohl None
    return
  endtry
  execute printf('tnoremap <expr> %s empty_prompt#is_empty() ? %s : %s',
    \             raw_lhs, string(rhs), string(fallback))
endfunction

function! s:get_map(opt, key, default = v:null) abort
  if has_key(a:opt, a:key)
    return a:opt[a:key]
  endif
  if type(a:default) ==# v:null
    throw "empty-prompt: '" .. a:key .. "' is required key for empty_prompt#map()"
  else
    return a:default
  endif
endfunction

" s:eval_map('<CR>') returns "\<CR>"
" cf.
" https://github.com/kana/vim-submode/blob/d29de4f55c40a7a03af1d8134453a703d6affbd2/autoload/submode.vim#L535-L539
function! s:eval_map(map) abort
  return a:map
    \->split('\(<[^<>]\+>\|.\)\zs')
    \->map({-> eval('"\' .. v:val .. '"') })
    \->join('')
endfunction
