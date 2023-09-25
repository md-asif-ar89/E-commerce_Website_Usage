
-- creating database
create database ecom_website;

use ecom_website;


-- query to create table structure in which csv flie data will be imported
create table events (
event_time text,
event_type text,
product_id int,
category_id bigint,
category_code text,
brand text,
price double,
user_id bigint,
user_session text
);


-- here you can set file path and file name as per your setting
load data infile 'D:\\ASIF FILES_PC1\\zz_test\\events.csv' into table events
fields terminated by ','
ignore 1 lines;


-- removing "UTC" from event_time values
update events set event_time = ltrim(substring_index(event_time, ' ', 2));


-- changing data type of event_time from text to datetime
alter table events
modify column event_time datetime;


/*
As of September 2020, the total number of records is less than 30,000, 
while for other months, the number of records falls within the range of 150,000 to 200,000.
Therefore, we can consider deleting the records from September 2020 for a more accurate analysis.
*/
delete from events
where event_time like '2020-09%';


select count(*) from events;
select * from events limit 5;
describe events;
