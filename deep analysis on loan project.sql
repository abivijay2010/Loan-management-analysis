show databases;
CREATE SCHEMA loan_project;
USE loan_project;
CREATE TABLE loan_analysiz (
	dummy_id int PRIMARY KEY,
    id INT,
    loan_amount INT,
    funded_amount INT,
    terms_months INT,
    grade VARCHAR(2),
    sub_grade VARCHAR(3),
    employee_length INT,
    home_ownership VARCHAR(20),
    annual_income DECIMAL(12,2),
    verification_status VARCHAR(30),
    loan_status VARCHAR(50),
    purpose VARCHAR(150),
    address_state VARCHAR(10),
    debt_to_income_ratio DECIMAL(5,2),
    delinquencies_of_2yrs INT,
    issue_date VARCHAR(15),
    earliest_credit_line VARCHAR(15),
    pub_rec INT,
    public_rec_risk_factor VARCHAR(20),
    inquiries_in_last_6_months INT,
    months_since_last_delinquencie INT,
    borrowers_based_on_risk VARCHAR(50),
    open_account INT,
    no_of_derogatory_public_records INT,
    total_credit_revolving_balance INT,
    revolving_line_utilization_rate DECIMAL(5,5),
    total_account INT,
    total_payment DECIMAL(12,2),
    recoveries DECIMAL(10,6)
);
ALTER TABLE loan_analysiz
CHANGE COLUMN id  loan_id INT ;
ALTER TABLE loan_analysiz
DROP PRIMARY KEY;
ALTER TABLE loan_analysiz
CHANGE COLUMN dummy_id  id INT  AUTO_INCREMENT PRIMARY KEY;
SHOW CREATE TABLE loan_analysiz;
SHOW TABLES;
SELECT * FROM loan_analysiz;
SELECT count(*) FROM loan_analysiz;
SELECT id AS borrower_id, loan_amount, annual_income
FROM loan_analysiz;
RENAME TABLE loan_analysiz TO loan_analysis;
