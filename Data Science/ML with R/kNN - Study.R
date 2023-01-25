
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

#kNN
library(class) #package 'class' was built under R version 3.6.3 
y_pred = knn(train=training_set[,-3],
             test = test_set[,-3],
             cl =training_set[,3],
             k=5)

#summary(y_pred)
result = cbind(test_set,y_pred)

#checkaccuracy
#convolution matrix
cm=table(test_set[,3],y_pred)

#auc
y_pred_num = as.numeric(y_pred)
colAUC(y_pred_num,test_set[,3],plotROC=TRUE)