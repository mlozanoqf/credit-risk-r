# Logistic credit scoring

**Frozen data included.** The complete repository supplies the dataset
used for this chapter, with a brief provenance note.
See [availability and dictionary](../../data/credit-scoring/README.md).

First use? Complete the [setup walkthrough](../../README.md#first-time-prepare-your-computer).
Open `credit-risk-r.Rproj` and run these commands in the RStudio **Console**:

```r
source("start.R")
start_chapter("01-logistic")
```

After **Complete:** appears, the browser opens `output/01-logistic/chapter.html`.
If it stays closed, open that file manually from the extracted project folder.

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Table 1.1 | Variable names used in the chapter. | [Code](chapter.qmd#L68) |
| Table 1.2 | First 10 loan records before cleaning. | [Code](chapter.qmd#L86) |
| Table 1.3 | Loan counts by home ownership. | [Code](chapter.qmd#L107) |
| Table 1.4 | Default rate by home-ownership category. | [Code](chapter.qmd#L128) |
| Figure 1.1 | Interest rate histogram. | [Code](chapter.qmd#L152) |
| Figure 1.2 | Annual income dotplot. | [Code](chapter.qmd#L170) |
| Figure 1.3 | Annual income after excluding values above $1,000,000. | [Code](chapter.qmd#L199) |
| Figure 1.4 | Sigmoid curve or logistic curve: age model. | [Code](chapter.qmd#L327) |
| Table 1.5 | Coefficient and odds-ratio interpretation for `logi_multi`. | [Code](chapter.qmd#L446) |
| Table 1.6 | AIC comparison across logistic model candidates. | [Code](chapter.qmd#L513) |
| Figure 1.5 | Predicted PDs from the age-only model across the test set. | [Code](chapter.qmd#L588) |
| Figure 1.6 | Narrow distribution of age-only predicted PDs. | [Code](chapter.qmd#L605) |
| Figure 1.7 | Prediction distributions for the interest-rate and multi-factor models. | [Code](chapter.qmd#L629) |
| Figure 1.8 | Prediction ranges across age, interest-rate, and multi-factor models. | [Code](chapter.qmd#L647) |
| Figure 1.9 | Sigmoid curve or logistic curve: full-model score. | [Code](chapter.qmd#L711) |
| Table 1.7 | Prediction ranges and AIC across logistic model candidates. | [Code](chapter.qmd#L776) |
| Figure 1.10 | Prediction distributions for the multi-factor and full models. | [Code](chapter.qmd#L808) |
| Figure 1.11 | Prediction ranges across all logistic model candidates. | [Code](chapter.qmd#L826) |
| Figure 1.12 | Full-model predicted PDs with a 15% cutoff. | [Code](chapter.qmd#L862) |
| Figure 1.13 | Full-model prediction distribution with a 15% cutoff. | [Code](chapter.qmd#L903) |
| Table 1.8 | First six full-model predictions after applying the 15% cutoff. | [Code](chapter.qmd#L945) |
| Table 1.9 | Ten test-set cases comparing predicted PD, cutoff decision, observed outcome, and credit consequence. | [Code](chapter.qmd#L984) |
| Table 1.10 | Accuracy can reward poor credit-screening rules. | [Code](chapter.qmd#L1034) |
| Figure 1.14 | Full-model predicted-PD density with the 80% acceptance cutoff. | [Code](chapter.qmd#L1069) |
| Table 1.11 | Cutoffs implied by target acceptance rates. | [Code](chapter.qmd#L1107) |
| Table 1.12 | Classification outcomes under the 15% cutoff and the 80% acceptance rule. | [Code](chapter.qmd#L1151) |
| Table 1.13 | Sample of test-set outcomes under the 80% acceptance rule. | [Code](chapter.qmd#L1186) |
| Table 1.14 | First 12 accept/reject decisions with ex-post evaluation. | [Code](chapter.qmd#L1232) |
| Table 1.15 | First 10 accepted applications and their observed outcomes. | [Code](chapter.qmd#L1276) |
| Table 1.16 | Bad rate among accepted loans at the 80% acceptance rule. | [Code](chapter.qmd#L1291) |
| Table 1.17 | Bad rate among accepted loans at the 65% acceptance rule. | [Code](chapter.qmd#L1324) |
| Table 1.18 | Bad rate by target acceptance rate for the age-only and full logistic models. | [Code](chapter.qmd#L1383) |
| Figure 1.15 | Bad-rate comparison between the age-only model and the full model. | [Code](chapter.qmd#L1416) |
| Table 1.19 | Net payoff across acceptance rates for the full logistic model. | [Code](chapter.qmd#L1490) |
| Table 1.20 | Numerical check of the best net-payoff row. | [Code](chapter.qmd#L1510) |
| Table 1.21 | Net-payoff sensitivity to the cost of accepting a default. | [Code](chapter.qmd#L1566) |
| Table 1.22 | Confusion-matrix language translated into credit decisions. | [Code](chapter.qmd#L1608) |
| Table 1.23 | Sensitivity, specificity, and error rates in credit language. | [Code](chapter.qmd#L1652) |
| Figure 1.16 | ROC curves: Full model in blue, age model in orange. | [Code](chapter.qmd#L1726) |
| Table 1.24 | Calibration by predicted-risk decile for the full and age-only models. | [Code](chapter.qmd#L1795) |
| Figure 1.17 | Calibration by decile: full model in blue, age model in orange. | [Code](chapter.qmd#L1824) |
| Table 1.25 | Brier score and Brier skill against a constant default-rate benchmark. | [Code](chapter.qmd#L1892) |
| Table 1.26 | Cutoffs, sensitivity, and specificity under two acceptance policies. | [Code](chapter.qmd#L1965) |
| Figure 1.18 | Full-model ROC curve (blue) with 65% (black) and 80% (red) acceptance policies. | [Code](chapter.qmd#L2019) |
| Figure 1.19 | Random-score ROC benchmark. | [Code](chapter.qmd#L2188) |
| Figure 1.20 | Perfect-score ROC benchmark. | [Code](chapter.qmd#L2237) |
