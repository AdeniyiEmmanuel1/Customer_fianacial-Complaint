

Create OR Alter View Gold.Fact_Customer_Complaints AS
Select
    Row_Number() Over(order by complaint_id) complaint_key,
    complaint_id,
    submitted_via,
    date_submitted,                 
    date_received,                  
    state_code,                     
    product,                    
    sub_product,                   
    issue,                          
    sub_issue,                      
    company_public_response,       
    company_response_to_consumer,   
    timely_response,               
    product_category,              
    sub_product_category,         
    issue_category,                 
    sub_issue_category,             
    is_timely_response,           
    has_public_response,           
    resolution_category,           
    response_lag_days,              
    submission_year,               
    submission_month,                   
    submission_month_name,          
    submission_quarter,                 
    submission_day_of_week,         
    submission_year_month,          
    us_region  
 From Silver.Customer_Complaints_Raw;
 Go

Select * From Gold.Fact_Customer_Complaints
