# Logistic credit scoring

**Dataset pending.** The code is available, but full execution and exact
reproduction require the temporarily excluded credit-scoring dataset.
See [availability and dictionary](../../data/credit-scoring/README.md).

From the project root:

```sh
Rscript run.R 01-logistic
```

This runs the complete chapter in a new R process and writes an HTML results
report, PNG figures, CSV/RDS table inputs, numeric results and session information.
The `chapter.qmd` is the editable source. Code is visible, including formatting.
Run preceding blocks before executing an individual result block.

## Book result index

| Result | Title | Code | Generated file |
|---|---|---|---|
| Table 1.1 | Variable names used in the chapter. | [Code](chapter.qmd#L64) / [Report](../../output/01-logistic/chapter.html#result-table-1-1) | [Output](../../output/01-logistic/tables/table-1-1.csv) |
| Table 1.2 | First 10 loan records before cleaning. | [Code](chapter.qmd#L82) / [Report](../../output/01-logistic/chapter.html#result-table-1-2) | [Output](../../output/01-logistic/tables/table-1-2.csv) |
| Table 1.3 | Loan counts by home ownership. | [Code](chapter.qmd#L103) / [Report](../../output/01-logistic/chapter.html#result-table-1-3) | [Output](../../output/01-logistic/tables/table-1-3.csv) |
| Table 1.4 | Default rate by home-ownership category. | [Code](chapter.qmd#L124) / [Report](../../output/01-logistic/chapter.html#result-table-1-4) | [Output](../../output/01-logistic/tables/table-1-4.csv) |
| Figure 1.1 | Interest rate histogram. | [Code](chapter.qmd#L148) / [Report](../../output/01-logistic/chapter.html#result-figure-1-1) | [Output](../../output/01-logistic/figures/figure-1-1-1.png) |
| Figure 1.2 | Annual income dotplot. | [Code](chapter.qmd#L166) / [Report](../../output/01-logistic/chapter.html#result-figure-1-2) | [Output](../../output/01-logistic/figures/figure-1-2-1.png) |
| Figure 1.3 | Annual income without extreme values. | [Code](chapter.qmd#L195) / [Report](../../output/01-logistic/chapter.html#result-figure-1-3) | [Output](../../output/01-logistic/figures/figure-1-3-1.png) |
| Figure 1.4 | Sigmoid curve or logistic curve: age model. | [Code](chapter.qmd#L323) / [Report](../../output/01-logistic/chapter.html#result-figure-1-4) | [Output](../../output/01-logistic/figures/figure-1-4-1.png) |
| Table 1.5 | Coefficient and odds-ratio interpretation for `logi_multi`. | [Code](chapter.qmd#L442) / [Report](../../output/01-logistic/chapter.html#result-table-1-5) | [Output](../../output/01-logistic/tables/table-1-5.csv) |
| Table 1.6 | AIC comparison across logistic model candidates. | [Code](chapter.qmd#L509) / [Report](../../output/01-logistic/chapter.html#result-table-1-6) | [Output](../../output/01-logistic/tables/table-1-6.csv) |
| Figure 1.5 | Predicted PDs from the age-only model across the test set. | [Code](chapter.qmd#L584) / [Report](../../output/01-logistic/chapter.html#result-figure-1-5) | [Output](../../output/01-logistic/figures/figure-1-5-1.png) |
| Figure 1.6 | Narrow distribution of age-only predicted PDs. | [Code](chapter.qmd#L601) / [Report](../../output/01-logistic/chapter.html#result-figure-1-6) | [Output](../../output/01-logistic/figures/figure-1-6-1.png) |
| Figure 1.7 | Prediction distributions for the interest-rate and multi-factor models. | [Code](chapter.qmd#L625) / [Report](../../output/01-logistic/chapter.html#result-figure-1-7) | [Output](../../output/01-logistic/figures/figure-1-7-1.png) |
| Figure 1.8 | Prediction ranges across age, interest-rate, and multi-factor models. | [Code](chapter.qmd#L643) / [Report](../../output/01-logistic/chapter.html#result-figure-1-8) | [Output](../../output/01-logistic/figures/figure-1-8-1.png) |
| Figure 1.9 | Sigmoid curve or logistic curve: full-model score. | [Code](chapter.qmd#L707) / [Report](../../output/01-logistic/chapter.html#result-figure-1-9) | [Output](../../output/01-logistic/figures/figure-1-9-1.png) |
| Table 1.7 | Prediction ranges and AIC across logistic model candidates. | [Code](chapter.qmd#L772) / [Report](../../output/01-logistic/chapter.html#result-table-1-7) | [Output](../../output/01-logistic/tables/table-1-7.csv) |
| Figure 1.10 | Prediction distributions for the multi-factor and full models. | [Code](chapter.qmd#L804) / [Report](../../output/01-logistic/chapter.html#result-figure-1-10) | [Output](../../output/01-logistic/figures/figure-1-10-1.png) |
| Figure 1.11 | Prediction ranges across all logistic model candidates. | [Code](chapter.qmd#L822) / [Report](../../output/01-logistic/chapter.html#result-figure-1-11) | [Output](../../output/01-logistic/figures/figure-1-11-1.png) |
| Figure 1.12 | Full-model predicted PDs with a 15% cutoff. | [Code](chapter.qmd#L858) / [Report](../../output/01-logistic/chapter.html#result-figure-1-12) | [Output](../../output/01-logistic/figures/figure-1-12-1.png) |
| Figure 1.13 | Full-model prediction distribution with a 15% cutoff. | [Code](chapter.qmd#L899) / [Report](../../output/01-logistic/chapter.html#result-figure-1-13) | [Output](../../output/01-logistic/figures/figure-1-13-1.png) |
| Table 1.8 | First six full-model predictions after applying the 15% cutoff. | [Code](chapter.qmd#L941) / [Report](../../output/01-logistic/chapter.html#result-table-1-8) | [Output](../../output/01-logistic/tables/table-1-8.csv) |
| Table 1.9 | Ten test-set cases comparing predicted PD, cutoff decision, observed outcome, and credit consequence. | [Code](chapter.qmd#L980) / [Report](../../output/01-logistic/chapter.html#result-table-1-9) | [Output](../../output/01-logistic/tables/table-1-9.csv) |
| Table 1.10 | Accuracy can reward poor credit-screening rules. | [Code](chapter.qmd#L1028) / [Report](../../output/01-logistic/chapter.html#result-table-1-10) | [Output](../../output/01-logistic/tables/table-1-10.csv) |
| Figure 1.14 | Full model prediction histogram with acceptance-rate cutoff. | [Code](chapter.qmd#L1063) / [Report](../../output/01-logistic/chapter.html#result-figure-1-14) | [Output](../../output/01-logistic/figures/figure-1-14-1.png) |
| Table 1.11 | Cutoffs implied by target acceptance rates. | [Code](chapter.qmd#L1101) / [Report](../../output/01-logistic/chapter.html#result-table-1-11) | [Output](../../output/01-logistic/tables/table-1-11.csv) |
| Table 1.12 | Classification outcomes under the 15% cutoff and the 80% acceptance rule. | [Code](chapter.qmd#L1145) / [Report](../../output/01-logistic/chapter.html#result-table-1-12) | [Output](../../output/01-logistic/tables/table-1-12.csv) |
| Table 1.13 | Sample of test-set outcomes under the 80% acceptance rule. | [Code](chapter.qmd#L1180) / [Report](../../output/01-logistic/chapter.html#result-table-1-13) | [Output](../../output/01-logistic/tables/table-1-13.csv) |
| Table 1.14 | First 12 accept/reject decisions with ex-post evaluation. | [Code](chapter.qmd#L1225) / [Report](../../output/01-logistic/chapter.html#result-table-1-14) | [Output](../../output/01-logistic/tables/table-1-14.csv) |
| Table 1.15 | First 10 accepted applications and their observed outcomes. | [Code](chapter.qmd#L1269) / [Report](../../output/01-logistic/chapter.html#result-table-1-15) | [Output](../../output/01-logistic/tables/table-1-15.csv) |
| Table 1.16 | Bad rate among accepted loans at the 80% acceptance rule. | [Code](chapter.qmd#L1284) / [Report](../../output/01-logistic/chapter.html#result-table-1-16) | [Output](../../output/01-logistic/tables/table-1-16.csv) |
| Table 1.17 | Bad rate among accepted loans at the 65% acceptance rule. | [Code](chapter.qmd#L1317) / [Report](../../output/01-logistic/chapter.html#result-table-1-17) | [Output](../../output/01-logistic/tables/table-1-17.csv) |
| Table 1.18 | Bad rate by target acceptance rate for the age-only and full logistic models. | [Code](chapter.qmd#L1376) / [Report](../../output/01-logistic/chapter.html#result-table-1-18) | [Output](../../output/01-logistic/tables/table-1-18.csv) |
| Figure 1.15 | Bad-rate comparison between the age-only model and the full model. | [Code](chapter.qmd#L1409) / [Report](../../output/01-logistic/chapter.html#result-figure-1-15) | [Output](../../output/01-logistic/figures/figure-1-15-1.png) |
| Table 1.19 | Net payoff across acceptance rates for the full logistic model. | [Code](chapter.qmd#L1483) / [Report](../../output/01-logistic/chapter.html#result-table-1-19) | [Output](../../output/01-logistic/tables/table-1-19.csv) |
| Table 1.20 | Numerical check of the best net-payoff row. | [Code](chapter.qmd#L1502) / [Report](../../output/01-logistic/chapter.html#result-table-1-20) | [Output](../../output/01-logistic/tables/table-1-20.csv) |
| Table 1.21 | Net-payoff sensitivity to the cost of accepting a default. | [Code](chapter.qmd#L1558) / [Report](../../output/01-logistic/chapter.html#result-table-1-21) | [Output](../../output/01-logistic/tables/table-1-21.csv) |
| Table 1.22 | Confusion-matrix language translated into credit decisions. | [Code](chapter.qmd#L1598) / [Report](../../output/01-logistic/chapter.html#result-table-1-22) | [Output](../../output/01-logistic/tables/table-1-22.csv) |
| Table 1.23 | Sensitivity, specificity, and error rates in credit language. | [Code](chapter.qmd#L1642) / [Report](../../output/01-logistic/chapter.html#result-table-1-23) | [Output](../../output/01-logistic/tables/table-1-23.csv) |
| Figure 1.16 | ROC curves: Full model in blue, age model in orange. | [Code](chapter.qmd#L1716) / [Report](../../output/01-logistic/chapter.html#result-figure-1-16) | [Output](../../output/01-logistic/figures/figure-1-16-1.png) |
| Table 1.24 | Calibration by predicted-risk decile for the full and age-only models. | [Code](chapter.qmd#L1785) / [Report](../../output/01-logistic/chapter.html#result-table-1-24) | [Output](../../output/01-logistic/tables/table-1-24.csv) |
| Figure 1.17 | Calibration by decile: full model in blue, age model in orange. | [Code](chapter.qmd#L1814) / [Report](../../output/01-logistic/chapter.html#result-figure-1-17) | [Output](../../output/01-logistic/figures/figure-1-17-1.png) |
| Table 1.25 | Brier score and Brier skill against a constant default-rate benchmark. | [Code](chapter.qmd#L1882) / [Report](../../output/01-logistic/chapter.html#result-table-1-25) | [Output](../../output/01-logistic/tables/table-1-25.csv) |
| Table 1.26 | Cutoffs and error rates implied by two acceptance policies. | [Code](chapter.qmd#L1955) / [Report](../../output/01-logistic/chapter.html#result-table-1-26) | [Output](../../output/01-logistic/tables/table-1-26.csv) |
| Figure 1.18 | Full model in blue, evaluated in two acceptance rates: 65% in black, 80% in red. | [Code](chapter.qmd#L2009) / [Report](../../output/01-logistic/chapter.html#result-figure-1-18) | [Output](../../output/01-logistic/figures/figure-1-18-1.png) |
| Figure 1.19 | Random-score ROC benchmark. | [Code](chapter.qmd#L2178) / [Report](../../output/01-logistic/chapter.html#result-figure-1-19) | [Output](../../output/01-logistic/figures/figure-1-19-1.png) |
| Figure 1.20 | Perfect-score ROC benchmark. | [Code](chapter.qmd#L2227) / [Report](../../output/01-logistic/chapter.html#result-figure-1-20) | [Output](../../output/01-logistic/figures/figure-1-20-1.png) |
