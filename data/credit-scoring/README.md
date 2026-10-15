# Credit-scoring data

## Availability

The complete frozen dataset is included in the repository at
`data/credit-scoring/credit_scoring.rds`. Run `Rscript checks/check-inputs.R`
to check its identity before reproducing Chapters 1 and 2. The
[provenance note](PROVENANCE.md) identifies Lore Dirick's DataCamp course as
the source and describes the semi-synthetic adaptation.

## Dictionary

`credit_scoring.rds` is the semi-synthetic dataset used in the
publication manuscript's first two chapters. It contains 30,024 loan records
and ten variables. Results describe this sample; they are not estimates
of default rates for a named lender or a defined borrower population.

Read the file from the project root with `readRDS("data/credit-scoring/credit_scoring.rds")`.
The analysis begins with the supplied records and includes data-quality checks
before fitting any model. The raw file retains observations requiring review.

| Original name | Book name | Meaning and units |
|---|---|---|
| `loan_status` | `loan_st` | Observed loan outcome, 0 for no default and 1 for default. |
| `loan_amnt` | `l_amnt` | Loan amount in dollars. |
| `int_rate` | `int` | Loan interest rate in percentage points; 12 denotes 12%. |
| `grade` | `grade` | Credit grade, A through E, ordered from stronger to weaker credit quality. |
| `emp_length` | `emp_len` | Employment length in years; 0.25 denotes one quarter of a year. Zero indicates no recorded employment tenure. |
| `home_ownership` | `home` | Housing category, MORTGAGE, OWN or RENT. |
| `annual_inc` | `income` | Annual income in dollars. |
| `age` | `age` | Age in completed years. |
| `sex` | `sex` | Recorded category, 0 for male and 1 for female. |
| `region` | `region` | Regional category, E, N, NE, NW, S, SE, SW or W. These denote East, North, Northeast, Northwest, South, Southeast, Southwest and West. |

The file is ordered by region, grade and age. Row position identifies a record
within this file, not a persistent customer identifier. Chapter 1 creates a
random training/test partition after cleaning; Chapter 2 reuses that partition.
`loan_status` supplies the outcome for model estimation and evaluation. It is
excluded from the predictors supplied for a new applicant.
