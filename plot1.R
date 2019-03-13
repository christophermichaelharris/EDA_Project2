##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}


##Creates new dataframes by year
PM25_1999 <- subset(NEI,year==1999)
PM25_2002 <- subset(NEI,year==2002)
PM25_2005 <- subset(NEI,year==2005)
PM25_2008 <- subset(NEI,year==2008)

#Sums the total emissions in each dataframe
SumPM25_1999 <- sum(PM25_1999$Emissions)
SumPM25_2002 <- sum(PM25_2002$Emissions)
SumPM25_2005 <- sum(PM25_2005$Emissions)
SumPM25_2008 <- sum(PM25_2008$Emissions)

#Combines information into two vectors for ease of plotting
Years <- c(1999,2002,2005,2008)
PM_Observations <- c(SumPM25_1999,SumPM25_2002,SumPM25_2005,SumPM25_2008)

#Plots the data and formats
plot(PM_Observations~Years,xlab="Year",ylab="Total Emissions",main="PM2.5 Emissions from All Sources",type="o",col="blue")
text(PM_Observations~Years,labels=round(PM_Observations,digits=0),pos=3)