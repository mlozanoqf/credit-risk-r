# Climate Credit Risk

From the project root:

```sh
Rscript run.R 06-climate-credit-risk
```

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

The default run uses frozen raw data. API/download examples are not executed.
Refreshing data is an explicit extension and can change the results.

For an optional refresh, run from the project root:

```r
source("chapters/06-climate-credit-risk/helpers/download-data.R")
download_ngfs_data(destination = "tmp/ngfs-refresh")
```

`source()` only defines the helpers; it does not download data. The explicit
download call requires a new destination directory that does not already exist.
It leaves the frozen files in `data/climate` unchanged.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Table 6.1 | Global NGFS short-term CLIMACRED scenarios used in the main analysis. | [Code](chapter.qmd#L87) |
| Table 6.2 | How transition and physical climate risk enter credit analysis in this chapter. | [Code](chapter.qmd#L118) |
| Table 6.3 | CLIMACRED variables used in the chapter. | [Code](chapter.qmd#L152) |
| Table 6.4 | Sector portfolio used for the climate credit-risk application. | [Code](chapter.qmd#L342) |
| Table 6.5 | Raw NGFS/IIASA files used in the chapter. | [Code](chapter.qmd#L363) |
| Table 6.6 | First rows of the raw global CLIMACRED file. | [Code](chapter.qmd#L376) |
| Table 6.7 | Data provenance for the climate credit-risk workflow. | [Code](chapter.qmd#L385) |
| Table 6.8 | Cleaned CLIMACRED credit variables for Highway to Paris in 2030. | [Code](chapter.qmd#L469) |
| Figure 6.1 | Maximum regional physical-risk PD adjustments over 2024-2030 in selected CLIMACRED DAPS runs. | [Code](chapter.qmd#L570) |
| Table 6.9 | Inputs needed to turn physical climate risk into a full credit-risk model. | [Code](chapter.qmd#L599) |
| Table 6.10 | Present value of five-year portfolio expected loss with and without the CLIMACRED climate adjustment. | [Code](chapter.qmd#L731) |
| Table 6.11 | Coal expected-loss mechanics under Highway to Paris. | [Code](chapter.qmd#L747) |
| Figure 6.2 | Present value of five-year portfolio expected loss with and without CLIMACRED climate adjustments. | [Code](chapter.qmd#L765) |
| Figure 6.3 | Sector contributions to the climate-related change in five-year discounted expected loss. | [Code](chapter.qmd#L790) |
| Figure 6.4 | Climate PD adjustments by scenario and sector in 2030. | [Code](chapter.qmd#L827) |
| Figure 6.5 | Baseline and climate-adjusted PD paths under Highway to Paris. | [Code](chapter.qmd#L885) |
| Table 6.12 | Largest 2030 CLIMACRED corporate bond spread adjustments by scenario. | [Code](chapter.qmd#L919) |
| Figure 6.6 | CLIMACRED bond spread adjustments compared with changes in the PD x LGD benchmark. | [Code](chapter.qmd#L965) |
| Table 6.13 | One-year simulated portfolio loss in 2030 under Highway to Paris. | [Code](chapter.qmd#L1084) |
| Table 6.14 | Credit scores and default cutoffs for two sectors in one simulated row. | [Code](chapter.qmd#L1123) |
| Figure 6.7 | Baseline and climate-adjusted one-year portfolio loss distributions in 2030 under Highway to Paris. | [Code](chapter.qmd#L1143) |
