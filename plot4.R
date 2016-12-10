# Coursera - Exploratory Data Analysis, Week 4, Course Project 2
# Question 4: Across the United States, how have emissions from coal combustion-related sources
# changed from 1999-2008?

# Set working directory and read in the data
setwd("C:/Users/Jenny/Documents/COURSERA/4 - Exploratory Data/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Strategy:
# Use pattern matching on SCC Short.Names to find those referring to both coal and combustion
# Based on the SCC codes for this subset, extract/subset rows from NEI
# Calculate the sum of emissions across the different years for the entire US
# Plot a boxplot of emission totals vs year

# Based on Short.Names, extract the names that match coal or Coal
coalSN <- SCC[grep("[Cc]oal", SCC$Short.Name),]

# Based on Short.Names, extract the names that match comb or Comb
# Initally tried Combust but some entries were omitted that should not have been
combustSN <-SCC[grep("[Cc]omb", SCC$Short.Name),]

# Pick out only those names that contain both C/coal AND C/comb
both <- intersect(coalSN$SCC, combustSN$SCC)

# Extract the rows of SCC where the code matches both (coal + combust) 
# myscc <- subset(SCC,SCC %in% both)

# Based on the SCC codes for the coal+combustion subset, extract/subset rows from NEI
NEI_4 <- subset(NEI, NEI$SCC %in% both)

# Calculate sum of Emissions for each year
NEIsums<- tapply(NEI_4$Emissions, NEI_4$year, sum)
df <- data.frame(c("1999", "2002", "2005", "2008"), NEIsums)
names(df) <- c("year", "PM25")

# Plot a barplot of the Total Emissions for each Year using png device
png(file = "plot4.png")
barplot(df$PM25, col = "purple", xlab = "Year", ylab = "Total Emission (tons)", main = paste("US Coal Combustion Emissions"))
dev.off()


# Conclusion
print("Across the US, the emissions from coal combustion decreased from 1999 to 2008.")
