\name{solSpace}
\alias{solSpace}
\alias{solSpace.editmatrix}
\alias{solSpace.matrix}
\title{Solution space for missing values under equality constraints}
\usage{
  solSpace(E, x, ...)

  \method{solSpace}{editmatrix} (E, x, adapt =
  logical(length(x)), checkFeasibility = TRUE, ...)

  \method{solSpace}{matrix} (E, x, b, adapt =
  logical(length(x)), tol = sqrt(.Machine$double.eps), ...)
}
\arguments{
  \item{E}{and \code{editmatrix} or equality constraint
  matrix}

  \item{x}{a named numeric vector.}

  \item{...}{Extra parameters to pass to
  \code{solSpace.matrix}}

  \item{checkFeasibility}{Check if the observed values can
  lead to a consistent record}

  \item{b}{Equality constraint constant vector}

  \item{adapt}{A named logical vector with variables in the
  same order as in x}

  \item{tol}{tolerance used to determine 0-singular values
  when determining generalized inverse and to round
  coefficients of C to zero. See \code{MASS::ginv}.}
}
\value{
  A \code{list} with elements \eqn{x0} and \eqn{C} or
  \code{NULL} if the solution space is empty
}
\description{
  Solution space for missing values under equality
  constraints

  solSpace method for editmatrix

  This function finds the space of solutions for a
  numerical record \eqn{x} with missing values under linear
  constraints \eqn{Ax=b}. Write \eqn{x=(x_{obs},x_{miss})}.
  Then the solution space for \eqn{x_{miss}} is given by
  \eqn{x_0 + Cz}, where \eqn{x_0} is a constant vector,
  \eqn{C} a constant matrix and \eqn{z} is any real vector
  of dimension \code{ncol(C)}. This function computes
  \eqn{x_0} and \eqn{C}.
}
\details{
  The user can specify extra fields to include in
  \eqn{x_{miss}} by specifying \code{adapt}. Also note that
  the method rests on the assumtion that all nonmissng
  values of \eqn{x} are correct.

  The most timeconsuming step involves computing the
  generalized inverse of \eqn{A_{miss}} using
  \code{MASS::ginv} (code copied from MASS to avoid
  dependency). See the package vignette and De Waal et al.
  (2011) for more details.
}
\examples{

# This example is taken from De Waal et al (2011) (Examples 9.1-9.2)
E <- editmatrix(c(
    "x1 + x2      == x3",
    "x2           == x4",
    "x5 + x6 + x7 == x8",
    "x3 + x8      == x9",
    "x9 - x10     == x11",
    "x6 >= 0",
    "x7 >= 0"
))


dat <- data.frame(
    x1=c(145,145),
    x2=c(NA,NA),
    x3=c(155,155),
    x4=c(NA,NA),
    x5=c(NA, 86),
    x6=c(NA,NA),
    x7=c(NA,NA),
    x8=c(86,86),
    x9=c(NA,NA),
    x10=c(217,217),
    x11=c(NA,NA)
)

# example with solSpace method for editmatrix
# example 9.1 of De Waal et al (2011).
x <-t(dat)[,1]
s <- solSpace(E,x)
s

# some values are uniquely determined and may be imputed directly:
imputess(x,s$x0,s$C)


# To impute everything, we choose z=1 (arbitrary)
z <- rep(1,sum(is.na(x)))
(y <- imputess(x,s$x0,s$C,z))

# did it work? (use a tolerance in checking to account for machine rounding)
# (FALSE means an edit is not violated)
any(violatedEdits(E,y,tol=1e-8))


# here's an example showing that solSpace only looks at missing values
# unless told otherwise.
Ey <- editmatrix(c(
    "yt == y1 + y2 + y3",
    "y4 == 0"))
y <- c(yt=10, y1=NA, y2=3, y3=7,y4=12)
# since solSpace by default checks the feasibility, we get no solution (since y4 violates the second edit)"
solSpace(Ey,y)


# If we ask solSpace not to check for feasibility, y4 is left alone (although the imputed answer is clearly wrong).
(s <- solSpace(Ey,y,checkFeasibility=FALSE))
imputess(y, s$x0, s$C)

# by setting 'adapt' we can include y4 in the imputation
# Since we know that with this adapt vector, imputation can be done consistently, we save some time by switching the feasibility check off.
(s <- solSpace(Ey,y,adapt=c(FALSE,FALSE,FALSE,FALSE,TRUE), checkFeasibility=FALSE))
imputess(y,s$x0,s$C)


}
\references{
  T. De Waal, J. Pannekoek and S. Scholtus (2011) Handbook
  of statistical data editing Chpt 9.2.1

  Venables, W. N. & Ripley, B. D. (2002) Modern Applied
  Statistics with S. Fourth Edition. Springer, New York.
  ISBN 0-387-95457-0
}
\seealso{
  \code{\link{deduImpute}}, \code{\link{deductiveZeros}}
}

