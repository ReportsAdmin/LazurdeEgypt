(select *,case when campaign_name like '%KSA%' then 'KSA'
when campaign_name like '%SA%' then 'KSA'
when campaign_name like '%Saudi%' then 'KSA' else 'Egypt' end as country,
case when campaign_name like '%BF%' then 'True' else 'False' end as Retargeting from
(select distinct date_start,campaign_id,campaign_name,publisher_platform as platform,sum(spend)cost
from `noted-computing-279322.MissL1.halo_lazurde_fb_2922033074692672_adinsights_breakdown_publisher_platform`
group by 1,2,3,4))