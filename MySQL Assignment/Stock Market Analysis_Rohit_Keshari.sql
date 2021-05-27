
-- Created schema as Assignment
use Assignment;

-- lets view the all table data
select * from bajaj_auto;
select * from eicher_motors;
select * from hero_motocorp;
select * from infosys;
select * from tcs;
select * from tvs_motors;

-- lets check the datatype of date column from each table and change to date format

-- bajaj_auto
SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS   
WHERE table_name = 'bajaj_auto' AND COLUMN_NAME = 'Date';

-- Update
update bajaj_auto
set `Date`=  str_to_date(`Date`,'%d-%M-%Y');

-- Alter
alter table bajaj_auto
modify `Date` date ;

-- eicher_motors

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS   
WHERE table_name = 'eicher_motors' AND COLUMN_NAME = 'Date';

-- Update
update eicher_motors
set `Date`=  str_to_date(`Date`,'%d-%M-%Y');

-- Alter
alter table bajaj_auto
modify `Date` date ;

-- hero_motocorp

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS   
WHERE table_name = 'hero_motocorp' AND COLUMN_NAME = 'Date';

-- Update
update hero_motocorp
set `Date` =  str_to_date(`Date`,'%d-%M-%Y');

-- Alter
alter table hero_motocorp
modify `Date` date ;

-- infosys

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS   
WHERE table_name = 'infosys' AND COLUMN_NAME = 'Date';

-- Update
update infosys
set `Date` =  str_to_date(`Date`,'%d-%M-%Y');

-- Alter
alter table infosys
modify `Date` date ;

-- tcs

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS   
WHERE table_name = 'tcs' AND COLUMN_NAME = 'Date';

-- Update
update tcs
set `Date` =  str_to_date(`Date`,'%d-%M-%Y');

-- Alter
alter table tcs
modify `Date` date ;

-- tvs_motors

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS   
WHERE table_name = 'tvs_motors' AND COLUMN_NAME = 'Date';

-- Update
update tvs_motors
set `Date` =  str_to_date(`Date`,'%d-%M-%Y');

-- Alter
alter table tvs_motors
modify `Date` date ;

-- We have changed the datatype of Date columns for all table, lets move the main Task. 

-- 1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)

-- 'bajaj1' table

drop table if exists `bajaj1`;

create table bajaj1
  as (select Date as `Date`, `Close Price` as `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`,
  row_number()     over (order by `Date` ) as `Row_Num`
  from `bajaj_auto`);

select * from bajaj1 order by Date;

# deleting the row as this not have Moving average which we need here for analysis
delete from bajaj1 
where  Row_Num < 50;

alter table bajaj1
drop column Row_Num;
  
select * from bajaj1 order by `Date`;
 

-- 'eicher_motors' table

drop table if exists `eicher_motors1`;

create table eicher_motors1
  as (select Date as `Date`, `Close Price` as `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`,
  row_number() over (order by `Date` ) as `Row_Num`
  from `eicher_motors`);

select * from eicher_motors1 order by Date;

# deleting the row as this not have Moving average which we need here for analysis
delete from eicher_motors1 
where  Row_Num < 50;

alter table eicher_motors1
drop column Row_Num;
  
select * from eicher_motors1 order by `Date`;

-- 'hero_motocorp' table
drop table if exists `hero_motocorp1`;
create table hero_motocorp1
  as (select Date as `Date`, `Close Price` as `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`,
  row_number() over (order by `Date` ) as `Row_Num`
  from `hero_motocorp`);

select * from hero_motocorp1 order by Date;

# deleting the row as this not have Moving average which we need here for analysis
delete from hero_motocorp1 
where  Row_Num < 50;

alter table hero_motocorp1
drop column Row_Num;
  
select * from hero_motocorp1 order by `Date`;

-- 'infosys' table
drop table if exists `infosys1`;

create table infosys1
  as (select Date as `Date`, `Close Price` as `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`,
  row_number() over (order by `Date` ) as `Row_Num`
  from `infosys`);

select * from infosys1 order by Date;

# deleting the row as this not have Moving average which we need here for analysis
delete from infosys1 
where  Row_Num < 50;

alter table infosys1
drop column Row_Num;
  
select * from infosys1 order by `Date`;


-- 'tcs' table
drop table if exists `tcs1`;

create table tcs1
  as (select Date as `Date`, `Close Price` as `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`,
  row_number() over (order by `Date` ) as `Row_Num`
  from `tcs`);

select * from tcs1 order by Date;

