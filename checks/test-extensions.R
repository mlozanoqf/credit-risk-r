args <- commandArgs(trailingOnly = TRUE)
root <- normalizePath(if (length(args)) args[1] else getwd(), winslash = "/", mustWork = TRUE)
setwd(root)
source("chapters/02-tree-based/helpers/models.R")
source("chapters/02-tree-based/helpers/new-applicants.R")
encode <- make_xgb_encoder(train, xgb_formula, colnames(xgb_train_matrix))
required <- all.vars(xgb_formula)
one <- test[1, required, drop = FALSE]
one[sapply(one, is.factor)] <- lapply(one[sapply(one, is.factor)], as.character)
new_matrix <- encode(one[, rev(names(one))])
stopifnot(identical(unname(new_matrix), unname(xgb_test_matrix[1, , drop = FALSE])))
pd <- as.numeric(predict(xgb_model, xgb.DMatrix(new_matrix)))
stopifnot(isTRUE(all.equal(pd, unname(pred_xgb[1]))))
bad <- function(expr) stopifnot(inherits(try(force(expr), silent = TRUE), "try-error"))
z <- one; z$region <- "UNKNOWN"; bad(encode(z))
z <- one; z$grade <- NA; bad(encode(z))
z <- one; z$income <- 0; bad(encode(z))
z <- one; z$age <- Inf; bad(encode(z))
bad(encode(one[, setdiff(names(one), "home")]))
stopifnot(isTRUE(all.equal(unname(encode(test[1:100, required])),
                          unname(xgb_test_matrix[1:100, , drop = FALSE]))))
cat("New-applicant schema and predictions PASS; PD =", format(pd, digits = 12), "\n")

source("chapters/05-copulas/helpers/portfolio.R")
book <- root
chunk <- function(file, label) {
  lines <- readLines(file.path(book, file), warn = FALSE)
  first <- which(lines == paste0("```{r ", label, "}"))
  stopifnot(length(first) == 1)
  last <- which(seq_along(lines) > first & lines == "```")[1]
  eval(parse(text = lines[(first + 1):(last - 1)]), envir = .GlobalEnv)
}
chunk("chapters/05-copulas/chapter.qmd", "heterogeneous-portfolio-inputs")
chunk("chapters/05-copulas/chapter.qmd", "heterogeneous-portfolio-check")
stopifnot(hetero_el == 1820000, abs(hetero_mean - hetero_el) < 5 * hetero_mcse)
se <- sqrt(borrowers$pd * (1-borrowers$pd) / nrow(hetero_defaults))
stopifnot(all(abs(colMeans(hetero_defaults) - borrowers$pd) < 5 * se))
perm <- c(3,1,2)
reordered_loss <- as.vector(hetero_defaults[,perm] %*% loss_if_default[colnames(hetero_defaults)[perm]])
stopifnot(identical(hetero_losses, reordered_loss))
cat("Heterogeneous portfolio PASS; EL =", hetero_mean, "MCSE =", hetero_mcse, "\n")

source("chapters/06-climate-credit-risk/helpers/validation.R")
chunk("chapters/06-climate-credit-risk/chapter.qmd", "step-010")
raw <- read.csv("data/climate/ngfs_climacred_global_raw.csv")
scenarios <- c("DIRE","HWTP","SWUC"); years <- 2022:2030
validate <- function(x = raw, p = portfolio) validate_climate_inputs(x,p,scenarios,years,metric_names)
validate()
bad(validate(raw[-1,]))
bad(validate(rbind(raw, raw[1,])))
bad(validate(subset(raw,year != 2029)))
bad(validate(subset(raw,scenario != "HWTP")))
z <- portfolio; z$ngfs_sector[1] <- "Missing sector"; bad(validate(p=z))
z <- raw; z$unit[1] <- "fraction"; bad(validate(z))
z <- raw; z$value[1] <- Inf; bad(validate(z))
ngfs_raw <- raw
chunk("chapters/06-climate-credit-risk/chapter.qmd", "step-017")
totals <- validate_climate_portfolio(climate_credit, portfolio, scenarios, years)
stopifnot(nrow(totals)==27, all(totals$ead == 1e8))
bad(validate_climate_portfolio(climate_credit[-1,], portfolio, scenarios, years))
z <- climate_credit; z$climate_pd[1] <- -0.1
bad(validate_climate_portfolio(z, portfolio, scenarios, years))
z <- climate_credit; z$baseline_pd[1] <- 1.01
bad(validate_climate_portfolio(z, portfolio, scenarios, years))
z <- climate_credit; z$ead[1] <- 1
bad(validate_climate_portfolio(z, portfolio, scenarios, years))
cat("Climate coverage, duplicates, units, values and PD checks PASS\n")
cat("Input conventions: annualized volatility =", .02*sqrt(252), "; rate =", log(1.05), "\n")
