select * from (
select distinct entity_id Productid,attribute	AttributeName,value1 as Value ,'Lazurde_Egypt' Halo_Country from

(select a.entity_id,a.attribute_set_id,a.type_id,a.sku, b.attribute_id, b.frontend_label as attribute,
b.attribute_code, av.value as av_value,av.store_id as av_store_id, ao.value as value1, ao.value_id,ao.store_id
from `noted-computing-279322.halo_1_1_lazurdeEgypt.magento_productentity` a
left join `noted-computing-279322.halo_1_1_lazurdeEgypt.magento_productentityint` av on a.entity_id = av.entity_id
left join `noted-computing-279322.halo_1_1_lazurdeEgypt.magento_producteav` b on av.attribute_id = b.attribute_id
left join `noted-computing-279322.halo_1_1_lazurdeEgypt.magento_producteavoptionvalue` ao on av.value = ao.option_id)

where lower(attribute) in ('jewelry collection','color','karat','allow amount range')
)