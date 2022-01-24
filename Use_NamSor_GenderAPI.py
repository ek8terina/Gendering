from GenderAPI import use_genderAPI
from NamSor import use_namSor
import pandas as pd
import sys


if __name__ == '__main__':
    genderAPIKey = sys.argv[1]
    namSorKey = sys.argv[2]
    file = "./gender_this.csv"
    data = pd.read_csv(file)

    firstNames = {'ArticleID': list(range(len(data['first_name']))),
               'name': list(data['first_name']), 'surName': list(data['surname'])}
    secondNames = {'ArticleID': list(range(len(data['first_name']))),
               'name': list(data['second_name']), 'surName': list(data['surname'])}
    use_genderAPI(genderAPIKey, firstNames, "./firstname_genderAPI.csv")
    use_genderAPI(genderAPIKey, secondNames, "./secondname_genderAPI.csv")
    use_namSor(namSorKey, firstNames, "./firstname_namSor.csv")
    use_namSor(namSorKey, secondNames, "./secondname_namSor.csv")
