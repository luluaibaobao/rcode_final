find_turns <- function(x,threshold)
{
  runmaxloc <- 1
  runminloc <- 1
  state <- 0
  swing_turn <- data.frame()
  for(i in 1 : length(x))
  {
    if(state <= 0)
    {
      if(x[i] < x[runminloc])
      {
        runminloc <- i
      }else
      {
        if(x[i] - x[runminloc] > threshold)
        {
          state <- 1
          runmaxloc <- runminloc
          swing_turn <- rbind(swing_turn,c(runminloc,1,i,1))
        }
      }
      next
    }
    if(state >= 0)
    {
      if(x[i] > x[runmaxloc])
      {
        runmaxloc <- i
      }else
      {
        if(x[i] - x[runmaxloc] < -threshold)
        {
          state <- -1
          runminloc <- runmaxloc
          swing_turn <- rbind(swing_turn,c(runmaxloc,-1,i,-1))
        }
      }
    }
  }
  names(swing_turn) <- c("swingLoc","swingState","turnLoc","turnState")
  plot_turns(swing_turn,x)
  return(swing_turn)
}
plot_turns <- function(turns,Sig)
{
  plot(Sig,type ="l")
  for(i in 1:length(turns$swingLoc))
  {
    if(turns$swingState[i] == -1)
      abline(v = turns$turnLoc[i],col = "green")
    if(turns$swingState[i] == 1)
      abline(v = turns$turnLoc[i],col = "red")
  }
}