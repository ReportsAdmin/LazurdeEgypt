
   SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by (DATETIME(Updated_at, "Asia/Riyadh")) desc) row_number
FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_customer_entity`  )
WHERE row_number = 1
and store_id in (3,4)