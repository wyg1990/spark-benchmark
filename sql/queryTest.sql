use ${DB};

select
  i_brand_id,
  i_brand,
  i_manufact_id,
  i_manufact,
  sum(ss_ext_sales_price) ext_price
from
  store_sales
  join item on (store_sales.ss_item_sk = item.i_item_sk)
  join customer on (store_sales.ss_customer_sk = customer.c_customer_sk)
  join customer_address on (customer.c_current_addr_sk = customer_address.ca_address_sk)
  join store on (store_sales.ss_store_sk = store.s_store_sk)
  join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
where
  ss_sold_date_sk between 2451484 and 2451513
  and d_moy = 11
  and d_year = 1999
  and i_manager_id = 7
  and substr(ca_zip, 1, 5) <> substr(s_zip, 1, 5)
group by
  i_brand,
  i_brand_id,
  i_manufact_id,
  i_manufact
order by
  ext_price desc,
  i_brand,
  i_brand_id,
  i_manufact_id,
  i_manufact
limit 100;


select
  d_year,
  i_category_id,
  i_category,
  sum(ss_ext_sales_price) as total_price
from
  store_sales
  join item on (store_sales.ss_item_sk = item.i_item_sk)
  join date_dim dt on (dt.d_date_sk = store_sales.ss_sold_date_sk)
where
  item.i_manager_id = 1
  and dt.d_moy = 12
  and dt.d_year = 1998
  and ss_sold_date_sk between 2451149 and 2451179
group by
  d_year,
  i_category_id,
  i_category
order by
  total_price desc,
  d_year,
  i_category_id,
  i_category 
limit 100;


select
  d_year,
  i_brand_id,
  i_brand,
  sum(ss_ext_sales_price) ext_price
from
  store_sales
  join item on (store_sales.ss_item_sk = item.i_item_sk)
  join date_dim dt on (store_sales.ss_sold_date_sk = dt.d_date_sk)
where
  i_manager_id = 1
  and d_moy = 12
  and d_year = 1998
  and ss_sold_date_sk between 2451149 and 2451179 
group by
  d_year,
  i_brand,
  i_brand_id
order by
  d_year,
  ext_price desc,
  i_brand_id 
limit 100;


select
  i_brand_id,
  i_brand,
  sum(ss_ext_sales_price) ext_price
from
  store_sales
  join item on (store_sales.ss_item_sk = item.i_item_sk)
  join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
where
  i_manager_id = 36
  and d_moy = 12
  and d_year = 2001
  and ss_sold_date_sk between 2452245 and 2452275 
group by
  i_brand,
  i_brand_id
order by
  ext_price desc,
  i_brand_id
limit 100;


select
  *
from
  (select
    i_manager_id,
    sum(ss_sales_price) sum_sales
  from
    store_sales
    join item on (store_sales.ss_item_sk = item.i_item_sk)
    join store on (store_sales.ss_store_sk = store.s_store_sk)
    join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
  where
    ss_sold_date_sk between 2451911 and 2452275
    and d_month_seq in (1212, 1212 + 1, 1212 + 2, 1212 + 3, 1212 + 4, 1212 + 5, 1212 + 6, 1212 + 7, 1212 + 8, 1212 + 9, 1212 + 10, 1212 + 11)
    and (
          (i_category in('Books', 'Children', 'Electronics')
            and i_class in('personal', 'portable', 'refernece', 'self-help')
            and i_brand in('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9')
          )
          or 
          (i_category in('Women', 'Music', 'Men')
            and i_class in('accessories', 'classical', 'fragrances', 'pants')
            and i_brand in('amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1')
          )
        )
  group by
    i_manager_id,
    d_moy
  ) tmp1
order by
  i_manager_id,
  sum_sales
limit 100;


select
  c_last_name,
  c_first_name,
  ca_city,
  bought_city,
  ss_ticket_number,
  extended_price,
  extended_tax,
  list_price
