# Gendering
This is a repository to get predicted gender from named entities with a first name, second name, and surname. This code gets the gender prediction from Gender API, NamSor, Genderize.io, and Gender R Package and combines all gender predictions to get the best possible prediction between all four services. Final result agglomerates output from all four sources.

Note: Results may change as Gender APIs' datasets and prediction algorithms are updated. Replication may yield very slightly different results over time.

In order to run, you will need the following:
1. .csv in the format of "gender_this.csv" it should contain the following columns: "first_name" "second_name" "surname". These can be blank if data is not available
2. Gender API Key (and credits)
3. NamSor API Key (and credits)
4. Genderize.io Key (and credits)
5. Python and R to run from command line

## Quickstart: How to Run
1. Clone or download this repo to local machine
2. Replace "gender_this.csv" with desired data
    1. Follow the format of names_format.csv
    2. Use the name "gender_this.csv"!
3. Open terminal at the /Gendering/ folder
4. Run the following (replace <API_KEY>):
    1. Install necessary libraries for Python and R
        1. Python dependencies detailed in requirements.txt
        2. R dependencies: 'stringr', 'dplyr', 'GenderGuesser', 'gender'
    3. `RScript Gendering_clean.R`
    4. `python Use_NamSor_GenderAPI.py "<GENDER_API_KEY>" "<NAM_SOR_API_KEY"`
        1. Make sure you have required libraries installed (see requirements.txt)
        2. Recommended: Install and run in a virtual environment
    5. `RScript Gendering_run.R "<GENDERIZE_API_KEY>"`
5. Hooray! This should have generated final.csv, the resulting gendering. See final_sample.csv.

Note: NamSor, GenderAPI, and Genderize.io may take some time to run across many observations. Recommended: create a .sh file and run in a compute cluster if possible.

## File Details
### Code
1. "GenderAPI.py","NamSor.py", and "Use_NamSor_GenderAPI.py" include python code to access the Gender API and NamSor API. See "requirements.txt" for Python dependencies
2. "Gendering.R", "Gendering_clean.R", and "Gendering_run.R" include R script to access Genderize.io and the Gender R package as well as clean the .csv and format + output the final file
### Other
This repo includes some csvs as samples to run the code as is and for formatting examples. "final_sample.csv" is an example of the output created by running the Quickstart, "names_format.csv" is the sample format input csvs MUST follow. "gender_this.csv" is the sample data the code will run on automatically, replace with desired data and follow [Quickstart](##heading-1 "Goto quickstart") instructions.

## Results
A sample of the results output is in "final_sample.csv". The final CSV output includes the following:
1. firstName
2. secondName
3. surName
4. accuracy
5. samples
6. gender (no threshold)
7. gender75 (threshold at .75 predicted accuracy)
8. gender8 (threshold at .8 predicted accuracy)
9. gender9 (threshold at .9 predicted accuracy)
10. gender95 (threshold at .95 predicted accuracy)
11. source (the API/package whose results were chosen. See "Gendering.R" function `create_final(namSor, genderAPI, gender, genderize)` for full details on selection process. The final prediction chosen is roughly the best accuracy and highest samples w/ some preference towards certain APIs that are expected to be more accurate. See [Comparison and benchmark of name-to-gender services](https://peerj.com/articles/cs-156/) from Lucia Santamaria and Mihaljevic. 

## Details about Gender Services
This repository combines the results from four different services. They are as follows. Find more details and buy credits + API Keys on Gender Services websites. There is currently no function to use fewer than all four of these services in this Repo, but "Gendering.R" contains functions `use_<service>(params)`, `create_df_<service>(params)`, and more formatting functions that can produce desired output if modified and run individually.
### Gender API
See website [here](https://gender-api.com/)
An API Key and credits are needed to use Gender API name-to-gender inference, these can be purchased through their website. If using this Gendering repo, be sure to us an API Key with access to enough credits for the size of the CSV. The count of name-to-gender calls used is `# of valid first_name + # of valid second_name` in the selected CSV. Values like NA or " " are not evaluated and not charged as credits.
### NamSor
See website [here](https://namsor.app/)
An API Key and credits are needed to use NamSor name-to-gender inference, these can be purchased through their website. If using this Gendering repo, be sure to us an API Key with access to enough credits for the size of the CSV. The count of name-to-gender calls used is `# of valid first_name + # of valid second_name` in the selected CSV. Values like NA or " " are not evaluated and not charged as credits.
### Genderize.io
See website [here](https://genderize.io/)
An API Key and credits are needed to use Genderize.io name-to-gender inference, these can be purchased through their website. If using this Gendering repo, be sure to us an API Key with access to enough credits for the size of the CSV. The count of name-to-gender calls used is `# of valid first_name + # of valid second_name` in the selected CSV. Values like NA or " " are not evaluated and not charged as credits.
### Gender R Package
Find documentation on [cran](https://cran.r-project.org/web/packages/gender/index.html)
Gender R package is unique between these four in that it is an installable R package that does not require calls to a credit-based API. No sign-up or API Key is necessary.
