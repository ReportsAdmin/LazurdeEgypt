select ta.* ,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',Enddate))) Value_DateRange,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',PrevX_Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',PrevX_Enddate))) PrevValue_DateRange,
concat(format_date('%d %b %y',parse_date('%Y-%m-%d',PrevYearX_Startdate)),' - ',format_date('%d %b %y',parse_date('%Y-%m-%d',PrevYearX_Enddate))) PrevYearValue_DateRange,
case when lower(KPI) like '%bounce%' and lower(KPI) not like '%non%bounce' then safe_divide(-(Value-prevvalue),prevvalue) else safe_divide((Value-prevvalue),prevvalue) end Change_PrevX,
case when lower(KPI) like '%bounce%' and lower(KPI) not like '%non%bounce' then safe_divide(-(Value-prevyearvalue),prevyearvalue) else safe_divide((Value-prevyearvalue),prevyearvalue) end Change_PrevYearX,
tb.KPI_ID,
tb.KPI_FORMAT
from
(
select
Halo_country,
KPI,
period_flag as XTD,
period_id date,
ifnull(Value,0) Value,

ifnull(lag(Value,1) over (partition by Halo_country,KPI,period_flag order by period_id),0) prevvalue,

ifnull(case when extract(year from parse_date('%Y-%m-%d',Startdate)) - 1 = extract(year from lag(parse_date('%Y-%m-%d',Startdate),1) over (partition by Halo_country,KPI,period_flag
order by  substr(period_id,5), cast(substr(period_id,1,4) as int64)
)) then lag(Value,1) over (partition by Halo_country,KPI,period_flag
order by  substr(period_id,5), cast(substr(period_id,1,4) as int64)
) end,0) prevyearvalue,

Startdate,
Enddate,

lag(Startdate,1) over (partition by Halo_country,KPI,period_flag order by period_id) PrevX_Startdate,

lag(Enddate,1) over (partition by Halo_country,KPI,period_flag order by period_id) PrevX_Enddate,

case when extract(year from parse_date('%Y-%m-%d',Startdate)) - 1 = extract(year from lag(parse_date('%Y-%m-%d',Startdate),1) over (partition by Halo_country,KPI,period_flag
order by  substr(period_id,5), cast(substr(period_id,1,4) as int64)
)) then lag(Startdate,1) over (partition by Halo_country,KPI,period_flag
order by  substr(period_id,5), cast(substr(period_id,1,4) as int64)
) end PrevYearX_Startdate,

case when extract(year from parse_date('%Y-%m-%d',Enddate)) - 1 = extract(year from lag(parse_date('%Y-%m-%d',Enddate),1) over (partition by Halo_country,KPI,period_flag
order by  substr(period_id,5), cast(substr(period_id,1,4) as int64)
)) then  lag(Enddate,1) over (partition by Halo_country,KPI,period_flag
order by  substr(period_id,5), cast(substr(period_id,1,4) as int64)
) end PrevYearX_Enddate



-- prvValue
from
(
select Halo_country,
KPI,
coalesce(date,dateweek,datemonth,datequarter,dateyear) period_id,
CASE WHEN datequarter is null THEN 'Year'
WHEN datemonth is null THEN 'Quarter'
WHEN dateweek is null THEN 'Month'
WHEN date is null THEN 'Week'
ELSE 'Day' END period_flag,
case when CASE WHEN datequarter is null THEN 'Y'
WHEN datemonth is null THEN 'Q'
WHEN dateweek is null THEN 'M'
WHEN date is null THEN 'W'
ELSE 'D' END = 'W' then
sum(Value) over(partition by Halo_country, KPI, CASE WHEN datequarter is null THEN 'Y'
WHEN datemonth is null THEN 'Q'
WHEN dateweek is null THEN 'M'
WHEN date is null THEN 'W'
ELSE 'D' END, coalesce(date,dateweek,datemonth,datequarter,dateyear))
else Value end Value,
case when CASE WHEN datequarter is null THEN 'Y'
WHEN datemonth is null THEN 'Q'
WHEN dateweek is null THEN 'M'
WHEN date is null THEN 'W'
ELSE 'D' END = 'W' then
min(Startdate) over(partition by Halo_country, KPI, CASE WHEN datequarter is null THEN 'Y'
WHEN datemonth is null THEN 'Q'
WHEN dateweek is null THEN 'M'
WHEN date is null THEN 'W'
ELSE 'D' END, coalesce(date,dateweek,datemonth,datequarter,dateyear))
else Startdate end Startdate,
case when CASE WHEN datequarter is null THEN 'Y'
WHEN datemonth is null THEN 'Q'
WHEN dateweek is null THEN 'M'
WHEN date is null THEN 'W'
ELSE 'D' END = 'W' then
max(Enddate) over(partition by Halo_country, KPI, CASE WHEN datequarter is null THEN 'Y'
WHEN datemonth is null THEN 'Q'
WHEN dateweek is null THEN 'M'
WHEN date is null THEN 'W'
ELSE 'D' END, coalesce(date,dateweek,datemonth,datequarter,dateyear))
else Enddate end Enddate,
case when CASE WHEN datequarter is null THEN 'Y'
WHEN datemonth is null THEN 'Q'
WHEN dateweek is null THEN 'M'
WHEN date is null THEN 'W'
ELSE 'D' END = 'W' then row_number() over(partition by Halo_country, KPI, CASE WHEN datequarter is null THEN 'Y'
WHEN datemonth is null THEN 'Q'
WHEN dateweek is null THEN 'M'
WHEN date is null THEN 'W'
ELSE 'D' END, coalesce(date,dateweek,datemonth,datequarter,dateyear) order by coalesce(date,dateweek,datemonth,datequarter,dateyear) desc)
else 1 end week_rno
from
(
select
Halo_country,
KPI,
dateyear,
datequarter,
datemonth,
dateweek,
date,
sum(Value) Value,
min(date) Startdate,
max(date) Enddate
-- sum(case when date <
from
(
select
Halo_country,
FORMAT_DATE('%Y-%m-%d', date) date,
FORMAT_DATE('%Y-%W', date) dateweek,
FORMAT_DATE('%Y-%m', date) datemonth,
FORMAT_DATE('%Y-%Q', date) datequarter,
FORMAT_DATE('%Y', date) dateyear,
Metrics_data.Metric KPI,
Metrics_data.Data Value,
max(date) over () current_date
from (
select
Halo_Country,
date,
Metrics_data
from (
select Halo_Country,date,
       [
       
                STRUCT('Sessions_G' as Metric, Sessions_G as Data)
            
                ,
            
        
                STRUCT('Impressions_G' as Metric, Impressions_G as Data)
            
                ,
            
        
                STRUCT('Adclicks_G' as Metric, Adclicks_G as Data)
            
                ,
            
        
                STRUCT('Addtocarts_G' as Metric, Addtocarts_G as Data)
            
                ,
            
        
                STRUCT('Bounces_G' as Metric, Bounces_G as Data)
            
                ,
            
        
                STRUCT('Spend_G' as Metric, Spend_G as Data)
            
                ,
            
        
                STRUCT('Transactions_G' as Metric, Transactions_G as Data)
            
                ,
            
        
                STRUCT('Revenue_G' as Metric, Revenue_G as Data)
            
        
        ] Metrics_data
        from (
select Halo_Country,date_start date,sum(sessions) Sessions_G, sum(Impressions) Impressions_G, sum(Adclickss) Adclicks_G, sum(Addtocarts) Addtocarts_G , sum(Bounces) Bounces_G, sum(Spend) Spend_G,
       sum(Orders) Transactions_G,sum(Revenue) Revenue_G
       from `noted-computing-279322.halo_1_1_lazurdeEgypt.fDailyAggMarketingFBGoogle` where source_medium in ('google / cpc')
--                                                                  and  date_start!=current_date()
       group by 1,2

   ))
cross join
unnest(Metrics_data) as Metrics_data
)) ta
group by rollup(Halo_country, KPI, dateyear, datequarter, datemonth, dateweek, date)
) where Halo_country is not null and KPI is not null
and coalesce(date,dateweek,datemonth,datequarter,dateyear) is not null
) where week_rno = 1
) ta,
`noted-computing-279322.halo_1_1_lazurdeEgypt.refKPI` tb
where ta.KPI = tb.KPI_VARIABLE