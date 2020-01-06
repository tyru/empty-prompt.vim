# empty-prompt.vim

Vim plugin to add mappings only when shell prompt is empty

## Requirements

* Vim 8.2 or higher

## Usage

After installing this plugin, write this to your vimrc.

```vim
function! s:empty_prompt_mappings() abort
  " If current line is empty prompt ...
  
  " : works as <C-w>:
  call empty_prompt#map(#{lhs: ':', rhs: '<C-w>:'})
  " <Esc> works as <C-w>N
  call empty_prompt#map(#{lhs: '<Esc>', rhs: '<C-w>N'})
  
  " ... Add more mappings you like
  
endfunction
autocmd VimEnter * ++once call s:empty_prompt_mappings()
```

## Customize

`g:empty_prompt#pattern` (default: `&shell =~# 'sh$' ? '\$ $' : '>\s*$'`)

If current line on terminal window matches this pattern, fire given mapping.

Default is:
* current line ends with `$ ` (`&shell` ends with `sh` (bash/zsh/...) like Unix environment)
* current line ends with `>` (otherwise, cmd.exe/powershell like Windows)

If the default value does not fit your environment, please consider customize the value.

## API

### `empty_prompt#map({'lhs': <string>, 'rhs': <string> [, 'fallback': <string>]})`

```vim
call empty_prompt#map(#{lhs: '<Esc>', rhs: "<C-w>N"})
```

This will be expanded to:

```
tnoremap <expr> {lhs} empty_prompt#is_empty() ? {rhs} : {fallback}
```

`{fallback}` is optional.
Default `{fallback}` is same as `{lhs}`
