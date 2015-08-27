myfilter <- function(rawPx,rawSig,smooth_type,periodPx,periodSig)
{
  library("TTR")
  Sig <- rawSig[-c(1:360)]
  Px <- rawPx[-c(1:360)]
  if(smooth_type == "ZLEMA")
  {
    Sig_filter <- ZLEMA(Sig,periodSig)
    Px_filter <-  ZLEMA(Px,periodPx)
    Sig_filter <- Sig_filter[-c(1:(max(periodPx,periodSig)-1))]
    Px_filter <- Px_filter[-c(1:(max(periodPx,periodSig)-1))]
  }
  if(smooth_type == "ALMA")
  {
    Sig_filter <- ALMA(Sig,periodSig)
    Px_filter <-  ALMA(Px,periodPx)
    if(periodPx < periodSig)
    {
      Px_filter <- Px_filter[-c(1:(periodSig - periodPx))]
    }
    if(periodPx > periodSig)
    {
      Sig_filter <- Sig_filter[-c(1:(periodPx - periodSig))]
    }
  }
  Sig <- Sig[-c(1:(max(periodPx,periodSig)-1))]
  Px <- Px[-c(1:(max(periodPx,periodSig)-1))]
  Px_sig <- data.frame(rawPx = Px, Px = Px_filter, rawSig = Sig, Sig = Sig_filter)
  save(Px_sig,file = "Px_sig.rdata")
  return(Px_sig)
}