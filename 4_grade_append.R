#----------------------------------------4. Psychology Data: Populating term|grades under column names--------

psychology_output <- read.csv("psychology_output.csv")
# Getting list of course names into variable courses
courses<- colnames(psychology_output)
courses <- courses[!(is.na(courses))]



# converting studentid from factor to character in psychology_output and courses_grades
psychology_output$studentid <- as.character(psychology_output$studentid)
course_grades_psych$V1 <- as.character(course_grades_psych$V1)
m<-2001
n <-3000

# iterating through each studentid in psychology_output table to match studentid in course_grades table
# then extracting term and grade, appending together and populating each row in a ridiculously slow fashion
# redo 6001-8000
for(i in 8001:nrow(psychology_output))
{
  sid <- psychology_output$studentid[i]
  if(sid %in% course_grades_psych$V1)
  {
  df <- course_grades_psych[course_grades_psych$V1 ==sid,]
  df <- df[,colSums(is.na(df))< nrow(df)]

  for(j in 1: nrow(df))
  {
    for(k in 3:(ncol(df)-2))
    {
      for(l in 1:(length(courses)-3))
      {
        if(!is.na(df[j,k]))
        {
          if(df[j,k]==courses[l])
         # print(j)
         # print(k)
         # print(l)
          {
          if(!(is.na(df[j,(k+2)])))
          {
            psychology_output[i,l] <- paste(df[j,2],df[j,(k+2)],sep="|")
          }
          else
          {
            psychology_output[i,l] <- NA
          }
         }
        }
      }
    }
  }
 }
}

View(psychology_output)

write.csv(psychology_output, 'psychology_final.csv')
