\name{deducorrect-package}
\alias{deducorrect-package}
\alias{deducorrect-package}
\title{Deductive correction methods for sign, rounding and typing errors...}
\description{Deductive correction methods for sign, rounding and typing errors}
\details{Deductive correction methods for sign, rounding and typing errors
It also contains functionality to check if a matrix of linear restrictions is
totally unimodular. See also

\itemize{
\item{\code{\link{correctRounding}}}
\item{\code{\link{correctSigns}}}
\item{\code{\link{correctTypos}}}
\item{\code{\link{deducorrect-object}} and \code{\link{status}} for output specification}
\item{\code{\link{isTotallyUnimodular}}}
}}
\docType{package}
\examples{require(editrules)

# some data 
dat <- data.frame(
    x = c( 3, 14, 15),
    y = c(13, -4,  5),
    z = c(10, 10,-10))

dat
# ... which has to obey
E <- editmatrix("z == x-y")


# All signs may be flipped, no swaps.
correctSigns(E, dat)

correctTypos(E, dat)

correctRounding(E, dat)}

