% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/browse_edgar.R
\name{browse_edgar}
\alias{browse_edgar}
\title{Browse Edgar Web}
\usage{
browse_edgar(
  ticker,
  ownership = FALSE,
  type = "",
  before = "",
  count = 40,
  page = 1
)
}
\arguments{
\item{ticker}{either a stock ticker or CIK number}

\item{ownership}{boolean for inclusion of company change filings}

\item{type}{Type of filing to fetch}

\item{before}{yyyymmdd format of latest filing to fetch}

\item{count}{Number of filings to fetch per page}

\item{page}{Which page of results to return}
}
\value{
A xml document
}
\description{
Attempts to access Edgar Web's browse page for a given company
}
\keyword{internal}
