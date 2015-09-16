\name{Discrete}
\alias{Discrete}
\title{Run BayesTraits Multistate or Discrete}
\usage{
Discrete(tree, data, mode = "ML", dependent = FALSE, res = NULL, resall = NULL, mrca = NULL, fo = NULL, 
mlt = 10, it = 100000, bi = 5000, sa = 100, pr = NULL, pa = NULL, hp = NULL, hpall = NULL, rj = NULL, 
rjhp = NULL, silent=TRUE)
}
\description{
	Runs BayesTraits Multistate (for one discrete trait with two or more levels) and Discrete (for two discrete traits, each with two levels).
}
\arguments{
  \item{tree}{an object of class phylo or multiPhylo}
  \item{data}{an object of class data.frame. The first column contains species names and subsequent columns contain discrete trait values. Species names must match those in the phylogeny.}
  \item{mode}{takes one of two values, "ML" to run models in maximum likelihood mode or "Bayesian" to run models in Bayesian MCMC mode. Defaults to "ML".}
  \item{dependent}{logical indicating whether to fit a dependent (correlated) model of evolution for a pair of binary characters.}
  \item{res}{character vector indicating restrictions to place on rates. Each element of the vector is a character string indicating a separate restriction. For example, if res = c("q01 q10 1.2", "q12 q21"), then rates q01 and q10 are restricted to the value 1.2, and rates q12 and q21 are restricted to be equal to each other.}
  \item{resall}{character string or numeric value indicating a rate or value to restrict all rates to. For example, if resall = "q01", then all rates are restricted to be equal to the rate q01, and if resall = 1.2, then all rates are restricted to be 1.2.}
  \item{mrca}{character vector indicating nodes to reconstruct using the most recent common ancestor approach. Each element of the vector is a character string naming a pair of species whose most recent common ancestor will be reconstructed. For example, mrca = c("Lemur_catta Homo_sapiens") will reconstruct the last common ancestor of Lemur_catta and Homo_sapiens.}
  \item{fo}{character vector indicating nodes to "fossilize" at particular states. Each element of the vector is a character string beginning with the state to fossilize, followed by the names of two species whose most recent common ancestor is to be fossilized. For example, fo = c("1 Lemur_catta Homo_sapiens", "2 Pan_troglodytes Homo_sapiens") fossilizes the ancestor of Lemur_catta and Homo_sapiens at 1, and the ancestor of Pan_troglodytes and Homo_sapiens at 2.}
  \item{mlt}{integer specifying the number of runs of the optimization algorithm in ML mode. Ignored if Bayesian mode is selected. Defaults to 10.}
  \item{it}{integer specifying the number of MCMC iterations in Bayesian mode. Default is 100000.}
  \item{bi}{integer specifying the number of iterations to discard as burn-in in Bayesian mode. Default is 5000.}
  \item{sa}{integer specifying the number of iterations to skip between samples in Bayesian mode. Default is 100.}
  \item{pr}{character vector describing prior distributions for model parameters. Each element of the vector is a character string specifying the distribution for a separate parameter by listing the parameter, the name of the distribution (exp, gamma, uniform, beta), and finally the parameters that define the distribution. For example, pr = c("q01 exp 10", "q10 gamma 10 10") sets an exponential prior with mean 10 for the rate q01 and a gamma prior with mean and shape 10 for rate q10. By default, all parameters have a uniform prior from -100 to 100.}
  \item{pa}{character string specifying the prior distribution for all parameters. For example, pa = "exp 10" sets an exponential prior with mean 10 for all rates in the model.}
  \item{hp}{character vector indicating prior distributions and hyper-priors for model parameters. Each element is a character string specifying the prior and bounds of the uniform hyper-prior for a separate parameter. For example, hp = "q01 exp 0 10" implements an exponential prior with the mean seeded by a uniform hyper-prior from 0 to 10 for the rate q01. If the specified prior distribution has two parameters, then the minimum and maximum for the hyper-prior must be given for each parameter, e.g., hp = "q01 gamma 0 10 0 10" implements a gamma prior with the mean and shape seeded by a uniform hyper-prior from 0 to 10.}
  \item{hpall}{character vector indicating a prior distribution and hyper-prior to use for all model parameters. For example, hp = "exp 0 10" implements an exponential prior with the mean seeded by a uniform hyper-prior from 0 to 10 for all rates.}
  \item{rj}{character string specifying the prior distribution for a reversible jump model. For example, rj = "exp 10" implements a reversible jump model with an exponential prior of mean 10.}
  \item{rjhp}{character string specifying the prior distribution for a reversible jump model, along with minimum and maximum values for a uniform hyper-prior. For example, rjhp = "exp 0 10" implements a reversible jump model with an exponential prior with the mean seeded by a uniform hyper-prior from 0 to 10.}
  \item{silent}{logical indicating whether to print BayesTraits output. Defaults to FALSE} 
}
\details{
	Runs BayesTraits Multistate (for one discrete trait with two or more levels) and Discrete (for two discrete traits, each with two levels). See BayesTraits documentation for more information: http://www.evolution.rdg.ac.uk/BayesTraits.html
	
	This function works by using `System` to write input files, run BayesTraits on your system, import the output into R, and finally delete both the input and output files from your system. When everything runs smoothly, there should be no extraneous files left on your system. However, if an error occurs, it is possible that some files will not be deleted. They will be overwritten the next time you run this function. 
	
	WARNING: The default settings for the number of iterations and burn-in period for Bayesian analysis is wayyyyy too low for a real analysis. 
}
\value{
	Results from BayesTraits output in a dataframe. 
}
\author{
	Randi H. Griffin 
}
\references{
	Pagel, M. (1994). "Detecting correlated evolution on phylogenies: a general method for the comparative analysis of discrete characters." Proceedings of the Royal Society of London. Series B: Biological Sciences 255(1342): 37-45.
	
	Pagel, M., et al. (2004). "Bayesian estimation of ancestral character states on phylogenies." Systematic biology 53(5): 673-684. 
	
	Pagel, M. and A. Meade (2006). "Bayesian analysis of correlated evolution of discrete characters by reversible-jump Markov chain Monte Carlo." The American Naturalist 167(6): 808-825.  
}


