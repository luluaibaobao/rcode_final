pos <- function(rawPx,rawSig,smooth_type,periodPx,periodSig,kappaPx,kappaSig)
{
  Px_sig <- myfilter(rawPx,rawSig,smooth_type,periodPx,periodSig)
 
  Sig_turn <- find_turns(Px_sig$Sig,kappaSig)
  Sig_target <- vector()

  Sig_target[1:Sig_turn$turnLoc[1]] <- 0
  
  for(i in 1:(length(Sig_turn$turnLoc)-1))
  {
    Sig_target[Sig_turn$turnLoc[i]:Sig_turn$turnLoc[i+1]] <- Sig_turn$turnState[i]
  }

  Sig_target[Sig_turn$turnLoc[length(Sig_turn$turnLoc)]:length(Px_sig$Sig)] <- Sig_turn$turnState[length(Sig_turn$turnLoc)]

  
  act_pos <- vector()
  loc <- 1
  for(i in 1 : length(Sig_target))
  {
    if(!is.na(match(i,Sig_turn$turnLoc)))
    {
      loc <- Sig_turn[match(i,Sig_turn$turnLoc),]$swingLoc
    }
  ¡¡if(Sig_target[i] > 0) {
      if(Px_sig$Px[i] - Px_sig$Px[loc] > kappaPx) {
          act_pos[i] <- Sig_target[i]
      }else {
          act_pos[i] <- act_pos[i-1]
      }
    } else if(Sig_target[i] < 0) {
      if(Px_sig$Px[i] - Px_sig$Px[loc] < -kappaPx) {
          act_pos[i] <- Sig_target[i]
      }else {
          act_pos[i] <- act_pos[i-1]
      }
    } else {
      act_pos[i] = 0
    }
  }
  
  
  library("plotrix")
  x <- c(1:length(Px_sig$rawSig))
  twoord.stackplot(x,x,Px_sig$Sig,cbind(Px_sig$rawPx,Px_sig$Px),ltype = "l",rtype = "l",rcol = c("black","brown"),lcol = "blue" )
  #plot(Px_sig$rawPx,type = "l")
  for(i in 2:length(act_pos))
  {
    if(act_pos[i] == -1)
    {
      points(i,Px_sig$rawPx[i],pch = 46,col = "green",cex = 4)
      if(act_pos[i-1] >=0)
      {
        abline(v = i,col = "green")
      }
      next
    }
    if(act_pos[i] == 1)
    {
      points(i,Px_sig$rawPx[i],pch = 46,col = "red",cex = 4)
      if(act_pos[i-1] <= 0)
      {
        abline(v = i,col = "red")
      }
    }
  }
  print(pnl(act_pos,Px_sig$rawPx))
  write_to_csv(act_pos,fut)
  return(act_pos)
}