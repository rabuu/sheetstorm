
///
/// TODO
///

#let todo-block = block(
  fill: luma(240),
  inset: 7pt,
  above: 8pt,
  below: 4pt,
  radius: 2pt,
  [*TODO*],
)
#let todo-counter = counter("sheetstorm-todo")
#let todo() = {
  todo-counter.step()
  [#todo-block]
}
