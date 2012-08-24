" File:    remote.vim
" Author:  kmnk <kmnknmk+vim@gmail.com>
" Version: 0.1.0
" License: 

let s:save_cpo = &cpo
set cpo&vim

function! giti#remote#show()"{{{
  return giti#system('remote show')
endfunction"}}}

function! giti#remote#show_verbose()"{{{
  return giti#system('remote --verbose show')
endfunction"}}}

function! giti#remote#add(param)"{{{
  if !has_key(a:param, 'name') || strlen(a:param.name) <= 0
    throw 'name required'
  endif
  if !has_key(a:param, 'url') || strlen(a:param.url) <= 0
    throw 'url required'
  endif
  let name = a:param.name
  let url  = a:param.url

  let branch  = has_key(a:param, 'branch') ? a:param.branch : ''
  let master  = has_key(a:param, 'master') ? a:param.master : ''
  let fetch   = has_key(a:param, 'fetch')  ? a:param.fetch  : 0
  let tags    = has_key(a:param, 'tags')   ? a:param.tags   : 0
  let no_tags = !tags && has_key(a:param, 'no_tags') ? a:param.no_tags : 0
  let mirror  = has_key(a:param, 'mirror') ? a:param.mirror : ''

  return giti#system(printf('remote add %s %s %s %s %s %s %s',
\   strlen(branch) > 0 ? '-t ' . branch       : '',
\   strlen(master) > 0 ? '-m ' . master       : '',
\   fetch              ? '-f'                 : '',
\   tags               ? '--tags'
\ : no_tags            ? '--no-tags'          : '',
\   strlen(mirror) > 0 ? '--mirror=' . mirror : '',
\   name,
\   url
\ ))
endfunction"}}}

function! giti#remote#rename(param)"{{{
  if !has_key(a:param, 'old') || strlen(a:param.old) <= 0
    throw 'old required'
  endif
  if !has_key(a:param, 'new') || strlen(a:param.new) <= 0
    throw 'new required'
  endif

  return giti#system(printf('remote rename %s %s',
\   a:param.old, a:param.new
\ ))
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__