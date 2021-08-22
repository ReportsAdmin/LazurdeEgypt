


select * from
(select * except(row_number) from(
select *,row_number() over ( partition by D_ga_date , D_ga_deviceCategory, D_ga_browser order by _daton_batch_runtime desc) row_number
from `noted-computing-279322.MissL1.Lazurde_ga_60023196_device_browser`
)
where row_number=1)





