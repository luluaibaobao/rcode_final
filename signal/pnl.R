pnl <- function(pos,rawPx)
{
  n <- sum(abs(diff(pos)))
  ret <- head(pos,-1) * diff(rawPx)
  pnl <- sum(ret) - 0.1*n
  
  print(n)
  return(pnl)
}