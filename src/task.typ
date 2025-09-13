#import "numbering.typ": apply-numbering-pattern, subtask-numbering-pattern
#import "i18n.typ"

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
  task-string: none,
  subtask-numbering: false,
  subtask-numbering-pattern: subtask-numbering-pattern,
  points: none,
  show-points: true,
  points-string: none,
  bonus: false,
  bonus-show-star: true,
  above: auto,
  below: 2em,
  content,
) = {
  let task-count = counter("sheetstorm-task")
  if reset-counter == none { task-count.step() } else { task-count.update(reset-counter) }

  let points-enabled = false
  let current-points
  let display-points

  if type(points) == int {
    points-enabled = true
    current-points = points
    display-points = [#points]

  // multiple points specified, e.g. `points: (1, 3, 1)`, gets rendered as "1 + 3 + 1"
  } else if type(points) == array and points.map(p => type(p) == int).reduce((a, b) => a and b) {
    points-enabled = true
    current-points = points.sum()
    display-points = points.map(str).intersperse(" + ").sum()
  }

  state("sheetstorm-points").update(if points-enabled { current-points })
  state("sheetstorm-bonus").update(bonus)

  task-string = if task-string == none { context i18n.task() }
  points-string = if points-string == none { context i18n.points() }

  let title = {
    task-string
    if show-counter [ #context task-count.display()]
    if name != none [: #emph(name)]
    if bonus and bonus-show-star [\*]
  }

  block(width: 100%, above: above, below: below)[
    #set enum(
      full: true,
      numbering: if subtask-numbering {
        apply-numbering-pattern.with(numbering-pattern: subtask-numbering-pattern)
      } else {
        apply-numbering-pattern
      }
    )

    #block({
      show heading: box
      [= #title <sheetstorm-task>]
      if points-enabled and show-points {
        h(1fr)
        [(#display-points #points-string)]
      }
    })
    #content
  ]
}
