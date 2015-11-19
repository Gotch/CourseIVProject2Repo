plot1 <- function(dir) {
  
  ##reads table
  NEI <- readRDS("summarySCC_PM25.rds")

  ##creates table of year and total emissions
  library(reshape2)
  NEImelt <-melt(NEI, id=c("year"), measure.vars = c("Emissions"))
  yearData <- dcast(NEImelt, year ~ variable, sum)

  ##creates png
  png(file = "plot1.png")
  barplot(yearData$Emissions, col = "blue", main = "Emissions", 
          xlab = "Year", ylab = "PM2.5 Emitted (tons)", names.arg = yearData$year)
  dev.off()
  
}