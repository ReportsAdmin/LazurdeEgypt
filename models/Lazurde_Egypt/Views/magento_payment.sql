
    SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY entity_id order by _daton_batch_runtime desc) row_number 
FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_sales_order_payment`)
WHERE row_number = 1