#!/bin/bash

R -f sweave.r
latex deducorrect-vignette.tex
bibtex deducorrect-vignette
pdflatex deducorrect-vignette.tex

