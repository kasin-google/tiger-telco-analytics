This document assumes dbt Cloud is used. Similar steps should apply to dbt CLI as well.

https://github.com/kasin-google/tiger-telco-analytics.git 

### Prerequisites on GCP / BigQuery

1. Create a service account with relevant permissions for dbt to access GCP resources including BigQuery and generate key as .json file e.g. dbt-user@caramel-brook-342204.iam.gserviceaccount.com
2. Create dataset
    1. 1 dataset for dbt development branch e.g. caramel-brook-342204.dbt_dataset 
    2. 1 dataset for dbt snapshot e.g.  caramel-brook-342204.dbt_dataset_snapshot 
3. Create tables as source input e.g.
    1. caramel-brook-342204.dbt_dataset.jaffle_shop_orders
    1. caramel-brook-342204.dbt_dataset.jaffle_shop_customers

by either
- Upload from CSV files into native tables
- Upload CSV files to a GCS bucket and create as external tables
- Upload CSV files to Google Drive and create as external tables (convenient option for testing new records and SCD type 2)

### Prerequisites on dbt (Cloud or CLI), this document assumes dbt Cloud is used

1. Create account and project
2. Create connection to BigQuery using .json key (e.g. to allow dbt to authenticate as the service account created in an earlier step)
3. By default, dbt will use location US. Edit under dbt Connection to BigQuery Optional Settings to specify location to ‘asia-southeast1’ or as appropriate

### To test:

1. dbt_project.yml, change project name on line 5 and 35
2. model/schema.yml
    1. Change line 5 to your project ID
    2. Change line 6 to your dataset ID
    3. Check line 9, 15 to match your source tables created in BigQuery
3. snapshots/snapshot_customer.sql
    1. Change line 5 to your project ID
    2. Change line 6 to your dataset ID

### Example to schedule daily run job:

1. dbt test
2. dbt run *** 
    - Compile SELECT statement ทั้งหมดบน dbt ให้กลายเป็น DDL, DML ที่ถูกต้อง และ submit ไปยัง BigQuery
    - สามารถแปลงข้อมูลผ่าน materialization mode – view / table / incremental / ephemeral ได้
3. dbt snapshot *** (อ่าน table ผ่าน strategy ระหว่าง timestamp vs check เพื่อ snapshot สำหรับ SCD type 2)
    - Snapshot จะถูกสร้างแยก BigQuery dataset ไว้ เพื่อลดความเสี่ยงถูกลบ เนื่องจากนำกลับมาไม่ได้
4. dbt docs generate 


### Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
