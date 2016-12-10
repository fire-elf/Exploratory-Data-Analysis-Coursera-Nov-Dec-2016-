# Coursera - Exploratory Data Analysis, Week 4, Course Project 2
# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to 
# make a plot answering this question.

# Set working directory and read in the data
setwd("C:/Users/Jenny/Documents/COURSERA/4 - Exploratory Data/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Strategy:
# Extract the rows of NEI that match the fips ID
# For each year, calculate the SUM of emissions
# Graph a barplot
# Print the conclusion to screen

Bmore <- subset(NEI, NEI$fips == "24510")
Bmore_sums<- tapply(Bmore$Emissions, Bmore$year, sum)
Bmore_df <- data.frame(year=names(Bmore_sums), Total.Emissions=Bmore_sums)
Bmore_df$year <- as.numeric(as.character(Bmore_df$year))

# Plot a barplot of the Total Emissions vs Year using png device
png(file = "plot2.png")
barplot(Bmore_df$Total.Emissions, col = "purple", main = paste("Baltimore, MD (ID 24510)"), xlab = "Year", ylab = "Total Emission (tons)")
dev.off()

# Conclusion
print("Based on the total emissions calculations for Baltimore, the emissions have gone down from 1999 to 2008.")
