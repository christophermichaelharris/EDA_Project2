library(ggplot2)

##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}

#Creates matrix of relevant values
PM25_Matrix_Balt_Type <- matrix(nrow=16,ncol = 3)
colnames(PM25_Matrix_Balt_Type) = c("Year","Type","Emissions")
PM25_Matrix_Balt_Type[1:16,1] = c(rep(1999,4),rep(2002,4),rep(2005,4),rep(2008,4))  #year values

#Convert to dataframe to keep year as an integer but add type as a character
PM25_df_Balt_Type <- data.frame(PM25_Matrix_Balt_Type)

#Adds levels 
PM25_df_Balt_Type[1:16,2] <- c(rep(c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"),4))

#Loop through the rows of the dataframe and populate by summing the observations that match (a) the year, (b) the fip/area, and then (c) the type 
for(i in 1:nrow(PM25_df_Balt_Type)){
  PM25_df_Balt_Type[i,3] = sum(NEI[NEI$year == PM25_df_Balt_Type[i,1] & NEI$fips == 24510 & NEI$type == PM25_df_Balt_Type[i,2],4])
}

qplot(Year,Emissions,data=PM25_df_Balt_Type, facets = .~Type) + geom_smooth(method=lm) + labs(y="Total Emissions",x="Year",main="Total Emissions in Baltimore by Year and Type")

