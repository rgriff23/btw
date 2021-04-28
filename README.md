# btw - version 2 

___

## Introduction

`btw` is an R package for running the [BayesTraits](https://www.evolution.rdg.ac.uk/BayesTraits.html) phylogenetic comparative methods software from R. The functions in `btw` run BayesTraits on your system, import and parse the output in R, and delete the files from your system.

BayesTraits was developed by Mark Pagel and Andrew Meade, and is available from their <a target="_blank" href="http://www.evolution.rdg.ac.uk/BayesTraits.html">website</a> as a command line program. 

Version 2 of `btw` adds three major changes from version 1:

1. Windows compatibility (formerly `btw` only worked on MacOS)
2. Simplified structure for specifying BayesTraits commands
3. It works with BayesTraitsV3

## Set-up

Install from `devtools`:

```r
library("devtools")
install_github("rgriff23/btw")
library("btw")
```

Before using `btw`, navigate to the directory containing BayesTraitsV3 using the `setwd` command. Double-check that you are in the right directory by typing `list.files()` in your R console. If BayesTraitsV3 is one of the files that prints to your R console, you are in the right place! The output files produced by BayesTraits will reside in this directory. 

`btw` comes with an example phylogeny and several data sets which can be loaded into your R session:

```r
data(primates)
```

Type `ls()` to see the data files that were loaded. Some important formatting points: 

* Phylogenies must be of class `phylo` or `multiPhylo`
* The first column of your data file must contain species names
* Species names must match exactly between the tree and data (but order doesn't matter)
* You cannot have spaces in your species names
* Discrete characters should be represented with characters or factors *(not integers!)* between 0 and 9
* A discrete character/factor with more than 1 digit is interpreted as ambiguous (e.g., "01"), and indicates that the species is equally likely to be in state "0" or "1" (now you see why the discrete characters can't be of class 'integer', because 01 would just be seen as 1)
* If testing for correlated evolution in discrete characters, use 0 and 1 as the character states
* The only valid way to represent missing data is with a "-" character

Now let's run some analyses. 

## Fitting models

In this updated version of `btw`, you must list the desired BayesTraits commands in a character vector, in the correct order. The only exception is that you do not need to include the final "run" command. For example, to fit the Multistate model in maximum likelihood mode without any additional parameters, your vector of commands would simply be:

```r
# commands to run multistate model ("1") in Maximum Likelihood mode ("1")
command_vec1 <- c("1", "1")
```

To run the analysis using the data files `primate.discrete1` and `primate.tree1`, pass these files as the first and second argument to the `bayestraits` function, and then pass the command vector as the third argument.

```r
results_1 <- bayestraits(primate.discrete1, primate.tree1, command_vec1)
```

You can include any valid BayesTraits commands in the command vector, but avoid commands that specify names for the output files since the naming of output files is handled within the `bayestraits` function. If you specify file names for the BayesTraits output, it WILL screw things up because the `bayestraits` function won't be able to find those files to scan the results into R.

There are two additional logical arguments you can pass to `bayestraits`. First, the `silent` argument tells `bayestraits` whether to display output from BayesTraits in the R console - the default is `silent = TRUE`, which silences the output from BayesTraits. Second, the `remove_files` argument tells `bayestraits` whether to remove the output files from the working directory - the default is `remove_files = TRUE`, which results in all the files produced by `btw` and BayesTraits being deleted from disk after the results are scanned into R. 

Now let's look at the output.

## BayesTraits output

The result of running `bayestraits` is a named list, with each element containing the parsed output from a single BayesTraits output file. For the simple model we just ran, there is only one output file, the **Log file**. The parsed output from the log file can be pulled from the results list like this:

```r
log_file_1 <- results_1$Log
```

The information from the log file is stored as a named list with two elements: 1) a block of information about the options specified for the model, and 2) a table of results. In maximum likelihood mode, there is one row of results for each tree in the tree file. In MCMC mode, there is one row for each sample from the posterior distribution. These elements can be accessed as with any named list:

```r
model_options_1 <- log_file_1$options
model_results_1 <- log_file_1$results
```

If we run an MCMC analysis, we get an additional output file called the **Schedule file**, which is used for monitoring chain mixing. Like log files, the schedule file is stored as a named list in R and can be accessed by name.

```r
# commands to run multistate model ("1") in MCMC mode ("2")
command_vec_2 <- c("1", "2")

# run analysis
results_2 <- bayestraits(primate.discrete1, primate.tree1, command_vec_2)

# extract log and schedule file results
log_2 <- results_2$Log
schedule_2 <- results_2$Schedule
```

The number of items in the schedule list will depend on the model settings. 

There are several more types of output files produced by BayesTraitsV3. The **AncStates file** is unique to the geographic model implemented in BayesTraitsV3. We can fit a geographic model and access the AncStates output like this:

```r
# commands to run geographic model ("13") in maximum likelihood mode
command_vec_3 <- c("13")

# run analysis
results_3 <- bayestraits(primate.continuous2, primate.tree100, command_vec_3)

# extract log, schedule, and AncStates file results
log_3 <- results_3$Log
schedule_3 <- results_3$Schedule
ancestors_3 <- results_3$AncStates
```

The next analysis introduces the **Stones file**, which is produced when the stepping stone sampler is used. 

```r
# commands to run Multistate model ("1") in MCMC mode ("2") with stepping stone sampler
command_vec_4 <- c("1", "2", "Stones 100 1000")

# run analysis
results_4 <- bayestraits(primate.discrete1, primate.tree1, command_vec_4)

# extract log, schedule, and stones file results
log_4 <- results_4$Log
schedule_4 <- results_4$Schedule
stones_4 <- results_4$Stones
```

Finally, the **OutputTrees file** is produced when the `SaveTrees` command is used. This is just a nexus file.

```r
# commands to run continuous random walk trait model ("4") in MCMC mode ("2"), estimating lambda 
# and saving initial trees, transformed trees
command_vec_5 <- c("4", "2", "lambda", "SaveTrees")

# run analysis
results_5 <- bayestraits(primate.continuous1, primate.tree100, command_vec_5)

# extract log, schedule, and output trees
log_5 <- results_5$Log
schedule_5 <- results_5$Schedule
output_trees_5 <- results_5$OutputTrees
```

It is possible to tell BayesTraits to save the initial sample of trees using the `SaveInitialTrees` command, and this requires you to specify a file name for the saved trees. You can tell BayesTraits to do this in the command vector, but `btw` won't handle the saved initial trees in any way - they will simply be saved in your working directory, and if you wish to bring them into R, you can do it using `read.nexus`. 

## Parsing existing BayesTraits output

In case you have some BayesTraits output that you want to read into R without actually running `bayestraits`, the `parse` functions can be used for this purpose:

1. `parse_log` - parses a BayesTraits log file
2. `parse_schedule` - parses a BayesTraits schedule file
3. `parse_stones` - parses a BayesTraits stones file
4. `parse_ancstates` - parses a BayesTraits AncStates file

Each function takes a file path as input and produces output identical to the output produced by `bayestraits`, except there will be a single output file rather than all of the output files from an analysis. There is no special function for importing the tree files because you can use `read.nexus` from the `ape` package.

## Other `btw` functions

There are a few more functions included in `btw`. An important one is `killbt`, which simply kills all BayesTraits processes running on your system. If you accidentally start a long BayesTraits processes and realize that you made a mistake, you have to kill that process otherwise it will keep running in the background and can really bog down your system. You can execute this function by hitting ESC or Ctrl-z to escape the function within R and typing `killbt()` in the R console. Sometimes you can't escape the function without restarting your R session. That's fine, but keep in mind that the process can keep running after R shuts down, so the first thing you will want to do when you restart R is run `killbt()`.

Another couple of handy shortcuts are `lrtest` and `bftest`, which perform likelihood ratio and Bayes Factor tests respectively. Each function takes a pair of model results as arguments, e.g., `lrtest(model_results_1, model_results_2)`. It isn't difficult to extract the relevant quantities from the model results and perform the tests on your own, but these functions can save you some typing.

## Trouble shooting

Before messaging me, check that you are specifying all of the BayesTraits parameters correctly. Go to your command line program (e.g., Terminal on a Mac, Command Prompt in Windows) and make sure you can run BayesTraits using the commands exactly as you have specified them in your command vector.

If you are specifying the commands correctly and `bayestraits` is still not working properly, there may be a problem with the parsing functions. You can investigate this by running BayesTraits from the command line and trying to use the parsing functions to pull each output file into R. If one of these fails, then you know the problem is with that function.

## Footnotes

Note that `btw` does not support the variable rates model available in BayesTraitsV3. I don't think this is a great loss because I suspect that model produces vastly overparameterized models (see [Ho & Ané 2014](https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.12285) for a discussion of the issue). On a practical note, the output of this model is nightmarish and I had a hard time understanding it. Pagel & Meade have provided a [web tool](http://www.evolution.reading.ac.uk/VarRatesWebPP/) to process the output from their variable rates model. 

If you use `btw` and you notice any ways in which it can be improved, please let me know in a comment or e-mail. Feedback from users was a big part of why I produced this update - it let me know that my code is being used and gave me specific ideas for how to improve it! 



