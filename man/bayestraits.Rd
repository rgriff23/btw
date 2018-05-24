\name{bayestraits}
\alias{bayestraits}
\title{Run BayesTraitsV3 from R}
\usage{
bayestraits(data = NULL, tree = NULL, commands = NULL, silent = TRUE, remove_files = TRUE)
}
\description{
	Function to run BayesTraitsV3 from R and return parsed output.
}
\arguments{
  \item{data}{an object of class data.frame. The first column contains species names and subsequent columns contain trait values. Species names must match those in the phylogeny.}
  \item{tree}{an object of class phylo or multiPhylo}
  \item{commands}{character vector containing BayesTraitsV3 commands.}
  \item{silent}{logical indicating whether to prevent BayesTraitsV3 output from printing to the R console. Defaults to TRUE} 
  \item{remove_files}{logical indicating whether to delete model output from disk after scanning it into R. Defaults to TRUE}
}
\details{Before running this function, use \code{setwd} to navigate to the same directory as BayesTraitsV3. To confirm that you are in the correct directory, type \code{list.files()} and check that BayesTraitsV3 is one of the files that prints in your R console. 

  Commands in the \code{commands} argument should be written exactly as they would be entered when running BayesTraitsV3 on the command line, and in the same order that they would be entered. Each command and its parameters should be represented by a single character string. Check the BayesTraitsV3 documentation to ensure that commands are being entered correctly: http://www.evolution.rdg.ac.uk/BayesTraitsV3.0.1/Files/BayesTraitsV3.Manual.pdf 
	
	The function works by writing data, tree, and input files to your current working directory, running BayesTraitsV3 on your system, scanning the output into R, parsing the output, and if \code{remove_files = TRUE} deleting all files producted by \code{btw} and BayesTraitsV3 from your system. 
	
	All of the files produced by \code{bayestraits} and BayesTraitsV3 on your system will overwrite existing files of the same name. Be aware of this before running \code{bayestraits}: if your working directory contains files named \code{data.txt}, \code{tree.nex}, \code{inputfile.txt}, or \code{data.txt.*} where \code{*} is the extension corresponding to BayesTraitsV3 output, those files may be overwritten and/or deleted when you run \code{bayestraits}.
}
\value{
	Parsed output from BayesTraitsV3 is returned in a list with 5 elements corresponding to 5 types of BayesTraitsV3 output files: 1) Log files, 2) Schedule files, 3) Stones files, 4) AncStates files, and 5) OutputTrees files. Check the BayesTraitsV3 documentation for descriptions of these output files. File types that were not produced by a given analysis are NULL. 
}
\author{
	Randi H. Griffin 
}