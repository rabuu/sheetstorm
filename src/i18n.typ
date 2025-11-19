#let _words = (
  // Task related
  Task: (
    de: "Aufgabe",
  ),
  Subtask: (
    de: "Teilaufgabe",
  ),
  Points: (
    de: "Punkte",
  ),
  // Theorem related
  Theorem: (
    de: "Satz",
  ),
  Lemma: (:),
  Corollary: (
    de: "Korollar",
  ),
  Proof: (
    de: "Beweis",
  ),
  // Other
  Tutor: (:),
  Appendix: (
    de: "Anhang",
  ),
)

#let _dates = (
  _default: "[day] [month repr:long] [year]",
  de: "[day].[month].[year]",
)

#let word(key) = {
  if not key in _words {
    return key
  }

  _words.at(key).at(text.lang, default: key)
}

#let date-format() = {
  _dates.at(text.lang, default: _dates._default)
}
