# NGFS/IIASA Raw Climate Credit Data

The frozen download manifest retains the original paths beginning with
`data/raw/`. In this companion those same files are under `data/climate/`;
their contents are unchanged. A deliberate refresh will record the new paths.

This folder stores the raw NGFS/IIASA CLIMACRED files used in Chapter 6.

The files were downloaded from the NGFS Phase 5 Short Term Scenario Explorer
using the public IIASA API. The download code is in:

`chapters/06-climate-credit-risk/helpers/download-data.R`

To refresh the data from R:

```r
source("chapters/06-climate-credit-risk/helpers/download-data.R")
```

The refresh script requires internet access and the R packages `httr` and
`jsonlite`.

The script requests a guest token, sends a JSON query to the time-series
endpoint, and writes the API response before the chapter performs any cleaning
or financial calculations.

Files:

- `ngfs_climacred_global_raw.csv`: global CLIMACRED observations for the main
  sector portfolio analysis.
- `ngfs_climacred_daps_raw.csv`: regional DAPS physical-stress observations
  used for the physical-risk diagnostic.
- `ngfs_climacred_download_manifest.csv`: file names, row counts, endpoint, and
  download timestamp.

The CSV files are raw for the purpose of the chapter. They preserve the API
columns such as `runId`, `model`, `scenario`, `region`, `variable`, `unit`,
`year`, and `value`. The chapter then separates metrics from sectors, joins the
illustrative portfolio, converts percentage-point values into decimal PDs, and
calculates expected loss, spread, price, and portfolio risk quantities.

## Attribution and source license

Source: NGFS Phase 5 Short Term Scenario Explorer, hosted by IIASA,
[official database](https://data.ece.iiasa.ac.at/ngfs-phase-5-short-term/).
Copyright IIASA 2022, as displayed on the
[source license page](https://data.ece.iiasa.ac.at/ngfs-phase-5-short-term/#/license).
This is a public license adapted from CC BY 4.0, not the unmodified CC license
and not the GPL license used for the analysis code.

The license permits sharing non-substantial extracts and derived analyses with
attribution; it prohibits redistribution of substantial portions of the source
database. These chapter-specific extracts contain 1,350 global observations and
126 regional DAPS observations. Their retention is based on this limited,
reproducibility-focused scope. The license specifies no numerical threshold
for substantiality; no separate provider confirmation has been obtained.

The manifest records the original database, endpoint and download time
(4 June 2026, UTC). The files preserve the selected API observations and values;
they are frozen extracts, not a current or complete copy of the database.
Selection and CSV serialization precede the cleaning and transformations
documented in Chapter 6. Refreshing or expanding the extract requires a new
review of its scope and the applicable source conditions.

The source material is supplied as-is and without warranties, subject to the
disclaimer and liability provisions in Section 5 of the linked license. Neither
NGFS nor IIASA endorses this companion or its interpretations. Retain this
attribution, copyright notice, source and license links, disclaimer reference,
and indication of modifications when redistributing the extracts.
