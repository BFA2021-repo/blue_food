suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(xlsx))

if (!dir.exists('./Results/Vulnerability/')) {
    dir.create('./Results/Vulnerability/', 
               recursive = T)
}

capacity_raw <- read.csv('./Results/model_input/capacity.csv') %>% 
    rename(Cap = AVG)

# quantity potential impact data
book_path <- './Results/PI_final/[Q]scoreFinal.xlsx'
book <- loadWorkbook(book_path) 
sheets <- names(getSheets(book))

for (sheet in sheets) {
    
    tab <- read.xlsx(book_path, sheetName = sheet)
    
    cap_df <- tab %>% 
        inner_join(capacity_raw, by = 'ISO') 
    
    cap_df <- cap_df %>% 
        mutate(vul = ScoreAvg *(1 - Cap)) %>% 
        select(ISO, vul, Catogary, Continent)
    write.xlsx(cap_df,
               './Results/Vulnerability/Q_vulnerability.xlsx',
               sheetName = sheet,
               append = T)
    
}

# safety potential impact data
book_path <- './Results/PI_final/[S]scoreFinal.xlsx'
book <- loadWorkbook(book_path) 
sheets <- names(getSheets(book))

for (sheet in sheets) {
    
    tab <- read.xlsx(book_path, sheetName = sheet)
    
    cap_df <- tab %>% 
        inner_join(capacity_raw, by = 'ISO') 
    
    cap_df <- cap_df %>% 
        mutate(vul = ScoreAvg *(1 - Cap)) %>% 
        select(ISO, vul, Catogary, Continent)
    write.xlsx(cap_df,
               './Results/Vulnerability/S_vulnerability.xlsx',
               sheetName = sheet,
               append = T)
    
}