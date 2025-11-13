#import "i18n.typ"
#import "util.typ": is-some

/// Helper function that takes an array of content and puts it together as a block
#let header-section(xs) = box(
  for i in xs.filter(is-some).intersperse(linebreak()) { i },
)

/// Create the contents of the header
///
/// This function is not exposed to the user, all configuration is done in the `setup` function.
#let header-content(
  course,
  title,
  authors,
  date,
  date-format,
  tutor,
  tutor-prefix,
  show-title-on-first-page,
  extra-left,
  extra-center,
  extra-right,
  columns-spacing,
) = {
  let header = grid(
    columns: columns-spacing,
    align: (left, center, right),
    rows: (auto, auto),
    gutter: 0.5em,

    // left
    header-section((
      if date != none {
        context date.display(if date-format == auto {
          i18n.default-date()
        } else { date-format })
      },
      if tutor != none [#tutor-prefix: #tutor],
      extra-left,
    )),

    // center
    header-section((
      course,
      if show-title-on-first-page { title } else {
        context {
          let n = counter(page).get().first()
          if n != 1 { title }
        }
      },
      extra-center,
    )),

    // right
    header-section(authors + (extra-right,)),

    grid.hline(),
  )

  return pad(top: 0.8cm, bottom: 1cm, header)
}
