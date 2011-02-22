\name{applyFix}
\alias{applyFix}
\title{Apply flips and swaps to a record.}
\usage{
  applyFix(flips, swaps, r)
}
\arguments{
  \item{flips}{Index vector in r. r will be sign-flipped at
  flips}

  \item{swaps}{nx2 matrix denoting value swaps in r.}

  \item{r}{numerical record.}
}
\value{
  r, with flips and swaps applied
}
\description{
  Apply flips and swaps to a record.
}
\keyword{internal}

