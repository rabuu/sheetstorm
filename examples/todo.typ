#import "@preview/sheetstorm:0.4.0": assignment, subtask, task, todo, todo-box

#show: assignment.with(
  title: "Assignment with TODO's",
  authors: "John Doe",
  todo-show: true, /// here you can deactivate the `TODO` in the doc header
  todo-box: todo-box, /// here you can customize the design of the `TODO` in the doc header
)

///
/// Exercises with TODO's
///

/// Default is with `todo-show: true` and a red box around `TODO`
#task(points: 42)[
  #subtask[
    _Some interesting exercise._

    #lorem(200)
  ]

  #subtask[
    _Some other exercise._

    #todo[Here you can explain what's left to do.]
  ]
]

/// Deativate the warning TODO in the title, but add a comment and stroke color = black
#task(points: 13, todo-show: false)[
  #subtask[
    _Are bananas red?_

    #lorem(15)
  ]

  #subtask[
    _Are apples blue?_

    #todo(todo-box: todo-box.with(stroke: black))[
      Write down the proofs.
    ]
  ]
]

/// Activate TODO in task title manually
#task(todo: true)[
  #lorem(30)
]

/// Deactivate the red box around `TODO`
/// Stroke is customizable, i.e. `stroke: blue` would create a blue box.
#let todo-box = todo-box.with(stroke: none)
#let todo = todo.with(todo-box: todo-box)
#let task = task.with(todo-box: todo-box)
#task(points: 22)[
  #subtask[
    _What is your favorite fruit?_

    #lorem(50)
  ]

  #subtask[
    _What is your favorite animal?_

    #todo()
  ]

  #subtask[
    _What is your favorite food?_

    #todo()
  ]
]
