
-- 
-- select  * from `noted-computing-279322.MissL1.lazurde_egypt_ga_236943373_cost`
-- 
-- 




SELECT * except(row_number) FROM
(SELECT *,ROW_NUMBER() OVER (PARTITION BY D_ga_date,D_ga_sourceMedium,D_ga_campaign,D_ga_keyword,D_ga_adContent
                                               order by _daton_batch_runtime desc) row_number
FROM `noted-computing-279322.MissL1.lazurde_egypt_ga_236943373_cost`)
WHERE row_number = 1

