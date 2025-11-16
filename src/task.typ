#import "numbering.typ": custom-enum-numbering
#import "i18n.typ"

/// A task block
///
/// Use this function to create a section for each task.
/// It supports customized task numbers, points and bonus tasks.
/// ```typst
/// #task(name: "Pythagorean theorem")[
///   _What is the Pythagorean theorem?_
///
///   $ a^2 + b^2 = c^2 $
/// ]
/// ```
#let task(
  name: none,
  task-prefix: context i18n.word("Task"),
  counter-show: true,
  counter-reset: none,
  subtask-numbering: custom-enum-numbering("a)", "1.", "i."),
  points: none,
  points-show: true,
  points-prefix: context i18n.word("Points"),
  bonus: false,
  bonus-show-star: true,
  hidden: false,
  space-above: auto,
  space-below: 2em,
  content,
) = {
  let task-count = counter("sheetstorm-task")
  if counter-reset != none { task-count.update(counter-reset) }

  let points-enabled = false
  let current-points
  let display-points

  if type(points) == int {
    points-enabled = true
    current-points = points
    display-points = [#points]

    // multiple points specified, e.g. `points: (1, 3, 1)`, gets rendered as "1 + 3 + 1"
  } else if type(points) == array and points.all(p => type(p) == int) {
    points-enabled = true
    current-points = points.sum()
    display-points = points.map(str).intersperse(" + ").sum()
  }

  state("sheetstorm-points").update(if points-enabled { current-points })
  state("sheetstorm-bonus").update(bonus)
  state("sheetstorm-hidden-task").update(hidden)

  let title = {
    task-prefix
    if counter-show {
      if task-prefix != "" [ ]
      context task-count.display()
    }
    if name != none [: #emph(name)]
    if bonus and bonus-show-star [\*]
  }

  block(width: 100%, above: space-above, below: space-below)[
    #set enum(
      full: type(subtask-numbering) != str,
      numbering: subtask-numbering,
    ) if subtask-numbering != none

    #block({
      show heading: box
      [= #title <sheetstorm-task>]
      if points-enabled and points-show {
        h(1fr)
        [(#display-points #points-prefix)]
      }
    })
    #content
  ]

  task-count.step()
}
