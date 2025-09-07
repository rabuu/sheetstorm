#let default-numbering-pattern(depth) = {
  if depth == 1 { "1." }
  else if depth == 2 { "a." }
  else if depth == 3 { "i." }
  else { "1." }
}

#let subtask-numbering-pattern(depth) = {
  if depth == 1 { "(a)" } else { default-numbering(depth + 1) }
}

#let apply-numbering-pattern(..nums, numbering-pattern: default-numbering-pattern) = {
  let nums = nums.pos()
  numbering(numbering-pattern(nums.len()), nums.last())
}
