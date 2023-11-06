; extends

((inline) @_inline (#match? @_inline "^\(import\|export\)")) @nospell

((inline) @_inline (#lua-match? @_inline "^<.*/>")) @nospell
