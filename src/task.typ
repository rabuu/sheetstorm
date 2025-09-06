#let task(
  name: none,
  show-counter: true,
  reset-counter: none,
  task-string: context if text.lang == "de" { "Aufgabe" } else { "Task" },
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

  block[
    = #title
    #content
  ]
}
