/// A task block
///
/// Use this function to create a section for each task.
/// It creates a heading and handles spacing.
///
/// ```typst
/// #task(name: "Pythagorean theorem")[
///   _What is the Pythagorean theorem?_
///
///   $ a^2 + b^2 = c^2 $
/// ]
/// ```
#let task(
  name: none,
  show-counter: true,
  reset-counter: none,
  task-string: context if text.lang == "de" { "Aufgabe" } else { "Task" },
  above: auto,
  below: 2em,
  content,
) = {
  let counter = counter("task")
  if reset-counter == none { counter.step() } else { counter.update(reset-counter) }

  let title = {
    task-string
    if show-counter {
      [ #context counter.display()]
    }
    if name != none [: #emph(name)]
  }

  block(width: 100%, above: above, below: below)[
    = #title
    #content
  ]
}
