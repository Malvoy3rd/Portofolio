
setwd("E:/Kuliah/Courses/Coaching Course Net")

df = read.csv('File 1.csv',fileEncoding = 'UTF-8-BOM')

df$User.ID = NULL
df$Purchased = as.factor(df$Purchased)

library(caTools)
set.seed(123)


split = sample.split(df$Purchased,SplitRatio=0.7)
training_set=subset(df,split==TRUE)
test_set=subset(df,split==FALSE)

library(randomForest)
classifier= randomForest(x=training_set[-3],
                         y=training_set$Purchased,
                         ntree=10)
#classifier
y_pred =predict(classifier,newdata=test_set[-3])
result = cbind(test_set,y_pred)

#checkaccuracy
#convolution matrix
cm=table(test_set[,3],y_pred)

#auc
y_pred_num = as.numeric(y_pred)
colAUC(y_pred_num,test_set[,3],plotROC=TRUE)

