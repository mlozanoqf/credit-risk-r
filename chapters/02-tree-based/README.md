# Tree-based credit scoring

**Dataset pending.** The code is available, but full execution and exact
reproduction require the temporarily excluded credit-scoring dataset.
See [availability and dictionary](../../data/credit-scoring/README.md).

From the project root:

```sh
Rscript run.R 02-tree-based
```

This runs the complete chapter in a new R process and writes an HTML results
report, PNG figures, CSV/RDS table inputs, numeric results and session information.
The `chapter.qmd` is the editable source. Code is visible, including formatting.
Run preceding blocks before executing an individual result block.

Chapter 1 helpers rebuild the common cleaning, split and logistic benchmark.
No Chapter 1 session or generated output is required.

## Book result index

| Result | Title | Code | Generated file |
|---|---|---|---|
| Figure 2.1 | A single decision tree for credit scoring. | [Code](chapter.qmd#L112) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-1) | [Output](../../output/02-tree-based/figures/figure-2-1-1.png) |
| Table 2.1 | Terminal leaves of the single decision tree. | [Code](chapter.qmd#L229) / [Report](../../output/02-tree-based/chapter.html#result-table-2-1) | [Output](../../output/02-tree-based/tables/table-2-1.csv) |
| Table 2.2 | Single-tree prediction summary on the test set. | [Code](chapter.qmd#L300) / [Report](../../output/02-tree-based/chapter.html#result-table-2-2) | [Output](../../output/02-tree-based/tables/table-2-2.csv) |
| Table 2.3 | Bridge between credit-scoring objects and XGBoost objects. | [Code](chapter.qmd#L329) / [Report](../../output/02-tree-based/chapter.html#result-table-2-3) | [Output](../../output/02-tree-based/tables/table-2-3.csv) |
| Table 2.4 | Dimensions of the encoded XGBoost design matrices. | [Code](chapter.qmd#L383) / [Report](../../output/02-tree-based/chapter.html#result-table-2-4) | [Output](../../output/02-tree-based/tables/table-2-4.csv) |
| Table 2.5 | XGBoost settings used for the checkpoint path and the full model. | [Code](chapter.qmd#L424) / [Report](../../output/02-tree-based/chapter.html#result-table-2-5) | [Output](../../output/02-tree-based/tables/table-2-5.csv) |
| Table 2.6 | Applicants selected to inspect two XGBoost checkpoint paths. | [Code](chapter.qmd#L550) / [Report](../../output/02-tree-based/chapter.html#result-table-2-6) | [Output](../../output/02-tree-based/tables/table-2-6.csv) |
| Table 2.7 | Selected XGBoost checkpoint corrections for two applicants. | [Code](chapter.qmd#L691) / [Report](../../output/02-tree-based/chapter.html#result-table-2-7) | [Output](../../output/02-tree-based/tables/table-2-7.csv) |
| Table 2.8 | Individual log-loss check for the two selected applicants. | [Code](chapter.qmd#L701) / [Report](../../output/02-tree-based/chapter.html#result-table-2-8) | [Output](../../output/02-tree-based/tables/table-2-8.csv) |
| Table 2.9 | tbl-xgb-two-round-arithmetic | [Code](chapter.qmd#L813) / [Report](../../output/02-tree-based/chapter.html#result-table-2-9) | [Output](../../output/02-tree-based/tables/table-2-9.csv) |
| Table 2.10 | tbl-xgb-five-round-arithmetic | [Code](chapter.qmd#L953) / [Report](../../output/02-tree-based/chapter.html#result-table-2-10) | [Output](../../output/02-tree-based/tables/table-2-10.csv) |
| Figure 2.2 | Predicted PD for two applicants as XGBoost boosting rounds accumulate. | [Code](chapter.qmd#L1025) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-2) | [Output](../../output/02-tree-based/figures/figure-2-2-1.png) |
| Table 2.11 | Inputs used by the XGBoost estimation call. | [Code](chapter.qmd#L1156) / [Report](../../output/02-tree-based/chapter.html#result-table-2-11) | [Output](../../output/02-tree-based/tables/table-2-11.csv) |
| Table 2.12 | Estimated XGBoost model summary. | [Code](chapter.qmd#L1216) / [Report](../../output/02-tree-based/chapter.html#result-table-2-12) | [Output](../../output/02-tree-based/tables/table-2-12.csv) |
| Figure 2.3 | Final predicted PD distributions for the full logistic model and XGBoost. | [Code](chapter.qmd#L1284) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-3) | [Output](../../output/02-tree-based/figures/figure-2-3-1.png) |
| Figure 2.4 | Full logistic-model PDs compared with final XGBoost PDs by observed outcome. | [Code](chapter.qmd#L1373) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-4) | [Output](../../output/02-tree-based/figures/figure-2-4-1.png) |
| Figure 2.5 | XGBoost learning curve: test AUC with train AUC as a diagnostic reference. | [Code](chapter.qmd#L1462) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-5) | [Output](../../output/02-tree-based/figures/figure-2-5-1.png) |
| Table 2.13 | Direct overfitting diagnostic from the XGBoost learning curve. | [Code](chapter.qmd#L1477) / [Report](../../output/02-tree-based/chapter.html#result-table-2-13) | [Output](../../output/02-tree-based/tables/table-2-13.csv) |
| Table 2.14 | Estimation, tuning, final evaluation and monitoring for XGBoost credit scoring. | [Code](chapter.qmd#L1520) / [Report](../../output/02-tree-based/chapter.html#result-table-2-14) | [Output](../../output/02-tree-based/tables/table-2-14.csv) |
| Table 2.15 | XGBoost prediction range and test-set performance summary. | [Code](chapter.qmd#L1560) / [Report](../../output/02-tree-based/chapter.html#result-table-2-15) | [Output](../../output/02-tree-based/tables/table-2-15.csv) |
| Figure 2.6 | XGBoost feature importance. | [Code](chapter.qmd#L1600) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-6) | [Output](../../output/02-tree-based/figures/figure-2-6-1.png) |
| Figure 2.7 | Average absolute XGBoost contribution by feature. | [Code](chapter.qmd#L1640) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-7) | [Output](../../output/02-tree-based/figures/figure-2-7-1.png) |
| Table 2.16 | Predicted PDs for selected test-set applicants. | [Code](chapter.qmd#L1688) / [Report](../../output/02-tree-based/chapter.html#result-table-2-16) | [Output](../../output/02-tree-based/tables/table-2-16.csv) |
| Table 2.17 | Reconstructing John Doe's XGBoost score and predicted PD. | [Code](chapter.qmd#L1715) / [Report](../../output/02-tree-based/chapter.html#result-table-2-17) | [Output](../../output/02-tree-based/tables/table-2-17.csv) |
| Table 2.18 | Largest local XGBoost contributions for John Doe. | [Code](chapter.qmd#L1747) / [Report](../../output/02-tree-based/chapter.html#result-table-2-18) | [Output](../../output/02-tree-based/tables/table-2-18.csv) |
| Figure 2.8 | Partial dependence of XGBoost predicted default probability. | [Code](chapter.qmd#L1790) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-8) | [Output](../../output/02-tree-based/figures/figure-2-8-1.png) |
| Table 2.19 | Out-of-sample performance of the credit-scoring models. | [Code](chapter.qmd#L1918) / [Report](../../output/02-tree-based/chapter.html#result-table-2-19) | [Output](../../output/02-tree-based/tables/table-2-19.csv) |
| Figure 2.9 | ROC curves: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L1975) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-9) | [Output](../../output/02-tree-based/figures/figure-2-9-1.png) |
| Table 2.20 | Probability checks within each model's own risk deciles. | [Code](chapter.qmd#L2012) / [Report](../../output/02-tree-based/chapter.html#result-table-2-20) | [Output](../../output/02-tree-based/tables/table-2-20.csv) |
| Figure 2.10 | Calibration by decile: logistic regression and XGBoost. | [Code](chapter.qmd#L2043) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-10) | [Output](../../output/02-tree-based/figures/figure-2-10-1.png) |
| Figure 2.11 | Bad rate by acceptance rate: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L2074) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-11) | [Output](../../output/02-tree-based/figures/figure-2-11-1.png) |
| Figure 2.12 | Net payoff by acceptance rate: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L2103) / [Report](../../output/02-tree-based/chapter.html#result-figure-2-12) | [Output](../../output/02-tree-based/figures/figure-2-12-1.png) |
| Table 2.21 | Numerical check of the overall best net-payoff strategy. | [Code](chapter.qmd#L2156) / [Report](../../output/02-tree-based/chapter.html#result-table-2-21) | [Output](../../output/02-tree-based/tables/table-2-21.csv) |
| Table 2.22 | Best net-payoff row by model. | [Code](chapter.qmd#L2187) / [Report](../../output/02-tree-based/chapter.html#result-table-2-22) | [Output](../../output/02-tree-based/tables/table-2-22.csv) |
| Table 2.23 | Governance checklist for moving from a tree-based score to a credit policy. | [Code](chapter.qmd#L2213) / [Report](../../output/02-tree-based/chapter.html#result-table-2-23) | [Output](../../output/02-tree-based/tables/table-2-23.csv) |
