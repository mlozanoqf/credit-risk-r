# Tree-based credit scoring

**Frozen data included.** The complete repository supplies the dataset
used for this chapter, with a brief provenance note.
See [availability and dictionary](../../data/credit-scoring/README.md).

First use? Complete the [setup walkthrough](../../README.md#first-time-prepare-your-computer).
Open `credit-risk-r.Rproj` and run these commands in the RStudio **Console**:

```r
source("start.R")
start_chapter("02-tree-based")
```

After **Complete:** appears, the browser opens `output/02-tree-based/chapter.html`.
If it stays closed, open that file manually from the extracted project folder.

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

Chapter 1 helpers rebuild the common cleaning, split and logistic benchmark.
No Chapter 1 session or generated output is required.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Figure 2.1 | A single decision tree for credit scoring. | [Code](chapter.qmd#L114) |
| Table 2.1 | Terminal leaves of the single decision tree. | [Code](chapter.qmd#L231) |
| Table 2.2 | Single-tree prediction summary on the test set. | [Code](chapter.qmd#L302) |
| Table 2.3 | Bridge between credit-scoring objects and XGBoost objects. | [Code](chapter.qmd#L331) |
| Table 2.4 | Dimensions of the encoded XGBoost design matrices. | [Code](chapter.qmd#L385) |
| Table 2.5 | XGBoost settings used for the checkpoint path and the full model. | [Code](chapter.qmd#L426) |
| Table 2.6 | Applicants selected to inspect two XGBoost checkpoint paths. | [Code](chapter.qmd#L554) |
| Table 2.7 | Selected XGBoost checkpoint corrections for two applicants. | [Code](chapter.qmd#L695) |
| Table 2.8 | Individual log-loss check for the two selected applicants. | [Code](chapter.qmd#L705) |
| Table 2.9 | First two XGBoost rounds for test-set applicant 7127: code values and algebraic updates. | [Code](chapter.qmd#L817) |
| Table 2.10 | First five boosting rounds for test-set applicant 7127: code value, score update, and PD. | [Code](chapter.qmd#L957) |
| Figure 2.2 | Predicted PD for two applicants as XGBoost boosting rounds accumulate. | [Code](chapter.qmd#L1029) |
| Table 2.11 | Inputs used by the XGBoost estimation call. | [Code](chapter.qmd#L1160) |
| Table 2.12 | Estimated XGBoost model summary. | [Code](chapter.qmd#L1239) |
| Figure 2.3 | Final predicted PD distributions for the full logistic model and XGBoost. | [Code](chapter.qmd#L1307) |
| Figure 2.4 | Full logistic-model PDs compared with final XGBoost PDs by observed outcome. | [Code](chapter.qmd#L1396) |
| Figure 2.5 | XGBoost learning curve: test AUC with train AUC as a diagnostic reference. | [Code](chapter.qmd#L1485) |
| Table 2.13 | Direct overfitting diagnostic from the XGBoost learning curve. | [Code](chapter.qmd#L1500) |
| Table 2.14 | Estimation, tuning, final evaluation and monitoring for XGBoost credit scoring. | [Code](chapter.qmd#L1543) |
| Table 2.15 | XGBoost prediction range and test-set performance summary. | [Code](chapter.qmd#L1583) |
| Figure 2.6 | XGBoost feature importance by Gain. | [Code](chapter.qmd#L1623) |
| Figure 2.7 | Average absolute contribution to the XGBoost log-odds score by feature. | [Code](chapter.qmd#L1663) |
| Table 2.16 | Predicted PDs for selected test-set applicants. | [Code](chapter.qmd#L1711) |
| Table 2.17 | Reconstructing John Doe's XGBoost score and predicted PD. | [Code](chapter.qmd#L1738) |
| Table 2.18 | Largest local contributions to John Doe's XGBoost log-odds score. | [Code](chapter.qmd#L1770) |
| Figure 2.8 | Partial dependence of XGBoost predicted default probability. | [Code](chapter.qmd#L1815) |
| Table 2.19 | Out-of-sample performance of the credit-scoring models. | [Code](chapter.qmd#L1932) |
| Figure 2.9 | ROC curves: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L1989) |
| Table 2.20 | Probability checks within each model's own risk deciles. | [Code](chapter.qmd#L2026) |
| Figure 2.10 | Calibration by decile: logistic regression and XGBoost. | [Code](chapter.qmd#L2057) |
| Figure 2.11 | Bad rate by target acceptance rate: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L2088) |
| Figure 2.12 | Net payoff by target acceptance rate: logistic regression, single tree, and XGBoost. | [Code](chapter.qmd#L2117) |
| Table 2.21 | Numerical check of the overall best net-payoff strategy. | [Code](chapter.qmd#L2170) |
| Table 2.22 | Best net-payoff row by model. | [Code](chapter.qmd#L2201) |
| Table 2.23 | Governance checklist for moving from a tree-based score to a credit policy. | [Code](chapter.qmd#L2227) |
