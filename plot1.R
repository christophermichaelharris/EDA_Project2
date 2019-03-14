##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}

#Creates matrix of relevant values
PM_25_Matrix <- matrix(nrow=4,ncol = 2)
colnames(PM_25_Matrix) = c("Year","Emissions")
PM_25_Matrix[1:4,1] = c(1999,2002,2005,2008)  #year values
PM_25_Matrix[1:4,2] <- c(sum(NEI[NEI$year == 1999,4]),sum(NEI[NEI$year == 2002,4]),sum(NEI[NEI$year == 2005,4]),sum(NEI[NEI$year == 2008,4]))
PM_25_df <- data.frame(PM_25_Matrix)                        
 
with(PM_25_df,{
  plot(PM_25_df$Year,PM_25_df$Emissions,xlab="Year",ylab="Total Emissions",main="PM2.5 Emissions from All Sources",type="p",col="blue",pch=19)
  text(PM_25_df$Year,PM_25_df$Emissions,labels=round(PM_25_df$Emissions,digits=0),pos=3)
  trend <- lm(PM_25_df$Emissions~PM_25_df$Year,data=PM_25_df)
  abline(trend,col="red")
})
