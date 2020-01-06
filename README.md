# empty-prompt.vim

Mapping library to add a mappings only when shell prompt is empty

## Requirements

* Vim 8.2 or higher

## Usage

After installing this plugin, write this to your vimrc.

```vim
function! s:empty_prompt_mappings() abort
  call empty_prompt#map(#{lhs: ':', rhs: "<C-w>:"})
  call empty_prompt#map(#{lhs: '<Esc>', rhs: "<C-w>N"})
endfunction
autocmd VimEnter * ++once call s:empty_prompt_mappings()
```
