#import "i18n.typ"

/// Theoremstyle package
/// 
/// These functions provides a styled enviroment for theorems, lemmas, corollaries and proofs.
/// It includes automatic numbering, optional naming, and customizable end symbols for proofs.

/// State variable that tracks the number of created theorem-like boxes
#let count = state("theorem-count",0)

/// Updates the counter and returns the current theorem number
#let compute(delta:1) = [
  #count.update(x => x + delta)
  #context{count.get()}
]
/// Removes all spaces from a given string
#let nospace(txt) = {
  show regex(" "): it => []
  txt
}

/// Creates a styled theorem block
/// Arguments:
/// 1. kind: lable of the theorem type, e.g. "Theorem", "Lemma"
/// 2. numbering: optional custom numbering
/// 3. name: optional theorem name
/// 4. content: theorem body
#let theorem(
  kind: [Theorem],
  numbering: none,
  name: [],
  content,
) = {
  let count = nospace(compute())
  if(numbering != none){
    count = numbering
  }
  if(name != []){
    name = [*#kind #count*#h(2pt) (#name)*.*]
  } else {
    name = [*#kind #count.*]
  }
  let theoblock = block(
    fill: luma(100%),
    inset: 4pt,
    outset: 4pt,
    radius: 4pt,
    above: 10pt,
    below: 10pt,
    [#name _#content _ ]
  )
  return theoblock
}

/// Corollary, based on the theorem style
#let title = context i18n.corollary()
#let corollary = theorem.with(kind:title)

/// Lemma, based on the theorem style
#let lemma = theorem.with(kind: [Lemma])

/// Proof enviroment with a default square end-symbol
#let proof(
  symbol: $square$,
  content,
) = {
  let title = context{ i18n.proof()}
  let proofbox = block(
    fill: luma(100%),
    inset: 4pt,
    outset: 1pt,
    radius: 4pt,
    below: 1pt,
    width: 100%,
    [_#title._#h(3pt) #content]
  )
  let proofend = align(right, symbol)
  return [#proofbox #proofend]
}


