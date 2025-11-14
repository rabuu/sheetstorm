#import "i18n.typ"
///
/// Appendix
///

#let appendix(
  title: context i18n.word("Appendix"),
  title-size: 1.6em,
  numbering: "A.1.",
  body,
) = [
  #if title != none {
    text(title-size, strong(title))
  }

  #set heading(numbering: numbering, supplement: context i18n.word("Appendix"))

  #counter(heading).update(0)

  #body
]
