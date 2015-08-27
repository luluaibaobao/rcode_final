target <- function(rawPx,rawSig,smooth_type,periodPx,periodSig,kappaPx,kappaSig)
{
  Px_sig <- myfilter(rawPx,rawSig,smooth_type,periodPx,periodSig)
  Px_turn <- find_turns(Px_sig$Px,kappaPx)
  Sig_turn <- find_turns(Px_sig$Sig,kappaSig)
  Px_target <- vector()
  Sig_target <- vector()
  Px_target[1:Px_turn$turnLoc[1]] <- 0
  Sig_target[1:Sig_turn$turnLoc[1]] <- 0
  for(i in 1:(length(Px_turn$turnLoc)-1))
  {
    Px_target[Px_turn$turnLoc[i]:Px_turn$turnLoc[i+1]] <- Px_turn$turnState[i]
  }
  for(i in 1:(length(Sig_turn$turnLoc)-1))
  {
    Sig_target[Sig_turn$turnLoc[i]:Sig_turn$turnLoc[i+1]] <- Sig_turn$turnState[i]
  }
  Px_target[Px_turn$turnLoc[length(Px_turn$turnLoc)]:length(Px_sig$Px)] <- Px_turn$turnState[length(Px_turn$turnLoc)]
  Sig_target[Sig_turn$turnLoc[length(Sig_turn$turnLoc)]:length(Px_sig$Sig)] <- Sig_turn$turnState[length(Sig_turn$turnLoc)]
  tar <- list()
  tar$Px <- Px_target
  tar$Sig <- Sig_target
#     plot(Px_sig$rawPx,type = "l")
#     for(i in 1:length(Px_target))
#     {
#       if(Sig_target[i] == -1)
#       {
#         points(i,Px_sig$rawPx[i],pch = 46,col = "green",cex = 4)
#         next
#       }
#       if(Sig_target[i] == 1)
#       {
#         points(i,Px_sig$rawPx[i],pch = 46,col = "red",cex = 4)
#       }
#     }
  return(tar)
}