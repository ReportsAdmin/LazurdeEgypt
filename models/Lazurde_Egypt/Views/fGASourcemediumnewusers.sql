

select * except(row_number) from(
select *,row_number() over ( partition by StartDate, D_ga_sourcemedium,D_ga_campaign order by _daton_batch_runtime desc) row_number
from `noted-computing-279322.MissL1.Lazurde_ga_60023196_sourcemediumnewusers`
)
where row_number=1





