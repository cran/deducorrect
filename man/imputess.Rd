\name{imputess}
\alias{imputess}
\title{Impute values from solution space}
\usage{
  imputess(x, x0, C, z = NULL,
    tol = sqrt(.Machine$double.eps))
}
\arguments{
  \item{x}{(named) numerical vector to be imputed}

  \item{x0}{\code{x0} outcome of \code{\link{solSpace}}}

  \item{C}{\code{C} outcome of \code{\link{solSpace}}}

  \item{z}{real vector of dimension \code{ncol(C)}.}

  \item{tol}{tolerance used to check which rows of \code{C}
  equal zero.}
}
\description{
  Given a record \eqn{x} with observerd \eqn{x_{obs}} and
  missing values \eqn{x_{miss}} under linear equality
  constraints \eqn{Ax=b}. The function
  \code{\link{solSpace}} returns the solution space which
  can be written as \eqn{x_{miss} = x_0 + Cz}, where
  \eqn{x_0} is are a constant vector (of dimension
  d=\code{length}\eqn{(x_{miss})}) and \eqn{C} a constant
  matrix of dimension \eqn{d\times d}.
}
\details{
  If \eqn{C} has rows equal to zero, then those missing
  values may be imputed deductively. For the other missing
  values, some \eqn{z} must be chosen or another imputation
  method used.

  The function \code{imputess} imputes missing values in a
  vector \eqn{x}, based on the solution space and some
  chosen vector \eqn{z}. If no \eqn{z} is passed as
  argument, only deductive imputations are performend (i.e.
  some missings may be left).

  If \eqn{C} is a named matrix (as returned by
  \code{\link{solSpace}}), rows of \eqn{x0} and \eqn{C} are
  matched by name to \eqn{x}. Otherwise it is assumed that
  the missings in \eqn{x} occur in the order of the rows in
  \eqn{C} (which is also the case when x0 and C are
  computed by \code{\link{solSpace}}).
}
\examples{

#############################################
# IMPUTATION OF NUMERIC DATA
#############################################

# These examples are taken from De Waal et al (2011) (Examples 9.1-9.2)
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

dat

d <- deduImpute(E,dat)
d$corrected
d$status
d$corrections




#############################################
# IMPUTATION OF CATEGORICAL DATA
#############################################


# Here's an example from Katrika (2001) [but see De Waal et al (2011), ex. 9.3)]
E <- editarray(c(
    "x1 \\\%in\\\% letters[1:4]",
    "x2 \\\%in\\\% letters[1:3]",
    "x3 \\\%in\\\% letters[1:3]",
    "x4 \\\%in\\\% letters[1:2]",
    "if (x2 == 'c'  & x3 != 'c' & x4 == 'a' ) FALSE",
    "if (x2 != 'a'  & x4 == 'b') FALSE",
    "if (x1 != 'c'  & x2 != 'b' & x3 != 'a') FALSE",
    "if (x1 == 'c'  & x3 != 'a' & x4 == 'a' ) FALSE"
))


dat <- data.frame(
    x1 = c('c', NA ),
    x2 = c('b', NA ),
    x3 = c(NA , NA ),
    x4 = c(NA , 'b'),
    stringsAsFactors=FALSE)


s <- deduImpute(E,dat)
s$corrected
s$status
s$corrections




}

