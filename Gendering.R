###IMPORT
library(stringr)
library(dplyr)
library(GenderGuesser)
library(gender)

###CONSTANTS
api_key_genderize = ""

###CLEAN FUNCTIONS
remove_accented_letters <- function(str){
  #e
  str_fixed = str_replace_all(str, "é", "e")
  str_fixed = str_replace_all(str_fixed, "É", "E")
  str_fixed = str_replace_all(str_fixed, "è", "e")
  str_fixed = str_replace_all(str_fixed, "È", "E")
  str_fixed = str_replace_all(str_fixed, "ê", "e")
  str_fixed = str_replace_all(str_fixed, "Ê", "E")
  str_fixed = str_replace_all(str_fixed, "ë", "e")
  str_fixed = str_replace_all(str_fixed, "Ë", "E")
  str_fixed = str_replace_all(str_fixed, "ě", "e")
  str_fixed = str_replace_all(str_fixed, "Ë", "E")
  
  #a
  str_fixed = str_replace_all(str_fixed, "à", "a")
  str_fixed = str_replace_all(str_fixed, "À", "A")
  str_fixed = str_replace_all(str_fixed, "á", "a")
  str_fixed = str_replace_all(str_fixed, "Á", "A")
  str_fixed = str_replace_all(str_fixed, "â", "a")
  str_fixed = str_replace_all(str_fixed, "Â", "A")
  str_fixed = str_replace_all(str_fixed, "ã", "a")
  str_fixed = str_replace_all(str_fixed, "Ã", "A")
  str_fixed = str_replace_all(str_fixed, "å", "a")
  str_fixed = str_replace_all(str_fixed, "ă", "a")
  str_fixed = str_replace_all(str_fixed, "Å", "A")
  str_fixed = str_replace_all(str_fixed, "ā", "a")
  str_fixed = str_replace_all(str_fixed, "Ā", "A")
  str_fixed = str_replace_all(str_fixed, "æ", "ae")
  str_fixed = str_replace_all(str_fixed, "Æ", "Ae")
  
  #i
  str_fixed = str_replace_all(str_fixed, "í", "i")
  str_fixed = str_replace_all(str_fixed, "Í", "I")
  str_fixed = str_replace_all(str_fixed, "î", "i")
  str_fixed = str_replace_all(str_fixed, "Î", "I")
  str_fixed = str_replace_all(str_fixed, "ï", "i")
  str_fixed = str_replace_all(str_fixed, "Ï", "I")
  str_fixed = str_replace_all(str_fixed, "ı", "i")
  str_fixed = str_replace_all(str_fixed, "Į", "I")
  
  #o
  str_fixed = str_replace_all(str_fixed, "ô", "o")
  str_fixed = str_replace_all(str_fixed, "Ô", "O")
  str_fixed = str_replace_all(str_fixed, "ö", "o")
  str_fixed = str_replace_all(str_fixed, "Ö", "O")
  str_fixed = str_replace_all(str_fixed, "œ", "oe")
  str_fixed = str_replace_all(str_fixed, "Œ", "Oe")
  str_fixed = str_replace_all(str_fixed, "ø", "o")
  str_fixed = str_replace_all(str_fixed, "Ø", "O")
  str_fixed = str_replace_all(str_fixed, "ò", "o")
  str_fixed = str_replace_all(str_fixed, "Ò", "O")
  str_fixed = str_replace_all(str_fixed, "ó", "o")
  str_fixed = str_replace_all(str_fixed, "Ó", "O")
  str_fixed = str_replace_all(str_fixed, "ӧ", "o")
  
  #u
  str_fixed = str_replace_all(str_fixed, "ü", "u")
  str_fixed = str_replace_all(str_fixed, "Ü", "U")
  str_fixed = str_replace_all(str_fixed, "û", "u")
  str_fixed = str_replace_all(str_fixed, "Û", "U")
  str_fixed = str_replace_all(str_fixed, "ū", "u")
  str_fixed = str_replace_all(str_fixed, "Ū", "U")
  str_fixed = str_replace_all(str_fixed, "ù", "u")
  str_fixed = str_replace_all(str_fixed, "Ù", "U")
  str_fixed = str_replace_all(str_fixed, "ú", "u")
  str_fixed = str_replace_all(str_fixed, "Ú", "U")
  
  #y
  str_fixed = str_replace_all(str_fixed, "ÿ", "y")
  str_fixed = str_replace_all(str_fixed, "Ÿ", "Y")
  
  #c
  str_fixed = str_replace_all(str_fixed, "ç", "c")
  str_fixed = str_replace_all(str_fixed, "Ç", "C")
  str_fixed = str_replace_all(str_fixed, "Ć", "C")
  str_fixed = str_replace_all(str_fixed, "č", "c")
  str_fixed = str_replace_all(str_fixed, "Č", "C")
  
  #n
  str_fixed = str_replace_all(str_fixed, "ñ", "n")
  str_fixed = str_replace_all(str_fixed, "Ñ", "N")
  
  #s
  str_fixed = str_replace_all(str_fixed, "ß", "ss")
  str_fixed = str_replace_all(str_fixed, "š", "s")
  str_fixed = str_replace_all(str_fixed, "Š", "S")
  str_fixed = str_replace_all(str_fixed, "ş", "s")
  str_fixed = str_replace_all(str_fixed, "Ş", "S")
  str_fixed = str_replace_all(str_fixed, "ș", "s")
  str_fixed = str_replace_all(str_fixed, "Ș", "S")
  str_fixed = str_replace_all(str_fixed, "ṣ", "s")
  str_fixed = str_replace_all(str_fixed, "Ṣ", "S")
  
  #g
  str_fixed = str_replace_all(str_fixed, "ğ", "g")
  
  #l
  str_fixed = str_replace_all(str_fixed, "ł", "l")
  str_fixed = str_replace_all(str_fixed, "Ł", "L")
  
  #weird stuff
  str_fixed = str_replace_all(str_fixed, "Ľ", "L")
  str_fixed = str_replace_all(str_fixed, "‐", "-")
  
  return(str_fixed)
}
remove_spaces <- function(names){
  cleaned = str_remove_all(names, "\\s")
  return(cleaned)
}

