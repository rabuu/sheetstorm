#import "util.typ": is-some

/// Score Box widget
///
/// This function creates an empty table for each task where the scores can be filled in.
/// By default, it reads the number of tasks from the `task` counter,
/// but you can set the task values manually.
#let score-box(
  tasks: none,
  show-points: true,
  fill-space: false,
  cell-width: 4.5em,
  inset: 0.7em,
) = context {
  let tasks-query = query(<task>)
  let task-counter = counter("task")
  let points-state = state("points")

  let tasks = tasks
  if tasks == none {
    tasks = tasks-query.map(t => task-counter.at(t.location()).first())
  }

  let points = tasks-query.map(t => points-state.at(t.location()))
  let raw-points = points.filter(is-some)
  let points-sum = if raw-points.len() > 0 { raw-points.sum() }

  let display-points = (points + (points-sum,)).map(p =>
    if show-points and p != none [\/ #p] else { v(1em) }
  )

  table(
    columns: if fill-space {
      tasks.map(_ => 1fr) + (1.3fr,)
    } else {
      tasks.map(_ => cell-width) + (1.3 * cell-width,)
    },
    inset: inset,
    align: (_, row) => if row == 1 { right } else { center },
    table.header(..(tasks.map(i => [*#i*]) + ([$sum$],))),
    ..display-points
  )
}

/// Info Box widget
///
/// This function creates a box with information about the authors of the document.
/// You need to provide the names of the authors and optionally student IDs and/or email addresses.
#let info-box(
  names,
  student-ids: none,
  emails: none,
  inset: 0.7em,
  gutter: 1em,
) = {
  let info = (student-ids, emails).filter(is-some)
  let entries = names.zip(..info).flatten()

  box(stroke: black, inset: inset, grid(
    columns: info.len() + 1,
    gutter: gutter,
    align: left,
    ..entries,
  ))
}
