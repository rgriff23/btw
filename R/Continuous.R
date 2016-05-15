Continuous = function (tree, data, mode = "ML", regression = FALSE, directional = FALSE, vr = FALSE, lambda = 1, kappa = 1, delta = 1, ou = 0, tc = FALSE, mrca = NULL, mlt = 10, it = 100000, bi = 5000, sa = 100, lf = NULL, silent=TRUE) {

# CHECK FOR PROBLEMS IN THE DATA 
tree$node.label = NULL
if (class(tree) == "phylo") {treelabs = tree$tip.label} else if (class(tree) == "multiPhylo") {treelabs = attributes(tree)$TipLabel} else {
	stop("Tree must be of class phylo or multiPhylo")
}
if (!(class(data[,1]) %in% c("character", "factor"))) {stop("First column of data should contain species names.")}
if (length(setdiff(treelabs, data[,1]))>0) {stop(paste("No match found in the data:", paste(setdiff(tree$tip.label, data[,1]), collapse=", ")))}
if (length(setdiff(data[,1], treelabs))>0) {stop(paste("No match found in the phylogeny:", paste(setdiff(data[,1], tree$tip.label), collapse=", ")))}
if(length(setdiff(treelabs, data[,1]))>0 | length(setdiff(data[,1], treelabs))>0) {stop("Species in your phylogeny and data must match up exactly.")}
if (ncol(data) != 3 & tc == TRUE) {stop("tc can only be used for a pair of continuous traits.")}
if (!exists(".BayesTraitsPath") | !file.exists(.BayesTraitsPath)) {stop("Must define '.BayesTraitsPath' to be the path to BayesTraitsV2 on your computer. For example: .BayesTraitsPath <- User/Desktop/BayesTraitsV2")}

# WRITE INPUT FILE 
if (mode == "Bayesian") {mode = 2} else {mode = 1}
if (directional == F) {model = 4} else {model = 5}
if (regression == T) {model = 6}
if (lambda == "ML") {L = ""} else {L = lambda}
if (kappa == "ML") {K = ""} else {K = kappa}
if (delta == "ML") {D = ""} else {D = delta}
if (ou == "ML") {O = ""} else {O = ou}
if (vr == TRUE) {model = 7; mode = 2}
input = c(model, mode)
input = c(input, paste("lambda", L))
input = c(input, paste("kappa", K))
input = c(input, paste("delta", D))
input = c(input, paste("ou", O))	
if (vr == TRUE) {input = c(input, "VarRates")}
if (!is.null(mrca) & vr != TRUE) {for (i in 1:length(mrca)) {input = c(input, paste("mrca", paste("mrcaNode", i, sep=""), mrca[i]))}}
if (ncol(data) == 3 & tc == TRUE) {input = c(input, "tc")}
if (mode == 1) {input = c(input, paste("mlt", as.numeric(mlt)))}
if (mode == 2) {
	input = c(input, paste("it", format(it, scientific=F)))
	input = c(input, paste("bi", format(bi, scientific=F)))
	input = c(input, paste("sa", format(sa, scientific=F)))
}
if (is.null(lf)) {input = c(input, paste("lf ./BTout.log.txt"))} else {input = c(input, paste("lf", lf))}
input = c(input, "run")	
write(input, file="./inputfile.txt") 
ape::write.nexus(tree, file="./tree.nex", translate=T)	
write.table(data, file="./data.txt", quote=F, col.names=F, row.names=F)

# RUN ANALYSIS
system(paste(.BayesTraitsPath, "./tree.nex", "./data.txt", "< ./inputfile.txt"), ignore.stdout = silent)

# GET OUTPUT 
if (is.null(lf)) {lf = "./BTout.log.txt"}
FullOut = scan(file = lf, what="c", quiet=T, sep="\n")
Results = read.table(lf, skip = (grep("Tree No", FullOut) - 1), sep = "\t", header = TRUE)
Results = Results[,-ncol(Results)]	
if (vr == TRUE) {
	skip = grep("=", scan(file = "./data.txt.PP.trees", what="c", quiet=T, sep="\n"))[1] - 1
	Trees = read.tree(file="~/Desktop/GitHub/Evaluating_mvBM/R/data.txt.PP.trees", skip=skip, keep.multi=TRUE)
	Results = list(Results, Trees)
}

# DELETE FILES FROM DISK
system(paste("rm", lf))
system(paste("rm ./inputfile.txt"))
system(paste("rm", "./tree.nex"))
system(paste("rm", "./data.txt"))
try(system(paste("rm", "./data.txt.PP.trees")))
try(system(paste("rm", "./data.txt.PP.txt")))

# RETURN RESULTS
return(Results)

}
