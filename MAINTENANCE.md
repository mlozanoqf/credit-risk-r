# Maintenance and verification

For first use, follow [the reader walkthrough](README.md). This page records
repository maintenance and checks beyond the initial chapter run.

## Structure and maintenance

`chapters/` holds editable chapter sources and specific helpers; `shared/`
holds formatting, plotting, risk utilities and output support. A helper used
by another chapter is loaded explicitly. `data/` holds frozen inputs and
source notes. Generated files go to `output/`, which is not versioned.

Keep the reference inputs, seeds and software versions unchanged when first
reproducing results. Record any intentional extension or dependency update.
Run `Rscript checks/check-inputs.R` to verify frozen input checksums. Revalidate
`results-index.csv` when book numbering changes; this technical index maps source
blocks to generated files for the execution checks. The chapter README indexes
provide the reader-facing navigation. On 11 October 2026, all seven
units, including both credit-scoring chapters, passed validation
from an extracted ZIP with a newly restored library
and package caching disabled on Windows 11. The checks matched 991 numerical
objects, 126 CSV tables and all 85 numbered figures against the reference.
It does not cover macOS/Linux or future package updates.

## Checks

After running all seven chapters through `run.R`, verify their inputs, book
numbering and code links, fresh outputs and numerical regression references:

```sh
Rscript checks/verify.R
Rscript checks/test-verification.R
Rscript checks/test-download.R
```

The references describe the recorded R environment. After changing sources, rerun
the chapters before verification. A deliberate extension may change the numerical
references; investigate those differences before updating the references. See
[verification details](checks/README.md) for the scope of these checks.

## Reader starter tests

Run `Rscript checks/test-start.R`. It tests menu cancellation, invalid selection,
runner delegation, browser handling and failed runs with controlled stubs.
The starter delegates all calculations and output verification to the existing runner.
