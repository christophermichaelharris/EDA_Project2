##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}


#Creates matrix of relevant values
PM25 <- data.frame(0,matrix(nrow=4,ncol = 2))
colnames(PM25) = c("Year","Emissions")
PM25[1:4,1] = c(1999,2002,2005,2008)  #year values
PM25[1:4,2] <- c(sum(NEI[NEI$year == 1999,4]),sum(NEI[NEI$year == 2002,4]),sum(NEI[NEI$year == 2005,4]),sum(NEI[NEI$year == 2008,4]))



with(PM25,{
  plot(PM25$Year,PM25$Emissions,xlab="Year",ylab="Total Emissions",main="PM2.5 Emissions from All Sources",type="p",col="blue",pch=19,xlim=c(1999,2009.5),ylim=c(0,8000000))
  text(PM25$Year,PM25$Emissions,labels=round(PM25$Emissions,digits=0),pos=4)
  trend <- lm(PM25$Emissions~PM25$Year,data=PM25_df)
  abline(trend,col="red")
})

dev.copy(png,file="plot1.png")
dev.off()