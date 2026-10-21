# Verification

Run each of the seven chapters with `Rscript run.R <chapter-id>`, then run
`Rscript checks/verify.R`. This checks frozen inputs, book-result identifiers,
index titles, source links, generated figures/tables, source freshness and numerical
references. Run `Rscript checks/test-verification.R` for negative regression
tests and `Rscript checks/test-download.R` for offline download-protection tests.

`book-results.csv` records the 211 numbered results checked against book revision
`d7a08d03801b73d9801b14eaffe095563c0e47a0`, with caption-only updates
checked against the compiled publication manuscript on 20 October 2026, including
14 table captions with unit clarifications. Numbering
and result identifiers are unchanged. Update the index and this reference
together after checking later changes in book numbering.

`numeric-reference.json` contains compact numerical checkpoints from the
independently executed 15 October 2026 audit, before these verification changes.
They include valuation, model evaluation, decision rules and portfolio/climate
results. They test reproducibility in the pinned R environment, including seeded
simulations, rather than equality of random draws across languages. The Python
repository carries its own numerical reference. Numerical regressions require
investigation; regenerating a fixture is a deliberate maintenance action.

The runner records normalized source hashes only after successful execution and
checks that numbered outputs were written by that run. Running Quarto directly
does not produce this verification record. Changes to shared code or chapter
sources invalidate the record and require rerunning the chapters.

The optional NGFS download requires a new destination. Sourcing its helper only
defines functions. Both responses are checked before any data are written, and
the frozen inputs remain unchanged.

The title check concerns the reader-facing result index. Caption wording inside
rendered figures and tables still requires editorial review against the book.
These checks complement financial interpretation and visual review; they do not
prove that every possible modification or untested platform is equivalent.

## Extension checks

Run `Rscript checks/test-extensions.R` from the repository root in its recorded environment.
This checks incoming-applicant encoding against the training matrix, rejects
unknown categories and invalid numeric inputs, verifies heterogeneous portfolio
expected loss and borrower alignment, and deliberately tests missing climate
coverage, duplicates, incorrect units and invalid PDs. These are implementation
checks; they do not validate the economic assumptions of a new application.
