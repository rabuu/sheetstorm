#import "@preview/sheetstorm:0.3.3": (
  assignment, corollary, lemma, proof, task, theorem,
)


#show: assignment.with(
  title: "Theorem-Style Demonstration",
  authors: "GOATlob Frege",
)

#task(points: 42)[
  /// Example: Standard theorem
  #theorem[This is a theorem with the standard numbering and no name.]

  /// Example: Named theorem
  #theorem(
    name: [Beautiful Name],
  )[This theorem is special because it is named. The numbering follows the standard.]

  /// Example: Theorem with emphasized = false
  #theorem(
    emphasized: false,
  )[This is a theorem without emphasized text.]

  /// Example: Theorem with custom numbering
  #theorem(
    numbering: 4.2,
  )[This theorem uses a custom numbering. Be creative when defining your one numbering style.]

  /// Example: Theorem with label
  #theorem(label: "banana", name: "Yellow bananas")[
    Bananas are yellow.
  ]

  Now you can reference @banana easily and it's displayed with a nice name.
  Or you link to it manually: #link(<banana>)[banana].

  /// Example: Standard corollary
  #corollary(
    label: "cor",
  )[A corollary usually follows from a preceding theorem.]

  Of course, you can also reference @cor.

  ///Example: Standard lemma
  #lemma[A lemma is typically a supporting statement. You can also assign a name or custom numbering as for theorem.]

  /// Example: Standard proof
  #proof[This is a standard proof.]

  /// Example: Proof with special symbol
  #proof(symbol: $q.e.d.$)[This proof ends with a custom symbol.]
]
