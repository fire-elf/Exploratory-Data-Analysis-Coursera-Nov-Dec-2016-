# Coursera - Exploratory Data Analysis, Week 4, Course Project 2
# Question 3: Of the four types of sources indicated by the type
# (point, nonpoint, onroad, nonroad) variable, which of these four
# sources have seen decreases in emissions from 1999-2008 for Baltimore City?
# Which have seen increases in emissions from 1999-2008?
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
# Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question.Use the ggplot2 plotting system to make a plot answer this question.

# Set working directory and read in the data
setwd("C:/Users/Jenny/Documents/COURSERA/4 - Exploratory Data/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Strategy:
# Extract the rows of NEI that match the fips ID
# For each year and each type, calculate the sum of emissions
# Create a barplot, showing all four emission types grouped by the four years
# Print the conclusion to screen

# Useful resource: http://www.r-graph-gallery.com/48-grouped-barplot-with-ggplot2/

# Subset four data groups based on the type of emission
Bmore <- subset(NEI, NEI$fips == "24510")
Bmore_t1 <- subset(Bmore, Bmore$type == "POINT")
Bmore_t2 <- subset(Bmore, Bmore$type == "NONPOINT")
Bmore_t3 <- subset(Bmore, Bmore$type == "ON-ROAD")
Bmore_t4 <- subset(Bmore, Bmore$type == "NON-ROAD")

# For each emission type, calculate the sum of emissions for each year
t1_sums<- tapply(Bmore_t1$Emissions, Bmore_t1$year, sum)
t2_sums<- tapply(Bmore_t2$Emissions, Bmore_t2$year, sum)
t3_sums<- tapply(Bmore_t3$Emissions, Bmore_t3$year, sum)
t4_sums<- tapply(Bmore_t4$Emissions, Bmore_t4$year, sum)

# Build a data frame analogous to the one in R graph gallery
# type_sums <- data.frame(t1_sums, t2_sums, t3_sums, t4_sums) # wrong structure for this analysis, try again
# Paste the data together as a long list of 16 elements
data_ls <- c(t1_sums, t2_sums, t3_sums, t4_sums)

year=c(rep("1999", 4), rep("2002", 4), rep("2005", 4), rep("2008", 4))
type=rep(c("Point", "Nonpoint", "On-road", "Non-road"))

df= data.frame(year, type, data_ls)

# Plot a barplot of the Total Emissions vs Year for each type using png device
png(file = "plot3.png")
myp <- ggplot(df, aes(fill=type, y=data_ls, x=year))
myp + geom_bar(position="dodge", stat="identity") + ggtitle("Baltimore City Emissions") +
  labs(x="Year",y="PM2.5 emissions (tons)") 
dev.off()


# Conclusion
print("In Baltimore (1999 to 2008), non-road, nonpoint, and on-road emissions decreased over time. Point emissions increased in that time period.")
