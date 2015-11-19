plot6 <- function(dir) {
  
  ##reads tables
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  ##merges the tables and selects only motor vehicle - related sources for Baltimre
  NEI_Balt <- NEI[NEI$fips=="24510",]
  TotalData_Balt = merge(NEI_Balt,SCC,by = "SCC", all.x = TRUE)
  TotalData_BaltMotor <- TotalData_Balt[grepl("Mobile", TotalData_Balt$EI.Sector), ]
  
  ##merges the tables and selects only motor vehicle - related sources for LA
  NEI_LA <- NEI[NEI$fips=="06037",]
  TotalData_LA = merge(NEI_LA,SCC,by = "SCC", all.x = TRUE)
  TotalData_LAMotor <- TotalData_LA[grepl("Mobile", TotalData_LA$EI.Sector), ]
  
  ##creates tables of year and total emissions
  library(reshape2)
  BaltMotormelt <-melt(TotalData_BaltMotor, id=c("year"), measure.vars = c("Emissions"))
  yearData_BaltMotor <- dcast(BaltMotormelt, year ~ variable, sum)
  LAMotormelt <-melt(TotalData_LAMotor, id=c("year"), measure.vars = c("Emissions"))
  yearData_LAMotor <- dcast(LAMotormelt, year ~ variable, sum)
  
  ##creates png
  library(ggplot2)
  png(file = "plot6.png")
  par(mfrow = c(1,2))
  barplot(yearData_BaltMotor$Emissions, col = "blue", main = "Emissions - Baltimore", 
          xlab = "Year", ylab = "PM2.5 Emitted (tons)", names.arg = yearData_BaltMotor$year)
  barplot(yearData_LAMotor$Emissions, col = "blue", main = "Emissions - LA", 
          xlab = "Year", ylab = "PM2.5 Emitted (tons)", names.arg = yearData_LAMotor$year)
  dev.off()
  
}