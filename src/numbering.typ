#let _custom_enum_numbering(patterns, cycle, default, ..nums) = {
  context assert(
    enum.full,
    message: "custom-enum-numbering must be used with enum.full",
  )

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

/// A helper to set a custom enum numbering based on the list depth
///
/// You must set `enum(full: true)` for it to work.
///
/// Example:
/// ```
/// #set enum(
///   full: true,
///   numbering: custom-enum-numbering("a)", "1.")
/// )
/// ```
#let custom-enum-numbering(cycle: false, default: auto, ..patterns) = {
  // Handle arguments
  let patterns = patterns.pos()
  assert(type(patterns) == array)
  assert(patterns.len() > 0, message: "No patterns provided")
  assert(patterns.all(p => type(p) == str), message: "Pattern must be a string")
  assert(type(cycle) == bool)
  if default == auto { default = patterns.last() }
  assert(type(default) == str)

  _custom_enum_numbering.with(patterns, cycle, default)
}