###GENDER FUNCTIONS
  #genderize.io
use_guessGender <- function(names, genderize_apikey){
  genders = data.frame(name = NA, gender = NA, probability = NA, count = NA)
  for( n in names){
    if(is.na(n) == TRUE){
      genders = rbind(genders, data.frame(name = NA, gender = NA, probability = NA, count = NA))
    }else if(str_detect(n, "[[:alpha:]]") == FALSE){
      genders = rbind(genders, data.frame(name = NA, gender = NA, probability = NA, count = NA))
    }else{
      temp = guessGender(n, apiKey = genderize_apikey)
      genders = rbind(genders, temp %>% select(name, gender, probability, count))
    }
  }
  return(genders)
}
use_genderize.io <- function(names, genderize_apikey){
  no_accents = remove_accented_letters(names)
  no_accents_spaces = remove_spaces(no_accents)
  genders = use_guessGender(no_accents_spaces, genderize_apikey)
  genders = genders[2:nrow(genders),]
  return(genders)
}
  #'@param api_dataframe dataframe of names, genders, and  info from genderize
  #'@param count integer of minimum number times a name must be in database
  #'@return api_dataframe with NA for probability and gender when < count
create_df_genderize <- function(gendered_first_name_df, gendered_second_name_df){
  gender_df = data.frame(firstname = gendered_first_name_df$name,
                               firstgender = gendered_first_name_df$gender,
                               firstprobability = gendered_first_name_df$probability,
                               firstcount = gendered_first_name_df$count,
                               secondname = gendered_second_name_df$name,
                               secondgender = gendered_second_name_df$gender,
                               secondprobability = gendered_second_name_df$probability,
                               secondcount = gendered_second_name_df$count)
  return(gender_df)
}
genderize_remove_low <- function(api_dataframe, count = 100){
  api_dataframe = api_dataframe %>% mutate(firstgender = ifelse(firstcount < count, NA, firstgender))
  api_dataframe = api_dataframe %>% mutate(secondgender = ifelse(secondcount < count, NA, secondgender))
  api_dataframe = api_dataframe %>% mutate(firstprobability = ifelse(firstcount < count, NA, firstprobability))
  api_dataframe = api_dataframe %>% mutate(secondprobability = ifelse(secondcount < count, NA, secondprobability))
  
  return(api_dataframe)
}
fix_check_genderize <- function(final_gender_df){
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                              & secondcount > 1000 
                                                              & firstcount > 1000,
                                                              firstgender,
                                                              gender))
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                              & firstcount > (secondcount + 300),
                                                              firstgender,
                                                              gender))
  
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                              & secondcount > (firstcount + 300),
                                                              secondgender,
                                                              gender))
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                              & firstprobability > secondprobability,
                                                              firstgender,
                                                              gender))
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                              & firstprobability < secondprobability,
                                                              secondgender,
                                                              gender))
  final_gender_df$probability = final_gender_df$firstprobability
  final_gender_df$count = final_gender_df$firstcount
  for(a in 1:nrow(final_gender_df)){
    if(is.na(final_gender_df$secondgender[a])){
      
    }else if(is.na(final_gender_df$firstgender[a])){
      final_gender_df$probability[a] = final_gender_df$secondprobability[a]
      final_gender_df$count[a] = final_gender_df$secondcount[a]
    }else if(final_gender_df$firstgender[a] == final_gender_df$secondgender[a]){
      final_gender_df$probability[a] = ifelse(final_gender_df$firstprobability[a] >= final_gender_df$secondprobability[a], 
                                        final_gender_df$firstprobability[a], final_gender_df$secondprobability[a])
      final_gender_df$count[a] = ifelse(final_gender_df$firstprobability[a] >= final_gender_df$secondprobability[a], 
                                  final_gender_df$firstcount[a], final_gender_df$secondcount[a])
    }else if(final_gender_df$gender[a] == final_gender_df$secondgender[a]){
      final_gender_df$probability[a] = final_gender_df$secondprobability[a]
      final_gender_df$count[a] = final_gender_df$secondcount[a]
    }
  }
  final_gender_df = final_gender_df %>% select(firstname, secondname, 
                                               probability, count,
                                               gender)
  return(final_gender_df)
}

  #genderR
