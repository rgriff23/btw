# btw

___

A package for running BayesTraits from R (works on Mac OS only). The functions work by using `System` to run BayesTraits on your system and delete the output files after importing them into R.

BayesTraits was developed by Mark Pagel and Andrew Meade, and is available from their [website](http://www.evolution.rdg.ac.uk/BayesTraits.html) as an executable file that can be run from a command line program such as Terminal. Consult the BayesTraits documentation before using `btw`.

___

## Installing btw

If you have the `devtools` package installed, you can intall `btw` from GitHub:

```
library(devtools)
install_github("rgriff23/btw")
library(btw)
```

## Using btw

Before using any of the functions that call BayesTraitsV2, you have to download Version 2 of [BayesTraits](http://www.evolution.rdg.ac.uk/BayesTraits.html). You then have to tell `btw` where to find it on your computer by defining the hidden variable `.BayesTraitsPath`:

```
.BayesTraitsPath <- "YourPath/BayesTraits"
```

You will have to define `.BayesTraitsPath` every time you start a new R session. 

The package includes some examples of tree and data files that will work with `btw` functions. You can load them into your R session after you load `btw`:

```
data(primates)
```

Then you can experiment with the primate data and `btw` functions. For example, this code fits a Brownian motion model of evolution for a single continuous trait using maximum likelihood, and also finds the maximum likelihood estimate of the phylogenetic signal parameter, lambda:

```
Continuous(primate.tree1, primate.continuous1, lambda="ML")
```

Check [my website](http://rgriff23.github.io/projects/btw.html) for examples of fitting, comparing, and visualizing BayesTraits output.

___

