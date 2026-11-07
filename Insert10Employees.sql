-- SQL Script to delete old data and insert 10 employee records into emp_tbl

-- 1. Clear existing data and reseed Identity column
DELETE FROM emp_tbl;
DBCC CHECKIDENT ('emp_tbl', RESEED, 0);

-- 2. Insert 10 new employee records
INSERT INTO emp_tbl (Name, Gender, Email, City, Address, Mobile, Image, Password) VALUES
('Aarav Patel', 'Male', 'aarav.patel@gmail.com', 'Ahmedabad', '102 Science City Road', '9825012345', '~/images/emp1.jpg', '123'),
('Priya Sharma', 'Female', 'priya.sharma@gmail.com', 'Rajkot', '405 Kalawad Road', '9876543210', '~/images/emp2.jpg', '123'),
('Rohan Mehta', 'Male', 'rohan.mehta@gmail.com', 'Surat', '201 Adajan Main Road', '9712345678', '~/images/emp3.jpg', '123'),
('Ananya Joshi', 'Female', 'ananya.joshi@gmail.com', 'Vadodara', '304 Alkapuri', '9898011223', '~/images/emp4.jpg', '123'),
('Vikram Trivedi', 'Male', 'vikram.trivedi@gmail.com', 'Rajkot', '501 Yagnik Road', '9426098765', '~/images/emp5.jpg', '123'),
('Neha Vaghela', 'Female', 'neha.vaghela@gmail.com', 'Ahmedabad', '602 SG Highway', '9879012345', '~/images/emp6.jpg', '123'),
('Parth Solanki', 'Male', 'parth.solanki@gmail.com', 'Bhavnagar', '703 Waghawadi Road', '9909054321', '~/images/emp7.jpg', '123'),
('Diya Shah', 'Female', 'diya.shah@gmail.com', 'Surat', '804 Ghoddod Road', '9824067890', '~/images/emp8.jpg', '123'),
('Kunal Jadeja', 'Male', 'kunal.jadeja@gmail.com', 'Jamnagar', '905 Park Colony', '9723045678', '~/images/emp9.jpg', '123'),
('Pooja Sikotra', 'Female', 'pooja.sikotra@gmail.com', 'Rajkot', '1001 MG Road', '9898567890', '~/images/emp10.jpg', '123');
