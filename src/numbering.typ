/// A helper to set a custom enum numbering based on the list depth
///
/// You must set `enum(full: true)` for it to work.
///
/// Example:
/// ```
/// #set enum(
///   full: true,
///   numbering: custom-enum-numbering(("a)", "1."))
/// )
/// ```
#let custom-enum-numbering(patterns, cycle: false, default: auto) = {
  // Handle arguments
  assert(type(patterns) == array)
  assert(patterns.all(p => type(p) == str))
  assert(patterns.len() > 0)
  assert(type(cycle) == bool)
  if default == auto { default = patterns.last() }
  assert(type(default) == str)

  return (..nums) => {
    assert(nums.pos().len() > 0)
    let depth = nums.pos().len() - 1
    let value = nums.pos().last()

    // Determine correct pattern for given depth
    let pattern = if cycle {
      patterns.at(calc.rem(depth, patterns.len()))
    } else {
      patterns.at(depth, default: default)
    }

    numbering(pattern, value)
  }
}
