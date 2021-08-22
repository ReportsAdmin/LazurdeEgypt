Select Date, 1 as SNO,
       'Total Revenue (With VAT in EGP)' as KPI,
       ifnull(sum(total_item_price_auth),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 2 as SNO,
       'No. Of Transactions' as KPI,
       ifnull(sum(orders_auth),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand` where brand not in ('Free Gift')
group by 1

union all
Select Date, 3 as SNO,
       'Total Sold Qty' as KPI,
       ifnull(sum(total_product_quantity_auth),0) as VALUE,
    'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand` where brand not in ('Free Gift')
group by 1

union all
Select Date, 4 as SNO,
       'Average Transaction Value' as KPI,
       ifnull(sum(total_item_price_auth)/sum(orders_auth),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
group by 1


union all
Select Date, 5 as SNO,
       'Average Daily Sales' as KPI,
       ifnull(sum(total_item_price_auth),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
group by 1

union all
Select Date, 6 as SNO,
       'Unit per Transaction' as KPI,
       ifnull(sum(total_product_quantity_auth)/sum(orders_auth),0) as VALUE,
        'Decimal' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
group by 1

union all
Select Date, 7 as SNO,
       'COD (%)' as KPI,
       ifnull(avg(safe_divide(cod,orders_auth)),0) as VALUE,
      'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
-- where brand not in ('Free Gift')
group by 1

union all
Select Date, 8 as SNO,
       'CC (%)' as KPI,
       ifnull(avg(safe_divide(cc,orders_auth)),0) as VALUE,
        'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
-- where brand not in ('Free Gift')
group by 1

union all
Select Date, 9 as SNO,
       'Valu (%)' as KPI,
       ifnull(avg(safe_divide(valu,orders_auth)),0) as VALUE,
        'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
-- where brand not in ('Free Gift')
group by 1

union all
Select Date, 10 as SNO,
       'Returned/Refunded Orders (%)' as KPI,
       ifnull(avg(safe_divide(returned_orders,orders)),0) as VALUE,
        'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
group by 1


union all
Select Date, 11 as SNO,
       'Conversion Rate (%) ' as KPI,
       ifnull(avg(safe_divide(orders_auth,sessions)),0) as VALUE,
        'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
group by 1

union all
Select Date, 12 as SNO,
       'Instyle Total Revenue (With VAT in EGP)' as KPI,
       ifnull(sum(case when brand = 'Lazurde Instyle' then total_item_price_auth end),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 13 as SNO,
       'Instyle Total Units' as KPI,
       ifnull(sum(case when brand = 'Lazurde Instyle' then total_product_quantity_auth end),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 14 as SNO,
       'Instyle % of Revenue' as KPI,
       ifnull(sum(case when brand = 'Lazurde Instyle' then total_item_price_auth end)/sum(total_item_price_auth),0) as VALUE,
        'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1


union all
Select Date, 15 as SNO,
       'Miss L Total Revenue (With VAT in EGP)' as KPI,
       ifnull(sum(case when brand = 'MissL' then total_item_price_auth end),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand` where brand not in ('Free Gift')
group by 1

union all
Select Date, 16 as SNO,
       'Miss L Total Units' as KPI,
       ifnull(sum(case when brand = 'MissL' then total_product_quantity_auth end),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 17 as SNO,
       'Miss L % of Revenue' as KPI,
       ifnull(sum(case when brand = 'MissL' then total_item_price_auth end)/sum(total_item_price_auth),0) as VALUE,
        'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 18 as SNO,
       'Diamonds Total Revenue (With VAT in EGP)' as KPI,
       ifnull(sum(case when brand = 'Lazurde Diamonds' then total_item_price_auth end),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 19 as SNO,
       'Diamonds Total Units' as KPI,
       ifnull(sum(case when brand = 'Lazurde Diamonds' then total_product_quantity_auth end),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 20 as SNO,
       'Diamonds % of Revenue' as KPI,
       ifnull(sum(case when brand = 'Lazurde Diamonds' then total_item_price_auth end)/sum(total_item_price_auth),0) as VALUE,
        'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 21 as SNO,
       'Not Defined Total Revenue (With VAT in EGP)' as KPI,
       ifnull(sum(case when brand in ('Not Defined','') then total_item_price_auth end),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 22 as SNO,
       'Not Defined Total Units' as KPI,
       ifnull(sum(case when brand in ('Not Defined','') then total_product_quantity_auth end),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1

union all
Select Date, 23 as SNO,
       'Not Defined % of Revenue' as KPI,
       ifnull(sum(case when brand in ('Not Defined','') then total_item_price_auth end)/sum(total_item_price_auth),0) as VALUE,
        'Percentage' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg_brand`
group by 1



union all
Select Date, 24 as SNO,
       'Sessions' as KPI,
       ifnull(sum(Sessions),0) as VALUE,
        'Integer' as KPI_FORMAT
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAgg`
group by 1