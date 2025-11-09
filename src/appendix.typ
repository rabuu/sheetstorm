///
/// Appendix
///

#let appendix(body) = [
  #let title = text(18pt, [*Appendix*])
  #title
  #set heading(numbering: "A.1.", supplement: [Appendix])
  #counter(heading).update(0)
  #body
]
