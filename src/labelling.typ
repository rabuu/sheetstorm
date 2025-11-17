#import "i18n.typ"

#let impromptu-label(lbl, kind: auto, supplement: none) = {
  assert(type(lbl) == str, message: "Label must be of type string")
  place[#figure(kind: kind, supplement: supplement)[]#label(lbl)]
}

#let subtask-label(lbl, identifier: auto) = {
  assert(type(lbl) == str, message: "Label must be of type string")
  if identifier == auto {
    identifier = lbl
  }

  let supplement = [#context i18n.word("Subtask") #identifier]
  impromptu-label(lbl, kind: "sheetstorm-subtask-label", supplement: supplement)
}
