##############################################
###### REPLICATION CODE FOR TEXT AS DATA ######
##############################################
# Author: Chuchu Wen and Priscila Stisman

rm(list=ls()) 

####### Setup
install.packages("readr")
install.packages("ggplot2")
install.packages("ggplotify")
install.packages("ggplotify")
install.packages("stringr")
install.packages("splitstackshape")
install.packages("cowplot")
install.packages("dplyr")
install.packages('Jmisc')
install.packages('psych')
install.packages('qwraps2')
install.packages("multiwayvcov")
install.packages("tm")
install.packages("RTextTools")
install.packages("qdap")
install.packages("qdapDictionaries")
install.packages("SnowballC")
install.packages("stm")

library(readr);library(ggplot2);library(stringr);library(dplyr);
library(splitstackshape);library(data.table);library(dplyr);library(cowplot);library(Jmisc);library(psych);library(qwraps2);library(xtable);library(sandwich);library(stargazer);library(lmtest);library(ggpubr);library(multiwayvcov)
library(wordcloud);library(stm);library(readxl)
library(ggplotify);library(ggraph);library(tidygraph); library(here)

require(tm) 
require(RTextTools) 
require(qdap) 
require(qdapDictionaries)
require(SnowballC) 
library(tidyverse)

#setwd("/Users/chuchuwan/Desktop/georgetown/2025Spring/PPOL-6801-Data as Text/rep2") #Chuchu'S working directory
#setwd(here("Code")) #Priscila's working directory
options(scipen=999)
options(max.print=1000000)

## Load Data
data <- read_csv("data_file2.csv") #load data with anonymized processed "text" 
data$my_station <- as.factor(data$my_station)
data <- data.frame(data)
data.frame(colnames(data))

# Subset corpus based on the complainant gender: male vs. female
male_complaint <- data[ with(data, grepl("other", data$complainant_gender)),]
fem_complaint <- data[ with(data, grepl("female", data$complainant_gender)),]

# Subset corpus based on if the report/crime is classified as gendered or non-gendered
nongendered <- data[ with(data, grepl(0, data$gendered)),] # non-gendered == 0
gendered <- data[ with(data, grepl(1, data$gendered)),] #gendered == 1


###########
library(Rtsne)
library(rsvd)
library(geometry)

###### For the first STM model we work with the whole corpus

set.seed(23456)
processed <- textProcessor(documents = data$text, metadata = data)

out <- prepDocuments(documents = processed$documents, 
                     vocab = processed$vocab,
                     meta = processed$meta, lower.thresh = 50)
docs <- out$documents
vocab <- out$vocab
meta <- out$meta

## Running Model (1)
test2 <- stm(documents = out$documents, vocab = out$vocab,
             K = 32,
             prevalence =~ complainant_gender + gendered + urban + convicted + acquitted + dismissed, # Multiple covariates
             max.em.its = 75,
             data = out$meta, init.type = "Spectral",
             verbose = TRUE)

#Create topic vector
topicnames <- c("(1) UNLICENSED:", "(2) CURRENCY:", "(3) DOWRY-A:", "(4) PHISHING:", "(5) CATTLE:", "(6) RESOURCE MAFIA:","(7) MISSING PERSON:", "(8) DOWRY-B:","(9) RAILWAY:","(10) ACCIDENT/ATTACK:","(11) LEWD BEHAVIOR:","(12) DEVELOPMENT:","(13) INJURY:","(14) DRIVING MISDEMEANOR:", "(15) FUGITIVE:","(16) BURGLARY:","(17) FIGHTING:","(18) ARMS:","(19) ALCOHOL:","(20) PROPERTY:", "(21) DRIVING ACCIDENT:","(22) AUTO THEFT-A:","(23) AUTO THEFT-B:","(24) CHEAT:","(25) MINORITIES:","(26) PHONE THEFT:","(27) KIDNAPPING:","(28) GAMBLING:","(29) CHAIN-SNATCH:","(30) ELECTRICTY THEFT:","(31) DRUGS:","(32) REAL ESTATE:")


