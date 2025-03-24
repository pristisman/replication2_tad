##This file replicates Figures 3, 4, 5, and 6 for 
##Grimmer and Stewart ``Text as Data: The Promise and Pitfalls of Automatic Content Analysis Methods for Political Texts"


#############
##Replication of Figure 3
#############

##loading the data for Figure 3.  

load('ExpData.RData')


data.set.laut<- list.data[[1]]
data.set.dir<- list.data[[2]]
data.set.roc<- list.data[[3]]


##calculating the means quickly
output.laut<- lm(data.set.laut[,1]~data.set.laut[,2])
output.roc<- lm(data.set.roc[,1]~data.set.roc[,2])
output.dir<- lm(data.set.dir[,1]~data.set.dir[,2])


mean.diff.laut<- output.laut$coef[2]
mean.diff.roc<- output.roc$coef[2]
mean.diff.dir<- output.dir$coef[2]

se.laut<- sqrt(diag(vcov(output.laut)))[2]
se.roc<- sqrt(diag(vcov(output.roc)))[2]
se.dir<- sqrt(diag(vcov(output.dir)))[2]

##and the confidence intervals (parametrically)
eighty.perc<- 1.28
ninety5.perc<- 1.96

##now creating Figure 3
plot(c(0.75,3.25)~c(0.75,3), pch='', xlim=c(-0.2, 0.2),xlab='', ylab='', main='', frame.plot=F, axes=F)
title(xlab='Cluster Quality(Expressed Agenda) - Cluster Quality(Other Methods)', col='black')

abline(v=0, lty=2, col='black')
axis(1, seq(-0.2, 0.2, by=0.1),  seq(-0.2, 0.2, by=0.1), col='black')
draw.arrow<- function(se, mean,sd, num, weight){
	arrows(sd*se + mean, num, mean - sd*se, num, len=0, lwd=weight, col='black')
	}
points(mean.diff.roc, 3, pch=20, col='black', cex = 2)
draw.arrow(se.roc, mean.diff.laut, eighty.perc, 3, 6)
draw.arrow(se.roc, mean.diff.laut, ninety5.perc, 3, 1)
text(mean.diff.roc + 0.025, 3.125, 'Rockefeller Press Releases', col='black')
points(mean.diff.laut, 2, pch=20, col='black', cex = 2)
draw.arrow(se.laut, mean.diff.roc, eighty.perc, 2, 6)
draw.arrow(se.laut, mean.diff.roc, ninety5.perc, 2, 1)
text(mean.diff.laut + 0.025, 2.125, 'Lautenberg Press Releases', col='black')
points(mean.diff.dir, 1, pch=20, col='black', cex = 2)
draw.arrow(se.dir, mean.diff.dir, eighty.perc, 1, 6)
draw.arrow(se.dir, mean.diff.dir, ninety5.perc, 1, 1)
text(mean.diff.dir, 1.125, 'Dirichlet Process', col='black')


############
##Remaining Figures rely on measures from Grimmer 2012, see corresponding replication file 
##for those measures
############


#############
##Replication of Figure 4
#############
load('IraqCounts.RData')
plot(list.iraq[[2]]~as.Date(list.iraq[[1]], origin="1960-01-01"),xlab='Date', ylab='Count' , main="Iraq War", type='h',frame.plot=F)
text(as.Date(list.iraq[[1]], origin="1960-01-01")[508], 55+2, 'al-Zarqawi\'s Death')
text(as.Date(list.iraq[[1]], origin="1960-01-01")[680], 69 + 1, 'Iraq Study Group')
text(as.Date(list.iraq[[1]], origin="1960-01-01")[714] +90, 67, 'Surge Announcement')

