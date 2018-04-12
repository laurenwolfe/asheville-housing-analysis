INSERT INTO property
(mls, listing_type, sale_date, sale_price, hoa, days_on_market)
VALUES (%s, %s, %s, %s, %s, %s)
RETURNING sid;

INSERT INTO location
(sid, in_city, neighborhood, region, address,
 city, state_code, zip, latitude, longitude)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);

INSERT INTO structure
(sid, beds, baths, build_sqft, year_built, per_sqft_cost)
VALUES (%s, %s, %s, %s, %s, %s);

<-- ORRRRRR -->

INSERT INTO land
(sid, lot_size)
    VALUES (%s, %s);


region = values[0]
neighborhood = values[1]
sale_ty = values[2]
 = values[3]
 = values[4]
 = values[5]
 = values[6]
 = values[7]
 = values[8]
 = values[9]
 = values[10]
 = values[11]
 = values[12]
 = values[13]
 = values[14]
 = values[15]
 = values[16]
 = values[17]
 = values[18]
 = values[19]
 = values[20]
 = values[21]
 = values[22]
 = values[23]
 = values[24]
 = values[25]
 = values[26]
 = values[27]
 = values[28]


<--
  """
    0'REGION',
    1'NEIGHBORHOOD',
    2'SALE TYPE',
    3'SOLD DATE',
    4'PROPERTY TYPE',
    5'ADDRESS',
    6'CITY',
    7'STATE',
    8'ZIP',
    9'PRICE',
    10'BEDS',
    11'BATHS',
    12'LOCATION',
    13'SQUARE FEET',
    14'LOT SIZE',
    15'YEAR BUILT',
    16'DAYS ON MARKET',
    17'$/SQUARE FEET',
    18'HOA/MONTH',
    19'STATUS',
    20'NEXT OPEN HOUSE START TIME',
    21'NEXT OPEN HOUSE END TIME',
    22'URL (SEE http://www.redfin.com/buy-a-home/comparative-market-analysis FOR INFO ON PRICING)',
    23'SOURCE',
    24'MLS#',
    25'FAVORITE',
    26'INTERESTED',
    27'LATITUDE',
    28'LONGITUDE\n']
    """
-->