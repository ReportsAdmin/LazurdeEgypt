select distinct StartDate,D_ga_country,sum(cast(M_ga_uniqueEvents as int64)) suceess_C_uniqueEvents ,'Lazurde_Egypt' Halo_Country
from `noted-computing-279322.halo_1_1_lazurdeEgypt.fGABaseEvents`
where    lower(D_ga_eventCategory) like '%coupontracking%'
 and lower(D_ga_eventAction) like '%success%' and lower(D_ga_eventLabel) != '(not set)' 
 group by 1,2,4