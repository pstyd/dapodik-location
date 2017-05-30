#this to automate the process of automating the data extraction of sekolah kemdikbud

setwd("C:/Users/wb466151/Box Sync/Work/Urban Poverty/Deliverables/Analysis/Code")

#get the province list
province_list <- read.csv("../Extracted Data/kemdikbud_province_list.csv")

#get the relevant source package
source("schoolExtractor.R")

#revising the missing 0
for (i in 1:dim(province_list)[1]){
  if(nchar(province_list$province_code[i])<6){
    province_list$province_code[i] <- paste("0",province_list$province_code[i],sep="")
  }
  else {
    #do nothing
  }
}

#automatingn the extraction #SD
#it seems the map cannot open for Jawa Barat, Jawa Tengah, and Jawa Timur SD
for (i in 1:dim(province_list)[1]) {
  schoolExtractor(province_list$province_code[i],province_list$province_name[i],"SD","C:/Users/wb466151/Box Sync/Work/Urban Poverty/Deliverables/Analysis/Extracted Data/")
}

#extracting SMP
for (i in 1:(dim(province_list)[1])) {
  schoolExtractor(province_list$province_code[i],as.character(province_list$province_name[i]),"SMP","C:/Users/wb466151/Box Sync/Work/Urban Poverty/Deliverables/Analysis/Extracted Data/SMP/")
}

data_smp_indonesia <- data.frame()
#combine all SMP into one big file
for (i in 1:length(list.files("../Extracted Data/SMP"))){
  data_smp_indonesia <- rbind(data_smp_indonesia,data.frame(read.csv(paste("../Extracted Data/SMP/",list.files("../Extracted Data/SMP")[i],sep=""))))
}

#write the SMP data
write.csv(data_smp_indonesia,"../Extracted Data/SMP/data_smp_indonesia.csv",row.names=FALSE)


#extracting SMA
for (i in 1:(dim(province_list)[1])) {
  schoolExtractor(province_list$province_code[i],as.character(province_list$province_name[i]),"SMA","C:/Users/wb466151/Box Sync/Work/Urban Poverty/Deliverables/Analysis/Extracted Data/SMA/")
}

data_sma_indonesia <- data.frame()
#combine all SMP into one big file
for (i in 1:length(list.files("../Extracted Data/SMA"))){
  data_sma_indonesia <- rbind(data_sma_indonesia,data.frame(read.csv(paste("../Extracted Data/SMA/",list.files("../Extracted Data/SMA")[i],sep=""))))
}

#write the SMA Data
write.csv(data_sma_indonesia,"../Extracted Data/SMA/data_sma_indonesia.csv",row.names=FALSE)

#extracting SMK
for (i in 1:(dim(province_list)[1])) {
  schoolExtractor(province_list$province_code[i],as.character(province_list$province_name[i]),"SMK","C:/Users/wb466151/Box Sync/Work/Urban Poverty/Deliverables/Analysis/Extracted Data/SMK/")
}

data_smk_indonesia <- data.frame()
#combine all SMK into one big file
for (i in 1:length(list.files("../Extracted Data/SMK"))){
  data_smk_indonesia <- rbind(data_smk_indonesia,data.frame(read.csv(paste("../Extracted Data/SMK/",list.files("../Extracted Data/SMK")[i],sep=""))))
}

#write the SMK data
write.csv(data_smk_indonesia,"../Extracted Data/SMK/data_smk_indonesia.csv",row.names=FALSE)

#extracting SLB
for (i in 1:(dim(province_list)[1])) {
  schoolExtractor(province_list$province_code[i],as.character(province_list$province_name[i]),"SLB","C:/Users/wb466151/Box Sync/Work/Urban Poverty/Deliverables/Analysis/Extracted Data/SLB/")
}

data_slb_indonesia <- data.frame()
#combine all SLB into one big file
for (i in 1:length(list.files("../Extracted Data/SLB"))){
  data_slb_indonesia <- rbind(data_slb_indonesia,data.frame(read.csv(paste("../Extracted Data/SLB/",list.files("../Extracted Data/SLB")[i],sep=""))))
}

#write the SLB data
write.csv(data_slb_indonesia,"../Extracted Data/SLB/data_slb_indonesia.csv",row.names=FALSE)

