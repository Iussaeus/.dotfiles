; extends

((string
    (string_content) @injection.content)
 (#match? @injection.content
  "\\%(.)?([0-9]|[a-z])")
  (#set! injection.language "printf"))
