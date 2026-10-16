# The Merton model

First use? Complete the [setup walkthrough](../../README.md#first-time-prepare-your-computer).
Open `credit-risk-r.Rproj` and run these commands in the RStudio **Console**:

```r
source("start.R")
start_chapter("03-merton")
```

After **Complete:** appears, the browser opens `output/03-merton/chapter.html`.
If it stays closed, open that file manually from the extracted project folder.

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Table 3.1 | Estimated Merton asset value, asset volatility, and risk-neutral default probability. | [Code](chapter.qmd#L77) |
| Table 3.2 | The d-values and normal probabilities behind the Merton PD. | [Code](chapter.qmd#L108) |
| Figure 3.1 | The red area represents the risk-neutral probability of default. | [Code](chapter.qmd#L165) |
| Table 3.3 | Objective function value at the estimated Merton solution. | [Code](chapter.qmd#L193) |
| Figure 3.2 | Objective-function slice when asset volatility is held fixed. | [Code](chapter.qmd#L239) |
| Figure 3.3 | Objective-function slice when asset value is held fixed. | [Code](chapter.qmd#L275) |
| Figure 3.4 | Merton objective function: a contour view. | [Code](chapter.qmd#L358) |
| Figure 3.5 | Merton objective function: a three-dimensional view. | [Code](chapter.qmd#L376) |
| Table 3.4 | How to read the Merton numerical-solution diagnostics. | [Code](chapter.qmd#L404) |
| Table 3.5 | Debt measures implied by the fitted Merton model. | [Code](chapter.qmd#L460) |
| Table 3.6 | Merton-implied bond yield and credit spread. | [Code](chapter.qmd#L503) |
| Figure 3.6 | Ten risk-neutral valuation paths for the firm's assets. | [Code](chapter.qmd#L571) |
| Figure 3.7 | Paths that cross below D before maturity; only paths ending below D default. | [Code](chapter.qmd#L622) |
| Table 3.7 | Default count and simulated risk-neutral PD with 10 paths. | [Code](chapter.qmd#L642) |
| Figure 3.8 | One hundred risk-neutral valuation paths for the firm's assets. | [Code](chapter.qmd#L678) |
| Table 3.8 | Default count and simulated risk-neutral PD with 100 paths. | [Code](chapter.qmd#L696) |
| Figure 3.9 | Paths that end below the promised debt payment at maturity. | [Code](chapter.qmd#L731) |
| Figure 3.10 | These paths cross below $D$ before maturity, but finish with $V_T$ above $D$ and therefore do not default. | [Code](chapter.qmd#L771) |
| Table 3.9 | Observing the same 100 asset paths at different frequencies. | [Code](chapter.qmd#L809) |
| Figure 3.11 | Convergence of the simulated risk-neutral probability of default to the analytical Merton probability. | [Code](chapter.qmd#L879) |
| Figure 3.12 | Histogram of 100,000 terminal asset values simulated under the risk-neutral measure. | [Code](chapter.qmd#L934) |
| Table 3.10 | Large-sample simulated risk-neutral PD compared with the analytical Merton PD. | [Code](chapter.qmd#L957) |
| Table 3.11 | Correspondence between a European call and Merton equity. | [Code](chapter.qmd#L982) |
| Figure 3.13 | Equity at maturity as a European call payoff on the firm's assets. | [Code](chapter.qmd#L1006) |
| Table 3.12 | Original Hull/Merton input position for the sensitivity analysis. | [Code](chapter.qmd#L1037) |
| Figure 3.14 | The risk-neutral probability of default as a function of the equity at time zero. | [Code](chapter.qmd#L1092) |
| Figure 3.15 | The risk-neutral probability of default as a function of the risk-free rate. | [Code](chapter.qmd#L1107) |
| Figure 3.16 | The risk-neutral probability of default as a function of the promised debt payment due at maturity. | [Code](chapter.qmd#L1124) |
| Figure 3.17 | The risk-neutral probability of default as a function of debt maturity. | [Code](chapter.qmd#L1139) |
| Figure 3.18 | The risk-neutral probability of default as a function of the volatility of the equity. | [Code](chapter.qmd#L1153) |
| Table 3.13 | Reading the one-input Merton sensitivity curves. | [Code](chapter.qmd#L1201) |
| Figure 3.19 | A contour view of the risk-neutral probability of default as a function of equity value and equity volatility. | [Code](chapter.qmd#L1302) |
| Figure 3.20 | The risk-neutral probability of default as a function of equity value and equity volatility: a three-dimensional view. | [Code](chapter.qmd#L1340) |
| Table 3.14 | Capital-structure scenario summary under the Merton model. | [Code](chapter.qmd#L1462) |
| Figure 3.21 | Initial capital-structure position and Merton risk-neutral PD. | [Code](chapter.qmd#L1484) |
| Figure 3.22 | Lower promised debt versus higher equity value from the initial position. | [Code](chapter.qmd#L1505) |
| Figure 3.23 | Alternative capital-structure position and Merton risk-neutral PD. | [Code](chapter.qmd#L1539) |
| Figure 3.24 | Lower promised debt versus higher equity value from the alternative capital-structure position. | [Code](chapter.qmd#L1569) |
| Figure 3.25 | Initial maturity-debt position and Merton risk-neutral PD. | [Code](chapter.qmd#L1632) |
| Figure 3.26 | Higher promised debt payment versus longer maturity. | [Code](chapter.qmd#L1659) |
