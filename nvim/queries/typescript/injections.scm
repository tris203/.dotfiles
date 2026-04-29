; extends

; fooMarkdownTable: `...`
((pair
  key: (property_identifier) @key
  value: (template_string
    (string_fragment) @injection.content))
  (#lua-match? @key "MarkdownTable$")
  (#set! injection.language "markdown"))

; fooMarkdownTable: `...`.trim()
((pair
  key: (property_identifier) @key
  value: (call_expression
    function: (member_expression
      object: (template_string
        (string_fragment) @injection.content)
      property: (property_identifier) @method)))
  (#lua-match? @key "MarkdownTable$")
  (#eq? @method "trim")
  (#set! injection.language "markdown"))

