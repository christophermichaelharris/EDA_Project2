##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}

##Creates new dataframes by subsetting by year and zip
BaltPM25_1999 <- subset(NEI,year==1999 & fips==24510)
BaltPM25_2002 <- subset(NEI,year==2002 & fips==24510)
BaltPM25_2005 <- subset(NEI,year==2005 & fips==24510)
BaltPM25_2008 <- subset(NEI,year==2008 & fips==24510)

