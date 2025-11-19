///
/// TODO
///

/// TODO-Box used for both, in text and in title
#let todo-box(comment: none, stroke: red) = {
  box(
    inset: (x: 3pt, y: 0.5pt),
    outset: (y: 2.5pt),
    stroke: stroke,
    radius: 3pt,
    baseline: -10%,
  )[#text(red)[*TODO*] #comment]
}
/// Counter
#let todo-counter = counter("sheetstorm-todo")

/// TODO-function
#let todo(comment: none, todo-box: todo-box) = {
  todo-counter.step()
  if (comment != none) {
    todo-box(comment: comment)
  } else {
    todo-box()
  }
}
