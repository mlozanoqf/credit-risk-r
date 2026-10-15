# Tree-based credit scoring

**Frozen data included.** The complete private checkout supplies the dataset
used for this chapter, with a source and modification notice.
See [availability and dictionary](../../data/credit-scoring/README.md).

From the project root:

```sh
Rscript run.R 02-tree-based
```

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

Chapter 1 helpers rebuild the common cleaning, split and logistic benchmark.
No Chapter 1 session or generated output is required.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Figure 2.1 | A single decision tree for credit scoring. | [Code](chapter.qmd#L112) |
| Table 2.1 | Terminal leaves of the single decision tree. | [Code](chapter.qmd#L229) |
| Table 2.2 | Single-tree prediction summary on the test set. | [Code](chapter.qmd#L300) |
| Table 2.3 | Bridge between credit-scoring objects and XGBoost objects. | [Code](chapter.qmd#L329) |
| Table 2.4 | Dimensions of the encoded XGBoost design matrices. | [Code](chapter.qmd#L383) |
| Table 2.5 | XGBoost settings used for the checkpoint path and the full model. | [Code](chapter.qmd#L424) |
| Table 2.6 | Applicants selected to inspect two XGBoost checkpoint paths. | [Code](chapter.qmd#L550) |
| Table 2.7 | Selected XGBoost checkpoint corrections for two applicants. | [Code](chapter.qmd#L691) |
| Table 2.8 | Individual log-loss check for the two selected applicants. | [Code](chapter.qmd#L701) |
| Table 2.9 | tbl-xgb-two-round-arithmetic | [Code](chapter.qmd#L813) |
| Table 2.10 | tbl-xgb-five-round-arithmetic | [Code](chapter.qmd#L953) |
| Figure 2.2 | Predicted PD for two applicants as XGBoost boosting rounds accumulate. | [Code](chapter.qmd#L1025) |
| Table 2.11 | Inputs used by the XGBoost estimation call. | [Code](chapter.qmd#L1156) |
| Table 2.12 | Estimated XGBoost model summary. | [Code](chapter.qmd#L1216) |
| Figure 2.3 | Final predicted PD distributions for the full logistic model and XGBoost. | [Code](chapter.qmd#L1284) |
| Figure 2.4 | Full logistic-model PDs compared with final XGBoost PDs by observed outcome. | [Code](chapter.qmd#L1373) |
| Figure 2.5 | XGBoost learning curve: test AUC with train AUC as a diagnostic reference. | [Code](chapter.qmd#L1462) |
| Table 2.13 | Direct overfitting diagnostic from the XGBoost learning curve. | [Code](chapter.qmd#L1477) |
| Table 2.14 | Estimation, tuning, final evaluation and monitoring for XGBoost credit scoring. | [Code](chapter.qmd#L1520) |
| Table 2.15 | XGBoost prediction range and test-set performance summary. | [Code](chapter.qmd#L1560) |
| Figure 2.6 | XGBoost feature importance. | [Code](chapter.qmd#L1600) |
| Figure 2.7 | Average absolute XGBoost contribution by feature. | [Code](chapter.qmd#L1640) |
| Table 2.16 | Predicted PDs for selected test-set applicants. | [Code](chapter.qmd#L1688) |
| Table 2.17 | Reconstructing John Doe's XGBoost score and predicted PD. | [Code](chapter.qmd#L1715) |
| Table 2.18 | Largest local XGBoost contributions for John Doe. | [Code](chapter.qmd#L1747) |
| Figure 2.8 | Partial dependence of XGBoost predicted default probability. | [Code](chapter.qmd#L1790) |
| Table 2.19 | Out-of-sample performance of the credit-scoring models. | [Code](chapter.qmd#L1918) |
| Figure 2.9 | ROC curves: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L1975) |
| Table 2.20 | Probability checks within each model's own risk deciles. | [Code](chapter.qmd#L2012) |
| Figure 2.10 | Calibration by decile: logistic regression and XGBoost. | [Code](chapter.qmd#L2043) |
| Figure 2.11 | Bad rate by acceptance rate: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L2074) |
| Figure 2.12 | Net payoff by acceptance rate: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L2103) |
| Table 2.21 | Numerical check of the overall best net-payoff strategy. | [Code](chapter.qmd#L2156) |
| Table 2.22 | Best net-payoff row by model. | [Code](chapter.qmd#L2187) |
| Table 2.23 | Governance checklist for moving from a tree-based score to a credit policy. | [Code](chapter.qmd#L2213) |
