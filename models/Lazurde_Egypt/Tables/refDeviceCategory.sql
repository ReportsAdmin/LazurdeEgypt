select row_number() over() Devicecategory_id,Devicecategory,'Lazurde_Egypt' Halo_Country
from (
select distinct Devicecategory
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fShoppingStages`
)