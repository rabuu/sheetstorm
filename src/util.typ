#let is-some(x) = x != none

#let to-content(x) = [#x]

#let impromptu-label(lbl, kind: auto, supplement: none) = {
  assert(type(lbl) == str, message: "Label must be of type string")
  place[#figure(kind: kind, supplement: supplement)[]#label(lbl)]
}
