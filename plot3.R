##Checks if the variable has already been created

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source Classification Code.rds")
}

#Creates matrix of relevant values
PM_25_Matrix_Balt_Type <- matrix(nrow=16,ncol = 3)
colnames(PM_25_Matrix_Balt_Type) = c("Year","Type","Emissions")
PM_25_Matrix_Balt_Type[1:16,1] = c(rep(1999,4),rep(2002,4),rep(2005,4),rep(2008,4))  #year values
PM_25_df_Balt_Type <- data.frame(PM_25_Matrix_Balt_Type)

PM_25_df_Balt_Type[1:16,2] <- c(rep(c("point", "nonpoint", "onroad", "nonroad"),each=4))
  

