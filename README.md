# Credit Risk Modeling with R

Computational companion by Martín Lozano. Reproduce and extend the book
calculations, tables and figures chapter by chapter. This repository does not
build the publisher PDF. See [release status](RELEASE_STATUS.md).

**Pre-publication access:** this repository is private while the book is being
prepared. Public access is planned for the book's publication, at the same URL.
The credit-scoring data remain excluded pending redistribution permission.

Download the complete repository using **Code > Download ZIP** on GitHub and
extract it, or clone it with Git. Each chapter has an editable `chapter.qmd`;
execution also uses the repository's data, helpers and recorded dependencies.

## Data availability

The credit-scoring dataset is temporarily excluded while redistribution
permission is being clarified. Chapters 1 and 2 include their complete code,
but require that dataset to reproduce the book results. They stop with an
explanatory message when it is absent. No replacement data are downloaded.
See the [data dictionary](data/credit-scoring/README.md).
Foundations and Chapters 3-6 have separate inputs and can run independently.

## Setup

Install R 4.6.1 and Quarto (tested with 1.5.54). LaTeX is not required.
On Windows, also install [Rtools45](https://cran.r-project.org/bin/windows/Rtools/rtools45/rtools.html)
in its recommended location. The pinned `xfun` version requires compilation
when its Windows binary is unavailable. Restart R after installing Rtools.
Open `credit-risk-r.Rproj` or start R from this folder. Restore the recorded
packages once, then check the environment:

```r
renv::restore(prompt = FALSE)
renv::status()
```

R and Quarto are separate installations; renv restores R packages only.
A first restore requires internet access or a populated renv cache. Source
package installation can require platform-specific build tools. On macOS or
Linux, install the compiler and system libraries requested by source packages;
the current clean-install validation targets Windows, not those platforms.

## Run one chapter

From a terminal at the project root:

```sh
Rscript run.R 03-merton
```

Or from the R console:

```r
source("run.R")
run_chapter("03-merton")
```

Each command launches a separate Quarto/R chapter process, with no calculation
caches or previous chapter session required. Edit `chapter.qmd` for extensions.
To execute selected blocks interactively, set the working directory to this
project root and run setup and prerequisite calculations first.

## Chapters

- [Foundations for Applied Credit Risk](chapters/00-foundations/README.md) (`00-foundations`).
- [Logistic credit scoring](chapters/01-logistic/README.md) (`01-logistic`).
- [Tree-based credit scoring](chapters/02-tree-based/README.md) (`02-tree-based`).
- [The Merton model](chapters/03-merton/README.md) (`03-merton`).
- [Credit Spreads and CDS Valuation](chapters/04-credit-spreads-cds/README.md) (`04-credit-spreads-cds`).
- [Portfolio Credit Risk with Copulas](chapters/05-copulas/README.md) (`05-copulas`).
- [Climate Credit Risk](chapters/06-climate-credit-risk/README.md) (`06-climate-credit-risk`).

## Find the code for a book result

Choose a chapter above. Its README lists each numbered figure and table with
a **Code** link to the corresponding block in `chapter.qmd`. Run the chapter
from the beginning so that its data and prerequisite calculations are available.
Result labels such as "Figure 2.6" retain the book's numbering.

## Output

After execution, open `output/<chapter>/chapter.html` in your browser to view
the code and results. These files are created on your computer and are not
published in this repository. Within `output/<chapter>/`, `figures/`
contains numbered PNGs; `tables/` contains CSV and RDS inputs passed to table
formatting, plus rendered table fragments. CSVs can contain display rounding;
`numeric-results.rds` preserves numerical objects used in the calculations.
`session-info.txt` and `loaded-packages.csv` record the actual environment.
Two Merton surface figures use the static views of the printed book.

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
units, including the locally held credit-scoring dataset, passed validation
from an extracted ZIP with a newly restored library
and package caching disabled on Windows 11. The checks matched 991 numerical
objects, 126 CSV tables and all 85 numbered figures against the reference.
That full-data validation is distinct from this public distribution, which
omits the credit-scoring dataset. It does not cover macOS/Linux or future
package updates.

## Licensing and availability

The author-supplied analysis code is licensed under GPL-3.0; see [LICENSE](LICENSE).
Preserve third-party notices, including those in the renv bootstrap script.
Data are not licensed under GPL by this repository; their source terms apply
separately. See [data notes](data/README.md). The code license does not grant
rights to reproduce the publisher's manuscript, layout or PDF.
No private authoring documents or instructor solutions belong in this package.
