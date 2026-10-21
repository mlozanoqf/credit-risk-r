# Credit Spreads and CDS Valuation

First use? Complete the [setup walkthrough](../../README.md#first-time-prepare-your-computer).
Open `credit-risk-r.Rproj` and run these commands in the RStudio **Console**:

```r
source("start.R")
start_chapter("04-credit-spreads-cds")
```

After **Complete:** appears, the browser opens `output/04-credit-spreads-cds/chapter.html`.
If it stays closed, open that file manually from the extracted project folder.

Open [chapter.qmd](chapter.qmd) to read or edit the code. The command above runs the
complete chapter in a new R session. Run setup and preceding calculations before
executing an individual block. See [generated results](../../README.md#output)
for where to find the files created on your computer.

## Find code by book result

| Result | Title | Code |
|---|---|---|
| Table 4.1 | Merton quantities carried into the credit-spread chapter. Debt amounts retain Chapter 3's common monetary unit (MU). | [Code](chapter.qmd#L70) |
| Table 4.2 | Discrete default timeline with a constant 2.5% conditional PD. | [Code](chapter.qmd#L137) |
| Table 4.3 | Risk-free and risky zero-coupon valuation. Prices are per 100 of face value. | [Code](chapter.qmd#L168) |
| Table 4.4 | Risk-free and risky coupon bond valuation. Prices are per 100 of face value. | [Code](chapter.qmd#L223) |
| Table 4.5 | Risky coupon bond price decomposition. | [Code](chapter.qmd#L279) |
| Figure 4.1 | Coupon bond price and yield spread as conditional default risk changes. | [Code](chapter.qmd#L337) |
| Table 4.6 | Default probabilities, recovery, and their roles in bond valuation. | [Code](chapter.qmd#L352) |
| Table 4.7 | Real-world and market-implied default probabilities and their uses. | [Code](chapter.qmd#L393) |
| Table 4.8 | Historical PDs and spread-implied PDs answer different questions. | [Code](chapter.qmd#L419) |
| Table 4.9 | A one-year CDS spread implied by the Merton PD. | [Code](chapter.qmd#L493) |
| Figure 4.2 | Present values of the CDS premium and protection legs across spreads. | [Code](chapter.qmd#L531) |
| Table 4.10 | Survival and default probabilities for a 2% hazard rate. | [Code](chapter.qmd#L587) |
| Table 4.11 | Present value of expected CDS premium payments for a $1 notional. | [Code](chapter.qmd#L614) |
| Table 4.12 | Present value of expected protection payoff for a $1 notional. | [Code](chapter.qmd#L643) |
| Table 4.13 | Present value of expected accrued premium for a $1 notional. | [Code](chapter.qmd#L670) |
| Table 4.14 | Fair CDS spread including accrued premium, for a $1 notional. | [Code](chapter.qmd#L698) |
| Table 4.15 | Refining default timing while retaining annual CDS premiums. | [Code](chapter.qmd#L736) |
| Table 4.16 | Mark-to-market value of an existing CDS. Present values are per unit of notional. | [Code](chapter.qmd#L794) |
| Table 4.17 | Implied hazard rate from a CDS spread. | [Code](chapter.qmd#L841) |
| Table 4.18 | Quick CDS spread approximation compared with the accrued-premium valuation. | [Code](chapter.qmd#L890) |
| Figure 4.3 | Fair CDS spread under hazard and recovery assumptions. | [Code](chapter.qmd#L944) |
| Figure 4.4 | Mark-to-market value to the protection seller as the contractual spread changes. | [Code](chapter.qmd#L975) |
| Table 4.19 | Protection-seller value sensitivity to the contractual CDS premium. | [Code](chapter.qmd#L1020) |
| Table 4.20 | CDS valuation tools and the credit questions they answer. | [Code](chapter.qmd#L1029) |
| Table 4.21 | Two corporate bonds considered for purchase; prices per 100 of principal. | [Code](chapter.qmd#L1082) |
| Figure 4.5 | Settlement-adjusted Treasury zero yields used to discount the corporate-bond payments. | [Code](chapter.qmd#L1118) |
| Table 4.22 | Issuer-specific pricing curves and model values for the bonds excluded from calibration. Model clean prices are per 100 of principal. | [Code](chapter.qmd#L1151) |
| Table 4.23 | Price and yield comparisons using the same promised payments for each bond. Clean prices and price differences are per 100 of principal. | [Code](chapter.qmd#L1179) |
| Figure 4.6 | Additional promised yield relative to each bond's issuer-curve benchmark. | [Code](chapter.qmd#L1199) |
| Table 4.24 | CCO minus Verizon yield-residual advantage under deterministic sensitivity checks. | [Code](chapter.qmd#L1262) |
| Figure 4.7 | How a deduction from CCO's model value changes the conditional purchase preference. | [Code](chapter.qmd#L1305) |
| Table 4.25 | First two and last two promised payments of the Brazilian sovereign bond, per 100 of principal. | [Code](chapter.qmd#L1349) |
| Table 4.26 | Recovery sensitivity for the Brazilian bond. Fitted PDs hold price at 99.091; the last column holds annual PD at 3.4535%. All prices are per 100 of principal. | [Code](chapter.qmd#L1418) |
| Figure 4.8 | Cumulative default probability implied by the Brazilian bond price under different recovery assumptions. | [Code](chapter.qmd#L1447) |
| Table 4.27 | Credit-spread and CDS valuation checklist. | [Code](chapter.qmd#L1501) |
