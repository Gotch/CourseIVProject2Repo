plot4 <- function(dir) {
  
  ##reads tables
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  ##merges the tables and selects only coal combustion - related sources
  TotalData = merge(NEI,SCC,by = "SCC", all.x = TRUE)
  TotalData_CoalComb <- TotalData[grepl("Coal", TotalData$EI.Sector), ]
  
  ##creates tables of year and total emissions
  library(reshape2)
  CoalCombmelt <-melt(TotalData_CoalComb, id=c("year"), measure.vars = c("Emissions"))
  yearData_CoalComb <- dcast(CoalCombmelt, year ~ variable, sum)
  
  ##creates png
  library(ggplot2)
  png(file = "plot4.png")
  barplot(yearData_CoalComb$Emissions, col = "blue", main = "Emissions", 
          xlab = "Year", ylab = "PM2.5 Emitted (tons)", names.arg = yearData_CoalComb$year)
  dev.off()
  
}