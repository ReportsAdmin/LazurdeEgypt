

select * from
 (select * except(row_number) from(
select *,row_number() over ( partition by StartDate, D_ga_userAgeBracket order by _daton_batch_runtime desc) row_number
from `noted-computing-279322.MissL1.lazurde_egypt_ga_236943373_age`
)
where row_number=1)




