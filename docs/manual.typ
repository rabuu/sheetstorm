#import "@preview/tidy:0.4.3"
#import "../src/lib.typ" as sheetstorm

#set page(
  margin: 1cm,
  numbering: "1 / 1",
)

#let scope = (
  sheetstorm: sheetstorm,
  todo-box: sheetstorm.todo-box,
)

= Setup
#let docs = tidy.parse-module(read("../src/assignment.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)

#pagebreak()

= Utilities
#let docs = tidy.parse-module(read("../src/appendix.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
