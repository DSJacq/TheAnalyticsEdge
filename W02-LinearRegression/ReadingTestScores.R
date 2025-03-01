### TAE H02 - READING TEST SCORES

# Source: National Center for Education Statistics
# URL: http://nces.ed.gov/pubsearch/pubsinfo.asp?pubid=2011038




# 1.1 DATASET SIZE
pisaTrain = read.csv("pisa2009train.csv")
pisaTest = read.csv("pisa2009test.csv")
str(pisaTrain)
str(pisaTest)

# 1.2 SUMMARIZING THE DATASET
names(pisaTrain)
tapply(pisaTrain$male, pisaTrain$readingScore, mean)
mean(pisaTrain$readingScore & pisaTrain$male == "1")
mean(pisaTrain$readingScore & pisaTrain$male == "0")

# 1.4 REMOVING MISSING VALUES
pisaTrain = na.omit(pisaTrain)
pisaTest = na.omit(pisaTest)
str(pisaTrain)
nrow(pisaTrain)
nrow(pisaTest)

# 3.1 BUILDING A MODEL  
pisaTrain$raceeth = relevel(pisaTrain$raceeth, "White")
pisaTest$raceeth = relevel(pisaTest$raceeth, "White")
lmScore = lm(readingScore ~., data = pisaTrain)
summary(lmScore)

# 3.2 COMPUTING THE ROOT-MEAN SQUARED ERROR OF THE MODEL
SSE = sum(lmScore$residuals^2)
RMSE = sqrt(SSE/nrow(pisaTrain))
RMSE

# 3.3 COMPARING PREDICTIONS FOR SIMILAR STUDENTS
summary(lmScore)
DiffAB = 11 - 9
IGrade = 29.542707
PredictRS = DiffAB*IGrade
PredictRS

# 4.1 PREDICTING ON UNSEEN DATA
# What is the range between the maximum and minimum predicted reading score on the test set?
predTest = predict(lmScore, newdata=pisaTest)
summary(predTest)
names(pisaTest)
DiffpredTest = 637.7 - 353.2
DiffpredTest

# 4.2 TEST SET SSE AND RMSE
SSE = sum((predTest - pisaTest$readingScore)^2)
SSE
RMSE = sqrt(mean((predTest - pisaTest$readingScore)^2))
RMSE

# 4.3 BASELINE PREDICTION AND TEST-SET SSE
baseline = mean(pisaTrain$readingScore)
baseline
SSE = sum((baseline - pisaTest$readingScore)^2)
SSE

# 4.4 TEST-SET R-SQUARED
SSE = sum((predTest - pisaTest$readingScore)^2)
SSE
SST = sum((mean(pisaTrain$readingScore) - pisaTest$readingScore)^2)
SST
R2 = 1 - (SSE/SST)
R2
