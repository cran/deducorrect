\name{correctRounding}
\alias{correctRounding}
\title{Correct records under linear restrictions for rounding errors}
\usage{
  correctRounding(R, dat, Q = NULL, fixate = NULL, delta =
  2, K = 10, round = TRUE, assumeUnimodularity = FALSE)
}
\arguments{
  \item{R}{editmatrix \eqn{Rx = a}, matrix may contain
  inequalities}

  \item{dat}{\code{data.frame} with the data to be
  corrected}

  \item{Q}{deprecated, (add inequalities to R)}

  \item{fixate}{\code{character} with variable names that
  should not be changed.}

  \item{delta}{tolerance on checking for rounding error}

  \item{K}{number of trials per record. See details}

  \item{round}{should the solution be a rounded, default
  TRUE}

  \item{assumeUnimodularity}{If \code{FALSE}, a test is
  performed before corrections are computed (expensive).}
}
\value{
  A \code{\link[=deducorrect-object]{deducorrrect}} object.
}
\description{
  This algorithm tries to detect and repair records that
  violate linear (in)equality constraints by correcting
  possible rounding errors as described by Scholtus(2008).
  Typically data is constrainted by \eqn{Rx=a} and \eqn{Qx
  \ge b}.
}
\details{
  The algorithm first finds violated constraints
  \eqn{|r'_{i}x-a_i| > 0} , and selects edits that may be
  due to a rounding error \eqn{0 < |r'_{i}x-a_i| \leq
  \delta}. The algorithm then makes a correction suggestion
  where the errors are attributed to randomly selected
  variables under the lineair equality constraints. It
  checks if the suggested correction does not violate the
  inequality matrix \eqn{Q}. If it does, it will try to
  generate a different solution up till \code{K} times.
}
\examples{
require(editrules)

E <- editmatrix(c( "x1 + x2 == x3"
                 , "x2 == x4"
                 , "x5 + x6  + x7== x8"
                 , "x3 + x8 == x9"
                 , "x9 - x10 == x11"
                 )
               )

dat <- data.frame( x1=12
                 , x2=4
                 , x3=15
                 , x4=4
                 , x5=3
                 , x6=1
                 , x7=8
                 , x8=11
                 , x9=27
                 , x10=41
                 , x11=-13
                 )

sol <- correctRounding(E, dat)
}
\references{
  Scholtus S (2008). Algorithms for correcting some obvious
  inconsistencies and rounding errors in business survey
  data. Technical Report 08015, Statistics Netherlands.
}
\seealso{
  \code{\link{deducorrect-object}} \code{\link{status}}
}