use_gender <- function(names){
  genders = data.frame(name = NA, gender = NA, proportion_male = NA)
  for( n in names){
    if(is.na(n) == TRUE){
      genders = rbind(genders, data.frame(name = NA, gender = NA, proportion_male = NA))
    }else if(str_detect(n, "[[:alpha:]]") == FALSE){
      genders = rbind(genders, data.frame(name = NA, gender = NA, proportion_male = NA))
    }else{
      temp = gender(n)
      if(nrow(temp) == 0){
        temp = data.frame(name = NA, gender = NA, proportion_male = NA)
      }
      genders = rbind(genders, temp %>% select(name, gender, proportion_male))
    }
  }
  return(genders)
}
use_genderR <- function(names){
  no_accents = remove_accented_letters(names)
  no_accents_spaces = remove_spaces(no_accents)
  genders = use_gender(no_accents_spaces)
  genders = genders[2:nrow(genders),]
  return(genders)
}
create_df_genderR <-function(gendered_first_name_df, gendered_second_name_df){
  gender_df = data.frame(firstname = gendered_first_name_df$name,
                                firstgender = gendered_first_name_df$gender,
                                firstproportion = gendered_first_name_df$proportion_male,
                                secondname = gendered_second_name_df$name,
                                secondgender = gendered_second_name_df$gender,
                                secondproportion = gendered_second_name_df$proportion_male)
  #changing proportion to be proportion of whatever assigned gender rather than male
  gender_df = gender_df %>% mutate(firstproportion = ifelse(firstgender == "female",
                                                                          1-firstproportion,
                                                                          firstproportion))
  gender_df = gender_df %>% mutate(secondproportion = ifelse(secondgender == "female",
                                                                           1-secondproportion,
                                                                           secondproportion))
  return(gender_df)
}
fix_check_genderR <- function(final_gender_df){
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                                 & firstproportion > secondproportion,
                                                                 firstgender,
                                                                 gender))
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                                 & firstproportion < secondproportion,
                                                                 secondgender,
                                                                 gender))
  final_gender_df$proportion = final_gender_df$firstproportion
  for(p in 1:nrow(final_gender_df)){
    if(is.na(final_gender_df$proportion[p]) == TRUE){
      final_gender_df$proportion[p] = final_gender_df$secondproportion[p]
    }else if(is.na(final_gender_df$secondproportion[p]) == TRUE){
      
    }else if(final_gender_df$firstgender[p] == final_gender_df$secondgender[p]){
      final_gender_df$proportion[p] = ifelse(final_gender_df$proportion[p] < final_gender_df$secondproportion[p], 
                                      final_gender_df$secondproportion[p], final_gender_df$firstproportion)
    }else if(final_gender_df$gender[p] == final_gender_df$secondgender[p]){
      final_gender_df$proportion[p] = final_gender_df$secondproportion[p]
    }
  }
  final_gender_df = final_gender_df %>% select(firstname, secondname, 
                                               proportion, gender)
  return(final_gender_df)
}

  #genderAPI
