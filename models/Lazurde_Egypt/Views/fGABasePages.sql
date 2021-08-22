-- 
-- select  * from `noted-computing-279322.MissL1.Lazurde_ga_60023196_page`
-- 
-- 




select  * from (
SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY D_ga_date,D_ga_pagePath,D_ga_deviceCategory
                                                order by _daton_batch_runtime desc) row_number
FROM `noted-computing-279322.MissL1.Lazurde_ga_60023196_page`)
WHERE row_number = 1
)


