#let score-box(
  first-task: none,
  last-task: none,
  tasks: none,
  inset: 0.7em,
  align: center,
  width: 80%,
) = context {
  let tasks = if tasks != none { tasks } else {
    let first-task = if first-task == none { 1 } else { first-task }
    let last-task = if last-task == none { counter("task").final().first() } else { last-task }
    range(first-task, last-task + 1)
  }

  box(width: width, table(
    columns: tasks.map(_ => 1fr) + (1.3fr,),
    inset: inset,
    align: align,
    table.header(..(tasks.map(i => [*#i*]) + ([$sum$],))),
    ..(tasks + (1,)).map(_ => v(1em)),
  ))
}
