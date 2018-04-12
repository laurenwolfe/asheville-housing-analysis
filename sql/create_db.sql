/*
  CREATE TABLE comps(
  sale_id SERIAL,
  date_sold DATE,
  mls VARCHAR(20),
  property_type VARCHAR(50),
  beds INT,
  baths INT,
  sqft INT,
  lot_size INT,
  year_built INT,
  price INT,
  days_on_market INT,
  hoa INT DEFAULT 0,
  sqft_cost INT,
  neighborhood VARCHAR(50) NOT NULL,
  located VARCHAR(50),
  address VARCHAR(100),
  city VARCHAR(50),
  state VARCHAR(5),
  zip VARCHAR(10),
  latitude VARCHAR(20),
  longitude VARCHAR(20),
  date_str VARCHAR(50)
)
*/

CREATE TABLE property (
  sid SERIAL PRIMARY KEY,
  mls VARCHAR(20),
  type VARCHAR(50),
  sale_date DATE,
  sale_price INT,
  hoa INT,
  days_on_market INT
);

CREATE TABLE location (
  sid SERIAL REFERENCES property (sid),
  in_city BOOLEAN,
  neighborhood VARCHAR(50),
  quadrant CHAR,
  address VARCHAR(100),
  city VARCHAR(50),
  state_code VARCHAR(2),
  zip VARCHAR(10),
  latitude VARCHAR(20),
  longitude VARCHAR(20)
);

CREATE TABLE residence (
  sid SERIAL REFERENCES property (sid),
  beds INT,
  baths INT,
  build_sqft INT,
  year_built INT,
  per_sqft_cost INT
);

CREATE TABLE lot (
  sid SERIAL REFERENCES property (sid),
  lot_size INT
);

CREATE TABLE quadrant_map (
  letter CHAR,
  quad_name VARCHAR(50)
);