
librarier <- function(package){

    suppressPackageStartupMessages(library(package,
                                           character.only = T,
                                           logical.return = T))

}

packages <- c('tidyverse', 'future', 'xlsx', 'countrycode')
sapply(packages, librarier)


# Exposure Impact Calculation ---------------------------------------------
ei_culculation <- function(var_path, ei_weight_path, type, loop, seed) {
    
    varEnv <- read_csv(var_path, show_col_types = F)
    varWei <- read_csv(ei_weight_path, show_col_types = F)
    
    weights <- varWei %>%
        select(-Stressor) %>%
        pivot_longer(-Var,
                     names_to = 'Cat',
                     values_to = 'Weight') %>%
        filter(Cat == type)
    
    countrylist <- unique(varEnv$ISO)
    
    finalMatrix <- matrix(nrow = length(countrylist),
                          ncol = loop)
    
    set.seed(seed)
    pb <- txtProgressBar(min = 0,
                         max = length(countrylist) * loop,
                         style = 3)
    k = 0
    for (i in 1:length(countrylist)) {
        
        country = countrylist[i]
        countryPara <- varEnv %>%
            filter(ISO == country) %>%
            filter((avg != 0))
        
        scoreVec <- c()
        for (j in seq(1, loop, 1)) {
            
            paraList <- tibble()
            for (variable in unique(countryPara$Var)) {
                
                var_para <- countryPara %>% filter(Var == variable)
                
                para <- rnorm(1,
                              mean = var_para$avg,
                              sd = var_para$SD)
                
                paraOnce <- tibble(Var = variable,
                                   value = para)
                
                paraList <- paraList %>%
                    bind_rows(paraOnce)
                
            }
            
            if (length(paraList) != 0) {
                
                calTibble <- paraList %>%
                    left_join(weights, by = 'Var') %>%
                    mutate(score = value * Weight)
                
                score <- sum(calTibble$score)
                
            }else {
                
                score <- 0
                
            }
            
            scoreVec <- c(scoreVec,
                          score)
            k <- k+1
            setTxtProgressBar(pb, k)
        }
        
        finalMatrix[i, ] <- scoreVec
        
    }
    
    return(finalMatrix)
    
}


# Potential Impact Calculation ---------------------------------------------

# Potential Impact Computation
pi_culculation <- function(var_path, pi_weight_path, type, loop, seed) {

    varEnv <- read_csv(var_path, show_col_types = F)
    varWei <- read_csv(pi_weight_path, show_col_types = F)

    weights <- varWei %>%
        select(-Stressor) %>%
        pivot_longer(-Var,
                     names_to = 'Cat',
                     values_to = 'Weight') %>%
        filter(Cat == type)

    countrylist <- unique(varEnv$ISO)

    finalMatrix <- matrix(nrow = length(countrylist),
                          ncol = loop)

    set.seed(seed)
    pb <- txtProgressBar(min = 0,
                         max = length(countrylist) * loop,
                         style = 3)
    k = 0
    for (i in 1:length(countrylist)) {
        
        country <- countrylist[i]
        countryPara <- varEnv %>%
            filter(ISO == country) %>%
            filter((avg != 0))

        scoreVec <- c()
        for (j in seq(1, loop, 1)) {

            paraList <- tibble()
            for (variable in unique(countryPara$Var)) {

                var_para <- countryPara %>% filter(Var == variable)

                para <- rnorm(1,
                              mean = var_para$avg,
                              sd = var_para$SD)

                paraOnce <- tibble(Var = variable,
                                   value = para)

                paraList <- paraList %>%
                    bind_rows(paraOnce)

            }

            if (length(paraList) != 0) {

                calTibble <- paraList %>%
                    left_join(weights, by = 'Var') %>%
                    mutate(score = value * Weight)

                score <- sum(calTibble$score)

            }else {

                score <- 0

            }

            scoreVec <- c(scoreVec,
                          score)
            k <- k+1
            setTxtProgressBar(pb, k)
        }

        finalMatrix[i, ] <- scoreVec

    }

    return(finalMatrix)

}
