getwd()

#import the data set itno R from github
metaurl <- "https://raw.githubusercontent.com/quadram-institute-bioscience/datasciencegroup/main/2_rarefaction/metadata.csv"
fturl <- "https://raw.githubusercontent.com/quadram-institute-bioscience/datasciencegroup/main/2_rarefaction/table.csv"
data <- read.csv(metaurl, header=T, sep = ',')
feat <- read.csv(fturl, header=T, sep = ',')
feat
data

#Another method to import  directly from the github using the URL link. #Taxonomy Information 
tax <- read.csv("https://raw.githubusercontent.com/quadram-institute-bioscience/datasciencegroup/main/2_rarefaction/taxonomy.csv", header=T, sep = ',')



# checking the structure of the data and the dimension.
nrow(data) # we have 20 observation which are mice names and 2 variables that are categorise based on collection time.
ncol(data)
dim(data)  
nrow(feat) # This is showing the number of  identified 16S marker genes found in the studied mice.
ncol(feat)
dim(feat)
nrow(tax)

#Checking the condition of the data collected based on. the time of collection as 'Early', 'Late', or 'Ctrl'  as shown in the metadata file.
names(data)
head(data)

##Checking the title of the columns i.e the identifier names of the mice in the feature table.
names(feat)
head(feat)
str(feat)

#Condition of the experiment 
#The number mice sampled early 
e_mice = which(data$Week == "Early")
length(e_mice)

#The number mice sampled late 
L_mice = which(data$Week == "Late")
length(L_mice)

#The number of control 
cont = which(data$Week == "Ctrl")
length(cont)

install.packages("tidyverse")
library(tidyverse)


heat(feat, 10)

heat#The number early as commapred to late and control 
#E = data$Week_status == 

barplot(feat)
  
  #
  