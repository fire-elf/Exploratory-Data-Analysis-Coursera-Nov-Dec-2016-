# Coursera - Exploratory Data Analysis, Week 4, Course Project 2
# Question 5: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Set working directory and read in the data
setwd("C:/Users/Jenny/Documents/COURSERA/4 - Exploratory Data/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Strategy:
# Extract the rows of NEI where type is ON-ROAD
# For each year, calculate the SUM of emissions
# Graph a barplot
# Print the conclusion to screen

Bmore <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
Bmore_sums<- tapply(Bmore$Emissions, Bmore$year, sum)
Bmore_df <- data.frame(year=names(Bmore_sums), Total.Emissions=Bmore_sums)
Bmore_df$year <- as.numeric(as.character(Bmore_df$year))

# Plot a barplot of the Total Emissions vs Year using png device
png(file = "plot5.png")
barplot(Bmore_df$Total.Emissions, col = "purple", main = paste("Baltimore City Motor Vehicle Emissions"), xlab = "Year", ylab = "Total Emission (tons)")
dev.off()

# Conclusion
print("Based on the total emissions calculations for Baltimore, the motor vehicle (on-road) emissions have gone down from 1999 to 2008.")


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
