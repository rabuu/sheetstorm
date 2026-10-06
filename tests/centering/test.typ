#import "@local/sheetstorm:0.5.1": assignment, subtask, task

#show: assignment

#task[
  #align(center, "task text")
][
  #align(center, "solution text")
]

#task[
  #subtask[
    #align(center, "subtask text")
  ][
    #align(center, "subtask solution text")
  ]
]
