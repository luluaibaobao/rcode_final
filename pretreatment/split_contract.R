April <- list.files("C:\\data\\201504")
for(i in 1:length(April))
{
  Filename <- paste("C:\\data\\201504",April[i],sep = "\\")
  load(Filename)
  Contract_name <- unique(Data$CONTRACTID)
  for(j in 1:length(Contract_name))
  {
    future_data <- Data[Data$CONTRACTID == Contract_name[j],]
    future_data <- data.frame(TDATE = future_data$TDATE,TTIME = future_data$TTIME,UPDATEMILLISEC = future_data$UPDATEMILLISEC,
                                CONTRACTID = future_data$CONTRACTID,LASTPX = future_data$LASTPX,HIGHPX = future_data$HIGHPX,
                                LOWPX = future_data$LOWPX,TQ = future_data$TQ,TM = future_data$TM,INITOPENINTS = future_data$INITOPENINTS,
                                OPENINTS = future_data$OPENINTS,S1 = future_data$S1,B1 = future_data$B1,OPENPX = future_data$OPENPX)
    if(!dir.exists(paste("C:\\data\\",Contract_name[j],sep = "")))
      dir.create(paste("C:\\data\\",Contract_name[j],sep = ""))
    save(future_data,file = paste(paste("C:\\data\\",Contract_name[j],sep = ""),April[i],sep = "\\"))
  }
}