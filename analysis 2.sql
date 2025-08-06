SELECT * FROM loan_project.loan_analysis;
SELECT COUNT(id) AS total_loans
FROM loan_analysis;
SELECT AVG(loan_amount) AS average_loan_amount
FROM loan_analysis;
SELECT loan_status, COUNT(id) AS num_loans
FROM loan_analysis
GROUP BY loan_status
ORDER BY num_loans DESC;
SELECT purpose, COUNT(id) AS num_loans
FROM loan_analysis
GROUP BY purpose
ORDER BY num_loans DESC
LIMIT 5;
SELECT grade, AVG(loan_amount) AS average_interest_rate
FROM loan_analysis
GROUP BY grade
ORDER BY grade;
SELECT home_ownership, COUNT(id) AS charged_off_loans
FROM loan_analysis
WHERE loan_status = 'Charged Off'
GROUP BY home_ownership
ORDER BY charged_off_loans DESC;
SELECT YEAR(issue_date) AS issue_year, COUNT(id) AS num_loans
FROM loan_analysis
GROUP BY issue_year
ORDER BY issue_year;
SELECT loan_status, AVG(debt_to_income_ratio) AS avg_dti
FROM loan_analysis
WHERE loan_status IN ('Fully Paid', 'Charged Off')
GROUP BY loan_status;
SELECT address_state, SUM(loan_amount) AS total_loaned_amount
FROM loan_analysis
GROUP BY address_state
ORDER BY total_loaned_amount DESC
LIMIT 5;
SELECT
    CASE
        WHEN loan_amount <= 5000 THEN '0-5K'
        WHEN loan_amount <= 10000 THEN '5K-10K'
        WHEN loan_amount <= 20000 THEN '10K-20K'
        ELSE '20K+'
    END AS loan_amount_range,
    AVG(loan_amount) AS avg_interest_rate
FROM loan_analysis
GROUP BY loan_amount_range
ORDER BY MIN(loan_amount);
SELECT
    loan_status,
    SUM(recoveries) AS total_recoveries,
    SUM(funded_amount) AS total_funded,
    (SUM(recoveries) / SUM(funded_amount)) * 100 AS recovery_rate_percentage
FROM loan_analysis
WHERE loan_status = 'Charged Off'
GROUP BY loan_status;
SELECT
    id,
    loan_amount,
    annual_income,
    debt_to_income_ratio,
    delinquencies_of_2yrs,
    loan_status
FROM loan_analysis
WHERE
    loan_status = 'Charged Off' AND
    debt_to_income_ratio > (SELECT AVG(debt_to_income_ratio) FROM loans WHERE loan_status = 'Charged Off') AND
    delinquencies_of_2yrs > 0
ORDER BY debt_to_income_ratio DESC;
SELECT
    DATE_FORMAT(issue_date, '%Y-%m') AS issue_month,
    COUNT(id) AS total_loans,
    SUM(CASE WHEN loan_status = 'Fully Paid' THEN 1 ELSE 0 END) AS fully_paid_loans,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS charged_off_loans,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0 / COUNT(id)) AS charged_off_rate
FROM loan_analysis
GROUP BY issue_month
ORDER BY issue_month;
SELECT
    CASE
        WHEN annual_income < 30000 THEN 'Low Income'
        WHEN annual_income >= 30000 AND annual_income < 70000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_segment,
    CASE
        WHEN loan_amount < 5000 THEN 'Small Loan'
        WHEN loan_amount >= 5000 AND loan_amount < 15000 THEN 'Medium Loan'
        ELSE 'Large Loan'
    END AS loan_size_segment,
    COUNT(id) AS num_customers,
    AVG(loan_amount) AS avg_interest_rate,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS charged_off_count
FROM loan_analysis
GROUP BY income_segment, loan_size_segment
ORDER BY income_segment, loan_size_segment;
SELECT
    address_state,
    COUNT(id) AS total_loans,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS charged_off_loans,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0 / COUNT(id)) AS charged_off_rate
FROM loan_analysis
GROUP BY address_state
HAVING COUNT(id) > 50
ORDER BY charged_off_rate DESC
LIMIT 10;
