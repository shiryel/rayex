# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,c_src,test}/**/*.{ex,exs}"],
  locals_without_parens: [
    # unifex
    module: :*,
    interface: :*,
    spec: :*,
    type: :*
  ]
]
