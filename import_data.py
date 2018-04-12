#!/usr/bin/python
import psycopg2
from datetime import datetime

PATH = 'data/comps.csv'
sales_records = open(PATH, 'r')

conn = psycopg2.connect("dbname=real_estate_comps user=broker")
cur = conn.cursor()

# skip header
next(sales_records)

for row in sales_records:
    "CSV string to list form"
    values = row.split(',')
    # Execute master insert query and retrieve autoinc'd key,
    for i in range(0, len(values)):
        if
        if values[i] == '':
            values[i] = None

        if values[9] == 'NC':
            print(values)

        if not values[3]:
            values[3] = 'January-1-2015'
        if not values[9]:
            values[9] = 0


    sale_date = datetime.strptime(values[3], '%B-%d-%Y')

    # Property details
    cur.execute("""
                  INSERT INTO property (mls, listing_type, sale_date, sale_price, hoa, days_on_market) 
                  VALUES (%s, %s, %s, %s, %s, %s) RETURNING sid;
                """,
                (values[24], values[4], sale_date, values[9], values[18], values[16]))

    sale_id = cur.fetchone()

    # Location details
    cur.execute("""
                  INSERT INTO location (sid, in_city, neighborhood, region, address, 
                  city, state_code, zip, latitude, longitude)
                  VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
                """,
                (sale_id, True, values[1], values[0], values[5], values[6], values[7],
                values[8], values[27], values[28].rstrip()))

    # Vacant Land or Developed?
    if values[4] == 'Vacant Land':

        # LAND TABLE
        cur.execute("""
                      INSERT INTO land (sid, lot_size)
                      VALUES (%s, %s);
                    """,
                    (sale_id, values[14]))
    else:
        # STRUCTURE TABLE
        cur.execute("""
                      INSERT INTO structure (sid, beds, baths, build_sqft, year_built, per_sqft_cost)
                      VALUES (%s, %s, %s, %s, %s, %s);
                    """,
                    (sale_id, values[10], values[11], values[13], values[15], values[17]))

conn.commit()
cur.close()
conn.close()