from
  (select
    ss_ticket_number,
    ss_customer_sk,
    ca_city bought_city,
    sum(ss_ext_sales_price) extended_price,
    sum(ss_ext_list_price) list_price,
    sum(ss_ext_tax) extended_tax
  from
    store_sales
    join store on (store_sales.ss_store_sk = store.s_store_sk)
    join household_demographics on (store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk)
    join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
    join customer_address on (store_sales.ss_addr_sk = customer_address.ca_address_sk)
  where
    store.s_city in('Midway', 'Fairview')
        and (household_demographics.hd_dep_count = 5
      or household_demographics.hd_vehicle_count = 3)
    and d_date between '1999-01-01' and '1999-03-31'
    and ss_sold_date_sk between 2451180 and 2451269
  group by
    ss_ticket_number,
    ss_customer_sk,
    ss_addr_sk,
    ca_city
  ) dn
  join customer on (dn.ss_customer_sk = customer.c_customer_sk)
  join customer_address current_addr on (customer.c_current_addr_sk = current_addr.ca_address_sk)
where
  current_addr.ca_city <> bought_city
order by
  c_last_name,
  ss_ticket_number 
limit 100;


select
  c_last_name,
  c_first_name,
  c_salutation,
  c_preferred_cust_flag,
  ss_ticket_number,
  cnt
from
  (select
    ss_ticket_number,
    ss_customer_sk,
    count(*) cnt
  from
    store_sales
    join household_demographics on (store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk)
    join store on (store_sales.ss_store_sk = store.s_store_sk)
  where
    store.s_county in ('Saginaw County', 'Sumner County', 'Appanoose County', 'Daviess County')
    and (household_demographics.hd_buy_potential = '>10000'
      or household_demographics.hd_buy_potential = 'unknown')
    and household_demographics.hd_vehicle_count > 0
    and case when household_demographics.hd_vehicle_count > 0 then household_demographics.hd_dep_count / household_demographics.hd_vehicle_count else null end > 1
    and ss_sold_date_sk between 2451180 and 2451269
  group by
    ss_ticket_number,
    ss_customer_sk
  ) dj
  join customer on (dj.ss_customer_sk = customer.c_customer_sk)
where
  cnt between 1 and 5
order by
  cnt desc
limit 1000;


select
  c_last_name,
  c_first_name,
  substr(s_city, 1, 30) as city,
  ss_ticket_number,
  amt,
  profit
from
  (select
    ss_ticket_number,
    ss_customer_sk,
    s_city,
    sum(ss_coupon_amt) amt,
    sum(ss_net_profit) profit
  from
    store_sales
    join household_demographics on (store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk)
    join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
    join store on (store_sales.ss_store_sk = store.s_store_sk)
  where
    store.s_number_employees between 200 and 295
    and (household_demographics.hd_dep_count = 8
      or household_demographics.hd_vehicle_count > 0)
    and date_dim.d_dow = 1
    and date_dim.d_year in (1998, 1998 + 1, 1998 + 2)
  and d_date between '1999-01-01' and '1999-03-31'
  and ss_sold_date_sk between 2451180 and 2451269
  group by
    ss_ticket_number,
    ss_customer_sk,
    ss_addr_sk,
    s_city
  ) ms
  join customer on (ms.ss_customer_sk = customer.c_customer_sk)
order by
  c_last_name,
  c_first_name,
  city,
  profit
limit 100;


select
  i_item_desc,
  i_category,
  i_class,
  i_current_price,
  sum(ss_ext_sales_price) as itemrevenue
from
  store_sales 
  join item on (store_sales.ss_item_sk = item.i_item_sk)
  join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
where
  i_category in('Jewelry', 'Sports', 'Books')
  and ss_sold_date_sk between 2451911 and 2451941
  and d_date between '2001-01-01' and '2001-01-31'
group by
  i_item_id,
  i_item_desc,
  i_category,
  i_class,
  i_current_price
order by
  i_category,
  i_class,
  i_item_id,
  i_item_desc
limit 1000;
