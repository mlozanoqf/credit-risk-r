# Credit Spreads and CDS Valuation

From the project root:

```sh
Rscript run.R 04-credit-spreads-cds
```

This runs the complete chapter in a new R process and writes an HTML results
report, PNG figures, CSV/RDS table inputs, numeric results and session information.
The `chapter.qmd` is the editable source. Code is visible, including formatting.
Run preceding blocks before executing an individual result block.

## Book result index

| Result | Title | Code | Generated file |
|---|---|---|---|
| Table 4.1 | Merton quantities carried into the credit-spread chapter. | [Code](chapter.qmd#L210) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-1) | [Output](../../output/04-credit-spreads-cds/tables/table-4-1.csv) |
| Table 4.2 | Discrete default timeline with a constant 2.5% conditional PD. | [Code](chapter.qmd#L292) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-2) | [Output](../../output/04-credit-spreads-cds/tables/table-4-2.csv) |
| Table 4.3 | Risk-free and risky zero-coupon valuation. | [Code](chapter.qmd#L336) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-3) | [Output](../../output/04-credit-spreads-cds/tables/table-4-3.csv) |
| Table 4.4 | Risk-free and risky coupon bond valuation. | [Code](chapter.qmd#L416) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-4) | [Output](../../output/04-credit-spreads-cds/tables/table-4-4.csv) |
| Table 4.5 | Risky coupon bond price decomposition. | [Code](chapter.qmd#L491) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-5) | [Output](../../output/04-credit-spreads-cds/tables/table-4-5.csv) |
| Figure 4.1 | Coupon bond price and yield spread as conditional default risk changes. | [Code](chapter.qmd#L549) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-figure-4-1) | [Output](../../output/04-credit-spreads-cds/figures/figure-4-1-1.png) |
| Table 4.6 | Checkpoint after the risky bond valuation block. | [Code](chapter.qmd#L564) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-6) | [Output](../../output/04-credit-spreads-cds/tables/table-4-6.csv) |
| Table 4.7 | Real-world and market-implied default probabilities and their uses. | [Code](chapter.qmd#L605) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-7) | [Output](../../output/04-credit-spreads-cds/tables/table-4-7.csv) |
| Table 4.8 | Historical PDs and spread-implied PDs answer different questions. | [Code](chapter.qmd#L631) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-8) | [Output](../../output/04-credit-spreads-cds/tables/table-4-8.csv) |
| Table 4.9 | A one-year CDS spread implied by the Merton PD. | [Code](chapter.qmd#L725) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-9) | [Output](../../output/04-credit-spreads-cds/tables/table-4-9.csv) |
| Figure 4.2 | CDS premium leg and protection leg as the spread changes. | [Code](chapter.qmd#L763) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-figure-4-2) | [Output](../../output/04-credit-spreads-cds/figures/figure-4-2-1.png) |
| Table 4.10 | Survival and default probabilities for a 2% hazard rate. | [Code](chapter.qmd#L856) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-10) | [Output](../../output/04-credit-spreads-cds/tables/table-4-10.csv) |
| Table 4.11 | Present value of expected CDS premium payments for a $1 notional. | [Code](chapter.qmd#L883) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-11) | [Output](../../output/04-credit-spreads-cds/tables/table-4-11.csv) |
| Table 4.12 | Present value of expected protection payoff for a $1 notional. | [Code](chapter.qmd#L912) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-12) | [Output](../../output/04-credit-spreads-cds/tables/table-4-12.csv) |
| Table 4.13 | Present value of expected accrued premium for a $1 notional. | [Code](chapter.qmd#L939) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-13) | [Output](../../output/04-credit-spreads-cds/tables/table-4-13.csv) |
| Table 4.14 | Fair CDS spread from premium, accrual, and protection legs for a $1 notional. | [Code](chapter.qmd#L967) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-14) | [Output](../../output/04-credit-spreads-cds/tables/table-4-14.csv) |
| Table 4.15 | Refining default timing while retaining annual CDS premiums. | [Code](chapter.qmd#L999) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-15) | [Output](../../output/04-credit-spreads-cds/tables/table-4-15.csv) |
| Table 4.16 | Mark-to-market value of an existing CDS. | [Code](chapter.qmd#L1058) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-16) | [Output](../../output/04-credit-spreads-cds/tables/table-4-16.csv) |
| Table 4.17 | Implied hazard rate from a CDS spread. | [Code](chapter.qmd#L1115) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-17) | [Output](../../output/04-credit-spreads-cds/tables/table-4-17.csv) |
| Table 4.18 | Quick CDS spread approximation compared with the accrued-premium valuation. | [Code](chapter.qmd#L1164) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-18) | [Output](../../output/04-credit-spreads-cds/tables/table-4-18.csv) |
| Figure 4.3 | Fair CDS spread under hazard and recovery assumptions. | [Code](chapter.qmd#L1218) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-figure-4-3) | [Output](../../output/04-credit-spreads-cds/figures/figure-4-3-1.png) |
| Figure 4.4 | Mark-to-market value to the protection seller as the contractual spread changes. | [Code](chapter.qmd#L1249) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-figure-4-4) | [Output](../../output/04-credit-spreads-cds/figures/figure-4-4-1.png) |
| Table 4.19 | Value sensitivity to the contractual premium. | [Code](chapter.qmd#L1294) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-19) | [Output](../../output/04-credit-spreads-cds/tables/table-4-19.csv) |
| Table 4.20 | Checkpoint after the accrued-premium CDS valuation block. | [Code](chapter.qmd#L1303) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-20) | [Output](../../output/04-credit-spreads-cds/tables/table-4-20.csv) |
| Table 4.21 | Two corporate bonds considered for purchase; prices per 100 of principal. | [Code](chapter.qmd#L1356) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-21) | [Output](../../output/04-credit-spreads-cds/tables/table-4-21.csv) |
| Figure 4.5 | Settlement-adjusted Treasury zero yields used to discount the corporate-bond payments. | [Code](chapter.qmd#L1392) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-figure-4-5) | [Output](../../output/04-credit-spreads-cds/figures/figure-4-5-1.png) |
| Table 4.22 | Issuer-specific pricing curves and out-of-calibration target values. | [Code](chapter.qmd#L1425) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-22) | [Output](../../output/04-credit-spreads-cds/tables/table-4-22.csv) |
| Table 4.23 | Price and yield comparisons using the same promised payments for each bond. | [Code](chapter.qmd#L1453) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-23) | [Output](../../output/04-credit-spreads-cds/tables/table-4-23.csv) |
| Figure 4.6 | Additional promised yield relative to each bond's issuer-curve benchmark. | [Code](chapter.qmd#L1473) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-figure-4-6) | [Output](../../output/04-credit-spreads-cds/figures/figure-4-6-1.png) |
| Table 4.24 | CCO minus Verizon yield-residual advantage under deterministic sensitivity checks. | [Code](chapter.qmd#L1536) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-24) | [Output](../../output/04-credit-spreads-cds/tables/table-4-24.csv) |
| Figure 4.7 | How a deduction from CCO's model value changes the conditional purchase preference. | [Code](chapter.qmd#L1579) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-figure-4-7) | [Output](../../output/04-credit-spreads-cds/figures/figure-4-7-1.png) |
| Table 4.25 | First two and last two promised payments of the Brazilian sovereign bond, per 100 of principal. | [Code](chapter.qmd#L1623) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-25) | [Output](../../output/04-credit-spreads-cds/tables/table-4-25.csv) |
| Table 4.26 | tbl-recovery-assumptions-and-price-implied-default-probabilities-for-the-same | [Code](chapter.qmd#L1692) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-26) | [Output](../../output/04-credit-spreads-cds/tables/table-4-26.csv) |
| Figure 4.8 | Default probability by maturity implied by the same Brazilian bond price under different recovery assumptions. | [Code](chapter.qmd#L1721) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-figure-4-8) | [Output](../../output/04-credit-spreads-cds/figures/figure-4-8-1.png) |
| Table 4.27 | Credit-spread and CDS valuation checklist. | [Code](chapter.qmd#L1775) / [Report](../../output/04-credit-spreads-cds/chapter.html#result-table-4-27) | [Output](../../output/04-credit-spreads-cds/tables/table-4-27.csv) |
