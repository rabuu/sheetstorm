# Contributing guide

## Tools
For developing, we use the following stack:
- Typst
- [typstyle](https://github.com/typstyle-rs/typstyle) as formatter
- [tytanic](https://github.com/typst-community/tytanic) as test runner

## Common tasks
We use [`just`](https://github.com/casey/just) for most common developing tasks:
- Install the package locally: `just install`
- Run the test suite: `just test`
- Format the code base: `just format`
- Update all test references and example tests: `just update-expected`
- Compile documentation: `just doc`

See the `justfile` in the project root for more details.

## Scripts
There are a few bash scripts in the `scripts` directory.
They are intended to be run using `just`.

### Git Hooks
```console
git config core.hooksPath scripts/git-hooks
```

## Testing
We use `tytanic` as test runner.

### Example tests
Sadly, we have to generate and synchronize the examples with their according tests (semi-)manually.
Use `just update-expected`.
