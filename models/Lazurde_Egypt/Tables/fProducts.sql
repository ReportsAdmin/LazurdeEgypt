select distinct cpe.entity_id as product_id, cpe.created_at,
                cpe.updated_at, cpe.sku, cpev.value as Product_name, ciss.qty as stock,
  (case when cpw.website_id = 1 then 'KSA'
    when cpw.website_id = 2 then 'Egypt'
    when cpw.website_id = 3 then 'UAE'
    else 'Not Defined' end) as country,
  (case when cpe.entity_id in
    (select distinct entity_id from
          (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY value_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_entity_int`)
          WHERE row_number = 1)
    where attribute_id = 97 and value = 1)
    then 'Active' else 'Inactive' end) as SKU_status,
  (case when lower(categories_brand.category) like '%gold%'  then  'Gold'
    when  lower(categories_brand.category) like '%l%azurde%diamonds%' then 'Lazurde Diamonds'
    when  lower(categories_brand.category) like '%miss%l%' then 'MissL'
    when  lower(categories_brand.category) like '%instyle%' then 'Lazurde Instyle'
    when  lower(categories_brand.category) like '%kenaz%' then 'Kenaz'
    when  lower(categories_brand.category) like '%free%gift%' then 'Free Gift'
    else 'Not Defined' end) as category,
  (case when  lower(categories_tb.category) like '%link%'  then  'Link Bracelets'
    when  lower(categories_tb.category) like '%bracelet%'  then  'Bracelets'
    when  lower(categories_tb.category) like '%necklace%'  then  'Necklaces'
    when  lower(categories_tb.category) like '%earring%'  then  'Earrings'
    when  lower(categories_tb.category) like '%ring%'  then  'Rings'
    when  lower(categories_tb.category) like '%anklet%'  then  'Anklets'
    when  lower(categories_tb.category) like '%pendant%'  then  'Pendants'
    when  lower(categories_tb.category) like '%glove%'  then  'Hand Gloves'
    when  lower(categories_tb.category) like '%coins%'  then  'Gold Coins & Bars'
    when  lower(categories_tb.category) like '%free%gift%' then 'Free Gift'
    when  lower(categories_tb.category) like '%set%' then 'Sets'
    else 'Not Defined' end) as sub_category
from (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_entity`)
          WHERE row_number = 1) cpe
left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY product_id,website_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_website`)
          WHERE row_number = 1) cpw
  on cpe.entity_id = cpw.product_id
left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY value_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_entity_varchar`)
          WHERE row_number = 1) cpev
  on cpe.entity_id = cpev.entity_id
left join
  (select entity_id, STRING_AGG(value) as category from
    (select distinct cpe.entity_id, cce.entity_id as category_id, ccev.value
    from (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_entity`)
          WHERE row_number = 1) cpe
    left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_category_product`)
          WHERE row_number = 1) ccp
    on cpe.entity_id = ccp.product_id
    left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY value_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_category_entity_varchar`)
          WHERE row_number = 1) ccev
      on ccp.category_id = ccev.entity_id
    left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_category_entity`)
          WHERE row_number = 1) cce
      on ccev.entity_id = cce.entity_id
      where cce.level = 3 and ccev.attribute_id = 45) cats
    group by entity_id) categories_tb
on cpe.entity_id = categories_tb.entity_id
left join
  (select entity_id, value as category from
    (select distinct cpe.entity_id, cce.entity_id as category_id, ccev.value
    from (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_entity`)
          WHERE row_number = 1) cpe
    left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_category_product`)
          WHERE row_number = 1) ccp
    on cpe.entity_id = ccp.product_id
    left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY value_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_category_entity_varchar`)
          WHERE row_number = 1) ccev
      on ccp.category_id = ccev.entity_id
    left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_category_entity`)
          WHERE row_number = 1) cce
      on ccev.entity_id = cce.entity_id
      where cce.level=2  and ccev.attribute_id = 45
        and (lower(ccev.value) in ('kenaz', 'gold') or lower(ccev.value) like '%miss%l%' or
             lower(ccev.value) like '%instyle%' or lower(ccev.value) like '%l%azurde%diamonds%') or
             lower(ccev.value) like '%free%gift%' )cats
--     group by entity_id
    ) categories_brand
on cpe.entity_id = categories_brand.entity_id
left join (SELECT * except(row_number)
          FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY product_id order by _daton_batch_runtime desc) row_number
          FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_cataloginventory_stock_status`)
          WHERE row_number = 1) ciss
on cpe.entity_id = ciss.product_id
where cpev.attribute_id =  73 and cpev.store_id = 0
and cpw.website_id = 1
order by cpe.entity_id