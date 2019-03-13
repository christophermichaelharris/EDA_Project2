##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}


##Creates new dataframes by subsetting by both year and zip
BaltPM25_1999 <- subset(NEI,year==1999 & fips==24510)
BaltPM25_2002 <- subset(NEI,year==2002 & fips==24510)
BaltPM25_2005 <- subset(NEI,year==2005 & fips==24510)
BaltPM25_2008 <- subset(NEI,year==2008 & fips==24510)

#Sums the total emissions in each dataframe
BaltSumPM25_1999 <- sum(BaltPM25_1999$Emissions)
BaltSumPM25_2002 <- sum(BaltPM25_2002$Emissions)
BaltSumPM25_2005 <- sum(BaltPM25_2005$Emissions)
BaltSumPM25_2008 <- sum(BaltPM25_2008$Emissions)

#Combines information into two vectors for ease of plotting
Years <- c(1999,2002,2005,2008)
Balt_PM_Observations <- c(BaltSumPM25_1999,BaltSumPM25_2002,BaltSumPM25_2005,BaltSumPM25_2008)

#Plots the data and formats
plot(Balt_PM_Observations~Years,xlab="Year",ylab="Total Emissions in Baltimore",main="PM2.5 Emissions from All Sources in Baltimore",type="o",col="red")
text(Balt_PM_Observations~Years,labels=round(Balt_PM_Observations,digits=0),pos=3)