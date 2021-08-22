    (
    SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY attribute_id order by _daton_batch_runtime desc) row_number
FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_eav_attribute` )
WHERE row_number = 1
  )