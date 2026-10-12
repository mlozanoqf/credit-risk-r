# Portfolio Credit Risk with Copulas

From the project root:

```sh
Rscript run.R 05-copulas
```

This runs the complete chapter in a new R process and writes an HTML results
report, PNG figures, CSV/RDS table inputs, numeric results and session information.
The `chapter.qmd` is the editable source. Code is visible, including formatting.
Run preceding blocks before executing an individual result block.

## Book result index

| Result | Title | Code | Generated file |
|---|---|---|---|
| Table 5.1 | Practical ways to justify the copula correlation input. | [Code](chapter.qmd#L130) / [Report](../../output/05-copulas/chapter.html#result-table-5-1) | [Output](../../output/05-copulas/tables/table-5-1.csv) |
| Figure 5.1 | Gaussian copula workflow for portfolio credit risk. | [Code](chapter.qmd#L202) / [Report](../../output/05-copulas/chapter.html#result-figure-5-1) | [Output](../../output/05-copulas/figures/figure-5-1-1.png) |
| Table 5.2 | Objects used in the Gaussian copula credit-risk workflow. | [Code](chapter.qmd#L217) / [Report](../../output/05-copulas/chapter.html#result-table-5-2) | [Output](../../output/05-copulas/tables/table-5-2.csv) |
| Table 5.3 | Hull Example 24.7 inputs and the corresponding Gaussian default thresholds. | [Code](chapter.qmd#L262) / [Report](../../output/05-copulas/chapter.html#result-table-5-3) | [Output](../../output/05-copulas/tables/table-5-3.csv) |
| Table 5.4 | Illustrative threshold rule for one simulated credit scenario. | [Code](chapter.qmd#L303) / [Report](../../output/05-copulas/chapter.html#result-table-5-4) | [Output](../../output/05-copulas/tables/table-5-4.csv) |
| Figure 5.2 | Default thresholds implied by Hull Example 24.7 cumulative PDs. | [Code](chapter.qmd#L358) / [Report](../../output/05-copulas/chapter.html#result-figure-5-2) | [Output](../../output/05-copulas/figures/figure-5-2-1.png) |
| Figure 5.3 | Checking that each Gaussian threshold reproduces the original cumulative PD. | [Code](chapter.qmd#L391) / [Report](../../output/05-copulas/chapter.html#result-figure-5-3) | [Output](../../output/05-copulas/figures/figure-5-3-1.png) |
| Figure 5.4 | Zoom: Gaussian thresholds and cumulative PDs between -2.5 and -0.5. | [Code](chapter.qmd#L418) / [Report](../../output/05-copulas/chapter.html#result-figure-5-4) | [Output](../../output/05-copulas/figures/figure-5-4-1.png) |
| Table 5.5 | One-firm simulation check for the 5-year marginal PD. | [Code](chapter.qmd#L487) / [Report](../../output/05-copulas/chapter.html#result-table-5-5) | [Output](../../output/05-copulas/tables/table-5-5.csv) |
| Figure 5.5 | One-firm simulation check with threshold comparison. | [Code](chapter.qmd#L515) / [Report](../../output/05-copulas/chapter.html#result-figure-5-5) | [Output](../../output/05-copulas/figures/figure-5-5-1.png) |
| Table 5.6 | Direct two-firm simulation check for $\\rho = 0.2$. | [Code](chapter.qmd#L649) / [Report](../../output/05-copulas/chapter.html#result-table-5-6) | [Output](../../output/05-copulas/tables/table-5-6.csv) |
| Table 5.7 | Two-firm default probabilities under different Gaussian copula correlations. | [Code](chapter.qmd#L677) / [Report](../../output/05-copulas/chapter.html#result-table-5-7) | [Output](../../output/05-copulas/tables/table-5-7.csv) |
| Figure 5.6 | Two-firm Gaussian copula simulations across negative and positive correlations. | [Code](chapter.qmd#L724) / [Report](../../output/05-copulas/chapter.html#result-figure-5-6) | [Output](../../output/05-copulas/figures/figure-5-6-1.png) |
| Table 5.8 | Equal-correlation matrix for the ten-firm portfolio. | [Code](chapter.qmd#L854) / [Report](../../output/05-copulas/chapter.html#result-table-5-8) | [Output](../../output/05-copulas/tables/table-5-8.csv) |
| Table 5.9 | Distribution of the number of defaults by year 5 for ten firms and $\\rho = 0.2$. | [Code](chapter.qmd#L892) / [Report](../../output/05-copulas/chapter.html#result-table-5-9) | [Output](../../output/05-copulas/tables/table-5-9.csv) |
| Table 5.10 | Default-event probabilities for ten firms under different copula correlations. | [Code](chapter.qmd#L904) / [Report](../../output/05-copulas/chapter.html#result-table-5-10) | [Output](../../output/05-copulas/tables/table-5-10.csv) |
| Figure 5.7 | Distribution of the number of defaults by year 5 under different copula correlations. | [Code](chapter.qmd#L935) / [Report](../../output/05-copulas/chapter.html#result-figure-5-7) | [Output](../../output/05-copulas/figures/figure-5-7-1.png) |
| Table 5.11 | Portfolio loss summary for a homogeneous ten-firm portfolio. | [Code](chapter.qmd#L1069) / [Report](../../output/05-copulas/chapter.html#result-table-5-11) | [Output](../../output/05-copulas/tables/table-5-11.csv) |
| Figure 5.8 | Portfolio loss distribution under different copula correlations. | [Code](chapter.qmd#L1099) / [Report](../../output/05-copulas/chapter.html#result-figure-5-8) | [Output](../../output/05-copulas/figures/figure-5-8-1.png) |
| Table 5.12 | Concentration risk with the same total exposure, PD, recovery, and copula correlation. | [Code](chapter.qmd#L1186) / [Report](../../output/05-copulas/chapter.html#result-table-5-12) | [Output](../../output/05-copulas/tables/table-5-12.csv) |
| Figure 5.9 | Same defaults and different exposure weights. | [Code](chapter.qmd#L1249) / [Report](../../output/05-copulas/chapter.html#result-figure-5-9) | [Output](../../output/05-copulas/figures/figure-5-9-1.png) |
| Table 5.13 | Two firms affected by the same t-copula scale draw. | [Code](chapter.qmd#L1426) / [Report](../../output/05-copulas/chapter.html#result-table-5-13) | [Output](../../output/05-copulas/tables/table-5-13.csv) |
| Table 5.14 | Default clustering under Gaussian and t-copulas. | [Code](chapter.qmd#L1440) / [Report](../../output/05-copulas/chapter.html#result-table-5-14) | [Output](../../output/05-copulas/tables/table-5-14.csv) |
| Table 5.15 | Portfolio loss measures under Gaussian and t-copulas. | [Code](chapter.qmd#L1451) / [Report](../../output/05-copulas/chapter.html#result-table-5-15) | [Output](../../output/05-copulas/tables/table-5-15.csv) |
| Figure 5.10 | Default-count distribution under Gaussian and t-copulas. | [Code](chapter.qmd#L1481) / [Report](../../output/05-copulas/chapter.html#result-figure-5-10) | [Output](../../output/05-copulas/figures/figure-5-10-1.png) |
| Table 5.16 | Inputs for the Vasicek-style Credit VaR approximation. | [Code](chapter.qmd#L1595) / [Report](../../output/05-copulas/chapter.html#result-table-5-16) | [Output](../../output/05-copulas/tables/table-5-16.csv) |
| Table 5.17 | Mapping the Credit VaR notation to the R implementation. | [Code](chapter.qmd#L1638) / [Report](../../output/05-copulas/chapter.html#result-table-5-17) | [Output](../../output/05-copulas/tables/table-5-17.csv) |
| Table 5.18 | Numerical substitution for the 99.9% Credit VaR calculation. | [Code](chapter.qmd#L1684) / [Report](../../output/05-copulas/chapter.html#result-table-5-18) | [Output](../../output/05-copulas/tables/table-5-18.csv) |
| Table 5.19 | Gaussian Vasicek Credit VaR, expected loss, capital, and expected shortfall. | [Code](chapter.qmd#L1739) / [Report](../../output/05-copulas/chapter.html#result-table-5-19) | [Output](../../output/05-copulas/tables/table-5-19.csv) |
| Table 5.20 | The 99.9% Gaussian Credit VaR calculation. | [Code](chapter.qmd#L1769) / [Report](../../output/05-copulas/chapter.html#result-table-5-20) | [Output](../../output/05-copulas/tables/table-5-20.csv) |
| Figure 5.11 | Systematic factor and conditional portfolio loss. | [Code](chapter.qmd#L1790) / [Report](../../output/05-copulas/chapter.html#result-figure-5-11) | [Output](../../output/05-copulas/figures/figure-5-11-1.png) |
| Table 5.21 | Credit VaR model risk under Gaussian and t-copula assumptions. | [Code](chapter.qmd#L1917) / [Report](../../output/05-copulas/chapter.html#result-table-5-21) | [Output](../../output/05-copulas/tables/table-5-21.csv) |
| Figure 5.12 | Loss-tail survival probabilities under Gaussian and t-copulas. | [Code](chapter.qmd#L1963) / [Report](../../output/05-copulas/chapter.html#result-figure-5-12) | [Output](../../output/05-copulas/figures/figure-5-12-1.png) |
| Table 5.22 | Monte Carlo precision of the 99.9% expected-shortfall comparison, in USD millions. | [Code](chapter.qmd#L2004) / [Report](../../output/05-copulas/chapter.html#result-table-5-22) | [Output](../../output/05-copulas/tables/table-5-22.csv) |
