\name{parse_stones}
\alias{parse_stones}
\title{parse BayesTraits stones files}
\usage{parse_stones(file)}
\description{
	Scans and parses a BayesTraits stones file. 
}
\arguments{
  \item{file}{character string containing the full path to the stones file}
}
\details{This is used by the \code{bayestraits} function.}
\value{
	List with three elements: 1) \code{options}, a character vector containing model options, 2) \code{diagnostics}, a data frame containing diagnostic output, and \code{logMarLH}, a numeric value representing the log marginal likelihood. 
}
\author{
	Randi H. Griffin 
}