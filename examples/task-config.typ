#import "@preview/sheetstorm:0.3.3": assignment, custom-enum-numbering, task

#show: assignment.with(
  title: "Task Configuration Example",
  authors: "John Doe",
  score-box-enabled: true,
  initial-task-number: 3,
)

// You can customize the task command like so:
#let task = task.with(
  counter-show: false,
  subtask-numbering: custom-enum-numbering("i)", "1.", "(a)"),
)

#task(name: "Unnumbered Task")[
  Now, the task numbers are disabled for the whole document.

  Also, we have our custom numbering pattern enabled by default:
  + Hi
    + Hey
      + Ho
]

#task(counter-show: true)[Unless you explicitely enable the counter.]

#task(hidden: true)[This task is also hidden in the score box.]
