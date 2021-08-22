SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY value_id order by _daton_batch_runtime desc) row_number
FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_eav_attribute_option_value` )
WHERE row_number = 1
and store_id in (3,4)