syn match CommentTag "@[A-Z]\+" containedin=pythonComment
hi def link CommentTag String

" Color those attrs
syn match   pythonAttribute	/\.\h\w*/hs=s+1
			\ contains=ALLBUT,pythonBuiltin,pythonFunction,pythonAsync

hi pythonException ctermfg=red
hi pythonAttribute ctermfg=gray

