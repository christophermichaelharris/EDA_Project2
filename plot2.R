##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}


#Creates matrix of relevant values
PM25_Matrix_Balt <- matrix(nrow=4,ncol = 2)
colnames(PM25_Matrix_Balt) = c("Year","Emissions")
PM25_Matrix_Balt[1:4,1] = c(1999,2002,2005,2008)  #year values
PM25_Matrix_Balt[1:4,2] <- c(sum(NEI[NEI$year == 1999 & NEI$fips == 24510,4]),sum(NEI[NEI$year == 2002 & NEI$fips == 24510,4]),sum(NEI[NEI$year == 2005  & NEI$fips == 24510,4]),sum(NEI[NEI$year == 2008 & NEI$fips == 24510,4]))
PM25_df_Balt <- data.frame(PM25_Matrix_Balt)          

with(PM25_df_Balt,{
  plot(PM25_df_Balt$Year,PM25_df_Balt$Emissions,xlab="Year",ylab="Total Emissions",main="PM2.5 Emissions from All Sources in Baltimore",type="p",col="blue",pch=19)
  text(PM25_df_Balt$Year,PM25_df_Balt$Emissions,labels=round(PM25_df_Balt$Emissions,digits=0),pos=3)
  trend <- lm(PM25_df_Balt$Emissions~PM25_df_Balt$Year,data=PM25_df_Balt)
  abline(trend,col="red")
})