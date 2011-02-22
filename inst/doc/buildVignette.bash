#!/bin/bash

R -e "Sweave('deducorrect-vignette.Snw')"
latex deducorrect-vignette.tex
bibtex deducorrect-vignette
latex deducorrect-vignette.tex
pdflatex deducorrect-vignette.tex


