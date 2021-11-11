suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggthemes))
suppressPackageStartupMessages(library(xlsx))
suppressPackageStartupMessages(library(stringr))

# 01 Fig S9 ----------------------------------------------------------------
workbook <- loadWorkbook('./Results/EI_final/[Q]scoreFinal.xlsx')
sheets_list <- names(getSheets(workbook))

figs9_df <- tibble()
for (sheet in sheets_list) {
    
    single_sheet <- read.xlsx('./Results/EI_final/[Q]scoreFinal.xlsx',
                              sheetName = sheet)
    
    figs9_df <- figs9_df %>% 
        bind_rows(single_sheet)
    
    
}

figs9_df <- figs9_df %>%
    mutate(Catogary = case_when(str_detect(Catogary, 'FW_capture') ~'Inland capture',
                                str_detect(Catogary, 'FW_culture') ~'Inland aquaculture',
                                str_detect(Catogary, 'M_capture') ~'Marine capture',
                                str_detect(Catogary, 'M_culture') ~'Marine aquaculture'),
           Continent = if_else(is.na(Continent), 'Oceania', Continent)) %>% 
    # ISO without continent info are small islands on pacific
    rename(Exposure = ScoreAvg) %>% 
    group_by(Continent, Catogary) %>% 
    mutate(idx = row_number(Continent))

figs9 <- ggplot(figs9_df, aes(x = idx, y = Exposure)) +
    geom_point() +
    geom_errorbar(aes(ymin = Exposure-ScoreStd, ymax = Exposure+ScoreStd)) +
    scale_x_continuous(labels = NULL, name = NULL)+
    theme_bw()

ggsave(plot = figs9, filename = './Viz/fig_s9.png', device = 'png')

# Fig S10 -----------------------------------------------------------------

workbook <- loadWorkbook('./Results/EI_final/[S]scoreFinal.xlsx')
sheets_list <- names(getSheets(workbook))

figs10_df <- tibble()
for (sheet in sheets_list) {
    
    single_sheet <- read.xlsx('./Results/EI_final/[S]scoreFinal.xlsx',
                              sheetName = sheet)
    
    figs10_df <- figs10_df %>% 
        bind_rows(single_sheet)
    
    
}

figs10_df <- figs10_df %>%
    mutate(Catogary = case_when(str_detect(Catogary, 'FW_capture') ~'Inland capture',
                                str_detect(Catogary, 'FW_culture') ~'Inland aquaculture',
                                str_detect(Catogary, 'M_capture') ~'Marine capture',
                                str_detect(Catogary, 'M_culture') ~'Marine aquaculture'),
           Continent = if_else(is.na(Continent), 'Oceania', Continent)) %>% 
    # ISO without continent info are small islands on pacific
    rename(Exposure = ScoreAvg) %>% 
    group_by(Continent, Catogary) %>% 
    mutate(idx = row_number(Continent))

figs10 <- ggplot(figs10_df, aes(x = idx, y = Exposure)) +
    geom_point() +
    geom_errorbar(aes(ymin = Exposure-ScoreStd, ymax = Exposure+ScoreStd)) +
    facet_grid(Continent~Catogary, scales = 'free') +
    scale_x_continuous(labels = NULL, name = NULL)+
    theme_bw()

ggsave(plot = figs10, filename = './Viz/fig_s10.png', device = 'png')
