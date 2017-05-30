#put school data extractor into a reusable function

schoolExtractor <- function(provinceCode,provinceName, schoolLevel, saveFolder) {
  library(rvest)
  library(stringr)
  root_url <- "http://sekolah.data.kemdikbud.go.id/index.php/cpetasebaran/index/"
  url <- paste(root_url,as.character(provinceCode),"/",schoolLevel,sep="")
  
  #processed it as a text files
  sebaran_sekolah <- readLines(url)
  
  #find where the list of coordinates, school id, school name, and alamat
  #school location
  unprocessed_coordinate = sebaran_sekolah[grep("L.marker",sebaran_sekolah)]
  unprocessed_coordinate <- unprocessed_coordinate[2:(length(unprocessed_coordinate))]
  
  #school id
  unprocessed_schoolid <- sebaran_sekolah[grep("NPSN",sebaran_sekolah)]
  
  #school name
  unprocessed_schoolname <- sebaran_sekolah[grep("index.php/chome/profil",sebaran_sekolah)]
  
  #school address
  unprocessed_schooladdress <- sebaran_sekolah[grep("Alamat",sebaran_sekolah)]
  
  #cleaning the data
  #find the position of the coordinate
  generateCoordinate <- function(coordinate) {
    position <- gregexpr("[-]*[0-9]*.[0-9]*,[-]*[0-9]*.[0-9]*",coordinate)
    #subset the coordinate
    clean_position <- substring(coordinate,position[[1]][1],position[[1]][2]-1)
    return(clean_position)
  }
  
  coordinateData <- lapply(unprocessed_coordinate, generateCoordinate)
  clean_coordinateData <- array()
  lat <- array()
  long <- array()
  
  for (i in 1:length(coordinateData)) {
    clean_coordinateData[i] <- coordinateData[[i]][1]
    lat[i] <- strsplit(clean_coordinateData[i],",")[[1]][1]
    long[i] <- strsplit(clean_coordinateData[i],",")[[1]][2]
  }
  
  clean_schoolCoordinate <- data.frame(lat,long)
  
  #clean school ID
  clean_schoolid <- gsub(": ","",str_extract(unprocessed_schoolid,": [0-9]*"))
  
  #clean school name
  clean_schoolName <- array()
  for (i in 1:length(unprocessed_schoolname)) {
    name_position <- gregexpr("\"_blank\">",unprocessed_schoolname[i])[[1]][1]
    processed_name <- substring(unprocessed_schoolname[i],name_position,nchar(unprocessed_schoolname[i]))
    processed_name2 <- gsub("\"_blank\">","",processed_name)
    processed_name3 <- gsub("</a></li>'\\+","",processed_name2)
    clean_schoolName[i] <- processed_name3
  }
  
  #clean school address
  clean_schoolAddress <- array()
  for (i in 1:length(unprocessed_schooladdress)) {
    name_position <- gregexpr(" : ",unprocessed_schooladdress[i])[[1]][1]
    processed_address <- substring(unprocessed_schooladdress[i],name_position,nchar(unprocessed_schooladdress[i]))
    processed_address2 <- gsub(" : ","",processed_address) #removing colon
    processed_address3 <- gsub("</li>'\\+","",processed_address2) #removing tags
    clean_schoolAddress[i] <- trimws(processed_address3) #removing whitespaces
  }
  
  #adding new variables
  province <- array()
  province[1:length(clean_schoolName)] <- provinceName
  
  school_level <- array()
  school_level[1:length(clean_schoolName)] <- schoolLevel
  
  #combining all data
  schoolData <- data.frame(clean_schoolid,clean_schoolName,clean_schoolAddress,province, school_level, clean_schoolCoordinate)
  
  #rename the variables
  names(schoolData)[1] <- "schoolId"
  names(schoolData)[2] <- "schoolName"
  names(schoolData)[3] <- "schoolAddress"
  
  
  #final dataset and write it into a CSV file
  targetedFolder = paste(saveFolder,provinceCode,"_",provinceName,"_",schoolLevel,".csv",sep="")
  write.csv(schoolData, targetedFolder,row.names=FALSE)
  
}

  
  

