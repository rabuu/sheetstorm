#import "header.typ": configure-header

#let setup(
  course: none,
  title: none,
  authors: none,
  tutor: none,

  x-margin: none,
  left-margin: none,
  right-margin: none,
  bottom-margin: none,

  paper: "a4",
  numbering: "1 / 1",

  header-show-title-on-first-page: false,
  header-extra-left: none,
  header-extra-center: none,
  header-extra-right: none,

  doc,
) = {
  let x-margin = if x-margin == none { 1.7cm } else { x-margin }
  let left-margin = if left-margin == none { x-margin } else { left-margin }
  let right-margin = if right-margin == none { x-margin } else { right-margin }
  let bottom-margin = if bottom-margin == none { 1.2cm } else { bottom-margin }

  let header = configure-header(
    course: course,
    title: title,
    authors: authors,
    tutor: tutor,
    show-title-on-first-page: header-show-title-on-first-page,
    extra-left: header-extra-left,
    extra-center: header-extra-center,
    extra-right: header-extra-right,
  )

  context {
    let top-margin = measure(width: page.width - left-margin - right-margin, header).height

    set page(
      paper: paper,
      numbering: numbering,
      margin: (
        top: top-margin,
        bottom: bottom-margin,
        left: left-margin,
        right: right-margin,
      ),
      header: header,
      header-ascent: 0pt,
    )

    if title != none {
      align(center, text(1.5em, underline([*#title*])))
    }

    doc
  }

}
