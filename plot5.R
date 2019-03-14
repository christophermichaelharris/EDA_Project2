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
Target_EI_Sector <- SCC_Levels[c(49,50,51,52)]   #list of the 4 levels relevant to the analysis
SCC_Nos <- as.character(SCC[(SCC$EI.Sector==Target_EI_Sector[1] | SCC$EI.Sector==Target_EI_Sector[2] | SCC$EI.Sector==Target_EI_Sector[3] | SCC$EI.Sector==Target_EI_Sector[4]),1])  #list of all SCC nos corresponding to levels
Road_Obs <- NEI[(NEI$SCC %in% SCC_Nos),]   ##observations in original data frame that match the SCC numbers

#Creates matrix of relevant values
Balt_Road_Obs <- data.frame(0,matrix(nrow=4,ncol = 2))
colnames(Balt_Road_Obs) = c("Year","Emissions")
Balt_Road_Obs[1:4,1] = c(1999,2002,2005,2008)  #year values
Balt_Road_Obs[1:4,2] <- c(sum(Road_Obs[Road_Obs$year == 1999 & Road_Obs$fips == 24510,4]),sum(Road_Obs[Road_Obs$year == 2002 & Road_Obs$fips == 24510,4]),sum(Road_Obs[Road_Obs$year == 2005  & Road_Obs$fips == 24510,4]),sum(Road_Obs[Road_Obs$year == 2008 & Road_Obs$fips == 24510,4]))

dev.copy(png,file="plot5.png")
plot5 <- qplot(Year,Emissions,data=Balt_Road_Obs) + geom_smooth(method=lm) + labs(y="Total Emissions",x="Year",title="Total Emissions from Motor Vehicle Sources in Baltimore City")
dev.off()

plot(plot5)
