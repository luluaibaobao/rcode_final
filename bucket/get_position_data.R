SUM_money_class("IF1505","20140417","20140514",5,1)
start <- "20150515"
end <- "20150619"
for(i in as.Date(start,"%Y%m%d"):as.Date(end,"%Y%m%d"))
{
  Date <- format(as.Date(i,"1970-01-01"),"%Y%m%d")
  Dir <- paste("C:\\data","IF1506",sep = "\\")
  Filename <- paste(paste(Dir,Date,sep = "\\"),"binary",sep = ".") 
  if(!file.exists(Filename))
  {
    next
  }
  temp <- Bucket_position_cum("IF1506","IF1505",Date,"20150417","20150514",300,5,1)
  print(Date)
}