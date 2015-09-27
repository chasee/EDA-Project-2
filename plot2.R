# Get the PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get the aggregate total emissions for Baltimore
balt.NEI <- NEI[NEI$fips == "24510",]

#Break it down by year
agg.totals.balt <- aggregate(Emissions ~ year, balt.NEI, sum)

# Open the graphics device
png(filename = "figures/plot2.png", width = 480, height = 480, units = "px")

# Construct the plot (setting margins before hand for labeling purposes)
par(mar = c(5.1, 6.1, 4.1, 4.1))
plot(agg.totals.balt, type = "l", col = "red", xlab = "", ylab = "", xaxt = "n")

# Label the plot and make it look pretty
title(main = expression("Total PM"[2.5]~ "Emissions from Baltimore City, MD"),
      col.main = "black",
      xlab = "Year",
      ylab = expression("Total PM"[2.5]~ "Emissions (tons)"),
      cex.main = 1.75,
      cex.lab = 1.5
)
## Replaces original, vague x-axis labels with ones corresponding to the data
axis(1, at=as.integer(agg.totals.balt$year), las=1)

#Close the graphic device
dev.off()