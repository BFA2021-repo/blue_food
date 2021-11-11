suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(xlsx))

if (!dir.exists('./Results/data_viz/')) {
    dir.create('./Results/data_viz/')
}

# Exposure data for viz ---------------------------------------------------
PI_output <- tibble() # Empty tibble for final EI score output

# Combine quantity ei score -----------------------------------------------

q_score_path <- './Results/EI_final/[Q]scoreFinal.xlsx'
q_score <- loadWorkbook(q_score_path)
sheets <- names(getSheets(q_score))

for (sheet in sheets) {
    
    book <- read.xlsx(q_score_path, sheetName = sheet)
    
    book_part <- book %>%  
        select(ISO, ScoreAvg, Catogary) 
    PI_output <- PI_output %>% 
        bind_rows(book_part)
    
}

write.xlsx(x = PI_output,
           file = './Results/data_viz/ei_viz.xlsx', 
           sheetName = 'Quantity', 
           append = T)

# Combine safety ei score -------------------------------------------------
PI_output <- tibble()

s_score_path <- './Results/EI_final/[S]scoreFinal.xlsx'
s_score <- loadWorkbook(s_score_path)
sheets <- names(getSheets(s_score))

for (sheet in sheets) {
    
    book <- read.xlsx(s_score_path, sheetName = sheet)
    
    book_part <- book %>%  
        select(ISO, ScoreAvg, Catogary) 
    PI_output <- PI_output %>% 
        bind_rows(book_part)
    
}

write.xlsx(x = PI_output,
           file = './Results/data_viz/ei_viz.xlsx', 
           sheetName = 'Safety', 
           append = T)



#  Potential Impact data for viz ------------------------------------------

EI_output <- tibble() # Empty tibble for final PI score output

# Combine quantity pi score -----------------------------------------------

q_score_path <- './Results/PI_final/[Q]scoreFinal.xlsx'
q_score <- loadWorkbook(q_score_path)
sheets <- names(getSheets(q_score))

for (sheet in sheets) {
    
    book <- read.xlsx(q_score_path, sheetName = sheet)
    
    book_part <- book %>%  
        select(ISO, ScoreAvg, Catogary) 
    EI_output <- EI_output %>% 
        bind_rows(book_part)
    
}

write.xlsx(x = EI_output,
           file = './Results/data_viz/pi_viz.xlsx', 
           sheetName = 'Quantity', 
           append = T)

# Combine safety ei score -------------------------------------------------

EI_output <- tibble()
s_score_path <- './Results/PI_final/[S]scoreFinal.xlsx'
s_score <- loadWorkbook(s_score_path)
sheets <- names(getSheets(s_score))

for (sheet in sheets) {
    
    book <- read.xlsx(s_score_path, sheetName = sheet)
    
    book_part <- book %>%  
        select(ISO, ScoreAvg, Catogary) 
    EI_output <- EI_output %>% 
        bind_rows(book_part)
    
}

write.xlsx(x = EI_output,
           file = './Results/data_viz/pi_viz.xlsx', 
           sheetName = 'Safety', 
           append = T)


# combine vulnerability score ---------------------------------------------

VUL_output <- tibble() # Empty tibble for final PI score output

# Combine quantity vulnerability score -----------------------------------------------

q_score_path <- './Results/Vulnerability/Q_vulnerability.xlsx'
q_score <- loadWorkbook(q_score_path)
sheets <- names(getSheets(q_score))

for (sheet in sheets) {
    
    book <- read.xlsx(q_score_path, sheetName = sheet) %>% 
        select(ISO, vul, Catogary, Continent)

    VUL_output <- VUL_output %>% 
        bind_rows(book)
    
}

write.xlsx(x = VUL_output,
           file = './Results/data_viz/vul_viz.xlsx', 
           sheetName = 'Quantity', 
           append = T)

# Combine safety vulnerability score -------------------------------------------------
VUL_output <- tibble()
s_score_path <- './Results/Vulnerability/S_vulnerability.xlsx'
s_score <- loadWorkbook(s_score_path)
sheets <- names(getSheets(s_score))

for (sheet in sheets) {
    
    book <- read.xlsx(s_score_path, sheetName = sheet) %>% 
        select(ISO, vul, Catogary, Continent)
    
    VUL_output <- VUL_output %>% 
        bind_rows(book)
    
}

write.xlsx(x = VUL_output,
           file = './Results/data_viz/vul_viz.xlsx', 
           sheetName = 'Safety', 
           append = T)
