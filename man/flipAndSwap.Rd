\name{flipAndSwap}
\alias{flipAndSwap}
\title{Try to solve balance edit violations by sign changes and/or variable swaps.}
\usage{flipAndSwap(A, C, r, flip, swap, maxSigns, maxCombinations, eps, w)
}
\description{Try to solve balance edit violations by sign changes and/or variable swaps.}
\details{WARNING: THIS FUNCTION IS DEPRECATED AND NO LONGER MAINTAINED.
IT WILL BE REMOVED IN VERSION 1.0



This is one of the workhorse functions for \code{\link{old.correctSigns}}, the other being \code{\link{old.getSignCorrection}}. 
It performs a breadth-first tree search to resolve (near) equality edit violations. The difference with 
\code{\link{old.getSignCorrection}} is that variable swaps are interpreted as a single action.
The solution(s), if any, with as little as possible sign changes are returned.}
\value{A \code{list} with vectors of length \code{r} with coefficients 
in \eqn{\{-1,1\}}. Empty \code{list} if no solution is found.}
\arguments{\item{A}{The \code{matrix} part of an \code{editmatrix}}
\item{C}{The \code{CONSTANT} part of an \code{editmatrix}}
\item{r}{A numerical record.}
\item{flip}{vector of  indices (integers) in r who's values may be swapped.}
\item{swap}{nx2 array of index combinations of variables wich may be swapped.}
\item{maxSigns}{how many signs may maximally be flipped (a variable swap is counted as one flip)}
\item{maxCombinations}{how many sign flip combinations may be tested? Defaults to 1e5 and overrules maxSigns. See details.}
\item{eps}{Tolerance for equality restriction checkin}
\item{w}{weights vector of length length(flip)+nrow(swap), w[1:lenght(flip)] are penalties for changing variables 
corresponding to indices in \code{flip}, the remaining entries are penalties for the value interchanges in the
rows of \code{swap}.}
}

