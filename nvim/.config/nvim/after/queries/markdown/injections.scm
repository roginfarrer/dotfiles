; extends

(
 (inline) @injection.content
 (#match? @injection.content "^\(import\|export\)") 
 (#set! injection.language "tsx")
)

(
 (html_block) @injection.content
 (#set! injection.language "tsx")
)

(
 (paragraph) @injection.content
 (#lua-match? @injection.content "^<.*/>")
 (#set! injection.language "tsx")
)
