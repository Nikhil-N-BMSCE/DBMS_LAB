CREATE DATABASE nikhil_insurance;
USE nikhil_insurance;

CREATE TABLE person (
    driver_id VARCHAR(10),
    name VARCHAR(20),
    address VARCHAR(30),
    PRIMARY KEY(driver_id)
);

CREATE TABLE car (
    reg_num VARCHAR(10),
    model VARCHAR(10),
    year INT,
    PRIMARY KEY(reg_num)
);

CREATE TABLE accident (
    report_num INT,
    accident_date DATE,
    location VARCHAR(20),
    PRIMARY KEY(report_num)
);

CREATE TABLE owns (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY(driver_id, reg_num),
    FOREIGN KEY(driver_id) REFERENCES person(driver_id),
    FOREIGN KEY(reg_num) REFERENCES car(reg_num)
);

CREATE TABLE participated (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY(driver_id, reg_num, report_num),
    FOREIGN KEY(driver_id) REFERENCES person(driver_id),
    FOREIGN KEY(reg_num) REFERENCES car(reg_num),
    FOREIGN KEY(report_num) REFERENCES accident(report_num)
);

-- Insert accident data
INSERT INTO accident VALUES 
    (11, '2003-01-01', 'Mysore Road'),
    (12, '2004-02-02', 'South end Circle'),
    (13, '2003-01-21', 'Bull temple Road'),
    (14, '2008-02-17', 'Mysore Road'),
    (15, '2004-03-05', 'Kanakpura Road');

-- Insert car data
INSERT INTO car VALUES 
    ('KA052250', 'Indica', 1990),
    ('KA031181', 'Lancer', 1957),
    ('KA095477', 'Toyota', 1998),
    ('KA053408', 'Honda', 2008),
    ('KA041702', 'Audi', 2005);

-- Insert person data
INSERT INTO person VALUES 
    ('A01', 'Richard', 'Srinivas nagar'),
    ('A02', 'Pradeep', 'Rajaji nagar'),
    ('A03', 'Smith', 'Ashok nagar'),
    ('A04', 'Venu', 'N R Colony'),
    ('A05', 'Jhon', 'Hanumanth nagar');

-- Insert owns data
INSERT INTO owns VALUES
    ('A01', 'KA052250'),
    ('A02', 'KA031181'),
    ('A03', 'KA095477'),
    ('A04', 'KA053408'),
    ('A05', 'KA041702');

-- You dropped the participated table, so recreate it
DROP TABLE IF EXISTS participated;

CREATE TABLE participated (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY(driver_id, reg_num, report_num),
    FOREIGN KEY(driver_id) REFERENCES person(driver_id),
    FOREIGN KEY(reg_num) REFERENCES car(reg_num),
    FOREIGN KEY(report_num) REFERENCES accident(report_num)
);

-- Insert participated data
INSERT INTO participated VALUES
    ('A01', 'KA052250', 11, 50000),
    ('A02', 'KA031181', 12, 40000),
    ('A03', 'KA095477', 13, 20000),
    ('A04', 'KA053408', 14, 10000),
    ('A05', 'KA041702', 15, 80000);

-- Select all from participated ordered by damage_amount descending
SELECT * FROM participated ORDER BY damage_amount DESC;

-- Get average damage amount
SELECT AVG(damage_amount) FROM participated;

-- Delete records where damage_amount is less than average damage_amount
DELETE FROM participated
WHERE damage_amount < (
    SELECT avg_damage FROM (
        SELECT AVG(damage_amount) AS avg_damage FROM participated
    ) AS temp
);


-- Select names of persons whose damage_amount is greater than average damage_amount
SELECT name 
FROM person A, participated B 
WHERE A.driver_id = B.driver_id 
  AND damage_amount > (SELECT AVG(damage_amount) FROM participated);
  SELECT MAX(DAMAGE_AMOUNT) FROM PARTICIPATED;