# deleting the row as this not have Moving average which we need here for analysis
delete from tcs1 
where  Row_Num < 50;

alter table tcs1
drop column Row_Num;
  
select * from tcs1 order by `Date`;

-- 'tvs_motors' table
drop table if exists `tvs_motors1`;

create table tvs_motors1
  as (select Date as `Date`, `Close Price` as `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`,
  row_number() over (order by `Date` ) as `Row_Num`
  from `tvs_motors`);

select * from tvs_motors1 order by Date;

# deleting the row as this not have Moving average which we need here for analysis
delete from tvs_motors1 
where  Row_Num < 50;

alter table tvs_motors1
drop column Row_Num;
  
select * from tvs_motors1 order by `Date`;


-- 2. Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock)

drop table if exists `master`;
CREATE TABLE master
select bajaj.Date as Date , bajaj.`Close Price` as Bajaj , tcs.`Close Price` as TCS , 
tvs.`Close Price` as TVS , info.`Close Price` as Infosys , eicher.`Close Price` as Eicher , hero.`Close Price` as Hero
from `bajaj_auto` bajaj
inner join `tcs` tcs on tcs.Date = bajaj.Date
inner join `tvs_motors` tvs on tvs.Date = bajaj.Date
inner join `infosys` info on info.Date = bajaj.Date
inner join `eicher_motors` eicher on eicher.Date = bajaj.Date
inner join `hero_motocorp` hero on hero.Date = bajaj.Date ;

select * from master order by Date;

-- 3. Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'.
--  Perform this operation for all stocks.

-- Concept to decide Buy and Sell :
		-- When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY, 
		-- as it indicates that the trend is shifting up. This is known as a Golden Cross.

		-- On the opposite when the shorter term moving average crosses below the longer term moving average, 
		-- it is a signal to SELL, as it indicates the trend is shifting down. It is sometimes referred to as the Death Cross.

-- bajaj_auto
drop table if exists `bajaj2`;

CREATE TABLE bajaj2 AS
SELECT Date, `Close Price`, 
case 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'Sell'
ELSE 'Hold'
END AS `Signal`
FROM bajaj1;

select * from bajaj2;

-- eicher_motors
drop table if exists `eicher_motors2`;


CREATE TABLE eicher_motors2 AS
SELECT Date, `Close Price`, 
case 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'Sell'
ELSE 'Hold'
END AS `Signal`
FROM eicher_motors1;

select * from eicher_motors2;

-- hero_motocorp

drop table if exists `hero_motocorp2`;

CREATE TABLE hero_motocorp2 AS
SELECT Date, `Close Price`, 
case 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'Sell'
ELSE 'Hold'
END AS `Signal`
FROM hero_motocorp1;

select * from hero_motocorp2;


-- infosys
drop table if exists `infosys2`;

CREATE TABLE infosys2 AS
SELECT Date, `Close Price`, 
case 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'Sell'
ELSE 'Hold'
END AS `Signal`
FROM infosys1;

select * from infosys2;

-- tcs

drop table if exists `tcs2`;

CREATE TABLE tcs2 AS
SELECT Date, `Close Price`, 
case 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'Sell'
ELSE 'Hold'
END AS `Signal`
FROM tcs1;

select * from tcs2;

-- tvs_motors
drop table if exists `tvs_motors2`;


CREATE TABLE tvs_motors2 AS
SELECT Date, `Close Price`, 
case 
WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'Buy'
WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'Sell'ELSE 'Hold'
END AS `Signal`
FROM tvs_motors1;

select * from tvs_motors2;

-- 4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.

delimiter $$

create function signal_funt( input_date Date)
returns varchar(15)
deterministic
begin
declare signal_val varchar(15);
select `Signal` into signal_val 
from bajaj2
where `Date` = input_date;
return signal_val;
end $$

delimiter ;

-- Lets run the function
-- Before that make sure the enter the date in this format -: YYYY-MM-DD 

select signal_funt('2015-12-17') as signal_val; # result for this - Buy
select signal_funt('2015-12-23') as signal_val; # result for this - Sell
select signal_funt('2015-12-29') as signal_val; # result for this - Hold

-- lets verify the test result which we got in above steps from UDF.
select * from bajaj2 where `Date` = '2015-12-17'; # expeted result - Buy
select * from bajaj2 where `Date` = '2015-12-23'; # expeted result - Sell
select * from bajaj2 where `Date` = '2015-12-29'; # expeted result - Hold


-- Thank you



 