#!/usr/bin/python
import csv
import os

PATH = 'data/2018-04-11/'
ADDED_HEADERS = "REGION,NEIGHBORHOOD,"

added_columns = False
master_file = open(PATH + '../comps.csv', 'w')

# Get CSV Filenames
# label rows with neighborhood and region
for file in os.listdir(PATH):

    # skip hidden file types
    if file[0] == '.':
        continue

    # split file name into list
    raw_filename = file.split('.')
    region_and_hood = raw_filename[0].split('_')
    region = region_and_hood[0]

    # Append neighborhood name
    neighborhood = ''
    for i in range(1, len(region_and_hood)):
        neighborhood += region_and_hood[i] + ' '

    # add comma delimiter to constructed name
    location_data = region + ',' + neighborhood.rstrip() + ','

    # open master .csv file to write
    with open(PATH + file, newline='', encoding='latin-1') as csvfile:

        csv_reader = csv.reader((line.replace('\0', '') for line in csvfile), delimiter=',', quotechar='|')
        headers = next(csv_reader)

        # build a header in the first round, use as label for .csv
        if not added_columns:
            added_columns = True
            row = ADDED_HEADERS + ",".join(headers)
            row += '\n'
            master_file.write(row)
        else:
            # convert csv list into a string
            for line in csv_reader:
                row = location_data + ",".join(line)
                row += '\n'
                master_file.write(row)
