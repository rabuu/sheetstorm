#import "@local/uni-template:0.1.0": *

#show: setup.with(
  course: smallcaps[A very interesting course 101],
  title: "Assignment 42",
  authors: ("John Doe", "Erika Mustermann"),

  score-box-enabled: true,
)

#task(name: "Introduction")[
  #lorem(100)
]

#task(name: "Very hard problem")[
  #lorem(200)
  + _This is an enumeration_
  + With multiple items
    + Which can be nested
]

#task[
  Another task but without a name.

  #lorem(700)
]
