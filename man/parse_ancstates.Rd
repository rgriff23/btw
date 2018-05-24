\name{parse_ancstates}
\alias{parse_ancstates}
\title{parse BayesTraits ancstates files}
\usage{parse_ancstates(file)}
\description{
	Scans and parses a BayesTraits ancstates file. 
}
\arguments{
  \item{file}{character string containing the full path to the ancstates file}
}
\details{This is used by the \code{bayestraits} function.}
\value{
	List with two elements: 1) \code{nodes}, a character vector containing node definitions, and 2) \code{results}, a data frame containing model results for ancestral state reconstructions. 
}
\author{
	Randi H. Griffin 
}