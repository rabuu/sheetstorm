
#import "@local/sheetstorm:0.3.3": assignment, task, todo

#show: assignment.with(
  title: "Assignment with TODO's",
  authors: "John Doe",
)

///
/// Exercises with TODO's
///

/// Default is `todo-show: true`
#task[
  + _Some interesting exercise._\
    #lorem(200)\

  + _Some other exercise._\
    #todo()
]


/// Deactivate the warning in the task title
#task(todo-show: false)[
  + _What is your favorite fruit?_\
    #lorem(50)\

  + _What is your favorite animal?_\
    #todo()
  + _What is your favorite food?_\
    #todo()
]
