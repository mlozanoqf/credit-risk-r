# Companion release status

## Reference inputs and execution

The repository contains the complete frozen credit-scoring dataset for
Chapters 1 and 2. See [provenance](data/credit-scoring/PROVENANCE.md).
The book and Python companion use the same RDS file. All six frozen inputs
match their recorded hashes. The repository remains private until publication.

## Verified results

Full-data clean-distribution validation passed on Windows 11 on 11 October
2026 using R 4.6.1, Quarto 1.5.54 and Rtools45. All seven units ran independently
with freshly restored packages and no author cache. The environment contains
82 locked packages; unused rayshader dependencies were removed without
changing retained package versions. This used the installed R runtime, not
a new operating system or virtual machine.

The October 15 rerun used the recorded, already installed Windows environment.
Both scoring chapters executed independently. All 393 saved numeric objects
were identical to their preceding R values at tolerance zero; RDS container
bytes can differ. This was a rerun, not a fresh package installation.

A separate October 12 check of Foundations and Chapters 3-6 reproduced all
598 numerical objects at tolerance zero, 77 CSV tables byte for byte and
53 figures pixel for pixel, using the R16-validated package library.

## Package scope

This package contains computations and result captions. Generated reports,
model objects, publisher files, reviewer correspondence and instructor
solutions are separate from the reader package. Code uses GPL-3.0; source
notices for external inputs are provided with those inputs.
