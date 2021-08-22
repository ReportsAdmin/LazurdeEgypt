
select * from
(Select Date,
  ifnull(sum(total_item_price_auth),0) as tot_rev,
  ifnull(avg(safe_divide(returned_orders,orders)),0) as returned_per,
  ifnull(avg(safe_divide(orders_auth,sessions)),0) as conv_rate,
  ifnull(sum(Sessions),0) as Sessions,
  ifnull(sum(cc),0) as cc,
  ifnull(sum(cod),0) as cod,
  ifnull(sum(valu),0) as valu,
  ifnull(sum(orders_auth),0) as orders_auth,

from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
group by 1) a

left join
(select Date as dt1,
  ifnull(sum(orders_auth),0) as tot_trans,
  ifnull(sum(total_item_price_auth)/sum(orders_auth),0) as avg_trans_value,
  ifnull(sum(total_item_price_auth),0) as avg_daly_sales,
  ifnull(sum(total_product_quantity_auth)/sum(orders_auth),0)  as UPT,
  ifnull(sum(total_product_quantity_auth),0) as tot_sold_qty,
  ifnull(sum(case when brand = 'Lazurde Instyle' then total_item_price_auth end),0) as instyle_rev,
  ifnull(sum(case when brand = 'Lazurde Instyle' then total_product_quantity_auth end),0) as instyle_qty,
  ifnull(sum(case when brand = 'Lazurde Instyle' then total_item_price_auth end)/sum(total_item_price_auth),0) as instyle_per,
  ifnull(sum(case when brand = 'Gold' then total_item_price_auth end),0) as Gold_rev,
  ifnull(sum(case when brand = 'Gold' then total_product_quantity_auth end),0) as Gold_qty,
  ifnull(sum(case when brand = 'Gold' then total_item_price_auth end)/sum(total_item_price_auth),0) as Gold_per,
  ifnull(sum(case when brand = 'Lazurde Diamonds' then total_item_price_auth end),0) as Diamonds_rev,
  ifnull(sum(case when brand = 'Lazurde Diamonds' then total_product_quantity_auth end),0) as Diamonds_qty,
  ifnull(sum(case when brand = 'Lazurde Diamonds' then total_item_price_auth end)/sum(total_item_price_auth),0) as Diamonds_per,
  ifnull(sum(case when brand = 'MissL' then total_item_price_auth end),0) as MissL_rev,
  ifnull(sum(case when brand = 'MissL' then total_product_quantity_auth end),0) as MissL_qty,
  ifnull(sum(case when brand = 'MissL' then total_item_price_auth end)/sum(total_item_price_auth),0) as MissL_per,
  ifnull(sum(case when brand in ('Not Defined','') then total_item_price_auth end),0) as Others_rev,
  ifnull(sum(case when brand in ('Not Defined','') then total_product_quantity_auth end),0) as Others_qty,
  ifnull(sum(case when brand in ('Not Defined','') then total_item_price_auth end)/sum(total_item_price_auth),0) as Others_per,
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
where brand not in ('Free Gift')
group by 1) b
on a.date = b.dt1
where a.date >= '2020-11-25'