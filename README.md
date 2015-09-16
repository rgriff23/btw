# btw

___

A package for running BayesTraitsV2 from R. 

___

## Installing btw

If you have the `devtools` package installed, you can intall `btw` from GitHub:

```
library(devtools)
install_github("rgriff23/btw")
library(btw)
```

## Using btw

Before using any of the functions that call BayesTraitsV2, you have to download Version 2 of [BayesTraits](http://www.evolution.rdg.ac.uk/BayesTraits.html) and tell `btw` where to find it on your computer by defining the hidden variable `.BayesTraitsPath`:

```
.BayesTraitsPath <- "YourPath/BayesTraits"
```

You will have to define `.BayesTraitsPath` every time you start a new R session. 

Your tree should be a nexus file and your data should be in a dataframe, where the first column has species names (must match the tree) and subsequent columns contain the data. There should be no missing values in your data (although eventually I'll fix the code to handle NAs).


