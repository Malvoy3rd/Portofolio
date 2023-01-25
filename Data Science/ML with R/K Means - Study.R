library(dplyr)

setwd("E:/Kuliah/Courses/Coaching Course Net")

data = read.csv('File 1.csv')

#Elbow Method
set.seed(6)
wcss = vector()
for(i in 1:10) wcss[i] = sum(kmeans(data,i)$withinss)
#plot(1:10,wcss, type='b', main=paste('cluster of plg'), xlabs = 'number', ylabs = Wcss)
plot(1:10,wcss, type='b',main=paste('cluster of plg'))

#build kmeans
set.seed(29)
#kmeans4 = kmeans(data,4,iter.max=10,nstart=10)
kmeans6 = kmeans(data,6,iter.max=10,nstart=10)
#kmeans10 = kmeans(data,10,iter.max=10,nstart=10)
#kmeans6$size

datafinal = cbind(data,kmeans6$cluster)

#getnewdata
data_pred = data

library(clue)
result = cl_predict(kmeans6, newdata = data_pred)
table(result)
