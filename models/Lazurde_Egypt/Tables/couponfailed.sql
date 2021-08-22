select c.date,a.failed_C_uniqueEvents,b.suceess_C_uniqueEvents,'Lazurde_KSA' Halo_Country from
(select date from `noted-computing-279322.halo_1_1_lazurdeksa.Calendar`)c

left join

(select distinct StartDate,sum(cast(M_ga_uniqueEvents as int64)) failed_C_uniqueEvents,'Lazurde_KSA' Halo_Country
from `noted-computing-279322.halo_1_1_lazurdeksa.fGABaseEvents`
where  lower(D_ga_eventCategory) like '%coupontracking%'
 and lower(D_ga_eventAction) like '%failure%' and lower(D_ga_eventLabel) != '(not set)' 
 group by 1,3)a

 on c.date=a.StartDate


left join
 (select distinct StartDate,sum(cast(M_ga_uniqueEvents as int64)) suceess_C_uniqueEvents ,'Lazurde_KSA' Halo_Country
from `noted-computing-279322.halo_1_1_lazurdeksa.fGABaseEvents`
where    lower(D_ga_eventCategory) like '%coupontracking%'
 and lower(D_ga_eventAction) like '%success%' and lower(D_ga_eventLabel) != '(not set)' 
 group by 1,3)b

 on c.date=b.StartDate