select ta.*,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',Enddate))) Value_DateRange,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',PrevX_Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',PrevX_Enddate))) PrevValue_DateRange,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',PrevYearX_Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',PrevYearX_Enddate))) PrevYearValue_DateRange,
case when lower(KPI) like '%bounce%' and lower(KPI) not like '%non%bounce' then safe_divide(-(Value-prevValue),prevValue) else safe_divide((Value-prevValue),prevValue) end Change_PrevX,
case when lower(KPI) like '%bounce%' and lower(KPI) not like '%non%bounce' then safe_divide(-(Value-prevyearvalue),prevyearvalue) else safe_divide((Value-prevyearvalue),prevyearvalue) end Change_PrevYearX,
tb.KPI_ID,
tb.KPI_FORMAT
from
(
select
Halo_country,
KPI,
'WTD' date,
'Week' XTD,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), ISOWEEK) and current_date() then Value else 0 end)Value,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), ISOWEEK), INTERVAL 1 DAY), ISOWEEK) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK) then Value else 0 end) prevValue,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),ISOWEEK),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then Value else 0 end) prevyearvalue,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), ISOWEEK) and current_date() then date else null end) startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), ISOWEEK) and current_date() then date else '0' end) enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), ISOWEEK), INTERVAL 1 DAY), ISOWEEK) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK) then date else null end) PrevX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), ISOWEEK), INTERVAL 1 DAY), ISOWEEK) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK) then date else '0' end) PrevX_Enddate,


min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),ISOWEEK),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else null end) PrevYearX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),ISOWEEK),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else '0' end) PrevYearX_Enddate



from `noted-computing-279322.halo_1_1_lazurdeEgypt.fKPIs`
where XTD = 'Day'
--and PARSE_DATE('%Y%m%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), WEEK), INTERVAL 1 DAY), WEEK) and current_date()
group by Halo_country, KPI

union all

select
Halo_country,
KPI,
'MTD' date,
'Month' XTD,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), MONTH) and current_date() then Value else 0 end) Value,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 DAY), MONTH) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH) then Value else 0 end) prevValue,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),MONTH),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then Value else 0 end) prevyearvalue,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), MONTH) and current_date() then date else null end) startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), MONTH) and current_date() then date else '0' end) enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 DAY), MONTH) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH) then date else null end) PrevX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 DAY), MONTH) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH) then date else '0' end) PrevX_Enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),MONTH),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else null end) PrevYearX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),MONTH),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else '0' end) PrevYearX_Enddate

from `noted-computing-279322.halo_1_1_lazurdeEgypt.fKPIs`
where XTD = 'Day'
-- and PARSE_DATE('%Y%m%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 2 DAY), MONTH) and current_date()
group by Halo_country, KPI

union all

select
Halo_country,
KPI,
'QTD' date,
'Quarter' XTD,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), QUARTER) and current_date() then Value else 0 end) Value,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), QUARTER), INTERVAL 1 DAY), QUARTER) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 QUARTER) then Value else 0 end) prevValue,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),QUARTER),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then Value else 0 end) prevyearvalue,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), QUARTER) and current_date() then  date else null end) startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), QUARTER) and current_date() then  date else '0' end) enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), QUARTER), INTERVAL 1 DAY), QUARTER) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 QUARTER) then date else null  end) PrevX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), QUARTER), INTERVAL 1 DAY), QUARTER) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 QUARTER) then date else '0' end) PrevX_Enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),QUARTER),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else null end) PrevYearX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),QUARTER),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else '0' end) PrevYearX_Enddate




from `noted-computing-279322.halo_1_1_lazurdeEgypt.fKPIs`
where XTD = 'Day'
--and PARSE_DATE('%Y%m%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), QUARTER), INTERVAL 1 DAY), QUARTER) and current_date()
group by Halo_country, KPI

union all

select
Halo_country,
KPI,
'YTD' date,
'Year' XTD,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), YEAR) and current_date() then Value else 0 end) Value,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 DAY), YEAR) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) then Value else 0 end) prevValue,
sum(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),YEAR),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then Value else 0 end) prevyearvalue,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), YEAR) and current_date() then date else null end) startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), YEAR) and current_date() then date else '0' end) enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 DAY), YEAR) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) then date else null end) PrevX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 DAY), YEAR) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) then date else '0' end) PrevX_Enddate,
min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),YEAR),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else null end) PrevYearX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),YEAR),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else '0' end) PrevYearX_Enddate


from `noted-computing-279322.halo_1_1_lazurdeEgypt.fKPIs`
where XTD = 'Day'
-- and PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 DAY), YEAR) and current_date()
group by Halo_country, KPI
) ta,
`noted-computing-279322.halo_1_1_lazurdeEgypt.refKPI` tb
where ta.KPI = tb.KPI_VARIABLE
and lower(ta.KPI) not in ('sku_less_than_three', 'sku_more_than_six', 'sku_more_than_three')

union all

