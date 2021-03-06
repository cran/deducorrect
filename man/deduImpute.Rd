% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/deduImpute.R
\name{deduImpute}
\alias{deduImpute}
\alias{deduImpute.editarray}
\alias{deduImpute.editmatrix}
\alias{deduImpute.editset}
\title{Deductive imputation of numerical or categorical values}
\usage{
deduImpute(E, dat, adapt = NULL, ...)

\method{deduImpute}{editset}(E, dat, adapt = NULL, ...)

\method{deduImpute}{editarray}(E, dat, adapt = NULL, ...)

\method{deduImpute}{editmatrix}(E, dat, adapt = NULL,
  tol = sqrt(.Machine$double.eps), round = TRUE, ...)
}
\arguments{
\item{E}{An \code{editmatrix} or \code{editarray}}

\item{dat}{A \code{data.frame}}

\item{adapt}{(optional) A boolean array of dim(dat), e.g. the result editrules::localizeErrors(E,dat).
Column names must match those of \code{dat}.}

\item{...}{arguments to be passed to \code{\link{solSpace}} (numerical data) or \code{\link{deductiveLevels}} (categorical data)}

\item{tol}{tolerance to use in \code{\link{solSpace}}
and in \code{\link{deductiveZeros}}}

\item{round}{should the result be rounded?}
}
\value{
A \code{\link{deducorrect-object}}
}
\description{
Based on observed values and edit rules, impute as many variables deductively as possible.

If \code{E} is an \code{editset}, imputation based on numerical rules (if any) is performed,
and imputations violating extra edits are reverted. Next, this procedure is repeated for
pure categorical rules. The results are combined and returned in a \code{deducorrect} object.

\bold{For categorical data:} The funcion \code{\link{deductiveLevels}} is used to derive
deductive imputations for as many fields as possible

\bold{For numerical data:} Given (equality) rules and a number of values to impute or adapt, in some cases
unique solutions can be derived. This function uses \code{\link{solSpace}} and
\code{\link{deductiveZeros}} (iteratively) to determine which values can be imputed
deductively. Solutions causing new violations of (in)equality rules are rejected by default by testing
if the observed values can lead to a feasible record. This may be switched off by passing
\code{checkFeasibility=FALSE}. This may be desirable for performance reasons. If \code{adapt}
was computed with an error localization algorithm, such as \code{editrules::localizeErrors}, the
feasibility check is also not nessecary.
}
\note{
When \code{adapt} is not \code{NULL}, values in \code{dat} where \code{adapt==TRUE}
are replaced with \code{NA}. The output may therefore contain missings at positions
that were previously filled (with wrong values, according to \code{adapt}).
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


E <- editset(expression(
    x + y == z,
    x >= 0,
    A \%in\% c('a','b'),
    B \%in\% c('c','d'),
    if ( A == 'a' ) B == 'b',
    if ( B == 'b' ) x > 0
))

x <- data.frame(
    x = NA,
    y = 1,
    z = 1,
    A = 'a',
    B = NA
)
# deduImpute will impute x=0 and B='b',which violates the 
# last edit. Hence, imputation will be reverted.
deduImpute(E,x) 


}
\references{
T. De Waal, J. Pannekoek and S. Scholtus (2011) Handbook of statistical data editing
Chpt 9.2.1 - 9.2.2
}
\seealso{
\code{\link{deductiveZeros}}, \code{\link{solSpace}}, \code{\link{deductiveLevels}}
}

