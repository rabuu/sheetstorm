#let default-date() = {
  if text.lang == "de" { "[day].[month].[year]" } else {
    "[day] [month repr:long] [year]"
  }
}

#let task() = {
  if text.lang == "de" { "Aufgabe" } else { "Task" }
}

#let points() = {
  if text.lang == "de" { "Punkte" } else { "Points" }
}

#let proof() = {
  if text.lang == "de" { "Beweis" } else { "Proof" }
}

#let corollary() = {
  if text.lang == "de" { "Korollar" } else { "Corollary" }
}

#let theorem() = {
  if text.lang == "de" { "Satz" } else { "Theorem" }
}

#let lemma() = {
  if text.lang == "de" { "Lemma" } else { "Lemma" }
}