select ta.*,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',Enddate))) Value_DateRange,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',PrevX_Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',PrevX_Enddate))) PrevValue_DateRange,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',PrevYearX_Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',PrevYearX_Enddate))) PrevYearValue_DateRange,
case when lower(KPI) like '%bounce%' and lower(KPI) not like '%non%bounce' then safe_divide(-(Value-prevValue),prevValue) else safe_divide((Value-prevValue),prevValue) end Change_PrevX,
case when lower(KPI) like '%bounce%' and lower(KPI) not like '%non%bounce' then safe_divide(-(Value-prevyearvalue),prevyearvalue) else safe_divide((Value-prevyearvalue),prevyearvalue) end Change_PrevYearX,
tb.KPI_ID,
tb.KPI_FORMAT
from
(
select
Halo_country,
KPI,
'WTD' date,
'Week' XTD,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), ISOWEEK) and current_date() then Value else 0 end)Value,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), ISOWEEK), INTERVAL 1 DAY), ISOWEEK) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK) then Value else 0 end) prevValue,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),ISOWEEK),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then Value else 0 end) prevyearvalue,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), ISOWEEK) and current_date() then date else null end) startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), ISOWEEK) and current_date() then date else '0' end) enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), ISOWEEK), INTERVAL 1 DAY), ISOWEEK) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK) then date else null end) PrevX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), ISOWEEK), INTERVAL 1 DAY), ISOWEEK) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK) then date else '0' end) PrevX_Enddate,


min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),ISOWEEK),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else null end) PrevYearX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),ISOWEEK),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else '0' end) PrevYearX_Enddate



from `noted-computing-279322.halo_1_1_lazurdeEgypt.fKPIs`
where XTD = 'Day'
--and PARSE_DATE('%Y%m%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), WEEK), INTERVAL 1 DAY), WEEK) and current_date()
group by Halo_country, KPI

union all

select
Halo_country,
KPI,
'MTD' date,
'Month' XTD,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), MONTH) and current_date() then Value else 0 end) Value,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 DAY), MONTH) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH) then Value else 0 end) prevValue,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),MONTH),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then Value else 0 end) prevyearvalue,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), MONTH) and current_date() then date else null end) startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), MONTH) and current_date() then date else '0' end) enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 DAY), MONTH) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH) then date else null end) PrevX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 DAY), MONTH) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH) then date else '0' end) PrevX_Enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),MONTH),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else null end) PrevYearX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),MONTH),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else '0' end) PrevYearX_Enddate

from `noted-computing-279322.halo_1_1_lazurdeEgypt.fKPIs`
where XTD = 'Day'
-- and PARSE_DATE('%Y%m%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 2 DAY), MONTH) and current_date()
group by Halo_country, KPI

union all

select
Halo_country,
KPI,
'QTD' date,
'Quarter' XTD,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), QUARTER) and current_date() then Value else 0 end) Value,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), QUARTER), INTERVAL 1 DAY), QUARTER) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 QUARTER) then Value else 0 end) prevValue,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),QUARTER),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then Value else 0 end) prevyearvalue,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), QUARTER) and current_date() then  date else null end) startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), QUARTER) and current_date() then  date else '0' end) enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), QUARTER), INTERVAL 1 DAY), QUARTER) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 QUARTER) then date else null  end) PrevX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), QUARTER), INTERVAL 1 DAY), QUARTER) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 QUARTER) then date else '0' end) PrevX_Enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),QUARTER),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else null end) PrevYearX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),QUARTER),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else '0' end) PrevYearX_Enddate




from `noted-computing-279322.halo_1_1_lazurdeEgypt.fKPIs`
where XTD = 'Day'
--and PARSE_DATE('%Y%m%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), QUARTER), INTERVAL 1 DAY), QUARTER) and current_date()
group by Halo_country, KPI

union all

select
Halo_country,
KPI,
'YTD' date,
'Year' XTD,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), YEAR) and current_date() then Value else 0 end) Value,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 DAY), YEAR) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) then Value else 0 end) prevValue,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),YEAR),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then Value else 0 end) prevyearvalue,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), YEAR) and current_date() then date else null end) startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(CURRENT_DATE(), YEAR) and current_date() then date else '0' end) enddate,

min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 DAY), YEAR) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) then date else null end) PrevX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 DAY), YEAR) and DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) then date else '0' end) PrevX_Enddate,
min(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),YEAR),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else null end) PrevYearX_Startdate,
max(case when PARSE_DATE('%Y-%m-%d', date) between DATE_SUB(DATE_TRUNC(CURRENT_DATE(),YEAR),INTERVAL 1 YEAR) and DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) then date else '0' end) PrevYearX_Enddate


from `noted-computing-279322.halo_1_1_lazurdeEgypt.fKPIs`
where XTD = 'Day'
-- and PARSE_DATE('%Y-%m-%d', date) between DATE_TRUNC(DATE_SUB(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 DAY), YEAR) and current_date()
group by Halo_country, KPI
) ta,
`noted-computing-279322.halo_1_1_lazurdeEgypt.refKPI` tb
where ta.KPI = tb.KPI_VARIABLE
and lower(ta.KPI) in ('sku_less_than_three', 'sku_more_than_six', 'sku_more_than_three')