from __future__ import print_function
import openapi_client
from openapi_client.rest import ApiException
import csv  # read csv files
import re  # regex

def use_namSor(key, authors, savename):
    # Configure API key authorization: api_key
    configuration = openapi_client.Configuration()
    configuration.api_key['X-API-KEY'] = key
    # Uncomment below to setup prefix (e.g. Bearer) for API key, if needed
    # configuration.api_key_prefix['X-API-KEY'] = 'Bearer'

    # create instance of API class
    api_instance = openapi_client.PersonalApi(openapi_client.ApiClient(configuration))

    dict_data = []  # creating dict for gendered data
    id = 0  # counter
    lowercaseletter = re.compile('[a-z]')


    for name in authors["name"]:
        first_name = name  # str |
        last_name = authors["surName"][id]  # str |
        if isinstance(name, str) is False:
            dict_data.append({'ArticleID': authors['ArticleID'][id],
                            'name': "NA",
                            'surname': last_name,
                            'gender': "NA",
                            'probability': "NA",
                            'genderScale': "NA",
                            'score': "NA"})
        elif lowercaseletter.search(name):  # only run NamSor if the name has a lower case (no "NA", "J.P.", "" etc)
            # Test without using any credits
            #dict_data.append({'ArticleID': authors['ArticleID'][id],
            #                  'name': first_name,
            #                  'surname': last_name,
            #                  'gender': "test",
            #                  'probability': "test",
            #                  'genderScale': "test",
            #                  'score': "test"})
            # Actually use NamSor (RUN CAREFULLY)
            try:
                # Infer the likely gender of a name.
                api_response = api_instance.gender(first_name, last_name)
                # change from first_last_name_gendered_out object to dict (see package doc)
                api_response = api_response.to_dict()
                dict_data.append({'ArticleID': authors['ArticleID'][id],
                                'name': first_name,
                                'surname': last_name,
                                'gender': api_response['likely_gender'],
                                'probability': api_response['probability_calibrated'],
                                'genderScale': api_response['gender_scale'],
                                'score': api_response['score']})
                print(first_name + ": " + api_response['likely_gender'] + " see full details in resulting .csv")
            except ApiException as e:
                print("Exception when calling PersonalApi->gender: %s\n" % e)
                dict_data.append({'ArticleID': authors['ArticleID'][id],
                                'name': first_name,
                                'surname': last_name,
                                'gender': "NA",
                                'probability': "NA",
                                'genderScale': "NA",
                                'score': "NA"})
        else:
            dict_data.append({'ArticleID': authors['ArticleID'][id],
                            'name': first_name,
                            'surname': last_name,
                            'gender': "NA",
                            'probability': "NA",
                            'genderScale': "NA",
                            'score': "NA"})
        id = id + 1

    csv_columns = ['ArticleID', 'name', 'surname', 'gender', 'probability', 'genderScale', 'score']
    csv_file = savename
    try:
        with open(csv_file, 'w') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
            writer.writeheader()
            for data in dict_data:
                writer.writerow(data)
    except IOError:
        print("I/O error")


# Getting status of API after using key
# create an instance of the API class
"""""
api_instance = openapi_client.AdminApi(openapi_client.ApiClient(configuration))

try:
    # Prints the current status of the classifiers.
    api_response = api_instance.api_usage()
    pprint(api_response)
except ApiException as e:
    print("Exception when calling AdminApi->api_usage: %s\n" % e)
"""""

# try:
# Activate/deactivate anonymization for a source.
#    api_instance.anonymize(source, anonymized)
# except ApiException as e:
#    print("Exception when calling AdminApi->anonymize: %s\n" % e)
