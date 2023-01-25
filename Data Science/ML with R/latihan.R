# X = 5
# X = c(3,2,1,3,1)
# x.1 = 'hello'
# sqrt(X*5*5)
# abs(-X)
# log(4)
# gtau <- rep(2,5)
# X*gtau
# e=matrix(c(1,2,3,4,5,6,7,8,9), nrow =3,byrow=FALSE)
# d = c(0,1,2,3,4,5,3,2,1,3,2,1,3,4,2,1,2,3)
# y = as.factor(d)
# summary(y)
# levels(y)
setwd("E:/Kuliah/Courses/Coaching Course Net")
data = read.csv("File 1.txt")
data = read.table("File 1.txt", header = TRUE, sep=",")
class(data) #type data
var1<-data$Salary <=100000
var = as.numeric(data$Salary >= 100000)
dim(data)
tail(data)
head(data)
data[data$Salary <= mean(data$Salary) & data$YearsExperience <=4 & data$YearsExperience >=2 ,]
