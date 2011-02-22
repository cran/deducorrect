\name{hellerTompkins}
\alias{hellerTompkins}
\title{Determine if a matrix is totally unimodular using Heller and Tompkins criterium.}
\usage{
  hellerTompkins(A)
}
\arguments{
  \item{A}{An object of class matrix in
  \eqn{\{-1,0,1\}^{m\times n}}.  Each column must have
  exactly 2 nonzero elements. (This is tested by
  \code{\link{isTotallyUnimodular}}).}
}
\value{
  \code{TRUE} if matrix is unimodular, otherwise
  \code{FALSE}
}
\description{
  This function is \code{deducorrect} internal
}
\seealso{
  \code{\link{isTotallyUnimodular}}
}

