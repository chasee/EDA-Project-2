# Load ggplot2
library(ggplot2)

# Get the PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset coal combustion related NEI data
combustion.related <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal.related <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal.combustion <- (combustion.related & coal.related)
combustion.SCC <- SCC[coal.combustion,]$SCC
combustion.NEI <- NEI[NEI$SCC %in% combustion.SCC,]

#Open graphics device
png(filename="figures/plot4.png", width=480, height=480, units = "px")

# Plot the subsetted data to show which sources have had decreased emissions
ggplot(combustion.NEI,aes(factor(year),Emissions)) + 
  geom_bar(stat = "identity", width = 0.75) +
  theme_bw() +  
  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]~ "Emissions (tons)")) + 
  labs(title=expression("PM"[2.5]~"Coal Combustion Source Emissions Across the US"))

#shutdown device
dev.off()