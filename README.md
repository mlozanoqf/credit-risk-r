# Credit Risk Modeling with R

Computational companion by Martín Lozano. Use it alongside the book to reproduce
and extend its calculations, tables and figures, one chapter at a time.
The chapter runner generates a local HTML report containing code and results, plus separate
figure and table files. This repository does not build the publisher PDF.

**Public access:** this repository is freely accessible on GitHub.
The complete frozen credit-scoring data are included. See [release status](RELEASE_STATUS.md)
and the [provenance note](data/credit-scoring/PROVENANCE.md).

## First time: prepare your computer

The recommended route uses RStudio. Once the complete ZIP is downloaded, running
the calculations requires neither Git nor a GitHub account, LaTeX or the publisher's template.

1. On this GitHub page, choose **Code > Download ZIP**. Extract the entire ZIP
   into a folder on your computer. Work in the extracted folder, not inside the
   ZIP. Keep its files together; a chapter uses the supplied data and helpers.
2. Install [R](https://cran.r-project.org/), [RStudio Desktop](https://posit.co/download/rstudio-desktop/)
   and [Quarto](https://quarto.org/docs/get-started/). The recorded environment
   uses **R 4.6.1** and **Quarto 1.5.54**. R performs the calculations, RStudio is
   the application in which you work, and Quarto produces the report.
   On Windows, also install [Rtools45](https://cran.r-project.org/bin/windows/Rtools/rtools45/rtools.html)
   in its recommended location, as used in our tested setup. The recorded
   `xfun` package may need compilation. Restart RStudio after installation.
3. In RStudio, choose **File > Open Project** and select `credit-risk-r.Rproj`
   in the extracted folder. This sets the working folder correctly. At startup,
   `renv` may ask to download its own recorded version; allow it to continue.
   A message that packages need restoring is expected on a first opening.
4. In RStudio's **Console** (the pane with the `>` prompt, not the Terminal),
   paste the following lines. Do not type the `>` prompt yourself.

```r
renv::restore(prompt = FALSE)
source("start.R")
check_setup()
```

`renv` installs the recorded R package versions in the project's library. It
does not install R, RStudio or Quarto. The first restore needs internet access
or an existing package cache and can take time, especially when compiling.
Wait for the Console's `>` prompt to return. **Setup check passed** confirms
that the package environment matches its record and Quarto can start; it does
not yet mean that a chapter has run. A warning about a different R or Quarto
version identifies a departure from the tested environment.

These instructions were validated on Windows. On macOS/Linux, source packages
may require compilers and system libraries; those platforms have not undergone
the same clean-install validation. See [troubleshooting](#if-something-stops).

## First result: run Foundations

With the project still open, run this in the RStudio **Console**:

```r
source("start.R")
start_chapter("00-foundations")
```

Keep RStudio open while Quarto prints its progress. When the run succeeds, the
Console prints **Complete:** and **Your report is ready:**, followed by a file
path. The HTML report opens in your browser. If it does not open automatically,
double-click `output/00-foundations/chapter.html` in the extracted folder.
Do not open `chapter.qmd` to view the finished report; that is the editable source.

## Next time: choose any chapter

Open `credit-risk-r.Rproj` again. In the **Console**, run:

```r
source("start.R")
start_chapter()
```

Choose a chapter from the numbered menu; enter `0` to leave without running one.
For a particular chapter, use its ID, for example `start_chapter("03-merton")`.
Each chapter runs in a fresh R process and prepares its own inputs. You do not
have to execute previous chapters first. You normally restore packages only
on first setup or after deliberately updating the downloaded companion.

The selector checks setup, calls the existing `run.R` executor and opens the
report only after the executor succeeds. Calculations, seeds and output checks
are the same with either entry point. Use `open = FALSE` to keep the report closed.

## Chapters and code for a book result

Choose a chapter below. Its README lists the numbered figures and tables from
the book. Each **Code** link points to the corresponding block in `chapter.qmd`
on GitHub. To change the calculation, open the local copy of that QMD in RStudio.

- [Foundations for Applied Credit Risk](chapters/00-foundations/README.md) (`00-foundations`).
- [Logistic credit scoring](chapters/01-logistic/README.md) (`01-logistic`).
- [Tree-based credit scoring](chapters/02-tree-based/README.md) (`02-tree-based`).
- [The Merton model](chapters/03-merton/README.md) (`03-merton`).
- [Credit Spreads and CDS Valuation](chapters/04-credit-spreads-cds/README.md) (`04-credit-spreads-cds`).
- [Portfolio Credit Risk with Copulas](chapters/05-copulas/README.md) (`05-copulas`).
- [Climate Credit Risk](chapters/06-climate-credit-risk/README.md) (`06-climate-credit-risk`).

Run the complete chapter before studying an individual result. A result block
can depend on objects created earlier. For extensions, first reproduce the
unchanged chapter, then edit its QMD and run it again through `start_chapter()`.
An intentional change can alter results. Save copies of outputs you want to
compare outside `output/`, because rerunning replaces the chapter's outputs.
Keep the supplied data, seeds and versions unchanged for your initial replication.

## Output

All generated results stay on your computer, under `output/<chapter>/`:

- `chapter.html` shows the chapter code and results in your browser.
- `figures/` holds the numbered PNG figures.
- `tables/` holds CSV and RDS inputs passed to table formatting, plus rendered
  table fragments. CSVs can contain display rounding.
- `numeric-results.rds` preserves numerical objects used in calculations.
- `session-info.txt` and `loaded-packages.csv` record the actual environment.

For example, a Merton run creates `output/03-merton/chapter.html`. These reports
are generated locally rather than stored on GitHub. Two Merton surface figures
use the static views of the printed book.

## If something stops

| What you see | What to do |
|---|---|
| R cannot find `start.R` or `chapters.json` | Open `credit-risk-r.Rproj`, then retry in the Console. The project must be extracted from the ZIP. |
| `renv` is unavailable | Reopen the project and allow its startup prompt to install `renv`. Check internet access if that installation fails. |
| Missing packages or an environment mismatch | Run `renv::restore(prompt = FALSE)`, then `check_setup()` again. Read any remaining `renv::status()` messages; do not use `renv::snapshot()` simply to silence them. |
| A package fails to compile on Windows | Confirm Rtools45 is installed in its recommended location, restart RStudio, and retry restore. Retain the first installation error if it persists. |
| Quarto was not found | Install Quarto, restart RStudio and rerun `check_setup()`. |
| A chapter stops with an error | Retain the first error, chapter ID and setup version messages. Do not treat a previously generated HTML as the result of the failed run. |
| The browser does not open | Open `output/<chapter>/chapter.html` manually after a successful run. |

The starter never installs packages or downloads replacement data automatically.
Setup checks diagnose the environment; successful chapter runs also check input
integrity and fresh numbered outputs. Full numerical regression tests are
available under [maintenance and verification](MAINTENANCE.md).

## Data and instructor resources

Chapters 1 and 2 include `data/credit-scoring/credit_scoring.rds` with 30,024
records before cleaning. See the [dictionary](data/credit-scoring/README.md)
and [source note](data/credit-scoring/PROVENANCE.md). Foundations and Chapters
3-6 have separate inputs and run independently. See [all data notes](data/README.md).

The *Instructor's Manual* is available through the publisher's password-protected
Instructor Hub, reserved for instructors. It uses this complete repository together with a separately
distributed, restricted instructor code package. Solutions reuse the book's
frozen inputs and shared R functions and add exercise-specific calculations.
The instructor package README identifies the compatible companion revision and
its own runner. `start_chapter()` and `run.R` here generate book results, not
instructor solutions. Access to the instructor package is separate.

## Alternative execution and maintenance

Experienced users can keep using `Rscript run.R 03-merton` from a terminal in
the project folder, or `source("run.R"); run_chapter("03-merton")` in R.
Using Quarto's Render button alone does not perform all the executor's output
checks or create its verification record. Use one of the provided runners for
the complete workflow.

See [maintenance](MAINTENANCE.md) for repository structure, validation history
and full test commands. These are not prerequisites for reading the first report.

## License

Author-supplied analysis code is licensed under GPL-3.0; see [LICENSE](LICENSE).
Preserve third-party notices, including those in the renv bootstrap script.
Data have separate source terms and are not licensed under GPL by this repository.
The code license does not grant rights to reproduce the publisher's manuscript,
layout or PDF. Private authoring documents and instructor solutions are excluded.
