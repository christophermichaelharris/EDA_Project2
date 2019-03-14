##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}


#Creates matrix of relevant values
PM25_Balt <- data.frame(0,matrix(nrow=4,ncol = 2))
colnames(PM25_Balt) = c("Year","Emissions")
PM25_Balt[1:4,1] = c(1999,2002,2005,2008)  #year values
PM25_Balt[1:4,2] <- c(sum(NEI[NEI$year == 1999 & NEI$fips == 24510,4]),sum(NEI[NEI$year == 2002 & NEI$fips == 24510,4]),sum(NEI[NEI$year == 2005  & NEI$fips == 24510,4]),sum(NEI[NEI$year == 2008 & NEI$fips == 24510,4]))
   

dev.copy(png,file="plot2.png")
with(PM25_Balt,{
  plot(PM25_Balt$Year,PM25_Balt$Emissions,xlab="Year",ylab="Total Emissions",main="PM2.5 Emissions from All Sources in Baltimore",type="p",col="blue",pch=19,ylim=c(0,4000))
  text(PM25_Balt$Year,PM25_Balt$Emissions,labels=round(PM25_Balt$Emissions,digits=0),pos=3)
  trend <- lm(PM25_Balt$Emissions~PM25_Balt$Year,data=PM25_Balt)
  abline(trend,col="red")
})
dev.off()
