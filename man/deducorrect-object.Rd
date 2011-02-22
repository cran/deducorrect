\name{deducorrect-object}
\alias{deducorrect-object}
\alias{deducorrect-object}
\title{deducorrect object}
\description{deducorrect object}
\details{All \code{correct*} functions of the deducorrect package return an S3 object of class \code{deducorrect}.
The "public slots" are
\itemize{
\item{\code{corrected} A copy of the input \code{data.frame}, with records corrected where possible.}
\item{\code{corrections} A data.frame with the following colums:
\itemize{    
\item{\code{row} Row number where correction was applied}
\item{\code{variable} Variable name where correction was applied} 
\item{\code{old} Old value of adapted variable}
\item{\code{new} New value of adapted variable}
}}   
\item{\code{status} A \code{data.frame} with the same number of rows as \code{corrected}. It has at least
a column called \code{\link{status}}. Further columns might be present, depending on the used correction function.}
\item{\code{generatedby} The name of the function that called \code{\link{newdeducorrect}} to construct the object.}
\item{\code{timestamp} The time and date when the object was generated, as returned by \code{\link{date}}.}
\item{\code{user} The system's username of the user running R. Note that this may yield unexpected results when R accessed on a remote (web)server.}
}}

