# Foundations for Applied Credit Risk

From the project root:

```sh
Rscript run.R 00-foundations
```

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

Foundations uses unnumbered worked calculations. Follow them in `chapter.qmd`
from the beginning.

The segment-prediction and two-loan simulation blocks match the October 14
Foundations additions. Setup uses `shared/formatting.R` and
`shared/figure-theme.R` from this repository root, as printed in the book.
The October 15 bond example calibrates a risk-neutral default probability
and values default protection by both replication and discounted expected
payment. These blocks, the supplied-PD simulation and the historical-frequency
prediction rule are independent of the Chapter 1/2 loan dataset.
