# Logistic credit scoring

**Frozen data included.** The complete repository supplies the dataset
used for this chapter, with a brief provenance note.
See [availability and dictionary](../../data/credit-scoring/README.md).

From the project root:

```sh
Rscript run.R 01-logistic
```

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Table 1.1 | Variable names used in the chapter. | [Code](chapter.qmd#L66) |
| Table 1.2 | First 10 loan records before cleaning. | [Code](chapter.qmd#L84) |
| Table 1.3 | Loan counts by home ownership. | [Code](chapter.qmd#L105) |
| Table 1.4 | Default rate by home-ownership category. | [Code](chapter.qmd#L126) |
| Figure 1.1 | Interest rate histogram. | [Code](chapter.qmd#L150) |
| Figure 1.2 | Annual income dotplot. | [Code](chapter.qmd#L168) |
| Figure 1.3 | Annual income without extreme values. | [Code](chapter.qmd#L197) |
| Figure 1.4 | Sigmoid curve or logistic curve: age model. | [Code](chapter.qmd#L325) |
| Table 1.5 | Coefficient and odds-ratio interpretation for `logi_multi`. | [Code](chapter.qmd#L444) |
| Table 1.6 | AIC comparison across logistic model candidates. | [Code](chapter.qmd#L511) |
| Figure 1.5 | Predicted PDs from the age-only model across the test set. | [Code](chapter.qmd#L586) |
| Figure 1.6 | Narrow distribution of age-only predicted PDs. | [Code](chapter.qmd#L603) |
| Figure 1.7 | Prediction distributions for the interest-rate and multi-factor models. | [Code](chapter.qmd#L627) |
| Figure 1.8 | Prediction ranges across age, interest-rate, and multi-factor models. | [Code](chapter.qmd#L645) |
| Figure 1.9 | Sigmoid curve or logistic curve: full-model score. | [Code](chapter.qmd#L709) |
| Table 1.7 | Prediction ranges and AIC across logistic model candidates. | [Code](chapter.qmd#L774) |
| Figure 1.10 | Prediction distributions for the multi-factor and full models. | [Code](chapter.qmd#L806) |
| Figure 1.11 | Prediction ranges across all logistic model candidates. | [Code](chapter.qmd#L824) |
| Figure 1.12 | Full-model predicted PDs with a 15% cutoff. | [Code](chapter.qmd#L860) |
| Figure 1.13 | Full-model prediction distribution with a 15% cutoff. | [Code](chapter.qmd#L901) |
| Table 1.8 | First six full-model predictions after applying the 15% cutoff. | [Code](chapter.qmd#L943) |
| Table 1.9 | Ten test-set cases comparing predicted PD, cutoff decision, observed outcome, and credit consequence. | [Code](chapter.qmd#L982) |
| Table 1.10 | Accuracy can reward poor credit-screening rules. | [Code](chapter.qmd#L1030) |
| Figure 1.14 | Full-model predicted-PD density with the 80% acceptance cutoff. | [Code](chapter.qmd#L1065) |
| Table 1.11 | Cutoffs implied by target acceptance rates. | [Code](chapter.qmd#L1103) |
| Table 1.12 | Classification outcomes under the 15% cutoff and the 80% acceptance rule. | [Code](chapter.qmd#L1147) |
| Table 1.13 | Sample of test-set outcomes under the 80% acceptance rule. | [Code](chapter.qmd#L1182) |
| Table 1.14 | First 12 accept/reject decisions with ex-post evaluation. | [Code](chapter.qmd#L1227) |
| Table 1.15 | First 10 accepted applications and their observed outcomes. | [Code](chapter.qmd#L1271) |
| Table 1.16 | Bad rate among accepted loans at the 80% acceptance rule. | [Code](chapter.qmd#L1286) |
| Table 1.17 | Bad rate among accepted loans at the 65% acceptance rule. | [Code](chapter.qmd#L1319) |
| Table 1.18 | Bad rate by target acceptance rate for the age-only and full logistic models. | [Code](chapter.qmd#L1378) |
| Figure 1.15 | Bad-rate comparison between the age-only model and the full model. | [Code](chapter.qmd#L1411) |
| Table 1.19 | Net payoff across acceptance rates for the full logistic model. | [Code](chapter.qmd#L1485) |
| Table 1.20 | Numerical check of the best net-payoff row. | [Code](chapter.qmd#L1504) |
| Table 1.21 | Net-payoff sensitivity to the cost of accepting a default. | [Code](chapter.qmd#L1560) |
| Table 1.22 | Confusion-matrix language translated into credit decisions. | [Code](chapter.qmd#L1600) |
| Table 1.23 | Sensitivity, specificity, and error rates in credit language. | [Code](chapter.qmd#L1644) |
| Figure 1.16 | ROC curves: Full model in blue, age model in orange. | [Code](chapter.qmd#L1718) |
| Table 1.24 | Calibration by predicted-risk decile for the full and age-only models. | [Code](chapter.qmd#L1787) |
| Figure 1.17 | Calibration by decile: full model in blue, age model in orange. | [Code](chapter.qmd#L1816) |
| Table 1.25 | Brier score and Brier skill against a constant default-rate benchmark. | [Code](chapter.qmd#L1884) |
| Table 1.26 | Cutoffs and error rates implied by two acceptance policies. | [Code](chapter.qmd#L1957) |
| Figure 1.18 | Full model in blue, evaluated at two acceptance rates: 65% in black, 80% in red. | [Code](chapter.qmd#L2011) |
| Figure 1.19 | Random-score ROC benchmark. | [Code](chapter.qmd#L2180) |
| Figure 1.20 | Perfect-score ROC benchmark. | [Code](chapter.qmd#L2229) |
