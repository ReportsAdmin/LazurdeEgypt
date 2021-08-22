

select
distinct a.*,
 b.category_id,
(case when  b.category_id in (42)  then  'Gold'
  when  b.category_id in (43) then 'Diamonds'
  when  b.category_id in (46) then 'MissL'
  when  b.category_id in (49) then 'Lazurde Instyle'
  when  b.category_id in (484) then 'Kenaz'
  else 'Not Defined' end) as brand
from
     (select * from(
select *,row_number() over (partition by entity_id order by _daton_batch_runtime desc) row_number
from `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_entity`
)
where row_number=1) a
left join
`noted-computing-279322.halo_1_1_lazurdeksa.magento_productcategoryproduct` b
on a.entity_id = b.product_id
left join `noted-computing-279322.halo_1_1_lazurdeksa.magento_productentity` c
on c.entity_id = b.category_id
where b.category_id in (42,43,46,49,484)