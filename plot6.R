# Load ggplot2
library(ggplot2)

# Get the PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset on motor vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicles.SCC <- SCC[vehicles,]$SCC
vehicles.NEI <- NEI[NEI$SCC %in% vehicles.SCC,]

# Subset on just motor vehicles from Baltimore and LA
vehicles.balt.NEI <- vehicles.NEI[vehicles.NEI$fips == 24510,]
vehicles.balt.NEI$city <- "Baltimore City"
vehicles.LA.NEI <- vehicles.NEI[vehicles.NEI$fips=="06037",]
vehicles.LA.NEI$city <- "Los Angeles"
both.NEI <- rbind(vehicles.balt.NEI,vehicles.LA.NEI)

#Open the graphics device
png(filename = "figures/plot6.png", width = 480, height = 480, units = "px")

# Plot the amounts of emissions in Baltimore and LA
ggplot(both.NEI, aes(x = factor(year), y = Emissions, fill = city)) +
  geom_bar(aes(fill = year),stat = "identity") +
  facet_grid(scales = "free", space = "free", .~city) +
  guides(fill = FALSE) + theme_bw() +
  labs(x = "Year", y=expression("Total PM"[2.5]~ "Emission (kTons)")) + 
  ggtitle(expression(atop("PM"[2.5]~ "Emission from Motor Vehicle Sources", atop(italic("Baltimore City, MD and Los Angeles County, CA")))))

#shutting down the device
dev.off()