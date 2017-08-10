#---------------------------------2. Psychology Data : append last term and last major declared------------------------

psychology_output <- read.csv("psychology_output1.csv", header = T, na.strings = c(""," ", NA, "NA"))
# Deleting null columns from psychology_output
psychology_output <- psychology_output[,colSums(is.na(psychology_output))< nrow(psychology_output)]
colnames(psychology_output)
# Renaming columns
colnames(psychology_output) <- c(colnames(psychology_output)[1:21], 't9','m9','t10','m10','t11','m11','t12','m12','t13','m13','t14','m14')

# Adding column of Last_term and Last_major
k<-ncol(psychology_output)
for(i in 1:nrow(psychology_output))
{
  while(is.na(psychology_output[i,k]))
  {
    k <- k-2
  }
  psychology_output$last_major[i] <- as.character(psychology_output[i,k])
  psychology_output$last_term[i] <- psychology_output[i,(k-1)]
  
  if(k > 11)
  {
    psychology_output$more_changes[i] <- 1
  }
  else
  {
    psychology_output$more_changes[i] <- 0
  }
  
  k <- ncol(psychology_output)-3
}

# Reordering columns
psychology_output <- psychology_output[,c(1:11,36,35,34)]

# Writing output to csv file
write.table(psychology_output, file="psychology_output.csv", sep = ",", row.names = FALSE)




