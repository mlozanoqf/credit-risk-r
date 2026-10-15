# Companion release status

## Current private distribution: 15 October 2026

The author authorized inclusion of the complete frozen scoring dataset in
this private repository, with source attribution and a description of the
modifications. See [provenance](data/credit-scoring/PROVENANCE.md).
This supersedes the input exclusion in the initial-release record below.
Future public redistribution remains a separate review. Repository visibility,
model specifications, data values and dependency versions are unchanged.

The October 15 rerun uses the recorded, already installed Windows environment,
rather than a fresh package installation. Both scoring chapters execute
independently. All 393 saved numeric objects are identical to their preceding
R values at tolerance zero (RDS container bytes differ). All six frozen
inputs match their recorded hashes. The same RDS is used by the book and Python.

## Initial companion release

Prepared for public release on 12 October 2026.
Book reference: review build 11 October 2026, 04:10:23 -06:00.

The author authorized publication with the credit-scoring dataset excluded.
Analysis code uses GPL-3.0; data terms are separate. Chapters 1 and 2 retain
their code but cannot reproduce the reference results without an authorized
local copy of that dataset. Generated reports, tables, model objects and
private source materials are not distributed.

Full-data clean-distribution validation passed on Windows
11 on 11 October 2026 using R 4.6.1, Quarto 1.5.54 and Rtools45. All seven
units ran independently with freshly restored packages and no author cache.
The environment contains 82 locked packages; unused rayshader dependencies
have been removed. The versions of retained packages remain unchanged.
The validation used the installed R runtime on this computer, not a new OS
or virtual machine. Those full-data results do not imply that the excluded
dataset is available in the public release.
Existing source/data notices are preserved; no additional data rights are granted.

On 12 October, the Git-index export without credit-scoring data was tested
using the R16-validated package library. Foundations and Chapters 3-6 ran
independently. All 598 numerical objects matched at tolerance zero, 77 CSV
tables matched byte for byte, and 53 figures matched pixel for pixel.
The five distributed input files passed their checksums. Chapters 1-2 stopped
with the intended missing-data message. This is a distribution check using
the existing validated library, not a second clean package installation.

This package contains computations and result captions, not the manuscript,
publisher template, reviewer correspondence or instructor solutions.
