#import "i18n.typ"

/// Theoremstyle package
///
/// These functions provides a styled enviroment for theorems, lemmas, corollaries and proofs.
/// It includes automatic numbering, optional naming, and customizable end symbols for proofs.

/// Theorem block
#let theorem(
  kind: context i18n.word("Theorem"),
  numbering: auto,
  name: none,
  emphasized: true,
  fill: none,
  stroke: none,
  inset: 0em,
  outset: 0.5em,
  radius: 0em,
  above: 1.3em,
  below: 1.3em,
  width: 100%,
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
    fill: fill,
    stroke: stroke,
    inset: inset,
    outset: outset,
    radius: radius,
    above: above,
    below: below,
    width: width,
    [#prefix #content],
  )

  if auto-numbering {
    theorem-count.step()
  }
}

/// Corollary, based on the theorem style
#let corollary = theorem.with(kind: context i18n.word("Corollary"))

/// Lemma, based on the theorem style
#let lemma = theorem.with(kind: context i18n.word("Lemma"))

/// Proof environment with a default square end-symbol
#let proof(
  symbol: $square$,
  prefix: context i18n.word("Proof"),
  prefix-style: p => [_#p._],
  fill: none,
  stroke: none,
  inset: 0em,
  outset: 0.5em,
  radius: 0em,
  above: 1em,
  below: 1em,
  width: 100%,
  content,
) = {
  let prefix = prefix-style(prefix)
  block(
    fill: fill,
    stroke: stroke,
    inset: inset,
    outset: outset,
    radius: radius,
    above: above,
    below: below,
    width: width,
    [#prefix #content #h(1fr)\u{2060}#box[#h(1em)#symbol]],
  )
}

