\name{newdeducorrect}
\alias{newdeducorrect}
\title{Generate an S3 deducorrect object...}
\usage{newdeducorrect(corrected, corrections, status)
}
\description{Generate an S3 \code{deducorrect} object}
\alias{print.deducorrect}
\value{an S3 object of class \code{deducorrect}}
\seealso{\code{\link{deducorrect-object}}}
\arguments{\item{corrected}{The corrected data.frame}
\item{corrections}{A \code{data.frame} listing old and new values for every row and variable where corrections were applied}
\item{status}{A \code{data.frame} with at least one \code{\link{status}} column.}
}

