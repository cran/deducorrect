\name{status}
\alias{status}
\title{Create empty status vector}
\usage{status(n, ini=NA)
}
\description{Create empty status vector}
\details{Every function in \code{\link[=deducorrect-package]{deducorrect}} returns the status of every row after treatment.
The status vector is an \code{ordered} factor with levels

\tabular{ll}{
\code{invalid}      \tab record is invalid but could not be corrected\cr
\code{partial}    \tab record violates less edits then before entering the function\cr
\code{corrected}    \tab record satisfies all edit restrictions after correction\cr
\code{valid}        \tab record violates no edit restrictions\cr
}
where \code{invalid < partial < corrected < valid}



This function is \code{deducorrect} internal.}
\value{an ordered factor with levels mentioned under details}
\arguments{\item{n}{length of status vector}
\item{ini}{initial value, defaults to \code{NA}}
}
\examples{# create statusvector

status <- deducorrect:::status(5)
status[1:5] <- c("invalid",NA,"corrected","valid","partial")

# 
which(status < "valid")}

