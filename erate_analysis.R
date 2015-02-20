df <- read.csv('erate.csv')

names(df)
head(df)

# Deals greater than $10,000,000

df$Duplicate <- 1
big <-df[df$Opty.Revenue..TOV. > 10000000, c("Opportunity.Account.Name", 
                                             "Opty.Revenue..TOV.", 
                                             "Opportunity.ID",
                                             "Duplicate",
                                             "SR.WR.ID",
                                             "Won.Loss.No.Sale.Status")]
big <- format(big,big.mark=",")
big <- big[order(big$Opportunity.ID, big$SR.WR.ID),]
big$Duplicate <- duplicated(big$Opportunity.ID)
big[big$Duplicate==FALSE,]

write.csv(df, 'erate_02.csv')
write.csv(big, 'big_01.csv')

# Create Month column and set datetime to POSIXlt and POSIXt format for analysis.

df$Month <- 1
df$ON.SR.WR.Status.Status.Detail.Start.Date <- as.character(df$ON.SR.WR.Status.Status.Detail.Start.Date)
df$ON.SR.WR.Status.Status.Detail.Start.Date <- strptime(df$ON.SR.WR.Status.Status.Detail.Start.Date, format=("%m/%d/%Y %H:%M"))
df$Month <- df$ON.SR.WR.Status.Status.Detail.Start.Date$mon+1
df$Month <- month.abb[df$Month]

write.csv(df, 'erate_03.csv')

# Identify valid E-Rate contributors


# Create Week column

df$Week <- 1
df$Week <- df[,"SR.WR.Status.Status.Detail.Start.Week"]
df$Week <- as.character(df$Week)
df$Week <- substr(df$Week, start = 10, stop = 12)

# Plot inbound SR/WR volumes per week and month

library(ggplot2)
p1 <- ggplot(df, aes(Week, fill = X.My.Position.2..Employee.Name))
p1 + geom_histogram()

p2 <- ggplot(df, aes(Month, fill = X.My.Position.3..Employee.Name))
p2 + geom_histogram()

head(df$My.Position.3..Employee.Name)


str(diamonds)
head(diamonds$cut)
head(diamonds)

p <- ggplot(diamonds, aes(x=clarity))
p + geom_histogram()
p <- ggplot(diamonds, aes(x = clarity, fill = cut))
p + geom_histogram()