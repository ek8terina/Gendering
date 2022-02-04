import urllib.request  # Opening URLS on MacOS, make sure you Python has certificates
import json  # read json files
import csv  # read csv files
import re  # regex

def use_genderAPI(key, authors, savename):
# Preparing variables
    myKey = key  # GenderAPI Key, DO NOT OVERUSE
    lowercaseletter = re.compile('[a-z]')  # Checking that a name has a lowercase letter, only use key if true

    dict_data = []  # creating dict for gendered data
    id = 0  # counter
    count = 0
    for name in authors['name']:
        if isinstance(name, str) is False:
            dict_data.append({'ArticleID': authors['ArticleID'][id],
                            'name': "NA",
                            'gender': "NA",
                            'samples': "NA",
                            'accuracy': "NA"})
        elif lowercaseletter.search(name):  # only run Gender API if the name has a lower case (no "NA", "J.P.", "" etc)
            try:
                url = "https://gender-api.com/get?key=" + myKey + "&name=" + name
                response = urllib.request.urlopen(url)
                decoded = response.read().decode('utf-8')
                data = json.loads(decoded)
                dict_data.append({'ArticleID': authors['ArticleID'][id],
                            'name': data['name'],
                            'gender': data['gender'],
                            'samples': data['samples'],
                            'accuracy': data['accuracy']})
                #print(name + ": " + data['gender'] + " see full details in resulting .csv")
                count = count + 1
            except UnicodeEncodeError:
                dict_data.append({'ArticleID': authors['ArticleID'][id],
                            'name': name,
                            'gender': "NA",
                            'samples': "NA",
                            'accuracy': "NA"})
        else:
            dict_data.append({'ArticleID': authors['ArticleID'][id],
                            'name': name,
                            'gender': "NA",
                            'samples': "NA",
                            'accuracy': "NA"})
        id = id + 1

    id = 0  # reset counter
    print(count)
    csv_columns = ['ArticleID', 'name', 'gender', 'samples', 'accuracy']
    csv_file = savename
    try:
        with open(csv_file, 'w') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
            writer.writeheader()
            for data in dict_data:
                writer.writerow(data)
    except IOError:
        print("I/O error")