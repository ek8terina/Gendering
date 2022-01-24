# Gendering
This is a repository to get predicted gender from named entities with a first name, second name, and surname. This code gets the gender prediction from Gender API, NamSor, Genderize.io, and Gender R Package and combines all gender predictions to get the best possible prediction between all four services. Final result agglomerates output from all four sources.

In order to run, you will need the following:
1. .csv in the format of "gender_this.csv" it should contain the following columns: "first_name" "second_name" "surname". These can be blank if data is not available
2. Gender API Key (and credits)
3. NamSor API Key (and credits)
4. Genderize.io Key (and credits)

## Quickstart: How to Run
1. Clone or download this repo to local machine
2. Replace "gender_this.csv" with desired data
    1. Follow the format of names_format.csv
    2. Use the name "gender_this.csv"!
3. Open terminal at the /Gendering/ folder
4. Run the following (replace <API_KEY>):
    1. `RScript Gendering_clean.R`
    2. `python Use_NamSor_GenderAPI.py "<GENDER_API_KEY>" "<NAM_SOR_API_KEY"`
        1. Make sure you have required libraries installed (see requirements.txt)
        2. Recommended: Install and run in a virtual environment
    2. `RScript Gendering_run.R "<GENDERIZE_API_KEY>"`
5. Hooray! This should have generated final.csv, the resulting gendering. See final_sample.csv.

## File Details
...

## Results
...

## Details about Gender Services
This repository combines the results from four different services. They are as follows. Find more details on Gender Services websites.
### Gender API
...
### NamSor
...
### Genderize.io
...
### Gender R Package
...
