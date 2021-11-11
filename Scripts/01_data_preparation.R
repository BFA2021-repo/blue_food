# Script for data preparation
# 1. split whole data table into 4 discrete part by class quantity (marine/inland)
#    and safety (marine/inland)
# 2. recalculate weight —— combine equal weighted results with expertise/literature
#    based results

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(xlsx))

input <- './Data/01_raw_data.xlsx'
sheets <- c('Q_marine', 'Q_inland', 'S_marine', 'S_inland')

save_path <- './Results/model_input/'

if (!dir.exists(save_path)) {
    dir.create(save_path)
} 

# 01_raw data split -------------------------------------------------------
# Raw data are divided into 4 separate csv files for convenience purpose

for (sheet in sheets) {
    
    df <- read.xlsx(input,
                    sheetName = sheet)
    
    empty <- tibble()
    for (i in seq(4, length(df)-1, by =2)) {
        
        varTibble <- df[, c(i, i+1)]
        var <- colnames(varTibble)[1]
        
        colnames(varTibble) <- c('avg', 'SD')
        varTibble$Var <- var
        
        empty <- bind_rows(empty, varTibble)
        
    }
    
    length(unique(empty$Var))
    
    empty$ISO <- rep(df$ISO, length(unique(empty$Var)))
    
    file_name <- paste0(save_path, sheet, '.csv')
    write_csv(empty,
              file_name)
}


# 02 Exposure Impact weight ------------------------------------------------
# For exposure weight, we output the exposure weight to separate csv file

e_weight <- read.xlsx(input, 
                      sheetName = 'E_weight') 
e_weight <- e_weight[1:28, 1:6] %>%  rename(Var = Indicator)

file_name <- paste0(save_path, 'ei_weight', '.csv')
write_csv(e_weight, file_name)

# 03 Potential Impact weight ------------------------------------------------
# Here we first multiply exposure weight and potential impact rank score 
# together for generating final used potential  impact weight in
# order to accelerate computation

pi_rank <- read.xlsx(input, 
                     sheetName = 'PI_weight') %>% 
    rename(Stressor = Stressors)

pi_rank_l <- pi_rank %>% 
    pivot_longer(-Stressor, names_to = 'Type',
                 values_to = 'Rank') 
e_weight_l <- e_weight %>% 
    pivot_longer(-c(Stressor, Var), names_to = 'Type', values_to = 'weight')

w <- e_weight_l %>% 
    left_join(pi_rank_l, 
              by = c('Stressor', 'Type')) %>% 
    mutate(Weight = weight * Rank) %>% 
    select(-weight, -Rank) %>% 
    pivot_wider(values_from = Weight, 
                names_from = Type)

file_name <- paste0(save_path, 'pi_weight', '.csv')
write_csv(w, file_name)

# 04 Create index of each data sets ----------------------------------------
# Here we first extract the index columns of the raw data, for further organize
# convenience

index_save_path <- paste0(save_path, 'index/')
if (!dir.exists(index_save_path)) {
    dir.create(index_save_path)
}

sheets <- c('Q_marine', 'Q_inland', 'S_marine', 'S_inland')
for (sheet in sheets) {
    
    df <- read.xlsx(input,
                    sheetName = sheet)
    
    index_df <- tibble(ISO = df[, 1])
    
    save_pattern <- str_replace(str_replace(sheet, 'marine', 'M'), 'inland', 'FW')
    save_pattern_name <- paste0(save_pattern, 
                                c('_capture', '_culture'))
    file_names <- paste0(index_save_path, save_pattern_name, '.csv')
    
    for (file_name in file_names) {
        write_csv(index_df,
                  file_name)
    }
    
}


# 05 Capacity index -------------------------------------------------------

capacity <- read.xlsx(input, 
                      sheetName = 'Capacity') 

file_name <- paste0(save_path, 'capacity', '.csv')
write_csv(capacity, file_name)



