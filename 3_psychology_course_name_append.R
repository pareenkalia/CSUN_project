#------------------------------------------3. Psychology Data: Appending columns of courses that psychology students take
#------------------------------------------                     with NA entries for rows (populating in the next step)


install.packages('RMySQL')
install.packages('sqldf')
install.packages('plyr')
library(plyr)
library(RMySQL)
library(sqldf)

# course_grades data of only psychology students 

course_grades_p <- course_grades[course_grades$V1 %in% psychology_output$studentid,]
course_grades_p$V1 <- as.character(course_grades_p$V1)

#psychology_merge_grades <- psychology_merge_grades[,colSums(is.na(psychology_merge_grades))< nrow(psychology_merge_grades)]

# Getting list of unique course names - course names start from column 17 and end at 70, and appear in positions that are multiples of 3
course_grades_p <- course_grades_p[,colSums(is.na(course_grades_p))<nrow(course_grades_p)]

a <- unique(unlist(course_grades_p[,c(3:ncol(course_grades_p))[c(T,F,F)]]))
b<- cbind(a)
# Getting rid of NULL/NA coursenames
b <- b[!(is.na(b))]

# Appending columns of course names to psychology_output table with NA entries for all rows.

df <- as.data.frame(matrix(nrow=nrow(psychology_output), ncol = length(b)))
colnames(df) <- c(b)
psychology_output <- cbind(psychology_output,df)


  

  
  


  
  