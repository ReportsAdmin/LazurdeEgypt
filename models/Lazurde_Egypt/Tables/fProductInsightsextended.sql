select distinct ifnull(prd.product_id,cast(ord.product_id as int64)) as product_id, prd.sku as product_sku, prd.stock  as inventory, ifnull(prd.category,'Not Defined') as category_L2,
ifnull(prd.sub_category,'Not Defined') as category_L1, prd.product_name as product_title, img.image,
                'Lazurde_Egypt' Halo_Country,
prd.stock, ord.order_date as date_start, Overall_orders,	Overall_units, impressions,
                clicks, productdetail_views, Addstocart,
Overall_revenue,	revenue,	units, orders,
stk.mrp, stk.selling_price
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fproducts` prd
full join

(select product_id, order_date,
count(distinct order_id) Overall_orders,
sum(product_quantity) Overall_units,
sum(total_item_price) Overall_revenue,
sum(case when order_status in ('successful') then total_item_price  end)  revenue,
Sum(case when order_status in ('successful') then product_quantity end) units,
count(distinct case when order_status in ('successful') then order_id end) orders
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fOrders`
group by product_id, order_date) ord
on prd.product_id = cast(ord.product_id as int64)

left join
(select distinct Product_id, Image from `noted-computing-279322.halo_1_1_lazurdeEgypt.fProductImage`) img
on prd.product_id = cast(img.product_id as int64)

left join (select D_ga_productSku, D_ga_date, sum(cast(M_ga_productListViews as float64)) impressions,
sum(cast(M_ga_productListClicks as float64)) clicks,
sum(cast(M_ga_productDetailViews as float64)) productdetail_views,
sum(cast(M_ga_productAddsToCart as float64)) Addstocart
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fGABaseSKU`
group by 1,2) sku
on cast(prd.product_id as string) = cast(sku.D_ga_productSku as string)
  and PARSE_DATE('%Y%m%d', sku.D_ga_date)= ord.order_date

left join `noted-computing-279322.halo_1_1_lazurdeEgypt.fProductStock` stk
on prd.product_id = cast(stk.productid as int64)