-- check all tables
select * from customer;
select * from cust_account;
select * from cust_loc;
select * from cust_services;
select * from cust_churn;


-- performing basic analysis on customer table
-- check gender wise division of customer
select gender, count(gender) from customer group by gender;
-- we have almost equal representation

-- check for customer with or without partner
select partner, count(partner) from customer group by partner;

-- check for customer having dependents or not
select dependents, count(dependents) from customer group by dependents;

-- performing basic analysis on cust_account
-- finding average of numerical values
select round(avg(tenure),2) from cust_account;
select round(avg(monthlycharges),2) from cust_account;
select round(avg(TotalCharges),2) from cust_account;

select paymentmethod, count(paymentmethod) from cust_account group by paymentmethod;
-- electronic check is most popular among other options
select contract, count(contract) from cust_account group by contract;
-- most prevalent contracts are monthly

-- number of customers having less than avg. monthly charges
select count(*) from cust_account where monthlycharges < (select avg(monthlycharges) from cust_account);

-- number of customers having more than avg. monthly charges
select count(*) from cust_account where monthlycharges > (select avg(monthlycharges) from cust_account);
-- more people are paying greater than avg for monthly charges  !! further investigate

-- performing basic analysis on cust_churn table
select churn, count(churn) from cust_churn group by churn;

-- checking churn with monthlycharges
SELECT cc.churn, avg(ca.monthlycharges)
from cust_account ca 
inner join cust_churn cc on cc.id = ca.account_id
group by cc.churn;

-- checking churn with totalcharges
SELECT cc.churn, avg(ca.totalcharges)
from cust_account ca 
inner join cust_churn cc on cc.id = ca.account_id
group by cc.churn;
-- churn people are paying more monthly than average, meaning monthly contract is popular among churned people

SELECT c.gender, cc.churn, count(c.gender)
from cust_churn cc
inner join customer c on c.customerid = cc.id
group by cc.churn, c.gender;


