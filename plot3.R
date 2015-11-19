plot3 <- function(dir) {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  ##SCC <- readRDS("Source_Classification_Code.rds")
  
  ##Not needed for this plot: TotalData = merge(NEI,SCC,by = "SCC", all.x = TRUE)
  
  ##selects only Baltimore data and individual tables for each "type"
  NEI_Balt <- NEI[NEI$fips=="24510",]

  ##creates tables of year and total emissions, by type
  library(reshape2)
  NEImelt_Balt <-melt(NEI_Balt, id=c("year", "type"), measure.vars = c("Emissions"))
  yearData_Balt_byType <- dcast(NEImelt_Balt, year + type ~ variable, sum)

  ##creates png
  library(ggplot2)
  png(file = "plot3.png")
  qplot(year, Emissions, data = yearData_Balt_byType, facets = .~type)
  dev.off()
  
}