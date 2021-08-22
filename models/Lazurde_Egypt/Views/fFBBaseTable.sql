select * from
(
select  * from (
SELECT * except(row_number)
FROM (
SELECT *, 'KSA' as country, ROW_NUMBER() OVER (partition by ad_id,date_start order by _daton_batch_runtime desc) row_number
FROM `noted-computing-279322.MissL1.halo_lazurde_fb_263542451604753_adinsights`)
WHERE row_number = 1
-- and date_start > '2020-08-31'
)

    )
where country  = 'KSA'