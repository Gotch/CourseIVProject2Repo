plot2 <- function(dir) {
  
  ##reads table
  NEI <- readRDS("summarySCC_PM25.rds")
  
  ##selects only Baltimore data
  NEI_Balt <- NEI[NEI$fips=="24510",]
  
  ##creates table of year and total emissions
  library(reshape2)
  NEImelt_Balt <-melt(NEI_Balt, id=c("year"), measure.vars = c("Emissions"))
  yearData_Balt <- dcast(NEImelt_Balt, year ~ variable, sum)
  
  ##creates png
  png(file = "plot2.png")
  barplot(yearData_Balt$Emissions, col = "blue", main = "Emissions", 
          xlab = "Year", ylab = "PM2.5 Emitted (tons)", names.arg = yearData_Balt$year)
  dev.off()
  
}