load('HonCounts.RData')
plot(list.hon[[2]]~as.Date(list.hon[[1]], origin="1960-01-01"),xlab='Date', ylab='Count' , main="Honorary", type='h',frame.plot=F)
text(as.Date(list.iraq[[1]], origin="1960-01-01")[91], list.hon[[2]][91]+2, 'Death of \n Pope John Paul II')
text(as.Date(list.iraq[[1]], origin="1960-01-01")[288], list.hon[[2]][288] + 2, 'Death of \n Rosa Parks')
text(as.Date(list.iraq[[1]], origin="1960-01-01")[382], list.hon[[2]][382] , 'Death of Coretta Scott King')
text(as.Date(list.iraq[[1]], origin="1960-01-01")[701], list.hon[[2]][701] + 1, 'Death of Gerald Ford')
text(as.Date(list.iraq[[1]], origin="1960-01-01")[597], list.hon[[2]][597] + 1, '9/11/06')
text(as.Date(list.iraq[[1]], origin="1960-01-01")[954], list.hon[[2]][954] + 1, '9/11/07')
text(as.Date(list.iraq[[1]], origin="1960-01-01")[857], list.hon[[2]][857] + 2, 'Death of \n Craig Thomas (R-WY)')


####Replicating Figure 5
####list.results calculates the per-committee differences in topic attention 
####as described in the text.

load('CommResults.RData')


##now calculating the mean, 80 and 95 percent confidence intervals,
##using the 

means<- c()
for(j in 1:120){
	means[j]<- mean(list.results[[j]]$diffs)
	}

seqs<- seq(1, 120, by=3)
seqs2<- seq(3, 120, by=3)

mean.3<- c()
for(j in 1:40){
	mean.3[j]<- mean(means[seqs[j]:seqs2[j]])
		}
ordered<- order(mean.3, decreasing=F)

quant.mat<- matrix(NA, nrow=120, ncol=4)
for(j in 1:120){
	quant.mat[j,]<- quantile(list.results[[j]]$diffs, c(0.025, 0.1, 0.9, 0.975))
	}


par(las=1)
par(mar=c(5,5,2,7))
plot(c(1:120)~means, pch='', xlim=c(-0.05, 0.28), axes=F, main='', xlab='(Mean Attention Leaders) - (Mean Attention Other Senators)', ylab='')
a<- 0
for(j in 1:120){
	arrows(-0.055,j, 0.28, j, col=gray(0.7), lty=2, len=0)
	}
abline(v=0, lty=2, col='black')
par(col.axis='black')
axis(1, seq(-0.05, 0.25,  by=0.05), seq(-0.05, 0.25,  by=0.05), col='black')
#axis(3, seq(-0.05, 0.25, by = 0.05), rep('', 7))
par(las=2)
for(j in 1:40){
	##aa<-ordered[j]
	aa<- j
	temp<- means[seqs[aa]:seqs2[aa]]
	temp2<- quant.mat[seqs[aa]:seqs2[aa],]
	
	if(j%%2==0){
		col=gray(0.5)
		par(col.axis=gray(0.5))}
	if(j%%2==1){
		col=gray(0)
		par(col.axis=gray(0))}
	axis(2, c(seqs[j]+ seqs2[j])/2, list.results[[seqs[aa]]]$topic, tick=F)
	#axis(2, c(seqs[j], seqs2[j]), c('',''), tick=T)
	axis(4, c(seqs[j]+ seqs2[j])/2, list.results[[seqs[aa]]]$comm, tick=F)
	#axis(4, c(seqs[j], seqs2[j]), c('',''), tick=T)
	for(m in 1:3){
	a<- a + 1
	points(temp[m], a, pch=20, col=col)
	arrows(temp2[m,2], a, temp2[m,3], a, lwd=2, len=0, col=col)
	arrows(temp2[m,1], a, temp2[m,4], a, lwd=1, len=0, col=col)
	}
	}


#############
##Replicating Figure 6.  

load('SupervisedAppropCredit.RData')
colnames(approp.est)<- c('grants','part','negative','substance.symb','nat.approp')

total.approp<- approp.est[,1] + approp.est[,2]

##loading the credit claiming estimates and number of press releases from 
##Grimmer 2012.  

load('CreditClaiming.RData') ##object is exp.apps

##and the number of press releases from each senator
load('NumPress.RData')

##now calculating the number of supervised and unsupervised
num.super<- total.approp*num.press
num.unsuper<- exp.apps*num.press


par(cex.lab=1.5)
par(cex.axis=1.5)
par(cex.main=1.5)

plot(num.super~num.unsuper, xlab='Number Credit Claiming, Unsupervised', frame.plot=F,ylab='Number Credit Claiming, Supervised', col=gray(0.6), cex=2, pch=20)
arrows(0,0,1e7,1e7, col=gray(0), lwd=3)



