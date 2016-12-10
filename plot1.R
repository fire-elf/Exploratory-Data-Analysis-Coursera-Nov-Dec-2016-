# Coursera - Exploratory Data Analysis, Week 4, Course Project 2
# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.

# Set working directory and read in the data
setwd("C:/Users/Jenny/Documents/COURSERA/4 - Exploratory Data/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Strategy:
# Extract the years of interest from NEI into a new data frame (not needed)
# For each year, calculate the SUM of emissions
# Graph a barplot
# Print the conclusion to screen

# Useful source: http://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega

NEIsums <- tapply(NEI$Emissions, NEI$year, sum)
NEIdf <- data.frame(year=names(NEIsums), Total.Emissions=NEIsums)
NEIdf$year <- as.numeric(as.character(NEIdf$year))

# Plot a barplot of the Total Emissions vs Year using png device
png(file = "plot1.png")
barplot(NEIdf$Total.Emissions, col = "purple", xlab = "Year", ylab = "Total Emission (tons)")
dev.off()

# Conclusion
print("Based on the total emissions calculations for 1999, 2002, 2005, and 2008, the emissions in the US have gone down.")
