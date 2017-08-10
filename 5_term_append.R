#-------- indexing term number on course_grades_psych dataframe


View(course_grades_psych)

course_grades_psych <- course_grades_psych[,colSums(is.na(course_grades_psych))< nrow(course_grades_psych)]

course_grades_psych_term <- as.data.frame(matrix(NA, ncol = ncol(course_grades_psych)))
course_grades_psych_term$term <- NA

#-- append term number 

unique_ids <- unique(course_grades_psych$V1)
for (i in 1:length(unique_ids))
{
  id<- unique_ids[i]
  df <- course_grades_psych[course_grades_psych$V1==id,]
  df <- df[order(df$V2),]
  df$term <- c(1:nrow(df))
  course_grades_psych_term <- rbind(course_grades_psych_term,df)
}

course_grades_psych_term<- course_grades_psych_term[,c(1,2,57,3:56)]

course_grades_psych_term <- course_grades_psych_term[-c(1),]
