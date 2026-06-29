; extends

((raw_string_literal
   (raw_string_literal_content) @injection.content)
 (#match? @injection.content
  "\\%(.)?([0-9]|[a-z])")
 (#set! injection.language "printf")
 (#set! "priority" 150))

((raw_string_literal
   (raw_string_literal_content) @injection.content)
 (#match? @injection.content
  "\\c(SET|TRUNCATE|SELECT|CREATE|DELETE|ALTER|UPDATE|DROP|INSERT|WITH)")
 (#set! injection.language "sql"))

((interpreted_string_literal
   (interpreted_string_literal_content) @injection.content)
 (#match? @injection.content
  "\\%(.)?([0-9]|[a-z])")
 (#set! injection.language "printf")
 (#set! "priority" 150))

((interpreted_string_literal
   (interpreted_string_literal_content) @injection.content)
 (#match? @injection.content
  "\\c(SET|TRUNCATE|SELECT|CREATE|DELETE|ALTER|UPDATE|DROP|INSERT|WITH)")
 (#set! injection.language "sql"))