#**FIGURE1**
plot(test2, n=6, type = "summary", xlim = c(0, 0.35), main = "All Crime Top Topics", topic.names = topicnames)
#**FIGURE2**
plot(test2, n=6, type = "summary", xlim = c(0, 0.35), main = "All Crime Top FREX", labeltype = "frex",topic.names = topicnames)

#**FIGURE3**
prep1 <- estimateEffect(1:32 ~ complainant_gender, test2, meta = out$meta, uncertainty = "Global")
pdf("3-complaint_plot.pdf", width=10, height=6)
plot(prep1, "complainant_gender", model=test2, method="difference",
     cov.value1="female", cov.value2="other",
     xlab = "Male ... Female",
     main = "Male/Female Complainants",
     ci.level = 0.95,
     verbose.labels = FALSE,
     custom.labels = topicnames,
     labeltype = "custom")
dev.off()

#**FIGURE4**
prep2 <- estimateEffect(1:32 ~ gendered, test2, meta = out$meta, uncertainty = "Global")
pdf("4-gendered_effect_plot.pdf", width=10, height=6)
plot(prep2, "gendered", model=test2, method="difference",
     cov.value1 = "1", cov.value2 = "0",
     xlab = "More Nongendered ... More Gendered",
     main = "Nongendered/Gendered Crime",
     ci.level = 0.95,
     verbose.labels = FALSE,
     custom.labels = topicnames,
     labeltype = "custom")

dev.off()


###### For the second STM model we work with the corpus subset for only female complainants

set.seed(23456)
processed <- textProcessor(documents = fem_complaint$text, metadata = fem_complaint)

out <- prepDocuments(documents = processed$documents, 
                     vocab = processed$vocab,
                     meta = processed$meta, lower.thresh = 50)
docs <- out$documents
vocab <- out$vocab
meta <- out$meta

## Running Model (2)
female_data <- stm(documents = out$documents, vocab = out$vocab,
                   K = 24, prevalence =~ gendered + urban + convicted + acquitted + dismissed,
                   max.em.its = 75,
                   data = out$meta, init.type = "Spectral")

#Create topic vector
topicnames <- c("(1) VILLAGE PROBLEM:", "(2) POISONING:", "(3) CHEAT:", "(4) UNLICENSED:", "(5) DOWRY-A:", "(6) DOWRY-B:", "(7) REAL ESTATE:", "(8) DEVELOPMENT:", "(9) DOWRY-C:", "(10) CHILD ABUSE/RAPE:", "(11) BURGLARY:", "(12) DOMESTIC VIOLENCE:", "(13) DOWRY-D:", "(14) FIGHTING:", "(15) CHAIN-SNATCH:", "(16) CRIMINAL FORCE:", "(17) RAPE:", "(18) RUNAWAY/SUICIDE:", "(19) MISSING PERSON:", "(20) MISCELLANEOUS:", "(21) PHISHING:", "(22) DRIVING ACCIDENT:", "(23) DOWRY-E:", "(24) ALCOHOL:")

#**FIGURE5**
plot(female_data, n=6, type = "summary", xlim = c(0, 0.35), main = "Female Complainant Top Topics", topic.names = topicnames) 
#**FIGURE6**
plot(female_data, n=6, type = "summary", xlim = c(0, 0.35), main = "Female Complainant Top FREX", labeltype = "frex",topic.names = topicnames)#What xaxs does is reduce whitespace


###### For the third STM model we work with the gendered crime corpus

set.seed(23456)
processed <- textProcessor(documents = gendered$text, metadata = gendered)

out <- prepDocuments(documents = processed$documents, 
                     vocab = processed$vocab,
                     meta = processed$meta, lower.thresh = 50)
