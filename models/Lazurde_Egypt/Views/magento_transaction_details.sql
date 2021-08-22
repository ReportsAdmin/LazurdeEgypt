(select *except(sku1,sku),
case
when sku like '%-eg%' then sku
-- when lower(sku) not like '%ksa%' then concat(sku,sku1)
-- when sku like '%KSA%' then concat(substr(sku,1,11),sku1)
else concat(substr(sku,1,12),sku1) end as sku from
(select *,'-eg' as sku1 from
(SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY item_id order by Updated_at desc) row_number
FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_sales_order_item` )
WHERE row_number = 1
and store_id in (3,4))
))