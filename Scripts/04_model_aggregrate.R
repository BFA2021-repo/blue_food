# This scripts works for aggregate the PI model results and output for analysis

librarier <- function(package){
    
    suppressPackageStartupMessages(library(package,
                                           character.only = T,
                                           logical.return = T))
    
}

packages <- c('tidyverse', 'future', 'xlsx', 'countrycode')
sapply(packages, librarier)
index_folder <- './Results/model_input/index/'

dir.create('./Results/EI_final/', recursive = T)
dir.create('./Results/PI_final/', recursive = T)
# Exposure Impact Model ---------------------------------------------------

# 01 Aggregrate quantity data ---------------------------------------------

results <- setdiff(list.files('./Results/modeloutput_raw/EI/', pattern = 'Q_'),
                   list.dirs('./results', recursive=F, full.names = F))

for (type in results) {
    
    typeName <- str_split(type, pattern = '\\.', simplify = T)[,1]
    resultFilePath <- paste0('./Results/modeloutput_raw/EI/', type)
    indexPath <- paste0(index_folder, typeName, '.csv')
    typeName_real <- str_split(typeName, '\\]', simplify = T)[, 1]
    
    indexRead <- read_csv(indexPath, show_col_types = F)
    resultRead <- read_rds(resultFilePath)
    
    resultProcess <- tibble(
        ScoreAvg = apply(resultRead, 1, mean),
        ScoreStd = apply(resultRead, 1, sd),
        Score_floor = apply(resultRead, 1, quantile, .025),
        Score_ceil = apply(resultRead, 1, quantile, .975),
        Catogary = typeName_real
    )
    
    resultFinish <- indexRead %>% 
        bind_cols(resultProcess) %>% 
        filter((ScoreAvg != 0) & (ScoreStd != 0)) %>% 
        mutate(Continent = countrycode(ISO, 
                                       origin = 'iso3c',
                                       destination = 'continent'))
    write.xlsx(as.data.frame(resultFinish), 
               './Results/EI_final/[Q]scoreFinal.xlsx',
               sheetName = typeName_real,
               append = T,
               row.names = F)
}

# 02 Aggregate safety data ---------------------------------------------

results <- setdiff(list.files('./Results/modeloutput_raw/EI/', pattern = 'S_'),
                   list.dirs('./results', recursive=F, full.names = F))

for (type in results) {
    
    typeName <- str_split(type, pattern = '\\.', simplify = T)[,1]
    resultFilePath <- paste0('./Results/modeloutput_raw/EI/', type)
    indexPath <- paste0(index_folder, typeName, '.csv')
    typeName_real <- str_split(typeName, '\\]', simplify = T)[, 1]
    
    indexRead <- read_csv(indexPath, show_col_types = F)
    resultRead <- read_rds(resultFilePath)
    
    resultProcess <- tibble(
        ScoreAvg = apply(resultRead, 1, mean),
        ScoreStd = apply(resultRead, 1, sd),
        Score_floor = apply(resultRead, 1, quantile, .025),
        Score_ceil = apply(resultRead, 1, quantile, .975),
        Catogary = typeName_real
    )
    
    
    resultFinish <- indexRead %>% 
        bind_cols(resultProcess) %>% 
        filter((ScoreAvg != 0) & (ScoreStd != 0)) %>% 
        mutate(Continent = countrycode(ISO, 
                                       origin = 'iso3c',
                                       destination = 'continent'))
    write.xlsx(as.data.frame(resultFinish), 
               './Results/EI_final/[S]scoreFinal.xlsx',
               sheetName = typeName_real,
               append = T,
               row.names = F)
}

# ---------------------------------------------------------------------------- #

# Potential Impact Model --------------------------------------------------

# 01 Aggregrate quantity data ---------------------------------------------

results <- setdiff(list.files('./Results/modeloutput_raw/PI/', pattern = 'Q_'),
                   list.dirs('./results', recursive=F, full.names = F))

for (type in results) {
    
    typeName <- str_split(type, pattern = '\\.', simplify = T)[,1]
    resultFilePath <- paste0('./Results/modeloutput_raw/PI/', type)
    indexPath <- paste0(index_folder, typeName, '.csv')
    typeName_real <- str_split(typeName, '\\]', simplify = T)[, 1]
    
    indexRead <- read_csv(indexPath, show_col_types = F)
    resultRead <- read_rds(resultFilePath)
    
    resultProcess <- tibble(
        ScoreAvg = apply(resultRead, 1, mean),
        ScoreStd = apply(resultRead, 1, sd),
        Score_floor = apply(resultRead, 1, quantile, .025),
        Score_ceil = apply(resultRead, 1, quantile, .975),
        Catogary = typeName_real
    )
    
    resultFinish <- indexRead %>% 
        bind_cols(resultProcess) %>% 
        filter((ScoreAvg != 0) & (ScoreStd != 0)) %>% 
        mutate(Continent = countrycode(ISO, 
                                       origin = 'iso3c',
                                       destination = 'continent'))
    write.xlsx(as.data.frame(resultFinish), 
               './Results/PI_final/[Q]scoreFinal.xlsx',
               sheetName = typeName_real,
               append = T,
               row.names = F)
}

# 02 Aggregate safety data ---------------------------------------------

results <- setdiff(list.files('./Results/modeloutput_raw/PI/', pattern = 'S_'),
                   list.dirs('./results', recursive=F, full.names = F))

for (type in results) {
    
    typeName <- str_split(type, pattern = '\\.', simplify = T)[,1]
    resultFilePath <- paste0('./Results/modeloutput_raw/PI/', type)
    indexPath <- paste0(index_folder, typeName, '.csv')
    typeName_real <- str_split(typeName, '\\]', simplify = T)[, 1]
    
    indexRead <- read_csv(indexPath, show_col_types = F)
    resultRead <- read_rds(resultFilePath)
    
    resultProcess <- tibble(
        ScoreAvg = apply(resultRead, 1, mean),
        ScoreStd = apply(resultRead, 1, sd),
        Score_floor = apply(resultRead, 1, quantile, .025),
        Score_ceil = apply(resultRead, 1, quantile, .975),
        Catogary = typeName_real
    )
    
    resultFinish <- indexRead %>% 
        bind_cols(resultProcess) %>% 
        filter((ScoreAvg != 0) & (ScoreStd != 0)) %>% 
        mutate(Continent = countrycode(ISO, 
                                       origin = 'iso3c',
                                       destination = 'continent'))
    write.xlsx(as.data.frame(resultFinish), 
               './Results/PI_final/[S]scoreFinal.xlsx',
               sheetName = typeName_real,
               append = T,
               row.names = F)
}

