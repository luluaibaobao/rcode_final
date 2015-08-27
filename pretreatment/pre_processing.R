dir.create("C:\\data\\201504")
Apr <- list.files("C:\\data\\201504fut")
Header <- read.csv("C:\\data\\future_price_header.csv",sep = "\t")
for(i in 1:length(Apr))
{
  Filename <- paste("C:\\data\\201504fut",Apr[i],sep = "\\")
  Data <- read.table(Filename,sep = "\t")
  names(Data) <- names(Header)
  temp <- strsplit(Filename,"fut")
  temp <- temp[[1]]
  temp <- paste(temp[1],temp[2],sep = "")
  save(Data,file = paste(strsplit(temp,".txt"),"binary",sep = "."))
}