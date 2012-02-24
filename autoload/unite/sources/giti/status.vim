" File:    status.vim
" Author:  kmnk <kmnknmk+vim@gmail.com>
" Version: 0.1.0
" License: MIT Licence

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#giti#status#define()"{{{
  return s:source
endfunction"}}}

let s:source = {
\ 'name' : 'giti/status',
\ 'description' : 'disp statuses',
\}

function! s:source.gather_candidates(args, context)"{{{
  call unite#print_message('[giti/status]')
  call unite#print_message(s:build_title())
  return extend(map(giti#status#list(), '{
\   "word" : s:build_word(v:val),
\   "source" : s:source.name,
\   "kind"   : "giti/status",
\   "action__path" : v:val.path,
\   "action__line" : 1,
\ }'), [{
\   "word" : "(execute other action)",
\   "source" : s:source.name,
\   "kind"   : "giti/status",
\   "action__path" : "./",
\   "action__line" : 1,
\ }])
endfunction"}}}

" local functions {{{
let s:word_format = '%-12s%-12s %s'
function! s:build_word(val)"{{{
  return printf(s:word_format,
\   '[' . a:val.index . ']',
\   '[' . a:val.work  . ']',
\   v:val.path)
endfunction"}}}
function! s:build_title()"{{{
  return printf('    ' . s:word_format,
\   'IndexStatus',
\   'WorkStatus',
\   'FilePath')
endfunction"}}}
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__