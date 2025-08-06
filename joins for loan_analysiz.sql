USE loan_project;
CREATE TABLE borrowers (
    borrower_id INT PRIMARY KEY,
    annual_income DECIMAL(12,2),
    home_ownership VARCHAR(20),
    verification_status VARCHAR(30)
    -- other borrower-specific fields
);
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    borrower_id INT,
    loan_amount INT,
    terms_months INT,
    loan_status VARCHAR(50),
    purpose VARCHAR(150),
    -- more loan-specific fields
    FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id)
);
SELECT b.borrower_id, l.loan_id, b.annual_income, l.loan_amount
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id;
SHOW TABLES;
SELECT * FROM loan_analysis LIMIT 5;
INSERT INTO borrowers (borrower_id, annual_income, home_ownership, verification_status)
SELECT id, annual_income, home_ownership, verification_status
FROM loan_analysis;
INSERT INTO loans (loan_id, borrower_id, loan_amount, terms_months, loan_status, purpose)
SELECT id, id, loan_amount, terms_months, loan_status, purpose
FROM loan_analysis;
SELECT * FROM borrowers LIMIT 5;
SELECT * FROM loans LIMIT 5;

