# dashboard_NorthWind_Database
Building a dashboard summarizing the Northwind Database

![Dashboard](https://github.com/asyaparfenova/dashboard_NorthWind_Database/blob/main/images/dashboard_prtscr.png?raw=true "Metabase Dashboard / PrintScreen")

In this project, I built a dashboard using open source service Metabase summarizing the Northwind Database. It is a sample database that is shipped along with Microsoft Access. The data is about “Northwind Traders”, a fictional company. The database contains all sales transactions between the company and its customers as well as purchases from Northwinds suppliers.
Data  was prepared by SPICED Academy Instructor [Paul Wlodkowski](https://github.com/pawlodkowski) and available in [his repository](https://github.com/pawlodkowski/northwind_data_clean). 

For this project data was apploaded into PostgreSQL Database in Amazon RDS instance. Then Metabase was installed on an AWS EC2 Machine and used for creating a publically available [Metabase dashboard](http://52.59.170.229/public/dashboard/c8bd210d-3b70-4d7f-916d-ffe902ebd4c6).

I also created a dashboard for this dataset in Power BI, following instructions from [this lesson](https://www.youtube.com/watch?v=czON7fhEuYI&t=1599s) in YouTube Channel [PK: An Excel Expert](https://www.youtube.com/c/PKAnExcelExpert/about)

![PowerBI](https://github.com/asyaparfenova/dashboard_NorthWind_Database/blob/main/images/PowerBI1.png?raw=true "PowerBI Dashboard / Printscreen")

Repo content:
In file database_creation.sql there is sql-code for creating tables and copying data from csv-files (check the path!) to database. It works only from command line!
In file dashboard_queries.sql there are some examples of sql-queries that I used to create a dashboard in metabase.
