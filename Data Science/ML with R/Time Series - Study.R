
setwd("E:/Kuliah/Courses/Coaching Course Net")

data = read.csv("Data Time Series.csv")

serene = data[,1] #Serene
typing = data[,2] #Typing
knocking = data[,3] #Knocking
shaking = data[,4] #Shaking
time = data[,5] #time
n = 64*3

library(forecast)
#install.packages('forecast') if the lib doens't exist

X_TS = ts(shaking,frequency =n/8.25,start=c(0,8.25))
plot(X_TS)

#X only
mod = auto.arima(X_TS)
result = data.frame(mod$fitted)

X_predict = forecast(mod,h=100) # h itu n periode yang ingin diforecast.
accuracy(X_predict)
plot(X_predict)

X_predict = data.frame(X_predict)

#Kesimpulan, data ini tidak bisa diforecast