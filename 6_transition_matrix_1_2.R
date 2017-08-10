#--- Transition matrix from Term 1 and Term 2


#--- Term 1 and Term 2 student/course list only

course_grades_psych_term_1 <- course_grades_psych_term[course_grades_psych_term$term==1,]

course_grades_psych_term_2 <- course_grades_psych_term[course_grades_psych_term$term==2,]

#-- count # students enrolled in term 1 in each course

ct<-0
count_courses<- as.data.frame(matrix(NA,nrow = length(c_list), ncol = 2))
for(i in 1:length(c_list))
{
  for(id in 1:nrow(course_grades_psych_term_1))
  {
    if(c_list[i] %in% course_grades_psych_term_1[id,])
    {
      ct <- ct+1
    }
  }
  count_courses$course[i] <- c_list[i]
  count_courses$count[i] <- ct
  ct<- 0
}
count_courses$V2 <- c_list
count_courses <- count_courses[,-c(1,3)]
View(count_courses)

#-- Transition matrix of counts from Term 1 to Term 2
#-- counts number of students that take course j (from 1:180 courses) given that they have taken course i (from 1:180) in term 1

ct<-0
tm_12<- matrix(NA,nrow = length(c_list), ncol = length(c_list))

for(i in 22:length(c_list))
{
  for(j in 1:length(c_list))
  {
    for(id in 1:nrow(course_grades_psych_term_1))
    {
        if(c_list[i] %in% course_grades_psych_term_1[id,] && c_list[j] %in% course_grades_psych_term_2[id,])
        {
          ct <- ct+1
        }
    }
    tm_12[i,j] <- ct
    ct<- 0
  }
} 

colnames(tm_12) <- as.character(c_list)
rownames(tm_12) <- as.character(c_list)
#-- converting counts to proportions / dividing by number of students that have taken specified course in term 1


proportions_tm_12 <- matrix(NA, nrow=180, ncol=180)
for(i in 1:180)
{
  proportions_tm_12[i,] <- tm_12[i,]/count_courses$count[i]
}

colnames(proportions_tm_12) <- as.character(c_list)
rownames(proportions_tm_12) <- as.character(c_list)


#-- final transition matrix from term 1 to term 2

View(tm_12)
transition_matrix_12<- as.data.frame(tm_12)
write.csv(transition_matrix_12, "tm_12.csv")

