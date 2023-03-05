with first_order_date  as
(
select distinct customer_id, min(order_date) as "최초구매일자" --가입기록이나 다른 로그가 없기 때문에 유저가 최초로 물건을 구매한 날짜로 설정 
from super 
group by customer_id
),
order_record as
(
select f.customer_id,
       s.sub_category,
       round(s.sales) as sales,
       to_char(s.order_date,'yyyymm') as "구매월",
       to_char(s.order_date,'yyyymmdd') as "구매일자",
       f.최초구매일자 as "최초구매일자",
       to_char(f.최초구매일자, 'yyyymm') AS "최초구매월",
       case when to_char(f.최초구매일자)!=to_char(s.order_date) then 1 else 0 end as reorder
from super s 
inner join first_order_date f on s.customer_id=f.customer_id 

)

select 최초구매월
       ,count(distinct case when 구매월=최초구매월 then customer_id end) "month0"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '1' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_1"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '2' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_2"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '3' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_3"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '4' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_4"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '5' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_5"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '6' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_6"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '7' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_7"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '8' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_8"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '9' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_9"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '10' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_10"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '11' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_11"
       ,round(count(distinct case when to_date(구매월,'yyyymm')>=to_date(최초구매월,'yyyymm') + (interval '12' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_12"

from order_record
group by 최초구매월