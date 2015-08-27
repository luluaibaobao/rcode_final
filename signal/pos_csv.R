write_to_csv <- function(act_pos,fut)
{
  pos_csv <- data.frame(Ticker = 0,LS = 0,EntryTdate = 0,EntryTtime = 0,EntryMs = 0,EntryPx = 0,ExitTdate = 0,ExitTtime = 0,ExitMs = 0,ExitPx = 0,EntryVol = 0,ExitVol = 0)
  index <- c((length(fut$tdate)-length(act_pos)+1) : length(fut$tdate))
  trade_times <- 1
  ticker <- as.character(fut$ticker[1])
  #names(pos_csv) <- c("Ticker","L/S","EntryTime","EntryPx","ExitTime","ExitPx","EntryVol","ExitVol")
  for(i in 2:length(act_pos))
  {
    if(act_pos[i] > act_pos[i-1])
    {
      pos_csv[trade_times,]$Ticker <- ticker
      pos_csv[trade_times,]$LS <- "Long"
      pos_csv[trade_times,]$EntryTdate <- fut$tdate[index[i]]
      pos_csv[trade_times,]$EntryTtime <- fut$ttime[index[i]]
      pos_csv[trade_times,]$EntryMs <- fut$ms[index[i]]
      pos_csv[trade_times,]$EntryPx <- fut$vwap[index[i]]
      pos_csv[trade_times,]$EntryVol <- 1
      pos_csv[trade_times,]$ExitVol <- 1
      if(act_pos[i-1] == -1)
      {
        pos_csv[trade_times-1,]$ExitTdate <- fut$tdate[index[i]]
        pos_csv[trade_times-1,]$ExitTtime <- fut$ttime[index[i]]
        pos_csv[trade_times-1,]$ExitMs <- fut$ms[index[i]]
        pos_csv[trade_times-1,]$ExitPx <- fut$vwap[index[i]]
      }
      trade_times <- trade_times + 1
    }
    if(act_pos[i] < act_pos[i-1])
    {
      pos_csv[trade_times,]$Ticker <- ticker
      pos_csv[trade_times,]$LS <- "Short"
      pos_csv[trade_times,]$EntryTdate <- fut$tdate[index[i]]
      pos_csv[trade_times,]$EntryTtime <- fut$ttime[index[i]]
      pos_csv[trade_times,]$EntryMs <- fut$ms[index[i]]
      pos_csv[trade_times,]$EntryPx <- fut$vwap[index[i]]
      pos_csv[trade_times,]$EntryVol <- 1
      pos_csv[trade_times,]$ExitVol <- 1
      if(act_pos[i-1] == 1)
      {
        pos_csv[trade_times-1,]$ExitTdate <- fut$tdate[index[i]]
        pos_csv[trade_times-1,]$ExitTtime <- fut$ttime[index[i]]
        pos_csv[trade_times-1,]$ExitMs <- fut$ms[index[i]]
        pos_csv[trade_times-1,]$ExitPx <- fut$vwap[index[i]]
      }
      trade_times <- trade_times + 1
    }
  }
  pos_csv[trade_times-1,]$ExitTdate <- fut$tdate[index[i]]
  pos_csv[trade_times-1,]$ExitTtime <- fut$ttime[index[i]]
  pos_csv[trade_times-1,]$ExitMs <- fut$ms[index[i]]
  pos_csv[trade_times-1,]$ExitPx <- fut$vwap[index[i]]
 # write.csv(x = pos_csv,file = paste(fut$tdate[1],"csv",sep = "."))
  write.csv(pos_csv, file = paste(fut$tdate[1],".csv",sep = ""),row.names = FALSE) 
  return(pos_csv)
}