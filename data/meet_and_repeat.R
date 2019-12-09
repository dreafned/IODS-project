

#Meet and Repeat: PART I
# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS

str(BPRS)

# Print out summaries of the variables

summary(BPRS)



#Graphical displays of longitudinal data: The magical gather()
# The data BPRS is available

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)


#Meet and Repeat: PART II
# dplyr is available

# read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Factor variables ID and Group

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Glimpse the data
glimpse(RATS)



#Linear Mixed Effects Models: Gather 'round
# dplyr, tidyr and RATS are available
str(RATS)
# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse the data
glimpse(RATSL)

write.csv2(BPRS, "data/BPRS.csv", row.names = FALSE)
write.csv2(BPRSL, "data/BPRSL.csv", row.names = FALSE)
write.csv2(RATS, "data/RATS.csv", row.names = FALSE)
write.csv2(RATSL, "data/RATSL.csv", row.names = FALSE)



