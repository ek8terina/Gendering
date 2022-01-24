args = commandArgs(trailingOnly=TRUE)
source("Gendering.R")
genderize_api_key = args[1]
file = "./gender_this.csv"
data = read.csv(file)

#genderize
first_df = use_genderize.io(data$first_name, genderize_api_key)
second_df = use_genderize.io(data$second_name, genderize_api_key)
write.csv(first_df, "./firstname_genderize.csv")
write.csv(first_df, "./secondname_genderize.csv")
gender_df = create_df_genderize(first_df, second_df)
gender_df = genderize_remove_low(gender_df)
gender_df$gender = combine_gender(gender_df)
genderize = fix_check_genderize(gender_df)

#genderR
first_df = use_genderR(data$first_name)
second_df = use_genderR(data$second_name)
write.csv(first_df, "./firstname_genderR.csv")
write.csv(first_df, "./secondname_genderR.csv")
gender_df = create_df_genderR(first_df, second_df)
gender_df$gender = combine_gender(gender_df)
genderR = fix_check_genderR(gender_df)

#genderAPI
file1 = "./firstname_genderAPI.csv"
file2 = "./secondname_genderAPI.csv"
first_df = read.csv(file1)
second_df = read.csv(file2)
gender_df = create_df_genderAPI(first_df, second_df)
gender_df = genderAPI_remove_low(gender_df)
gender_df$gender = combine_gender(gender_df)
genderAPI = fix_check_genderAPI(gender_df)

#namSor
file1 = "./firstname_namSor.csv"
file2 = "./secondname_namSor.csv"
first_df = read.csv(file1)
second_df = read.csv(file2)
gender_df = create_df_nameSor(first_df, second_df)
gender_df$gender = combine_gender(gender_df)
namSor = fix_check_namsor(gender_df)

#final results
final_df = create_final(namSor, genderAPI, genderR, genderize)
write.csv(final_df, "./final.csv")

