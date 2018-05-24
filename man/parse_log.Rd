\name{parse_log}
\alias{parse_log}
\title{parse BayesTraits log files}
\usage{parse_log(file)}
\description{
	Scans and parses a BayesTraits log file. 
}
\arguments{
  \item{file}{character string containing the full path to the log file}
}
\details{This is used by the \code{bayestraits} function.}
\value{
	List with two elements: 1) \code{options}, a character vector containing information on model options, and 2) \code{results}, a data frame containing model results.
}
\author{
	Randi H. Griffin 
}