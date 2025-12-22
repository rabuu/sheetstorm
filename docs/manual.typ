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

#show heading.where(level: 1): set text(1.4em)
#show heading.where(level: 1): it => block(smallcaps(it), below: 1em)
#show heading.where(level: 3): it => {
  set text(1.2em)
  block(
    below: 0.7em,
    inset: 0.4em,
    stroke: black,
    fill: luma(235),
    radius: 0.3em,
    [Function: #it.body],
  )
}

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

#show heading.where(level: 1): set heading(numbering: "1.")

#let documentation(file) = {
  let docs = tidy.parse-module(
    read("/src/" + file),
    scope: (sheetstorm: sheetstorm),
  )
  tidy.show-module(
    docs,
    show-outline: false,
    break-param-descriptions: true,
    sort-functions: none,
    omit-private-definitions: true,
  )
}

= Example
#{
  set text(size: 10pt)
  raw(read("/examples/assignment.typ"), lang: "typst")
}
#pagebreak()

= Template Setup
#documentation("assignment.typ")
#pagebreak()

= Tasks
#documentation("task.typ")
#pagebreak()

= The "TODO" System
#documentation("todo.typ")
#pagebreak()

= Theorem and Proof Environments
#documentation("theorem.typ")
#pagebreak()

= Widgets
#documentation("widgets.typ")
#pagebreak()

= Utilities
#documentation("appendix.typ")
#documentation("numbering.typ")
