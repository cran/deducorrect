\name{correctTypos}
\alias{correctTypos}
\title{Correct records under linear restrictions using typographical error suggestions...}
\usage{correctTypos(E, dat, fixate, cost=c(1, 1, 1, 1), eps=sqrt(.Machine$double.eps),
    maxdist=1)
}
\description{Correct records under linear restrictions using typographical error suggestions}
\details{This algorithm tries to detect and repair records that violate linear equality constraints by correcting simple typo's as described in Scholtus (2009).
The implemention of the detection of typing errors differs in that it uses the Damerau-Levensthein distance. Furthermore it solves a broader class of 
problems: the original paper describes the class of equalities: \eqn{Ex=0} (balance edits) and this implementation allows for  \eqn{Ex=a}.

For each row in \code{dat} the correction algorithm first detects if row \code{x} violates the equality constraints of \code{E} taking possible rounding errors into account.
Mathematically:
\eqn{|\sum_{i=1}^nE_{ji}x_i - a_j| \leq \varepsilon,\quad \forall j }

It then generates correction suggestions by deriving alternative values for variables only involved in the violated edits. The correction suggestions must be within a typographical
edit distance (default = 1) to be selected. If there are more then 1 solutions possible the algorithm tries to derive a partial solution, otherwise the solution is applied to the data.

\code{correctTypos} returns an object of class \code{\link[=deducorrect-object]{deducorrect}} object describing the status of the record and the corrections that have been applied.

Inequalities in editmatrix \code{E} will be ignored in this algorithm, so if this is the case, the corrected records
are valid according to the equality restrictions, but may be incorrect for the given inequalities.

Please note that if the returned status of a record is "partial" the corrected record still is not valid.
The partially corrected record will contain less errors and will violate less constraints. 
Also note that the status "valid" and "corrected" have to be interpreted in combination with \code{eps}.
A common scenario is first to correct for typo's and then correct for rounding errors. This means that in the first
step the algorithm should allow for typo's (e.g. \code{eps==2}). The returned "valid"  record therefore may still contain 
rounding errors.}
\seealso{\code{\link{damerauLevenshteinDistance}}}
\value{\code{\link[=deducorrect-object]{deducorrect}} object with corrected data.frame, applied corrections and status of the records.}
\references{Scholtus S (2009). Automatic correction of simple typing errors in numerical data with balance edits.
Discussion paper 09046, Statistics Netherlands, The Hague/Heerlen.

Damerau F (1964). A technique for computer detection and correction of
spelling errors. Communications of the ACM, 7,issue 3

Levenshtein VI (1966). Binary codes capable of correcting deletions, insertions, 
and reversals. Soviet Physics Doklady 10: 707-10}
\arguments{\item{E}{\code{\link{editmatrix}} that constrains \code{x}}
\item{dat}{\code{data.frame} with data to be corrected.}
\item{fixate}{\code{character} with variable names that should not be changed.}
\item{cost}{for a deletion, insertion, substition or transposition.}
\item{eps}{\code{numeric}, tolerance on edit check. Default value is \code{sqrt(.Machine$double.eps)}. Set to 2 
to allow for rounding errors. Set this parameter to 0 for exact checking.}
\item{maxdist}{\code{numeric}, tolerance used in finding typographical corrections. Default value 1 allows for one error. Used in combination with \code{cost}.}
}
\examples{library(editrules)

# example from section 4 in Scholtus (2009)

E <- editmatrix( c("x1 + x2 == x3"
                  ,"x2 == x4"
                  ,"x5 + x6 + x7 == x8"
                  ,"x3 + x8 == x9"
                  ,"x9 - x10 == x11"
                  )
               )

dat <- read.csv(txt<-textConnection(
"    , x1, x2 , x3  , x4 , x5 , x6, x7, x8 , x9   , x10 , x11
4  , 1452, 116, 1568, 116, 323, 76, 12, 411,  1979, 1842, 137
4.1, 1452, 116, 1568, 161, 323, 76, 12, 411,  1979, 1842, 137
4.2, 1452, 116, 1568, 161, 323, 76, 12, 411, 19979, 1842, 137
4.3, 1452, 116, 1568, 161,   0,  0,  0, 411, 19979, 1842, 137
4.4, 1452, 116, 1568, 161, 323, 76, 12,   0, 19979, 1842, 137"
))
close(txt)
(cor <- correctTypos(E,dat))}

