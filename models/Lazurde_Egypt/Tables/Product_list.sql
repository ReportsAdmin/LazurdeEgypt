select
distinct a.*,
# b.category_id,
(case when d.parent_id in (471) then 'Diamonds'
  when  d.parent_id in (451) then 'MissL'
  when d.parent_id in (452) then 'Lazurde Instyle' else 'Others' end) as brand
from
     (select * from(
select *,row_number() over (partition by entity_id order by _daton_batch_runtime desc) row_number
from `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_product_entity`
)
where row_number=1) a


left join
(select * from(
select *,row_number() over (partition by product_id,category_id order by _daton_batch_runtime desc) row_number
from `noted-computing-279322.MissL1.Lazurde_lazurde_live_catalog_category_product`
)) b


on a.entity_id = b.product_id
left join `noted-computing-279322.halo_1_1_lazurdeEgypt.magento_productentity` c
on c.entity_id = b.category_id
left join `noted-computing-279322.halo_1_1_lazurdeEgypt.magento_productcategoryentity` d
on b.category_id = d.entity_id
where d.parent_id in (451,471,452)