docs <- out$documents
vocab <- out$vocab
meta <- out$meta

## Running Model (3)
gendered_data <- stm(documents = out$documents, vocab = out$vocab,
                     K = 20,
                     prevalence =~ urban + convicted + acquitted + dismissed, #covariates
                     max.em.its = 75,
                     data = out$meta, init.type = "Spectral")


#Create topic vector
topicnames <- c("(1) DOWRY-MENTAL:", "(2) DOWRY-PHYSICAL:", "(3) DOWRY-PREGNANCY:", "(4) DOWRY-ECONOMIC:", "(5) UNLICENSED (SEX SELECTION):", "(6) DOWRY-RAPE:", "(7) KILLING GIRL CHILD:", "(8) DOWRY DEATH:", "(9) ALCOHOL:", "(10) HURT/DOMESTIC VIOLENCE:", "(11) KIDNAPPING:", "(12) TRAFFICKING:", "(13) BLACKMAIL:", "(14) SEX SELECTION/ABORTION:", "(15) DOWRY-EXTENDED:", "(16) DOWRY-POST COUNSELING:", "(17) RAPE:", "(18) LEWD PHOTOS:", "(19) DOWRY-DESERTION:", "(20) DOWRY-STARVATION:")

#**FIGURE7**
plot(gendered_data, n=6, type = "summary", xlim = c(0, 0.45), main = "VAW Top Topics", topic.names = topicnames) 
#**FIGURE8**
plot(gendered_data, n=6, type = "summary", xlim = c(0, 0.45), main = "VAW Top FREX", labeltype = "frex",topic.names = topicnames)



####### STM - COVARIATES ####### 

data$female_complainant <- ifelse(grepl("female", data$complainant_gender), 1, 0) #Creating a Gender Covariate

##
set.seed(23456) #Set paper's seed for reproducibility

processed <- textProcessor(documents = data$text, metadata = data) # Process text documents using the textProcessor() function


out <- prepDocuments(documents = processed$documents, 
                     vocab = processed$vocab,
                     meta = processed$meta, lower.thresh = 500) # Remove words that appear fewer than 500 times (lower.thresh = 500)

docs <- out$documents
vocab <- out$vocab
meta <- out$meta

##Thanks to Brandon Stewart

##########

K <- 32 #as defined in the paper 

stm.out.c <- stm(
  out$documents,     # The processed documents
  out$vocab,         # The vocabulary of the documents
  K=K,               # Number of topics (32 in this case)
  prevalence=~female_complainant,   # Covariate affecting topic prevalence
  content=~female_complainant,      # Covariate affecting topic content 
  data=out$meta,     # Metadata associated with the documents
  max.em.its=25,     # Maximum number of EM (Expectation-Maximization) iterations
  seed=1033311       # Random seed for reproducibility
)

labelTopics(stm.out.c)

#**FIGURE9**
plot(stm.out.c, n=6, type = "summary", xlim = c(0, 0.35), main = "All Crime Content Covariate")


## 
## 

library(devtools)
library(stm)
library(stringr)
library(textir)
library(cem)
library(kernlab)
library(rbounds)
library(xtable)
library(MASS)
library(weights)
library(Zelig)
library(stargazer)



#######
#For non-gender related crimes Covariate 
data <- data[with(data, grepl(0, data$gendered)),]
data$female_complainant <- ifelse(grepl("female", data$complainant_gender), 1, 0) #female ==1 male == 0

##
set.seed(23456)
processed <- textProcessor(documents = data$text, metadata = data)

out <- prepDocuments(documents = processed$documents, 
                     vocab = processed$vocab,
                     meta = processed$meta, lower.thresh = 500) # Remove words that appear fewer than 500 times (lower.thresh = 500)

docs <- out$documents
vocab <- out$vocab
meta <- out$meta

##########
K <- 32 

