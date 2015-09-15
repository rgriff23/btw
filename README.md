# btw

___

A package for running BayesTraits from R. 

___

## Installing btw

If you have the `devtools` package installed, you can intall `btw` from GitHub:

```
library(devtools)
install_github("rgriff23/btw")
library(btw)
```

## Using btw

Before using any of the functions that call BayesTraits, you have to download [BayesTraits](http://www.evolution.rdg.ac.uk/BayesTraits.html) and tell `btw` where to find it on your computer. To do this, use the `locateBayesTraits` function:

```
locateBayesTraits("YourPath/BayesTraits")
```

This creates a hidden variable that `btw` will use to locate BayesTraits whenever you run a BayesTraits function.


