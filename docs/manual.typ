#import "@preview/tidy:0.4.3"
#import "/src/lib.typ" as sheetstorm

#let manifest = toml("/typst.toml")
#let package = manifest.package.name
#let version = manifest.package.version
#let description = manifest.package.description
#let repository = manifest.package.repository

#let authors = (
  "Rasmus Buurman",
  "Leander Herter",
)
#let date = datetime.today().display("[day] [month repr:long] [year]")

#set document(author: authors, title: package)
#set page(margin: 1.3cm, numbering: "1 / 1")

#show heading.where(level: 1): it => block(smallcaps(it), below: 1em)

// TITLE PAGE

#v(2fr)

#align(center, {
  block(text(weight: 700, 1.75em, raw(package)))
  block(text(1em, description))
  v(3em, weak: true)
  [v#version #h(3em) #date]
  block(underline(link(repository)))
  v(3em, weak: true)
})
#pad(
  top: 0.5em,
  x: 2em,
  grid(
    columns: (1fr,) * calc.min(3, authors.len()),
    gutter: 1em,
    ..authors.map(author => align(center, strong(author))),
  ),
)

#v(3fr)

#set par(justify: true)

#pad(10%, outline(depth: 3, indent: 1em))

#v(3fr)

#pagebreak()

// -------------------------------------------

#show heading.where(level: 1): set heading(numbering: "1.")
#show heading.where(level: 3): set text(1.2em)

#let scope = (
  sheetstorm: sheetstorm,
  todo-box: sheetstorm.todo-box,
)

= Template Setup
#let docs = tidy.parse-module(read("../src/assignment.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
#pagebreak()

= Tasks
#let docs = tidy.parse-module(read("../src/task.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
#pagebreak()

= The "TODO" System
#let docs = tidy.parse-module(read("../src/todo.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
#pagebreak()

= Theorem and Proof Environments
#let docs = tidy.parse-module(read("../src/theorem.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
#pagebreak()

= Widgets
#let docs = tidy.parse-module(read("../src/widgets.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
#pagebreak()

= Utilities
#let docs = tidy.parse-module(read("../src/appendix.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
#let docs = tidy.parse-module(read("../src/numbering.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
#let docs = tidy.parse-module(read("../src/labelling.typ"), scope: scope)
#tidy.show-module(docs, show-outline: false, break-param-descriptions: true)