create_df_genderAPI <- function(gendered_first_name_df, gendered_second_name_df){
  names(gendered_first_name_df)[2] = "firstname"
  names(gendered_first_name_df)[3] = "firstgender"
  names(gendered_first_name_df)[4] = "firstsamples"
  names(gendered_first_name_df)[5] = "firstaccuracy"
  names(gendered_second_name_df)[2] = "secondname"
  names(gendered_second_name_df)[3] = "secondgender"
  names(gendered_second_name_df)[4] = "secondsamples"
  names(gendered_second_name_df)[5] = "secondaccuracy"
  gendered_first_name_df = gendered_first_name_df %>% 
    select(firstname, firstgender, firstsamples, firstaccuracy)
  gendered_second_name_df = gendered_second_name_df %>% 
    select(secondname, secondgender, secondsamples, secondaccuracy)
  gender_df = cbind(gendered_first_name_df, gendered_second_name_df)
  return(gender_df)
}
  #'@param api_dataframe dataframe of names, genders, and  info from gender API
  #'@param count integer of minimum number times a name must be in database
  #'@return api_dataframe with NA for probability and gender when < count
genderAPI_remove_low <- function(api_dataframe, c = 100){
  api_dataframe = api_dataframe %>% mutate(firstgender = ifelse(firstsamples < c, NA, firstgender))
  api_dataframe = api_dataframe %>% mutate(secondgender = ifelse(secondsamples < c, NA, secondgender))
  api_dataframe = api_dataframe %>% mutate(firstaccuracy = ifelse(firstsamples < c, NA, firstaccuracy))
  api_dataframe = api_dataframe %>% mutate(secondaccuracy = ifelse(secondsamples < c, NA, secondaccuracy))
  
  return(api_dataframe)
}
fix_check_genderAPI <- function(final_gender_df){
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                   & secondsamples > 1000 
                                                   & firstsamples > 1000,
                                                   firstgender,
                                                   gender))
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                   & firstsamples > (secondsamples + 300),
                                                   firstgender,
                                                   gender))
  
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                   & secondsamples > (firstsamples + 300),
                                                   secondgender,
                                                   gender))
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                   & firstaccuracy > secondaccuracy,
                                                   firstgender,
                                                   gender))
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                                   & firstaccuracy < secondaccuracy,
                                                   secondgender,
                                                   gender))
  final_gender_df$accuracy = final_gender_df$firstaccuracy
  final_gender_df$samples = final_gender_df$firstsamples
  for(a in 1:nrow(final_gender_df)){
    if(is.na(final_gender_df$secondgender[a])){
      
    }else if(is.na(final_gender_df$firstgender[a])){
      final_gender_df$accuracy[a] = final_gender_df$secondaccuracy[a]
      final_gender_df$samples[a] = final_gender_df$secondsamples[a]
    }else if(final_gender_df$firstgender[a] == final_gender_df$secondgender[a]){
      final_gender_df$accuracy[a] = ifelse(final_gender_df$firstaccuracy[a] >= final_gender_df$secondaccuracy[a], 
                                     final_gender_df$firstaccuracy[a], final_gender_df$secondaccuracy[a])
      final_gender_df$samples[a] = ifelse(final_gender_df$firstaccuracy[a] >= final_gender_df$secondaccuracy[a], 
                                    final_gender_df$firstsamples[a], final_gender_df$secondsamples[a])
    }else if(final_gender_df$gender[a] == final_gender_df$secondgender[a]){
      final_gender_df$accuracy[a] = final_gender_df$secondaccuracy[a]
      final_gender_df$samples[a] = final_gender_df$secondsamples[a]
    }
  }
  final_gender_df = final_gender_df %>% select(firstname, secondname, accuracy,
                                               samples, gender)
  return(final_gender_df)
}

  #namSor
create_df_nameSor <- function(gendered_first_name_df, gendered_second_name_df){
  names(gendered_first_name_df)[2] = "firstname"
  names(gendered_first_name_df)[3] = "surname"
  names(gendered_first_name_df)[4] = "firstgender"
  names(gendered_first_name_df)[5] = "firstprobability"
  names(gendered_first_name_df)[6] = "firstgenderScale"
  names(gendered_first_name_df)[7] = "firstscore"
  names(gendered_second_name_df)[2] = "secondname"
  names(gendered_second_name_df)[4] = "secondgender"
  names(gendered_second_name_df)[5] = "secondprobability"
  names(gendered_second_name_df)[6] = "secondgenderScale"
  names(gendered_second_name_df)[7] = "secondscore"
  gendered_first_name_df = gendered_first_name_df %>% 
    select(firstname, surname, firstgender, firstprobability, firstgenderScale,firstscore)
  gendered_second_name_df = gendered_second_name_df %>% 
    select(secondname, secondgender, secondprobability, secondgenderScale,secondscore)
  gender_df = cbind(gendered_first_name_df, gendered_second_name_df)
  return(gender_df)
}
fix_check_namsor <- function(final_gender_df){
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                             & firstprobability > secondprobability,
                                             firstgender,
                                             gender))
  final_gender_df = final_gender_df %>% mutate(gender = ifelse(str_detect(gender, "check") 
                                             & firstprobability < secondprobability,
                                             secondgender,
                                             gender))
  final_gender_df$probability = final_gender_df$firstprobability
  for(p in 1:nrow(final_gender_df)){
    if(is.na(final_gender_df$probability[p]) == TRUE){
      final_gender_df$probability[p] = final_gender_df$secondprobability[p]
    }else if(is.na(final_gender_df$secondprobability[p]) == TRUE){
      final_gender_df$probability[p] = final_gender_df$probability[p]
    }else if(final_gender_df$firstgender[p] == final_gender_df$secondgender[p]){
      final_gender_df$probability[p] = ifelse(final_gender_df$probability[p] < final_gender_df$secondprobability[p], 
                                     final_gender_df$secondprobability[p], final_gender_df$firstprobability)
    }else if(final_gender_df$gender[p] == final_gender_df$secondgender[p]){
      final_gender_df$probability[p] = final_gender_df$secondprobability[p]
    }
  }
  final_gender_df = final_gender_df %>% select(firstname, secondname, surname, 
                                               probability, gender)
  return(final_gender_df)
}

