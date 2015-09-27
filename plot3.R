# Load ggplot2 and plyr (for dealing with the data)
library(ggplot2)
library(plyr)

# Get the PM2.5 Emissions Data and Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Total emissions for Baltimore grouped by types of sources
types.balt <- ddply(NEI[NEI$fips == "24510",], c("year", "type"), function(df)sum(df$Emissions, na.rm = TRUE))

# Open the graphics device
png(filename = "figures/plot3.png", width = 480, height = 480, units = "px")

# Plot the data and label the graph
ggplot(types.balt, aes(x = year, y = V1, group = type, color = type)) +
  geom_line() +
  xlab("Year") +
  ylab(expression("PM"[2.5]~"(tons)")) +
  ggtitle(expression("Total PM"[2.5]~ "Emissions per Year by Source Type"))

# Close the graphics device
dev.off()