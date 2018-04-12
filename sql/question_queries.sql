-- avg number of bedrooms in sold homes, by in-city neighborhood

select neighborhood, ROUND(AVG(beds)::NUMERIC, 2) as avg_beds  from comps
  WHERE property_type != 'Vacant Land'
  AND city_neighborhood = 1
GROUP BY neighborhood
ORDER BY avg_beds desc;

-- avg cost per sqft, with volume

select neighborhood, round(avg(sqft_cost)::NUMERIC, 2) as avg_sqft_cost, count(neighborhood) as num_homes_sold from comps
  WHERE property_type != 'Vacant Land'
  AND city_neighborhood = 1
GROUP BY neighborhood
ORDER BY avg_sqft_cost desc;

-- avg time on market, etc

SELECT quadrant,
  round(avg(days_on_market)::NUMERIC, 2) as avg_days_on_market,
  round(avg(sqft)::NUMERIC, 2) as avg_sqft,
  round(avg(lot_size)::NUMERIC, 2) as avg_lot_size,
  round(avg(year_built)::NUMERIC, 2) as avg_year_built,
  round(avg(price)::NUMERIC, 2) as avg_price,
  round(avg(beds)::NUMERIC, 1) as avg_beds,
  round(avg(baths)::NUMERIC, 1) as avg_baths,
  round(avg(hoa)::NUMERIC, 2) as avg_hoa FROM comps
GROUP BY quadrant
ORDER BY avg_days_on_market;

-- breakdown of counts by quadrant and category of housing

 select property_type, quadrant, count(DISTINCT sale_id) as cat_total
 from comps
   WHERE quadrant = 'C'
 GROUP BY property_type, quadrant
 ORDER BY property_type, cat_total desc;


-- breakdown of housing totals and percentages for single quadrant

select quadrant, property_type, count(DISTINCT sale_id) as cat_total,
  (count(DISTINCT sale_id) * 100 / (select count(*) from comps where quadrant = 'W')) as percentage
       from comps
         WHERE quadrant = 'W'
       GROUP BY quadrant, property_type
       ORDER BY cat_total DESC;

-- breakdown of days on market by length of time and neighborhood

Select neighborhood,
  sum(case when days_on_market BETWEEN 0 and 7 then 1 else 0 end) one_week,
  sum(case when days_on_market BETWEEN 8 and 15 then 1 else 0 END) half_month,
  sum(case when days_on_market BETWEEN 16 and 30 then 1 else 0 END) one_month,
  sum(case when days_on_market BETWEEN 31 and 60 then 1 else 0 END) two_months,
  sum(case when days_on_market BETWEEN 61 and 90 then 1 else 0 END) three_months,
  sum(case when days_on_market > 90 then 1 else 0 end) sat_on_market,
  sum(case when days_on_market ISNULL then 0 else 1 end) total
FROM comps
  where beds >= 1
GROUP BY neighborhood;

-- breakdown of sqft cost by # of bedrooms and neighborhood

select c1.neighborhood,
  (select round(avg(sqft_cost)::NUMERIC, 2) from comps c2
    WHERE beds = 1 and c1.neighborhood = c2.neighborhood) beds1,
  (select round(avg(sqft_cost)::NUMERIC, 2) from comps c3
    WHERE beds = 2 and c1.neighborhood = c3.neighborhood) beds2,
  (select round(avg(sqft_cost)::NUMERIC, 2) from comps c4
    WHERE beds = 3 and c1.neighborhood = c4.neighborhood) beds3,
  (select round(avg(sqft_cost)::NUMERIC, 2) from comps c5
    WHERE beds = 4 and c1.neighborhood = c5.neighborhood) beds4,
  (select round(avg(sqft_cost)::NUMERIC, 2) from comps c6
    WHERE beds >= 5 and c1.neighborhood = c6.neighborhood) beds5
FROM comps c1
GROUP BY neighborhood
order by beds3, beds4 DESC;

-- averages

select neighborhood, beds, round(avg(sqft)::NUMERIC, 2) as avg_sqft,
  round(avg(price)::NUMERIC, 2) as avg_price,
  round(avg(baths)::NUMERIC, 2) as avg_baths,
  round(avg(lot_size)::NUMERIC, 2)/ 43560 as acres,
  round(avg(year_built)::NUMERIC, 2) as avg_year,
  sum(case when beds = 2 then 1 else 0 end) as sell_count,
  round(avg(days_on_market)::NUMERIC, 2) as avg_year
from comps
  where beds = 2
group by neighborhood, beds;