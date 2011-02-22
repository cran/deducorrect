\name{old.getSignCorrection}
\alias{old.getSignCorrection}
\title{Try to solve balance edit violations by sign changes...}
\usage{old.getSignCorrection(A, C, r, adapt, maxSigns, maxCombinations, eps, w)
}
\description{Try to solve balance edit violations by sign changes}
\details{WARNING: THIS FUNCTION IS DEPRECATED AND NO LONGER MAINTAINED.
IT WILL BE REMOVED IN VERSION 1.0

This is one of the workhorse functions for \code{\link{old.correctSigns}}, the other being \code{\link{flipAndSwap}}.
It performs a breadth-first tree search to resolve (near) equality edit violations. The difference with \code{\link{flipAndSwap}}
is that variable swaps are interpreted as two actions (two sign flips).
The solution(s), if any, with as little as possible sign changes are returned.}
\value{A \code{list} with vectors of length \code{r} with coefficients 
in \eqn{\{-1,1\}}. Empty \code{list} if no solution is found.}
\seealso{\code{\link{old.correctSigns}}}
\arguments{\item{A}{The \code{matrix} part of an \code{editmatrix}}
\item{C}{The \code{CONSTANT} part of an \code{editmatrix}}
\item{r}{A numerical record.}
\item{adapt}{A logical vector of length \code{ncol(A)} indicating which variables may be changed.}
\item{maxSigns}{how many signs may maximally be flipped?}
\item{maxCombinations}{how many sign flip combinations may be tested? Overrules maxSigns.}
\item{eps}{Tolerance for equality restriction checking}
\item{w}{positive weight vector of \code{length(ncol(A))}}
}

