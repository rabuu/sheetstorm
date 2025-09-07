#let default-numbering-pattern(depth) = {
  if calc.rem(depth, 3) == 1 { "1." }
  else if calc.rem(depth, 3) == 2 { "a." }
  else { "i." }
}

#let subtask-numbering-pattern(depth) = {
  if calc.rem(depth, 3) == 1 { "a." }
  else if calc.rem(depth, 3) == 2 { "1." }
  else { "i." }
}

#let apply-numbering-pattern(
  numbering-pattern: default-numbering-pattern,
  ..nums,
) = {
  let nums = nums.pos()
  numbering(numbering-pattern(nums.len()), nums.last())
}
