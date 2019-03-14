require(ggplot2)   ##load ggplot2


##Checks if the variable has already been created
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}

SCC_Class <- SCC[4]  #lists all the values in SCC
SCC_Levels <- levels(SCC_Class$EI.Sector)   #strips out 59 levels of classes from SCC
Target_EI_Sector <- SCC_Levels[c(13,18,23)]   #list of the 3 levels relevant to the analysis
SCC_Nos <- as.character(SCC[(SCC$EI.Sector==Target_EI_Sector[1] | SCC$EI.Sector==Target_EI_Sector[2] | SCC$EI.Sector==Target_EI_Sector[3]),1])  #list of all SCC nos corresponding to levels
Coal_Obs <- NEI[(NEI$SCC %in% SCC_Nos),]   ##observations in original data frame that match the SCC numbers


#Creates empty matrix and populates titles and row numbers
PM25_Coal <- data.frame(matrix(0,ncol=2,nrow=4))
colnames(PM25_Coal) = c("Year","Emissions")
PM25_Coal[1:4,1] = c(1999,2002,2005,2008)  #year values

#Sums up and populates rows in dataframe by year
PM25_Coal[1:4,2] <- c(sum(Coal_Obs[Coal_Obs$year == 1999,4]),sum(Coal_Obs[Coal_Obs$year == 2002,4]),sum(Coal_Obs[Coal_Obs$year == 2005,4]),sum(Coal_Obs[Coal_Obs$year == 2008,4]))

#creates plot
dev.copy(png,file="plot4.png")
plot4 <- qplot(Year,Emissions,data=PM25_Coal) + geom_smooth(method=lm) + labs(y="Total Emissions",x="Year",title="Total Coal Combustion-Related Emissions in the United States")
dev.off()

plot(plot4)
