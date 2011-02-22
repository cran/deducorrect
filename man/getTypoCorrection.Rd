\name{getTypoCorrection}
\alias{getTypoCorrection}
\title{Check record validity and suggest typo corrections}
\usage{
  getTypoCorrection(E, x, fixate = FALSE, eps =
  sqrt(.Machine$double.eps), maxdist = 1)
}
\arguments{
  \item{E}{editmatrix}

  \item{x}{numerical record to be checked}

  \item{eps}{tolerance for an edit to be valid}

  \item{maxdist}{maximum edit distance to be valid as a
  correction suggestion}
}
\value{
  list with members \tabular{ll}{ status \tab \cr cor \tab
  suggested corrections \cr B \tab reduced binary
  editmatrix with violated edits, needed for choosing the
  suggested corrections\cr }
}
\description{
  This function is the working horse for
  \code{\link{correctTypos}}
}
\keyword{internal}

