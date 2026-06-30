; extends

((raw_string_literal
   (raw_string_literal_content) @injection.content)
 (#match? @injection.content
  "^\\{.*\\}$")
 (#set! injection.language "json"))

((raw_string_literal
   (raw_string_literal_content) @injection.content)
 (#match? @injection.content
  "^\\<(.+)\\>.*\\</(.+)\\>$")
 (#set! injection.language "xml"))

((raw_string_literal
   (raw_string_literal_content) @injection.content)
 (#match? @injection.content
  "\\<(html|head|body|div|span|p|a|img|script|style|table|ul|ol|li|form|input|button|section|article|header|footer|nav|main|aside|h[1-6]|br|hr|meta|link|title)\\>")
 (#set! injection.language "html"))

((raw_string_literal
   (raw_string_literal_content) @injection.content)
 (#match? @injection.content
  "\\c(SET|TRUNCATE|SELECT|CREATE|DELETE|ALTER|UPDATE|DROP|INSERT|WITH)")
 (#set! injection.language "sql"))

((interpreted_string_literal
   (interpreted_string_literal_content) @injection.content)
 (#match? @injection.content
  "\\c(SET|TRUNCATE|SELECT|CREATE|DELETE|ALTER|UPDATE|DROP|INSERT|WITH)")
 (#set! injection.language "sql"))

((interpreted_string_literal
   (interpreted_string_literal_content) @injection.content)
 (#match? @injection.content
  "^\\<(.+)\\>.*\\</(.+)\\>$")
 (#set! injection.language "xml"))

((interpreted_string_literal
   (interpreted_string_literal_content) @injection.content)
 (#match? @injection.content
  "\\<(html|head|body|div|span|p|a|img|script|style|table|ul|ol|li|form|input|button|section|article|header|footer|nav|main|aside|h[1-6]|br|hr|meta|link|title)\\>")
 (#set! injection.language "html"))