###GENERAL FUNCTIONS
  #'@param genders dataframe with columns firstgender and secondgender
  #'@return vector of "final genders" derived from first and second name: "male", "female", "check", NA
combine_gender <- function(genders){
  finalgender = c()
  for(g in (1:nrow(genders))){
    if(is.na(genders$secondgender[g]) == TRUE){
      finalgender = c(finalgender, genders$firstgender[g])
    }else if(is.na(str_locate(genders$firstgender[g], genders$secondgender[g])[1]) == TRUE){
      finalgender = c(finalgender, "check")
    }else if(str_locate(genders$firstgender[g], genders$secondgender[g])[1] == 1){
      finalgender = c(finalgender, genders$firstgender[g])
    }else{
      finalgender = c(finalgender, "check")
    }
  }
  return(finalgender)
}
create_final <- function(namSor, genderAPI, gender, genderize){
  final = data.frame(firstName = namSor$firstname,
                     secondName = namSor$secondname,
                     surName = namSor$surname,
                     accuracy = genderAPI$accuracy,
                     samples = genderAPI$samples,
                     gender = genderAPI$gender,
                     gender75 = NA,
                     gender8 = NA,
                     gender9 = NA,
                     gender95 = NA,
                     source = "genderAPI")
  final = final %>% mutate(source = ifelse(is.na(samples), NA, "genderAPI"))
  for(n in 1:nrow(final)){
    if(is.na(genderize$gender[n])){
      
    }else if(is.na(final$gender[n])){
      final$gender[n] = genderize$gender[n]
      final$samples[n] = genderize$count[n]
      final$accuracy[n] = genderize$probability[n]
      final$source[n] = "genderize.io"
    }else if(genderize$count[n] > final$samples[n]){
      final$gender[n] = genderize$gender[n]
      final$samples[n] = genderize$count[n]
      final$accuracy[n] = genderize$probability[n]
      final$source[n] = "genderize.io"
    }
  }
  for(n in 1:nrow(final)){
    if(is.na(namSor$gender[n])){
      
    }else if(is.na(final$gender[n])){
      final$gender[n] = namSor$gender[n]
      final$samples[n] = NA
      final$accuracy[n] = namSor$probability[n]
      final$source[n] = "NamSor"
    }else if(namSor$probability[n] > final$accuracy[n]){
      final$gender[n] = namSor$gender[n]
      final$samples[n] = NA
      final$accuracy[n] = namSor$probability[n]
      final$source[n] = "NamSor"
    }
  }
  for(n in 1:nrow(final)){
    if(is.na(gender$gender[n])){
      
    }else if(is.na(final$gender[n])){
      final$gender[n] = gender$gender[n]
      final$samples[n] = NA
      final$accuracy[n] = gender$proportion[n]
      final$source[n] = "gender R Package"
    }
  }
  final$gender75 = final$gender
  final$gender8 = final$gender
  final$gender9 = final$gender
  final$gender95 = final$gender
  final = final %>% mutate(gender75 = ifelse(accuracy <.75, NA, gender75))
  final = final %>% mutate(gender8 = ifelse(accuracy <.8, NA, gender8))
  final = final %>% mutate(gender9 = ifelse(accuracy <.9, NA, gender9))
  final = final %>% mutate(gender95 = ifelse(accuracy <.95, NA, gender95))
  # 3 sig figs on accuracy
  final$accuracy = round(final$accuracy, digits = 3)
  
  return(final)
}
