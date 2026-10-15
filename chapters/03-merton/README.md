# The Merton model

From the project root:

```sh
Rscript run.R 03-merton
```

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Table 3.1 | Estimated Merton asset value, asset volatility, and risk-neutral default probability. | [Code](chapter.qmd#L112) |
| Table 3.2 | The d-values and normal probabilities behind the Merton PD. | [Code](chapter.qmd#L143) |
| Figure 3.1 | The red area represents the risk-neutral probability of default. | [Code](chapter.qmd#L200) |
| Table 3.3 | Objective function value at the estimated Merton solution. | [Code](chapter.qmd#L228) |
| Figure 3.2 | Objective-function slice when asset volatility is held fixed. | [Code](chapter.qmd#L274) |
| Figure 3.3 | Objective-function slice when asset value is held fixed. | [Code](chapter.qmd#L310) |
| Figure 3.4 | Minimization of the function: a contour view. | [Code](chapter.qmd#L393) |
| Figure 3.5 | Minimization of the function: a three-dimensional view. | [Code](chapter.qmd#L411) |
| Table 3.4 | How to read the Merton numerical-solution diagnostics. | [Code](chapter.qmd#L439) |
| Table 3.5 | Debt measures implied by the fitted Merton model. | [Code](chapter.qmd#L495) |
| Table 3.6 | Merton-implied bond yield and credit spread. | [Code](chapter.qmd#L538) |
| Figure 3.6 | Ten risk-neutral valuation paths for the firm's assets. | [Code](chapter.qmd#L606) |
| Figure 3.7 | Paths that cross below D before maturity; only paths ending below D default. | [Code](chapter.qmd#L657) |
| Table 3.7 | Default count and simulated risk-neutral PD with 10 paths. | [Code](chapter.qmd#L677) |
| Figure 3.8 | One hundred risk-neutral valuation paths for the firm's assets. | [Code](chapter.qmd#L713) |
| Table 3.8 | Default count and simulated risk-neutral PD with 100 paths. | [Code](chapter.qmd#L731) |
| Figure 3.9 | Paths that end below the promised debt payment at maturity. | [Code](chapter.qmd#L766) |
| Figure 3.10 | These paths cross below $D$ before maturity, but finish with $V_T$ above $D$ and therefore do not default. | [Code](chapter.qmd#L806) |
| Table 3.9 | Observing the same 100 asset paths at different frequencies. | [Code](chapter.qmd#L844) |
| Figure 3.11 | Convergence of the simulated risk-neutral probability of default to the analytical Merton probability. | [Code](chapter.qmd#L914) |
| Figure 3.12 | Histogram of 100,000 values of the assets at maturity. | [Code](chapter.qmd#L969) |
| Table 3.10 | Large-sample simulated risk-neutral PD compared with the analytical Merton PD. | [Code](chapter.qmd#L992) |
| Table 3.11 | Correspondence between a European call and Merton equity. | [Code](chapter.qmd#L1017) |
| Figure 3.13 | Equity at maturity as a European call payoff on the firm's assets. | [Code](chapter.qmd#L1041) |
| Table 3.12 | Original Hull/Merton input position for the sensitivity analysis. | [Code](chapter.qmd#L1113) |
| Figure 3.14 | The risk-neutral probability of default as a function of the equity at time zero. | [Code](chapter.qmd#L1168) |
| Figure 3.15 | The risk-neutral probability of default as a function of the risk-free rate. | [Code](chapter.qmd#L1183) |
| Figure 3.16 | The risk-neutral probability of default as a function of the promised debt payment due at maturity. | [Code](chapter.qmd#L1200) |
| Figure 3.17 | The risk-neutral probability of default as a function of debt maturity. | [Code](chapter.qmd#L1215) |
| Figure 3.18 | The risk-neutral probability of default as a function of the volatility of the equity. | [Code](chapter.qmd#L1229) |
| Table 3.13 | Reading the one-input Merton sensitivity curves. | [Code](chapter.qmd#L1277) |
| Figure 3.19 | A contour view of the risk-neutral probability of default as a function of equity value and equity volatility. | [Code](chapter.qmd#L1378) |
| Figure 3.20 | The risk-neutral probability of default as a function of equity value and equity volatility: a three-dimensional view. | [Code](chapter.qmd#L1416) |
| Table 3.14 | Capital-structure scenario summary under the Merton model. | [Code](chapter.qmd#L1532) |
| Figure 3.21 | Initial capital-structure position and Merton risk-neutral PD. | [Code](chapter.qmd#L1554) |
| Figure 3.22 | Debt reduction versus equity injection from the initial position. | [Code](chapter.qmd#L1575) |
| Figure 3.23 | Alternative starting balance sheet and Merton risk-neutral PD. | [Code](chapter.qmd#L1609) |
| Figure 3.24 | Debt reduction versus equity injection from the alternative balance sheet. | [Code](chapter.qmd#L1639) |
| Figure 3.25 | Initial maturity-debt position and Merton risk-neutral PD. | [Code](chapter.qmd#L1702) |
| Figure 3.26 | Higher promised debt payment versus longer maturity. | [Code](chapter.qmd#L1729) |
