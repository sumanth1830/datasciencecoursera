pollutantmean <- function(directory, pollutant, id = 1:332){
        path <- file.path(directory)
        files_list <- list.files(directory)
         
        first <- 0
        for( i in id ){
            ##print(i)
            if(first != 1) {
                data <- read.csv(paste(path,"/",files_list[i],sep = ""))
                first <- 1
            } else {
                data <- rbind(data, read.csv(paste(path,"/",files_list[i],sep = ""))) 
            }
             
        }
        
        data <- na.omit(data)
        mean_val <- mean(data[[pollutant]])
        mean_val
}


complete <- function(directory, id = 1:332){
        path <- file.path(directory)
        files_list <- list.files(directory)
        
        result_df <- data.frame(id = integer(),
                                nobs = integer(),
                                stringsAsFactors=FALSE)
        for( i in id ){
          ##print(i)
          data <- read.csv(paste(path,"/",files_list[i],sep = ""))
          result_df <- rbind(result_df, data.frame(id = i, nobs = sum(complete.cases(data))))
        }
        result_df
}


corr <- function(directory, threshold = 0){
        path <- file.path(directory)
        files_list <- list.files(directory)
        corr_data <- c()
        
        for( i in files_list){
          
          data <- read.csv(paste(path,"/",i,sep = ""))
          if ( sum(complete.cases(data)) > threshold){
            data <- na.omit(data) 
            #print(i)
            #print(class(data$sulfate))
            corr_data <- c(corr_data, cor(data$sulfate, data$nitrate))
          }
        }
        corr_data
}
  
  
  
  
  
  
  
  
  