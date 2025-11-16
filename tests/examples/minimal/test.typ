#import "@local/sheetstorm:0.3.3": assignment, task

#show: assignment.with(
  title: "Minimal Example",
  authors: "John Doe",
)

#task[
  This is how the template looks with no/minimal configuration.
]

#task(lorem(1000))
