#import "i18n.typ"

/// Theoremstyle package
///
/// These functions provides a styled enviroment for theorems, lemmas, corollaries and proofs.
/// It includes automatic numbering, optional naming, and customizable end symbols for proofs.

/// Creates a styled theorem block
/// Arguments:
/// 1. kind: lable of the theorem type, e.g. "Theorem", "Lemma"
/// 2. numbering: optional custom numbering
/// 3. name: optional theorem name
/// 4. content: theorem body
#let theorem(
  kind: context i18n.theorem(),
  numbering: auto,
  name: none,
  emphasized: true,
  content,
) = {
  let theorem-count = counter("sheetstorm-theorem-count")

  let auto-numbering = (numbering == auto)
  if auto-numbering {
    numbering = context theorem-count.get().first()
  }

  let prefix = {
    let numbering = if numbering != none [ #numbering]
    let name = if name != none [ (#name)]
    [*#kind#numbering*#name*.*]
  }

  if emphasized { content = emph(content) }

  block(
    fill: luma(100%),
    inset: 4pt,
    outset: 4pt,
    radius: 4pt,
    above: 10pt,
    below: 10pt,
    [#prefix #content],
  )

  if auto-numbering {
    theorem-count.step()
  }
}

/// Corollary, based on the theorem style
#let corollary = theorem.with(kind: context i18n.corollary())

/// Lemma, based on the theorem style
#let lemma = theorem.with(kind: context i18n.lemma())

/// Proof enviroment with a default square end-symbol
#let proof(
  symbol: $square$,
  content,
) = {
  let title = context { i18n.proof() }
  block(
    fill: luma(100%),
    inset: 4pt,
    outset: 1pt,
    radius: 4pt,
    below: 1pt,
    width: 100%,
    [
      _#title._ #content #h(1fr)\u{2060}#box[#h(1em)#symbol]
    ],
  )
}

