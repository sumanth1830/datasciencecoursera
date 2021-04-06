best <- function(state_name, outcome_name){
      hosp_data <- read.csv("E:/R/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character",
                            na.strings = ("Not Available"))
      ##hosp_data <- na.omit(hosp_data)
      state_values <- unique(hosp_data["State"])
      ##print(colnames(hosp_data))
      
      ## Sorting values based on alphabetic order of hospital name
      hosp_data <- hosp_data[order(hosp_data["Hospital.Name"]), ]
      
      ## Converting outcome_name to lower case
      outcome_name <- tolower(outcome_name)
      
      ##State calue check
      if ( any(state_values == state_name) ){
            
            ## Subsetting hospital data of that state from whole country data
            hosp_state_data <- hosp_data[hosp_data$State == state_name, ]
            
            if ( outcome_name == "heart attack" ){
                hosp_index <- which.min(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
                hosp_name <- hosp_state_data$Hospital.Name[hosp_index]
            } else if ( outcome_name == "heart failure" ) {
                hosp_index <- which.min(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
                hosp_name <- hosp_state_data$Hospital.Name[hosp_index]
            } else if( outcome_name == "pneumonia" ){
                hosp_index <- which.min(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
                hosp_name <- hosp_state_data$Hospital.Name[hosp_index]
            } else {
                stop("Invalid Outcome")
            }
            
      } else {
            stop("Invalid State")
      }
      print(hosp_name)
}



rankhospital <- function(state_name, outcome_name, num = "best" ) {
      hosp_data <- read.csv("E:/R/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character",
                            na.strings = ("Not Available"))
      ##hosp_data[hosp_data == "<NA>"] <- NA
      ##hosp_data <- na.omit(hosp_data)
      state_values <- unique(hosp_data["State"])
      
      
      ## Converting outcome_name to lower case
      outcome_name <- tolower(outcome_name)
      
      
      
      
      if ( any(state_values == state_name) ){
        
            ## Subsetting hospital data of that state from whole country data
            hosp_state_data <- hosp_data[hosp_data$State == state_name, ]
            length_hosp_data <- nrow(hosp_state_data)
            ##print(head(hosp_state_data[,c(2,7,11)], 6))
            ##print(nrow(hosp_state_data))
            
            ## Converting num value to numeric
            if (num == "best") {
                  num <- as.numeric(1)
            } else if (num == "worst") {
                  num <- "worst"
            } else if (num > length_hosp_data){
                  return(NA)
            } else {
                  num <- as.numeric(num)
            }
            
        
            if ( outcome_name == "heart attack" ){
                  
                  hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
                  hosp_state_data <- hosp_state_data[, 1:11]
                  hosp_state_data <- na.omit(hosp_state_data)
                  
                  if (num == "worst") {
                      num <- nrow(hosp_state_data)
                  }
                  
                  hosp_data <- hosp_state_data[with(hosp_state_data, order(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, hosp_state_data$Hospital.Name)), ]
                  ##print(hosp_state_data[with(hosp_state_data,order(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, hosp_state_data$Hospital.Name)), ][, c(2,7,11)])
                  
                  hosp_data$rank <- rank(hosp_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, ties.method = "first")
                  hosp_index <- match(num, hosp_data$rank)
                  hosp_name <- hosp_data$Hospital.Name[hosp_index]
                  ##index <- which(colnames(hosp_data)== "rank")
                  ##print(hosp_data[, c(2,11,index)])
            
            } else if ( outcome_name == "heart failure" ) {
                  
                  hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
                  hosp_state_data <- hosp_state_data[, c(1:10,17)]
                  hosp_state_data <- na.omit(hosp_state_data)
                  
                  if (num == "worst") {
                      num <- nrow(hosp_state_data)
                  }
                  hosp_data <- hosp_state_data[order(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, hosp_state_data$Hospital.Name), ]
                  
                  hosp_data$rank <- rank(hosp_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, ties.method = "first")
                  hosp_index <- match(num, hosp_data$rank)
                  hosp_name <- hosp_data$Hospital.Name[hosp_index]
                  ##index <- which(colnames(hosp_data)== "rank")
                  ##print(hosp_data[, c(2,11,index)])
            
            } else if( outcome_name == "pneumonia" ){
                  
                  hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
                  hosp_state_data <- hosp_state_data[, c(1:10,23)]
                  hosp_state_data <- na.omit(hosp_state_data)
                  
                  if (num == "worst") {
                      num <- nrow(hosp_state_data)
                  }
                  hosp_data <- hosp_state_data[order(hosp_state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, hosp_state_data$Hospital.Name), ]
                  
                  hosp_data$rank <- rank(hosp_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, ties.method = "first")
                  hosp_index <- match(num, hosp_data$rank)
                  hosp_name <- hosp_data$Hospital.Name[hosp_index]
                  ##index <- which(colnames(hosp_data)== "rank")
                  ##print(hosp_data[, c(2,11,index)])
          
            } else {
                  stop("Invalid Outcome")
            }
            
      } else {
            stop("Invalid State")
      }
      
      
      print(hosp_name)
}



rankall <- function ( outcome_name, rank_num = "best" ){
      
    hosp_data <- read.csv("E:/R/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character",
                          na.strings = ("Not Available"))
    hosp_data <- na.omit(hosp_data)
    state_values <- unique(hosp_data["State"])
    
    
    ## Converting outcome_name to lower case
    outcome_name <- tolower(outcome_name)
    
    statewise_hosp <- data.frame(Hospital.Name = character(), State = character())
    
    for ( state in unique(hosp_data$State) ){
        
          #print(state)
          #print("Hello")
          if ( outcome_name == "heart attack" || outcome_name == "heart failure" || outcome_name == "pneumonia"){
                hosp_name <- rankhospital(state_name = state, outcome_name = outcome_name, num = rank_num)
                statewise_hosp[nrow(statewise_hosp) + 1, ] <- c(hosp_name, state)
          } else {
                stop("Invalid Outcome")
          }
          
    }
    statewise_hosp  
}



