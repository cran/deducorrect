\name{hellerTompkins}
\alias{hellerTompkins}
\title{Determine if a matrix is totally unimodular using Heller and Tompkins criterium.}
\usage{hellerTompkins(A)
}
\description{Determine if a matrix is totally unimodular using Heller and Tompkins criterium.}
\details{This function is \code{deducorrect} internal}
\value{\code{TRUE} if matrix is unimodular, otherwise \code{FALSE}}
\seealso{\code{\link{isTotallyUnimodular}}}
\arguments{\item{A}{An object of class matrix in \eqn{\{-1,0,1\}^{m\times n}}. 
Each column  must have exactly 2 nonzero elements. (This is tested by 
\code{\link{isTotallyUnimodular}}).}
}

