#import "@preview/sheetstorm:0.4.0"as sheetstorm: task


#show: sheetstorm.setup.with(
  title: "Theorem-Style Demonstration",
  authors: "GOATlob Frege",
)

#task(points: 42)[
  /// Example: Standard theorem
 #sheetstorm.theorem()[This is a theorem with the standard numbering and no name.]

 /// Example: Named theorem
 #sheetstorm.theorem(name: [Beautiful Name])[This theorem is special because it is named. The numbering follows the standard.]

 /// Example: Theorem with custom numbering
 #sheetstorm.theorem(numbering: 4.2)[This thoerem uses a custom numbering. Be creative when defining your one numbering style.]

 /// Example: Standard corollary
 #sheetstorm.corollary()[A corollary usually follows from a preceding theorem. ]

 ///Example: Standard lemma
 #sheetstorm.lemma()[A lemma is typically a supporting statement. You can also assign a name or custom numbering as for theorem.]

/// Example: Standard proof
#sheetstorm.proof()[This is a standard proof.]

/// Example: Proof with special symbol
#sheetstorm.proof(symbol: $q.e.d.$)[This proof ends with a custom symbol.]
]