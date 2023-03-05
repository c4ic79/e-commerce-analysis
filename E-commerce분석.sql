with first_order_date  as
(
select distinct customer_id, min(order_date) as "���ʱ�������" --���Ա���̳� �ٸ� �αװ� ���� ������ ������ ���ʷ� ������ ������ ��¥�� ���� 
from super 
group by customer_id
),
order_record as
(
select f.customer_id,
       s.sub_category,
       round(s.sales) as sales,
       to_char(s.order_date,'yyyymm') as "���ſ�",
       to_char(s.order_date,'yyyymmdd') as "��������",
       f.���ʱ������� as "���ʱ�������",
       to_char(f.���ʱ�������, 'yyyymm') AS "���ʱ��ſ�",
       case when to_char(f.���ʱ�������)!=to_char(s.order_date) then 1 else 0 end as reorder
from super s 
inner join first_order_date f on s.customer_id=f.customer_id 

)

select ���ʱ��ſ�
       ,count(distinct case when ���ſ�=���ʱ��ſ� then customer_id end) "month0"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '1' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_1"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '2' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_2"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '3' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_3"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '4' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_4"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '5' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_5"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '6' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_6"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '7' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_7"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '8' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_8"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '9' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_9"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '10' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_10"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '11' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_11"
       ,round(count(distinct case when to_date(���ſ�,'yyyymm')>=to_date(���ʱ��ſ�,'yyyymm') + (interval '12' month) then customer_id end)*100/ count(distinct customer_id),2) "pct_12"

from order_record
group by ���ʱ��ſ