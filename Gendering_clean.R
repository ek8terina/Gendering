source("Gendering.R")

file = "./gender_this.csv"
data = read.csv(file)

data$first_name = remove_accented_letters(data$first_name)
data$second_name = remove_accented_letters(data$second_name)
data$surname = remove_accented_letters(data$surname)

data$first_name = remove_spaces(data$first_name)
data$second_name = remove_spaces(data$second_name)
data$surname = remove_spaces(data$surname)

write.csv(data, file)