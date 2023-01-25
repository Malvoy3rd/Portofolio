
setwd("E:/Kuliah/Courses/Coaching Course Net")

df = read.csv('File 1.csv',fileEncoding = 'UTF-8-BOM')

#gabutuh user ID
df <- df[,-1]
#atau
df$User.ID = NULL

#feature scaling
df[,1:2] = scale(df[,1:2])

#trainset
library(caTools)
set.seed(123)

split = sample.split(df$Purchased,SplitRatio=0.7)
training_set=subset(df,split==TRUE)
test_set=subset(df,split==FALSE)

#train log_res
regressor = lm(formula=Purchased~., data = training_set)
y_pred = predict(regressor,newdata=test_set)
result=cbind(test_set,y_pred)
#error = 
#result=cbind(test_set,error)
