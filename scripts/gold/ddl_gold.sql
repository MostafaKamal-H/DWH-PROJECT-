--ddl script : create a gold viewa 
--script purpose :
-- this script creates views for the gold layer in hte  DWH
-- the gold layer represents the final dimention and fact tables (star schema)
-- usage : this views can be quired directly for analytics and reports

--==================
--bulid dim_customers
--===================
create view gold.dim_customers as 
select 
      row_number() over (order by cst_id )as customer_key,
      cci.cst_id as customer_id ,
      cci.cst_key as customer_number ,
      cci.cst_firstname as first_name ,
      cci.cst_lastname as last_name ,
       el.cntry as country,
      cci.cst_marital_status as marital_status ,
       case 
      	   when  cci.cst_gndr != 'N/A' then cci.cst_gndr /* Use CRM gender if it is not 'N/A'.
														-- 2) If CRM contains 'N/A', use ERP gender instead.
														-- 3) If ERP value is NULL, default to 'N/A'.*/
           else coalesce(ec.gen,'N/A') 
       end as gender,
       ec.bdate as birthdate ,
      cci.cst_create_date as create_date 
from silver.crm_cust_info cci 
left join silver.erp_cust ec 
on cci.cst_key  =ec.cid 
left join silver.erp_loc el 
on cci.cst_key =el.cid ; 



--============================
---- bulid a dim_product ----
--============================
create view gold.dim_products as
select 
       row_number() over(order by prd_start_dt ,prd_key )as product_key,
       cpi.prd_id as product_id,
       cpi.prd_key as product_number ,
       cpi.prd_nm as product_name,
       cpi.cat_id as category_id ,
       epcgv.cat as category ,
       epcgv.subcat as sub_category ,
       epcgv.maintenance ,
       cpi.prd_cost as cost,
       cpi.prd_line as product_line ,
       cpi.prd_start_dt  as start_date
from silver.crm_prd_info cpi
left join silver.erp_px_car_g1v2 epcgv 
on cpi.cat_id = epcgv.id 
where  cpi.prd_end_dt is null  ;--prd_end_date indicates the end date of the product.
                                -- If NULL, the product is still active/current.
--

--======================================
-- bulid_fact_sales
--======================================
create view gold.fact_sales as
select 
      csd.sls_ord_num as order_number ,
      dp.product_key   ,
      dc.customer_key ,
      csd.sls_order_dt as order_date ,
      csd.sls_ship_dt as shipping_date,
      csd.sls_due_dt as due_date ,
      csd.sls_sales  as sales_amount,
      csd.sls_quantity as quantity,
      csd.sls_price as price
from silver.crm_sales_details csd 
left join gold.dim_products dp 
on csd.sls_prd_key =dp.product_number
left join gold.dim_customers dc  
on csd.sls_cust_id =dc.customer_id ;




 
