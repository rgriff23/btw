\name{plotdiscrete}
\alias{plotdiscrete}
\title{Plot Discrete}
\usage{
plotdiscrete(model, estimates=TRUE, main=NULL)
}
\description{
	Plot a transition rate matrix for output from a Discrete BayesTraits analysis of dependent/independent evolution of a pair of discrete characters. 
}
\arguments{
  \item{model}{output from a Discrete BayesTraits analysis.}
  \item{estimates}{logical indicating whether to label arrows with the rate estimates.}
  \item{main}{character string label for the plot.}
}
\value{
	A graphical depiction of the model transition rate matrix.
}
\author{
	Randi H. Griffin 
}
\examples{
# Load data
data(primates)
	
# Fit discrete models
nocorrD <- Discrete(primate.tree1, primate.discrete2)
corrD <- Discrete(primate.tree1, primate.discrete2, dependent = TRUE)
	
# Plot
layout(matrix(1:2, 1, 2))
plotdiscrete(nocorrD, main = "Independent")
plotdiscrete(corrD, main = "Dependent")
}



