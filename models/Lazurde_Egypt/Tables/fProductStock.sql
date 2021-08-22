select Inventory,product_id as productid,null Sizes,Selling_Price,null Discount,
     Case when selling_price>=100 and selling_price<10000 then "0 to 11k"
          when selling_price>=10000 and selling_price<=15000 then "11K to 15k"
          when selling_price>15000 and selling_price<=25000 then "15K to 25k"
          when selling_price>25000 and selling_price<=35000 then "25k to 35k"
          when selling_price>35000 and selling_price<=50000 then "25k to 35k"
          when selling_price>50000 then "Above 50k"
          else "other" End as Selling_Price_Category ,
          'Lazurde_Egypt' Halo_Country
          ,MRP
from(
select distinct prd.product_id, prd.stock as inventory, max(pei.value) as MRP, max(pei.value) as Selling_Price from `noted-computing-279322.halo_1_1_lazurdeEgypt.fproducts` prd
left join (    SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY value_id order by _daton_batch_runtime desc) row_number
FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_entity_decimal`)
WHERE row_number = 1 and attribute_id = 77) pei
on prd.product_id = pei.entity_id
group by 1,2
order by product_id
)