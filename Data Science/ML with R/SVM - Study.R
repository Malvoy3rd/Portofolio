
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
split = ?ample.split(df$Purchased,SplitRatio=0.7)
training_set=subset(df,split==TRUE)
test_set=subset(df,split==FALSE)

#model SVM
#library(e1071) #package 'e1071' was built under R version 3.6.3 
classifier = svm(formula=Purchased~.,
                 data=training?set,
                 type='C-classification',
                 kernel= 'linear' )
y_pred = predict(classifier,newdata=test_set[-3])
result = cbind(test_set,y_pred)
