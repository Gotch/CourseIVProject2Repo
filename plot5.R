plot5 <- function(dir) {
  
  ##reads tables
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  ##merges the tables and selects only motor vehicle - related sources for Baltimore
  NEI_Balt <- NEI[NEI$fips=="24510",]
  TotalData_Balt = merge(NEI_Balt,SCC,by = "SCC", all.x = TRUE)
  TotalData_BaltMotor <- TotalData_Balt[grepl("Mobile", TotalData_Balt$EI.Sector), ]
  
  ##creates tables of year and total emissions
  library(reshape2)
  BaltMotormelt <-melt(TotalData_BaltMotor, id=c("year"), measure.vars = c("Emissions"))
  yearData_BaltMotor <- dcast(BaltMotormelt, year ~ variable, sum)
  
  ##creates png
  library(ggplot2)
  png(file = "plot5.png")
  barplot(yearData_BaltMotor$Emissions, col = "blue", main = "Emissions", 
          xlab = "Year", ylab = "PM2.5 Emitted (tons)", names.arg = yearData_BaltMotor$year)
  dev.off()
  
}