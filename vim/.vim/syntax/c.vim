syn match    cCustomParen    "?=(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
syn keyword  cCustomSpecial  THROW_NEW THROW_CONT VTHROW_NEW VTHROW_CONT PROP_THROW VPROP_THROW ERROR_NEW ERROR_CONT ERROR_ABORT error_abort error_print error_waiting
syn match    cCustomDeref    "&[^& ]"ms=s,me=e-1 contained containedin=cParen

hi def link cCustomFunc Function
hi def link cCustomClass Function
hi def link cCustomSpecial Special
hi def link cCustomDeref Boolean
