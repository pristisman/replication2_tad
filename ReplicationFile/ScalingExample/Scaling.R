##This file replicates Figures 7
##Grimmer and Stewart ``Text as Data: The Promise and Pitfalls of Automatic Content Analysis Methods for Political Texts"


##the German scores are from Slapin and Proksch's (2008) article
load('WordFishGerman.RData')

##replicating their Figure.  
test<- example.A$documents


##alright, now plotting the points from the paper

plot(c(0,1)~c(0,1),pch='', xlab='Year', ylab='Policy Position', ylim=c(-2,2), xlim=c(1,5), frame.plot=F, axes=F)
part1<-test[1:5,1]
part2<- test[6:10,1]
part3<- test[11:15,1]
part4<- test[16:20,1]
part5<- test[21:25,1] 
lines(rev(part1), type='b', col=gray(0.1), lwd=3)
lines(rev(part2), type='b', col=gray(0), lwd=3)
lines(rev(part3), type='b', col=gray(0.5), lwd=3)
lines(rev(part4), type='b', col=gray(0.3), lwd=3)
lines(rev(part5), type='b', col=gray(0.6), lwd=3)
axis(2, c(-2, -1, 0, 1, 2))
axis(1, c(1, 2, 3, 4, 5), c('1990', '1994', '1998', '2002', '2005'))

text(2, 1.69, 'PDS')

text(2, 0.89, 'Greens')
text(2, 0.27, 'SPD' )
text(2, -0.67, 'CDU/CSU' )
text(2, -1.43, 'FDP')
title(main='Wordfish and German Platforms')




load('SenateTDM.RData')

##this fixes Kennedy and Coburn as the ends of the scale
##We use code from Slapin and Proksch, available on their excellent website. A local copy of Version 1.3 is included.  
source('WordFish.R')
out<- wordfish(tdm, tol=1e-05, fixtwo=T, fixdoc=c(24, 58, 2, -2))

##also, can just load our measures: precalculated here.
load('WordScoresSenate.RData')

##loading the first dimension identified in Grimmer 2012
load('FirstDim.RData')
##and finally, the party indicator
load('Party.RData')

col.stuff<- ifelse(party==1, gray(0), gray(0.5))


layout(matrix(c(1, 2), nrow=2, ncol=1), heights=c(2,1))
par(mar=c(5, 4, 4, 2))
plot(diff~I(-1*out$documents[,1]), pch=20, col=col.stuff, cex=2, xlab='Wordfish Scaling', ylab='Scaling, Grimmer (2012)', frame.plot=F)
lines(lowess(diff~I(-1*out$documents[,1]), iter=0), col='black', lwd=4)
legend(2.5, 0, pch=20, col=c(gray(0), gray(0.5)), legend=c('Dem', 'GOP'),cex=1.5)
title(main='Wordfish and Senate Press Releases')  
resc<- -1*out$documents[,1]
par(mar=c(5, 4, 0.5, 1))
plot(density(resc[which(party[1:100]==1)]), col='black', lwd=3, xlab='Wordfish Scaling', ylab='Density', main='', xlim=c(-2.5, 4))
lines(density(resc[which(party[1:100]==0)]), col=gray(0.5), lwd=3)
