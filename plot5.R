# Load ggplot2
library(ggplot2)

# Get the PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting on Baltimore and "on-road" type
NEI.OR.balt <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"),]

#Filter out from all emissions on above criteria and calculate aggregate
agg.MV.balt <- aggregate(NEI.OR.balt$Emissions, list(Year=NEI.OR.balt$year), sum)

#Open graphics device
png(filename = "figures/plot5.png", width = 480, height = 480, units = "px")

#Plotting the details to answer how emissions changed from motor vecicle sources 
ggplot(agg.MV.balt) + 
  geom_line(aes(y = x, x = Year)) + 
  labs(y=expression("PM"[2.5]~ "Emission (tons)")) + 
  ggtitle(expression(atop("Total PM"[2.5]~ "Emission from Motor Vehicle Sources", atop(italic("Baltimore City, MD")))))

#shutdown device
dev.off()