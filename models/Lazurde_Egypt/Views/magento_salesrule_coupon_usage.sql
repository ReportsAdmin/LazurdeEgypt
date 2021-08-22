    SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY coupon_id,customer_id order by times_used desc) row_number
FROM `noted-computing-279322.MissL1.Lazurde_lazurde_live_salesrule_coupon_usage` )
WHERE row_number = 1