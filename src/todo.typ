///
/// TODO
///

/// TODO-Box used for both, in text and in title
#let todo-box(
  todo-prefix: [TODO],
  todo-style: t => text(red)[*#t*],
  text-style: t => t,
  stroke: red,
  inset: (x: 0.2em),
  outset: (y: 0.3em),
  radius: 0.3em,
  ..content,
) = {
  let content = content.pos()
  box(
    inset: inset,
    outset: outset,
    stroke: stroke,
    radius: radius,
    {
      todo-style(todo-prefix)
      for content in content.map(text-style) {
        h(0.3em)
        content
      }
    },
  )
}

/// Local-Counter
#let todo-counter = counter("sheetstorm-todo")

/// Global-Counter
#let todo-global-count = counter("sheetstorm-global-todo")

/// TODO-function
#let todo(todo-box: todo-box, ..comments) = {
  todo-counter.step()
  todo-global-count.step()
  todo-box(..comments)
}
