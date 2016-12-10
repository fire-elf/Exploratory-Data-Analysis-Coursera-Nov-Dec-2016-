# Coursera - Exploratory Data Analysis, Week 4, Course Project 2
# Question 6: Compare emissions from motor vehicle sources in Baltimore Cit
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Set working directory and read in the data
setwd("C:/Users/Jenny/Documents/COURSERA/4 - Exploratory Data/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Strategy:
# Extract the rows of NEI where type is ON-ROAD
# For each year, calculate the SUM of emissions
# Graph a barplot
# Print the conclusion to screen

Bmore <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
Bmore_sums<- tapply(Bmore$Emissions, Bmore$year, sum)
Bmore_df <- data.frame(year=names(Bmore_sums), Total.Emissions=Bmore_sums)
Bmore_df$year <- as.numeric(as.character(Bmore_df$year))
Bmore_df <- cbind(Bmore_df, c(rep("Baltimore City",4)))
names(Bmore_df) <- c("year", "Emissions", "City")

LA <- subset(NEI, NEI$fips == "06037" & NEI$type == "ON-ROAD")
LA_sums<- tapply(LA$Emissions, LA$year, sum)
LA_df <- data.frame(year=names(LA_sums), Total.Emissions=LA_sums)
LA_df$year <- as.numeric(as.character(LA_df$year))
LA_df <- cbind(LA_df, c(rep("Los Angeles",4)))
names(LA_df) <- c("year", "Emissions", "City")

# Useful resource: http://www.r-graph-gallery.com/48-grouped-barplot-with-ggplot2/
# Build a data frame analogous to the one in R graph gallery
df <- rbind(Bmore_df, LA_df)
df$year <- as.character(df$year)


# Plot a barplot of the Total Emissions vs Year for each type using png device
# The scales for the two cities are very different, so to make the differences easier to distinguish
# take the log10 of the emissions
png(file = "plot6.png")
myp <- ggplot(df, aes(fill=City, y=log10(Emissions), x=year))
myp + geom_bar(position="dodge", stat="identity") + ggtitle("Motor Vehicle Emissions") +
  labs(x="Year",y="log10(PM2.5 emissions)") 
dev.off()


# Conclusion
print("Based on the motor vehicle (on-road) emissions, a greater change (decrease) was seen in Baltimore compared to LA.")
