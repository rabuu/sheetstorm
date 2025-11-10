#import "i18n.typ"
///
/// Appendix
///

#let appendix(
  title: context i18n.appendix(),
  title-size: 1.6em,
  numbering: "A.1.",
  body,
) = [
  #if title != none {
    text(18pt, strong(title))
  }

  #set heading(numbering: numbering, supplement: context i18n.appendix())

  #counter(heading).update(0)

  #body
]
