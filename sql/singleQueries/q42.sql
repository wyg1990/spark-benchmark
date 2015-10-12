use tpcds_300G_parquet_snappy;

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
