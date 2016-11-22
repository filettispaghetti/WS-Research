# R CMD BATCH gen_plots.R

# first row contains variable names, comma is separator
# assign the variable id to row names
# note the / instead of \ on mswindows systems

mydata <- read.table("data2.txt", header=TRUE, sep="")
names(mydata)
attach(mydata)

print("-------------------All Comparisons--------------------------")

for (y in c("P", "R", "F", "MAP", "MRR" )) {
# map only
#y <- "map"

print(paste("Analyzing:", y, sep=" "))
	
		name <- paste("figs/box_", y, ".pdf", sep="")
		pdf(name, height=6, width=4)
		par(las=2)
		par(mar=c(11, 4.5, 1, 1))
				
		
		
# get the means
		mediansx <- tapply(mydata[[y]],mydata$tech,median)
		meansx <- tapply(mydata[[y]],mydata$tech,mean)
		qx <- tapply(mydata[[y]],mydata$tech,quantile, prob=0.25)

# sort the levels of config factor		
#mydata$tech=factor(mydata$tech, levels=c("NL-Body", "NL-Sig", "STMT", "SWUM", "TF-IDF", "MRF", "DLM"))
		mydata$tech=factor(mydata$tech, levels=levels(mydata$tech)[order(-meansx)])

		print(levels(mydata$tech))
# get the means again in the new order (otherwise box plots won't have the right means)
		meansx <- tapply(mydata[[y]],mydata$tech,mean)
		print(meansx)

#	box plots	
		boxplot(mydata[[y]] ~ tech, data=mydata, range=1.5, boxwex=0.5,
	ylim=c(0,1), 
	ylab=y, col="lightgray")		
		points(meansx,col="red",pch=3,lw=2)
#		ct <- "MAP"
#		title(ct);
		
		
# generate summary numbers used in boxplots		
		print(tapply(X=mydata[[y]],INDEX=list(mydata$tech),FUN=summary))
		
		print("Testing")
		
		# f test --summary(fm1 <- aov(Rust ~ Brand))
		print(summary(fm1 <- aov(mydata[[y]] ~ tech, family=binomial, data=mydata)))
		fm1Tukey=TukeyHSD(fm1) # , order.contrasts=TRUE # , ordered=TRUE
		print(fm1Tukey)
		#print(?TukeyHSD)
		
		# names, attributes
		#print(attributes(fm1Tukey))
		#print(attributes(fm1Tukey$config))
		
		name <- paste("figs/tukey_", y, ".pdf", sep="")
		pdf(name, height=8, width=8)
		par(las=1)
		# (bottom, left, top, right)
		par(mar=c(5, 20, 3, 1))
		plot(fm1Tukey)
		title(y);

}


