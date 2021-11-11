suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(xlsx))

PI_folder <- './Results/PI_final'
V_folder <- './Results/Vulnerability'


# 01_Combine Pptential Impact tibble --------------------------------------

PI_all_df <- tibble()
for (res_xlsx in list.files(PI_folder, full.names = T)) {
    workbook <- loadWorkbook(res_xlsx)
    sheets_list <- names(getSheets(workbook))
    
    single_file <- tibble()
    for (sheet in sheets_list) {
        
        loaded <- read.xlsx(file = res_xlsx, 
                            sheetName = sheet) %>% 
            select(ISO, ScoreAvg, Catogary)
        single_file <- bind_rows(single_file, loaded)
        
    }
    
    PI_all_df <- bind_rows(PI_all_df, single_file)
}

PI_all_df <- PI_all_df %>% 
    mutate(Catogary = paste0('PI_', Catogary))


# 02_Combine Vulnerability tibble -----------------------------------------

V_all_df <- tibble()
for (res_xlsx in list.files(V_folder, full.names = T)) {
    workbook <- loadWorkbook(res_xlsx)
    sheets_list <- names(getSheets(workbook))
    
    single_file <- tibble()
    for (sheet in sheets_list) {
        
        loaded <- read.xlsx(file = res_xlsx, 
                            sheetName = sheet) %>% 
            select(ISO, vul, Catogary)
        single_file <- bind_rows(single_file, loaded)
        
    }
    
    V_all_df <- bind_rows(V_all_df, single_file)
}

V_all_df <- V_all_df %>% 
    mutate(Catogary = paste0('V_', Catogary)) %>% 
    rename(ScoreAvg = vul)

# 03_Combine Vulnerbility and Potential Impact / Rename columns -----------
# rename rules
col_rename <- function(Catogary){
    
    new_name <- case_when(Catogary == 'PI_Q_FW_capture' ~'PIQIC',
                          Catogary == 'PI_Q_FW_culture' ~'PIQIA',
                          Catogary == 'PI_Q_M_capture' ~'PIQMC',
                          Catogary == 'PI_Q_M_culture' ~'PIQMA',
                          Catogary == 'PI_S_FW_capture' ~'PISIC',
                          Catogary == 'PI_S_FW_culture' ~'PISIA',
                          Catogary == 'PI_S_M_capture' ~'PISMC',
                          Catogary == 'PI_S_M_culture' ~'PISMA',
                          Catogary == 'V_Q_FW_capture' ~'VIC',
                          Catogary == 'V_Q_FW_culture' ~'VIA',
                          Catogary == 'V_Q_M_capture' ~'VMC',
                          Catogary == 'V_Q_M_culture' ~'VMA',
                          Catogary == 'V_S_FW_capture' ~'SVIC',
                          Catogary == 'V_S_FW_culture' ~'SVIA',
                          Catogary == 'V_S_M_capture' ~'SVMC',
                          Catogary == 'V_S_M_culture' ~'SVMA')
    
    return(new_name)
    
}




Viz_df_long <- bind_rows(PI_all_df, V_all_df) %>% 
    mutate(var = col_rename(Catogary)) %>% 
    select(-Catogary)

Viz_df_wide <- Viz_df_long %>% 
    pivot_wider(id_cols = ISO, 
                names_from = var, 
                values_from = ScoreAvg) 


# Capacity data -----------------------------------------------------------

capacity_df <- read_csv('./Results/model_input/capacity.csv',
                        show_col_types = FALSE) %>%
    rename(Capacity = AVG)

Viz_df_wide <- Viz_df_wide %>% 
    inner_join(capacity_df, by = 'ISO')

# ISO Information ---------------------------------------------------------
iso_info <- read_csv('./Data/02_ISO_information.csv', 
                     show_col_types = FALSE)

Viz_df_wide <- Viz_df_wide %>% 
    left_join(iso_info, by = 'ISO')

# Saving results ----------------------------------------------------------

Viz_df_wide %>% 
    write_csv('./Results/data_viz/fig_viz.csv')


