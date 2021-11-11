# This scripts used to compute EI for each type of blue food source 
# and the step stone data are saved to rds for further aggregation

source('./Scripts/00_functions.R')
loops = 5
r_seed = 2021
save_path <- './Results/modeloutput_raw/EI/'
if (!dir.exists(save_path)) {
    dir.create(save_path, recursive = T)
} 


# Quantity - FW capture ---------------------------------------------------

var_Path <- './Results/model_input/Q_inland.csv'
ei_weight_path <- './Results/model_input/ei_weight.csv'
ty <- 'FW_capture'

print(paste0('Now running ', ty, ' part!'))
res <- ei_culculation(
    var_path = var_Path,
    ei_weight_path = ei_weight_path,
    type = ty,
    loop = loops,
    seed = r_seed
)
print('Finish!')

save_name <- paste0(save_path, 'Q_', ty, '.rds')
write_rds(res, save_name, compress = 'gz')


# Quantity - FW culture ---------------------------------------------------

var_Path <- './Results/model_input/Q_inland.csv'
ei_weight_path <- './Results/model_input/ei_weight.csv'
ty <- 'FW_culture'

print(paste0('Now running ', ty, ' part!'))
res <- ei_culculation(
    var_path = var_Path,
    ei_weight_path = ei_weight_path,
    type = ty,
    loop = loops,
    seed = r_seed
)
print('Finish!')

save_name <- paste0(save_path, 'Q_', ty, '.rds')
write_rds(res, save_name, compress = 'gz')


# Quantity - Marine capture -----------------------------------------------

var_Path <- './Results/model_input/Q_marine.csv'
ei_weight_path <- './Results/model_input/ei_weight.csv'
ty <- 'M_capture'

print(paste0('Now running ', ty, ' part!'))
res <- ei_culculation(
    var_path = var_Path,
    ei_weight_path = ei_weight_path,
    type = ty,
    loop = loops,
    seed = r_seed
)
print('Finish!')

save_name <- paste0(save_path, 'Q_', ty, '.rds')
write_rds(res, save_name, compress = 'gz')


# Quantity - Marine culture -----------------------------------------------

var_Path <- './Results/model_input/Q_marine.csv'
ei_weight_path <- './Results/model_input/ei_weight.csv'
ty <- 'M_culture'

print(paste0('Now running ', ty, ' part!'))
res <- ei_culculation(
    var_path = var_Path,
    ei_weight_path = ei_weight_path,
    type = ty,
    loop = loops,
    seed = r_seed
)
print('Finish!')

save_name <- paste0(save_path, 'Q_', ty, '.rds')
write_rds(res, save_name, compress = 'gz')

# Safety - FW capture -----------------------------------------------------

var_Path <- './Results/model_input/S_inland.csv'
ei_weight_path <- './Results/model_input/ei_weight.csv'
ty <- 'FW_capture'

print(paste0('Now running ', ty, ' part!'))
res <- ei_culculation(
    var_path = var_Path,
    ei_weight_path = ei_weight_path,
    type = ty,
    loop = loops,
    seed = r_seed
)
print('Finish!')

save_name <- paste0(save_path, 'S_', ty, '.rds')
write_rds(res, save_name, compress = 'gz')

# Safety - FW culture -----------------------------------------------------

var_Path <- './Results/model_input/S_inland.csv'
ei_weight_path <- './Results/model_input/ei_weight.csv'
ty <- 'FW_culture'

print(paste0('Now running ', ty, ' part!'))
res <- ei_culculation(
    var_path = var_Path,
    ei_weight_path = ei_weight_path,
    type = ty,
    loop = loops,
    seed = r_seed
)
print('Finish!')

save_name <- paste0(save_path, 'S_', ty, '.rds')
write_rds(res, save_name, compress = 'gz')

# Safety - marine capture -----------------------------------------------------

var_Path <- './Results/model_input/S_marine.csv'
ei_weight_path <- './Results/model_input/ei_weight.csv'
ty <- 'M_capture'

print(paste0('Now running ', ty, ' part!'))
res <- ei_culculation(
    var_path = var_Path,
    ei_weight_path = ei_weight_path,
    type = ty,
    loop = loops,
    seed = r_seed
)
print('Finish!')

save_name <- paste0(save_path, 'S_', ty, '.rds')
write_rds(res, save_name, compress = 'gz')

# Safety - Marine culture -----------------------------------------------------

var_Path <- './Results/model_input/S_marine.csv'
ei_weight_path <- './Results/model_input/ei_weight.csv'
ty <- 'M_culture'

print(paste0('Now running ', ty, ' part!'))
res <- ei_culculation(
    var_path = var_Path,
    ei_weight_path = ei_weight_path,
    type = ty,
    loop = loops,
    seed = r_seed
)
print('Finish!')

save_name <- paste0(save_path, 'S_', ty, '.rds')
write_rds(res, save_name, compress = 'gz')