\name{deduImpute}
\alias{deduImpute}
\alias{deduImpute.editarray}
\alias{deduImpute.editmatrix}
\title{Deductive imputation of numerical or categorical values}
\usage{
  deduImpute(E, dat, adapt = NULL, ...)

  \method{deduImpute}{editarray} (E, dat, adapt = NULL,
    ...)

  \method{deduImpute}{editmatrix} (E, dat, adapt = NULL,
    tol = sqrt(.Machine$double.eps), ...)
}
\arguments{
  \item{E}{An \code{editmatrix} or \code{editarray}}

  \item{dat}{A \code{data.frame}}

  \item{adapt}{(optional) A boolean array of dim(dat), e.g.
  the result editrules::localizeErrors(E,dat).  Column
  names must match those of \code{dat}.}

  \item{...}{arguments to be passed to
  \code{\link{solSpace}} (numerical data) or
  \code{\link{deductiveLevels}} (categorical data)}

  \item{tol}{tolerance to use in \code{\link{solSpace}} and
  in \code{\link{deductiveZeros}}}
}
\value{
  A \code{\link{deducorrect-object}}
}
\description{
  Based on observed values and edit rules, impute as many
  variables deductively as possible.

  \bold{For categorical data:} The funcion
  \code{\link{deductiveLevels}} is used to derive deductive
  imputations for as many fields as possible

  \bold{For numerical data:} Given (equality) rules and a
  number of values to impute or adapt, in some cases unique
  solutions can be derived. This function uses
  \code{\link{solSpace}} and \code{\link{deductiveZeros}}
  (iteratively) to determine which values can be imputed
  deductively. Solutions causing new violations of
  (in)equality rules are rejected by default by testing if
  the observed values can lead to a feasible record. This
  may be switched off by passing
  \code{checkFeasibility=FALSE}. This may be desirable for
  performance reasons. If \code{adapt} was computed with an
  error localization algorithm, such as
  \code{editrules::localizeErrors}, the feasibility check
  is also not nessecary.
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
\references{
  T. De Waal, J. Pannekoek and S. Scholtus (2011) Handbook
  of statistical data editing Chpt 9.2.1 - 9.2.2
}
\seealso{
  \code{\link{deductiveZeros}}, \code{\link{solSpace}},
  \code{\link{deductiveLevels}}
}