stm.out.c <- stm(
  out$documents,     # The processed documents
  out$vocab,         # The vocabulary of the documents
  K=K,               # Number of topics (32 in this case)
  prevalence=~female_complainant,   # Covariate affecting topic prevalence 
  # Allows the presence of a female complainant to affect how frequently different topics appear
  content=~female_complainant,      # Covariate affecting topic content
  #Allows the gender of the complainant to influence the words used in each topic
  data=out$meta,     # Metadata associated with the documents
  max.em.its=25,     # Maximum number of EM (Expectation-Maximization) iterations
  seed=1033311       # Random seed for reproducibility
)


labelTopics(stm.out.c)

#**FIGURE10**
plot(stm.out.c, n=6, type = "summary", xlim = c(0, 0.35), main = "Non-Gender Crime Content Covariate")

################################################ 
############ EXTENSIONS ########################
################################################ 

#Extension (1)
##Examining in non-gender related crimes what words are used by men and women, if different or not and how so

plot(stm.out.c, type = "perspectives", topics =24, main="Word Used for abdution realted crime, by gender of the complaints") #topic 6
plot(stm.out.c, type = "perspectives", topics =6, main="Word Used for theft realted crime, by gender of the complaints") #topic 24
plot(stm.out.c, type = "perspectives", topics =30, main="Word Used for alcohol realted crime, by gender of the complaints") #topic 34

##Examining in gender related crimes what words are used by men and women, if different or not and how so
data <- data[with(data, grepl(1, data$gendered)),]
data$female_complainant <- ifelse(grepl("female", data$complainant_gender), 1, 0)

##
set.seed(23456)
processed <- textProcessor(documents = data$text, metadata = data)

out <- prepDocuments(documents = processed$documents, 
                     vocab = processed$vocab,
                     meta = processed$meta, lower.thresh = 1)
docs <- out$documents
vocab <- out$vocab
meta <- out$meta

##########
K <- 32 #number of topics as defined in the paper

stm.out.c <- stm(out$documents, out$vocab, K=K,
                 prevalence=~female_complainant,
                 content=~female_complainant,data=out$meta,
                 max.em.its=25, 
                 seed=1033311)

labelTopics(stm.out.c)

#Extension (2)
plot(stm.out.c, n=6, type = "summary", xlim = c(0, 0.35), main = "Gendered Crime Content Covariate")
 
##Examining in non-gender related crimes what words are used by men and women, if different or now and how so
compare_content_words <- function(model, topic, group_var = "female_complainant", top_n = 10) {
  logbeta <- model$beta$logbeta
  
  vocab <- model$vocab
  
  group0 <- exp(logbeta[[1]][topic, ])
  group1 <- exp(logbeta[[2]][topic, ])
  
  df <- data.frame(
    word = vocab,
    male = group0,
    female = group1
  )
  
  df$diff <- df$female - df$male
  
  df_top <- df[order(abs(df$diff), decreasing = TRUE), ][1:top_n, ]
  
# Reshape for ggplot
  library(tidyr)
  df_long <- df_top |>
    select(word, male, female) |>
    pivot_longer(cols = c("male", "female"), names_to = "group", values_to = "prob")
  
# Plot
  library(ggplot2)
  ggplot(df_long, aes(x = reorder(word, prob), y = prob, fill = group)) +
    geom_col(position = "dodge") +
    coord_flip() +
    labs(title = paste("Top", top_n, "Words in Topic", topic, "by Complainant Gender"),
         x = "Word", y = "Probability",
         fill = "Group") +
    scale_fill_manual(values = c("male" = "#d95f02", "female" = "#7570b3"),
                      labels = c("Male (0)", "Female (1)")) +
    theme_minimal(base_size = 14)
}

#Extension (3)
compare_content_words(stm.out.c, topic = 9, top_n = 12) #Topic 9

#Extension (4)
compare_content_words(stm.out.c, topic = 18, top_n = 12) #Topic 18


