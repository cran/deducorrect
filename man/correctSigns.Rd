\name{correctSigns}
\alias{correctSigns}
\title{Correct records violating linear restrictions with sign flips and value swaps}
\usage{correctSigns(E, dat, maxSigns=length(unique(c(flip, unlist(swap)))),
    eps=sqrt(.Machine$double.eps), flip=colnames(E), swap,
    swapIsOneFlip=FALSE, weight=NA, fix=NA)
}
\description{Correct records under linear restrictions using sign flips and variable swaps}
\details{This algorithm tries to repair records that violate linear equality constraints by
switching signs or swapping variable values occuring in violated edits. Possible rounding errors
can be taken into account. Specifically, it tries to solve

\eqn{(1)\quad \min_{s\in\{-1,1\}^n\backslash V}(\sum_{i=1}^n\delta_{s_i,-1}) \textrm{ under } |\sum_{i=1}^nE_{ji}x_is_i - b_j| \leq \varepsilon,\quad \forall j},

where \eqn{\delta} is the Kronecker delta function (the sum counts the number of occurences where \eqn{s_i=1}). Furthermore, 
\eqn{E} is an \code{editmatrix}, \eqn{x} is a the subset of a record of \code{dat} corresponding to
columns in \code{E}, and \eqn{b}  a vecor of constants. \eqn{V} is the set of vectors in \eqn{\{-1,1\}^n} excluded from the 
search space because they flip signs of variables not occuring in violated restrictions.

When a set \eqn{S} of equivalent solutions is found, the solution minimizing a certain
weight will be chosen. Rounding errors which mask sign  errors in \eqn{x} can be circumvented by setting \eqn{\varepsilon} to 2 or more
units of measure. 

Note that when two elements of \eqn{x} have coefficients with opposite signs in one of the rows of \eqn{E},
flipping the sign of both elements is equal to changing their order (\emph{i.e.} \eqn{a-b=-(b-a)}). We will
call this a variable swap.

The algorithm has two modes: one where a variable swap is counted as two sign flips (the default) and one where 
a variable swap is counted as one sign flip. This can be set with the option  \code{swapIsOneFlip}. 

If \code{swapIsOneFlip=FALSE}, the default, the algorithm tries to solve the minimization of Eqn. (1). When a set \eqn{S} of
multiple solutions is found the solution satisfying

\eqn{(2)\quad \min_{s\in S}\sum_{i=1}^n w_is_i\delta_{s_i,-1}}

is chosen (\eqn{n} is the number of variables in the record). 
If this still doesn't single out one solution, the first one encountered is used. If the user passes a list
of variable pairs which may be interchanged (the \code{swap} argument), the solution will be checked for
swaps and if so, the swaps are applied.

When \code{swapIsOneFlip=TRUE}, a value interchange counts as one sign change. The algorithm still searches for
the minimum of Eqn. (1). However, signs of swap-pairs are always changed simultaneously. Therefore the list of 
variables who's signs may be changed (\code{flip} argument) must be disjunct from the list of variable pairs
that may be swapped (\code{swap}). When more then one solution is found, the solution satisfying


\eqn{(3)\quad \min_{s\in S}\sum_{i\in {\tt flips}}^{m} w_i  +\sum_{i\in{\tt swaps}} w_i }

is chosen. Here, \eqn{w} is a vector of length \code{length{flip}+length{swap}}. The case where 
\code{swapIsOneFlip=TRUE}, is can be used in the the profit-loss account example
in \cite{Scholtus (2008)}.}
\value{An object of class \code{\link[=deducorrect-object]{deducorrect}}, where the \code{\link{status}} slot contains the following.

\tabular{ll}{
\code{status}\tab a \code{\link{status}} factor, showing the status of the treated record.\cr
\code{degeneracy}\tab the number of solutions found, \emph{after} applying the weight\cr
\code{weight}\tab the weight of the chosen solution\cr
\code{nflip}\tab the number of applied sign flips\cr
\code{nswap}\tab the number of applied value interchanges\cr
}}
\references{Scholtus S (2008). Algorithms for correcting some obvious
inconsistencies and rounding errors in business survey data. Technical
Report 08015, Netherlands.}
\seealso{\code{\link{deducorrect-object}}}
\arguments{\item{E}{An object of class \code{editmatrix}. It may contain equality as well as inequality constraints, 
but only the equality constraints will be used.}
\item{dat}{The data to correct}
\item{maxSigns}{Maximum number of signs that may be changed. Defaults to 
the number of variables that occur in violated edits if \code{swapIsOneFlip==FALSE}. Ignored otherwise.}
\item{eps}{Tolerance on edit check. Defaults to \code{sqrt(.Machine.double.eps)}. Increase this to correct sign errors masked by rounding.}
\item{flip}{Names of variables whos signs may be flipped. Defaults to \code{colnames(E)}, use \code{c()} to flip nothing.}
\item{swap}{\code{list} of 2-vectors containing pairs of variable names who's values may 
be interchanged. Defaults to \code{NA}.}
\item{swapIsOneFlip}{\code{logical}. Count a value interchange as 1 (TRUE) or 2 (default) sign changes. See details.}
\item{weight}{Positive numeric vector of length \code{ncol(E)}. Variables with heigher 
reliability weight are less likely to be changed. Defaults to \code{rep(1,ncol(E))}}
\item{fix}{character vector. Names of variables which may not be changed. Ignored when \code{swapIsOneFlip==TRUE}}
}
\examples{require(editrules)

# some data 
dat <- data.frame(
    x = c( 3,14,15, 1),
    y = c(13,-4, 5, 2),
    z = c(10,10,-10, NA))
# ... which has to obey
E <- editmatrix(c("z == x-y"))

# All signs may be flipped, no swaps.
correctSigns(E, dat)

# fix z, flip everything else
correctSigns(E, dat,fix="z")

# the same result is achieved with
correctSigns(E, dat, flip=c("x","y"))

# make x and y swappable, if both x and y are flipped, it is interpreted as a swap.
correctSigns(E, dat, flip=c(), swap=list(c("x","y")))

# make x and y swappable, swap a counts as one flip
correctSigns(E, dat, flip="z", swap=list(c("x","y")), swapIsOneFlip=TRUE)

# make x and y swappable, swap counts as one flip, flipping z gets higher penalty
correctSigns(E, dat, flip="z", swap=list(c("x","y")), swapIsOneFlip=TRUE, weight=c(2,1))}

