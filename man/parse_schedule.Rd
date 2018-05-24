\name{parse_schedule}
\alias{parse_schedule}
\title{parse BayesTraits schedule files}
\usage{parse_schedule(file)}
\description{
	Scans and parses a BayesTraits schedule file. 
}
\arguments{
  \item{file}{character string containing the full path to the schedule file}
}
\details{This is used by the \code{bayestraits} function.}
\value{
	List with two elements: 1) \code{schedule}, a data frame listing the percentage of operators tried, and 2) \code{header}, a data frame containing further chain mixing diagnostics. 
}
\author{
	Randi H. Griffin 
}