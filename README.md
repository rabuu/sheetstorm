# uni-template
A typst template for university assignment submissions.

This is a work in progress. The package is not published to the [Typst universe](https://typst.app/universe) yet.

## Development
First, install the package, e.g. to the `@local` namespace.

This is very easy with a tool like [typship](https://github.com/sjfhsjfh/typship):
```sh
typship install local
```

Then, you can use it in a Typst file:
```typst
#import "@local/uni-template:0.1.0"

#show: uni-template.setup.with(
  course: smallcaps[A very interesting course 101],
  title: "Assignment 42",
  authors: ("John Doe", "Erika Mustermann"),
)

#lorem(3000)
```
