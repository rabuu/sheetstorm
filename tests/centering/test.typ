#import "@local/sheetstorm:0.5.1": assignment, subtask, task

#show: assignment

#task[
  #align(center, "Task text")
][
  #align(center, "Solution text")
]

#task[
  #subtask[
    #align(center, "Subtask text")
  ][
    #align(center, "Subtask solution text")
  ]
]
