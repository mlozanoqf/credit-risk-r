# Portfolio Credit Risk with Copulas

From the project root:

```sh
Rscript run.R 05-copulas
```

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Table 5.1 | Practical ways to justify the copula correlation input. | [Code](chapter.qmd#L132) |
| Figure 5.1 | Gaussian copula workflow for portfolio credit risk. | [Code](chapter.qmd#L204) |
| Table 5.2 | Objects used in the Gaussian copula credit-risk workflow. | [Code](chapter.qmd#L219) |
| Table 5.3 | Hull Example 24.7 inputs and the corresponding Gaussian default thresholds. | [Code](chapter.qmd#L264) |
| Table 5.4 | Illustrative threshold rule for one hypothetical credit scenario. | [Code](chapter.qmd#L305) |
| Figure 5.2 | Default thresholds implied by Hull Example 24.7 cumulative PDs. | [Code](chapter.qmd#L360) |
| Figure 5.3 | Checking that each Gaussian threshold reproduces the original cumulative PD. | [Code](chapter.qmd#L393) |
| Figure 5.4 | Zoom: Gaussian thresholds and cumulative PDs for credit-state scores between -2.5 and -0.5. | [Code](chapter.qmd#L420) |
| Table 5.5 | One-firm simulation check for the 5-year marginal PD. | [Code](chapter.qmd#L489) |
| Figure 5.5 | One-firm simulation check with threshold comparison. | [Code](chapter.qmd#L517) |
| Table 5.6 | Direct two-firm simulation check for $\rho = 0.2$. | [Code](chapter.qmd#L651) |
| Table 5.7 | Two-firm default probabilities under different Gaussian copula correlations. | [Code](chapter.qmd#L679) |
| Figure 5.6 | Two-firm Gaussian copula simulations across negative and positive correlations. | [Code](chapter.qmd#L726) |
| Table 5.8 | Equal-correlation matrix for the ten-firm portfolio. | [Code](chapter.qmd#L856) |
| Table 5.9 | Distribution of the number of defaults by year 5 for ten firms and $\rho = 0.2$. | [Code](chapter.qmd#L894) |
| Table 5.10 | Default-event probabilities for ten firms under different copula correlations. | [Code](chapter.qmd#L906) |
| Figure 5.7 | Distribution of the number of defaults by year 5 under different copula correlations. | [Code](chapter.qmd#L937) |
| Table 5.11 | Portfolio loss summary for a homogeneous ten-firm portfolio. | [Code](chapter.qmd#L1071) |
| Figure 5.8 | Portfolio loss distribution under different copula correlations. | [Code](chapter.qmd#L1101) |
| Table 5.12 | Concentration risk with the same total exposure, PD, recovery, and copula correlation. | [Code](chapter.qmd#L1188) |
| Figure 5.9 | Portfolio loss distributions with the same defaults and different exposure weights. | [Code](chapter.qmd#L1251) |
| Table 5.13 | Two firms affected by the same t-copula scale draw. | [Code](chapter.qmd#L1428) |
| Table 5.14 | Default clustering under Gaussian and t-copulas. | [Code](chapter.qmd#L1442) |
| Table 5.15 | Portfolio loss measures under Gaussian and t-copulas. | [Code](chapter.qmd#L1453) |
| Figure 5.10 | Default-count distribution under Gaussian and t-copulas. | [Code](chapter.qmd#L1483) |
| Table 5.16 | Inputs for the Vasicek-style Credit VaR approximation. | [Code](chapter.qmd#L1597) |
| Table 5.17 | Mapping the Credit VaR notation to the R implementation. | [Code](chapter.qmd#L1640) |
| Table 5.18 | Numerical substitution for the 99.9% Credit VaR calculation. | [Code](chapter.qmd#L1686) |
| Table 5.19 | Gaussian Vasicek Credit VaR, expected loss, capital, and expected shortfall. | [Code](chapter.qmd#L1741) |
| Table 5.20 | The 99.9% Gaussian Credit VaR calculation. | [Code](chapter.qmd#L1771) |
| Figure 5.11 | Systematic factor and conditional portfolio loss. | [Code](chapter.qmd#L1792) |
| Table 5.21 | Credit VaR model risk under Gaussian and t-copula assumptions. | [Code](chapter.qmd#L1919) |
| Figure 5.12 | Loss-tail survival probabilities under Gaussian and t-copulas. | [Code](chapter.qmd#L1965) |
| Table 5.22 | Monte Carlo precision of the 99.9% expected-shortfall comparison, in USD millions. | [Code](chapter.qmd#L2006) |
