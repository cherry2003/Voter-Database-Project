-- CREATING DATABASE
DROP DATABASE IF EXISTS final_project;
CREATE DATABASE IF NOT EXISTS final_project;

USE final_project;

-- MEGA TABLE CREATION
DROP TABLE IF EXISTS mega_table;
CREATE TABLE IF NOT EXISTS mega_table (
	precinct_desc VARCHAR(5),
    party_cd VARCHAR(10),
    race_code VARCHAR(10),
    ethnic_code VARCHAR(10),
    sex_code VARCHAR(2),
    age INT,
    pct_portion DOUBLE,
    first_name VARCHAR(25),
    middle_name VARCHAR(15),
    last_name VARCHAR(25),
    name_suffix_lbl VARCHAR(3),
    full_name_mail VARCHAR(80),
    mail_addr1 VARCHAR(100),
    mail_addr2 VARCHAR(100),
    mail_city_state_zip VARCHAR(100),
    house_num INT,
    street_dir VARCHAR(20),
    street_name VARCHAR(50),
    street_type_cd VARCHAR(25),
    street_sufx_cd VARCHAR(50),
    res_city_desc VARCHAR(50),
    state_cd VARCHAR(5),
    zip_code INT,
    registr_dt DATETIME,
    voter_reg_num INT,
    nc_senate_desc VARCHAR(25),
    nc_house_desc VARCHAR(25),
    E1 INT,
    E1_date VARCHAR(20),
    E1_VotingMethod VARCHAR(5),
    E1_PartyCd VARCHAR(5),
    E2 INT,
    E2_Date VARCHAR(20),
    E2_VotingMethod VARCHAR(5),
    E2_PartyCd VARCHAR(5),
    E3 INT,
    E3_Date VARCHAR(20),
    E3_VotingMethod VARCHAR(5),
    E3_PartyCd VARCHAR(5),
    E4 INT,
    E4_Date VARCHAR(20),
    E4_VotingMethod VARCHAR(5),
    E4_PartyCd VARCHAR(5),
    PRIMARY KEY (voter_reg_num)
) ENGINE = InnoDB;

-- IMPORTING DATA INTO MEGA TABLE
LOAD DATA LOCAL INFILE '/Users/21winniet/Desktop/My School Stuff/CS 3265/FINAL PROJECT/voter_data_23.csv' INTO TABLE mega_table
FIELDS
	TERMINATED BY ';'
    ENCLOSED BY '$'
    ESCAPED BY '"'
LINES TERMINATED BY '\r\n';


-- MISCELLANEOUS TABLE
DROP TABLE IF EXISTS misc;
CREATE TABLE IF NOT EXISTS misc (
	precinct_desc VARCHAR(5),
    party_cd VARCHAR(10),
    race_code VARCHAR(10),
    ethnic_code VARCHAR(10),
    sex_code VARCHAR(2),
    age INT,
    pct_portion DOUBLE,
    first_name VARCHAR(25),
    middle_name VARCHAR(15),
    last_name VARCHAR(25),
    name_suffix_lbl VARCHAR(3),
    full_name_mail VARCHAR(80),
    mail_addr1 VARCHAR(100),
    mail_addr2 VARCHAR(100),
    mail_city_state_zip VARCHAR(100),
    house_num INT,
    street_dir VARCHAR(20),
    street_name VARCHAR(50),
    street_type_cd VARCHAR(25),
    street_sufx_cd VARCHAR(50),
    res_city_desc VARCHAR(50),
    state_cd VARCHAR(5),
    zip_code INT,
    registr_dt DATETIME,
    voter_reg_num INT,
    nc_senate_desc VARCHAR(25),
    nc_house_desc VARCHAR(25),
    E1 INT,
    E1_date VARCHAR(20),
    E1_VotingMethod VARCHAR(5),
    E1_PartyCd VARCHAR(5),
    E2 INT,
    E2_Date VARCHAR(20),
    E2_VotingMethod VARCHAR(5),
    E2_PartyCd VARCHAR(5),
    E3 INT,
    E3_Date VARCHAR(20),
    E3_VotingMethod VARCHAR(5),
    E3_PartyCd VARCHAR(5),
    E4 INT,
    E4_Date VARCHAR(20),
    E4_VotingMethod VARCHAR(5),
    E4_PartyCd VARCHAR(5),
    PRIMARY KEY (voter_reg_num)
) ENGINE = InnoDB;

-- DISTRICT TABLE
DROP TABLE IF EXISTS district;
CREATE TABLE district (
    pct_portion DOUBLE,
    street_name VARCHAR(50),
	precinct_desc VARCHAR(5),
    nc_senate_desc VARCHAR(25),
    nc_house_desc VARCHAR(25),
    PRIMARY KEY (pct_portion, street_name)
);

-- VOTERNAME TABLE
DROP TABLE IF EXISTS votername;
CREATE TABLE votername (
    full_name_mail VARCHAR(80),
	first_name VARCHAR(25),
	middle_name VARCHAR(15), 
	last_name VARCHAR(25),
	PRIMARY KEY (full_name_mail)
);


-- ELECTION1 TABLE
DROP TABLE IF EXISTS election1;
CREATE TABLE election1 (
	E1 INT,
    E1_date VARCHAR(20),
    PRIMARY KEY(E1)
);


-- ELECTION2 TABLE
DROP TABLE IF EXISTS election2;
CREATE TABLE election2 (
	E2 INT,
    E2_Date VARCHAR(20),
    PRIMARY KEY(E2)
);


-- ELECTION3 TABLE
DROP TABLE IF EXISTS election3;
CREATE TABLE election3 (
	E3 INT,
    E3_Date VARCHAR(20),
    PRIMARY KEY(E3)
);


-- ELECTION4 TABLE
DROP TABLE IF EXISTS election4;
CREATE TABLE election4 (
	E4 INT,
    E4_Date VARCHAR(20) ,
    PRIMARY KEY (E4)
);


-- ELECTION TABLE
DROP TABLE IF EXISTS election;
CREATE TABLE election (
    registr_dt DATETIME,
	E1 INT,
	E2 INT,
	E3 INT,
	E4 INT,
    PRIMARY KEY (registr_dt),
    CONSTRAINT fk_e1 FOREIGN KEY (E1) REFERENCES election1(E1)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_e2 FOREIGN KEY (E2) REFERENCES election2(E2)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_e3 FOREIGN KEY (E3) REFERENCES election3(E3)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_e4 FOREIGN KEY (E4) REFERENCES election4(E4)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- REGION TABLE
DROP TABLE IF EXISTS region;
CREATE TABLE region (
	res_city_desc VARCHAR(50),
    state_cd VARCHAR(5),
    zip_code INT,
    PRIMARY KEY (res_city_desc)
);

-- VOTERINFO TABLE
DROP TABLE IF EXISTS voterinfo;
CREATE TABLE voterinfo (
    voter_reg_num INT,
    house_num INT,
    full_name_mail VARCHAR(80),
    pct_portion DOUBLE,
    registr_dt DATETIME,
    state_cd VARCHAR(5),
    mail_addr1 VARCHAR(100),
    street_name VARCHAR(50),
	name_suffix_lbl VARCHAR(3),
	party_cd VARCHAR(10),
    race_code VARCHAR(10),
    ethnic_code VARCHAR(10),
    sex_code VARCHAR(2),
    age INT,
    street_type_cd VARCHAR(25),
    res_city_desc VARCHAR(50),
    street_sufx_cd VARCHAR(50),
    street_dir VARCHAR(20),
    mail_city_state_zip VARCHAR(100),
    mail_addr2 VARCHAR(100),
    PRIMARY KEY (voter_reg_num),
    CONSTRAINT fk_full_name_mail FOREIGN KEY (full_name_mail) REFERENCES votername(full_name_mail)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_res_city_desc FOREIGN KEY (res_city_desc) REFERENCES region(res_city_desc)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_reg_date FOREIGN KEY (registr_dt) REFERENCES election(registr_dt)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_pct_portion_street_name FOREIGN KEY (pct_portion, street_name) REFERENCES district(pct_portion, street_name)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


-- ELECTION VOTING PARTY TABLE
DROP TABLE IF EXISTS election_voting_party;
CREATE TABLE election_voting_party (
    voter_reg_num INT,
    election_id INT UNSIGNED auto_increment,
    E1_VotingMethod VARCHAR(5),
    E1_PartyCd VARCHAR(5),
    E2_VotingMethod VARCHAR(5),
    E2_PartyCd VARCHAR(5),
    E3_VotingMethod VARCHAR(5),
    E3_PartyCd VARCHAR(5),
    E4_VotingMethod VARCHAR(5),
    E4_PartyCd VARCHAR(5),
    PRIMARY KEY (election_id, voter_reg_num),
    CONSTRAINT fk_voterreg FOREIGN KEY (voter_reg_num) REFERENCES voterinfo(voter_reg_num)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- INSERTING VIOLATIONS IN VOTERNAME TABLE TO MISC TABLE
SET SQL_SAFE_UPDATES = 0;

INSERT INTO misc
SELECT *
FROM mega_table
WHERE full_name_mail IN (
	SELECT full_name_mail
    FROM mega_table
    GROUP BY full_name_mail
    HAVING
		COUNT(DISTINCT first_name) > 1
		OR COUNT(DISTINCT middle_name) > 1
        OR COUNT(DISTINCT last_name) > 1
);

DELETE FROM mega_table
WHERE voter_reg_num IN (
	SELECT voter_reg_num
    FROM misc
);


SET SQL_SAFE_UPDATES = 1;

-- POPULATING VOTERNAME TABLE
INSERT INTO votername
SELECT
	DISTINCT full_name_mail,
    first_name,
    middle_name,
    last_name
FROM mega_table;

-- POPULATING DISTRICT TABLE
INSERT INTO district(pct_portion,
street_name,
precinct_desc,
nc_senate_desc,
nc_house_desc)
SELECT
	DISTINCT pct_portion,
	street_name,
	precinct_desc,
	nc_senate_desc,
	nc_house_desc
FROM mega_table;


-- POPULATING ELECTION1 TABLE
INSERT IGNORE INTO election1
SELECT
	DISTINCT E1,
    E1_date
FROM mega_table;

-- POPULATING ELECTION2 TABLE
INSERT IGNORE INTO election2
SELECT
	DISTINCT E2,
    E2_date
FROM mega_table;

-- POPULATING ELECTION3 TABLE
INSERT IGNORE INTO election3
SELECT
	DISTINCT E3,
    E3_date
FROM mega_table;

-- POPULATING ELECTION4 TABLE
INSERT IGNORE INTO election4
SELECT
	DISTINCT E4,
    E4_date
FROM mega_table;

-- POPULATING ELECTION TABLE
INSERT IGNORE INTO election
SELECT
	DISTINCT registr_dt,
    E1,
    E2,
    E3,
    E4
FROM mega_table;

-- POPULATING REGION TABLE
INSERT IGNORE INTO region
SELECT
	DISTINCT res_city_desc,
	state_cd,
	zip_code
FROM mega_table;

-- POPULATING VOTERINFO TABLE
INSERT INTO voterinfo
SELECT
	DISTINCT voter_reg_num,
    house_num,
    full_name_mail,
    pct_portion ,
    registr_dt ,
    state_cd ,
    mail_addr1 ,
    street_name ,
	name_suffix_lbl ,
	party_cd ,
    race_code ,
    ethnic_code ,
    sex_code ,
    age ,
    street_type_cd ,
    res_city_desc ,
    street_sufx_cd ,
    street_dir ,
    mail_city_state_zip ,
    mail_addr2
FROM mega_table;

-- POPULATING ELECTION_VOTING_PARTY TABLE
INSERT INTO election_voting_party
	(voter_reg_num,
	E1_VotingMethod,
	E1_PartyCd,
	E2_VotingMethod,
	E2_PartyCd,
	E3_VotingMethod,
	E3_PartyCd,
	E4_VotingMethod,
	E4_PartyCd)
SELECT
	voter_reg_num,
	E1_VotingMethod,
	E1_PartyCd,
	E2_VotingMethod,
	E2_PartyCd,
	E3_VotingMethod,
	E3_PartyCd,
	E4_VotingMethod,
	E4_PartyCd
FROM mega_table;

-- JOINING FOR CHECKING LOSSLESS NORMALIZATION
SELECT *
FROM voterinfo JOIN votername ON voterinfo.full_name_mail = votername.full_name_mail
JOIN district ON voterinfo.pct_portion = district.pct_portion AND voterinfo.street_name = district.street_name
JOIN election ON voterinfo.registr_dt = election.registr_dt
JOIN election1 ON election.E1 = election1.E1
JOIN election2 ON election.E2 = election2.E2
JOIN election3 ON election.E3 = election3.E3
JOIN election4 ON election.E4 = election4.E4
JOIN region ON voterinfo.res_city_desc = region.res_city_desc
JOIN election_voting_party ON voterinfo.voter_reg_num = election_voting_party.voter_reg_num;

-- STORED PROCEDURES
-- Get Voting History function
DROP PROCEDURE IF EXISTS get_voting_record;
DELIMITER //
CREATE PROCEDURE get_voting_record(IN user_num INT)
BEGIN
    
	SELECT
		(SELECT E1 AS election_ID
		FROM election
		JOIN voterinfo ON voterinfo.registr_dt = election.registr_dt
		WHERE voter_reg_num = user_num) AS election_ID,
		E1_VotingMethod AS voting_method,
		E1_PartyCd AS party_cd
	FROM election_voting_party
	WHERE voter_reg_num = user_num

	UNION ALL

	SELECT
		(SELECT E2
		FROM election
		JOIN voterinfo ON voterinfo.registr_dt = election.registr_dt
		WHERE voter_reg_num = user_num),
		E2_VotingMethod,
		E2_PartyCd
	FROM election_voting_party
	WHERE voter_reg_num = user_num

	UNION ALL

	SELECT
		(SELECT E3
		FROM election
		JOIN voterinfo ON voterinfo.registr_dt = election.registr_dt
		WHERE voter_reg_num = user_num),
		E3_VotingMethod,
		E3_PartyCd
	FROM election_voting_party
	WHERE voter_reg_num = user_num

	UNION ALL

	SELECT
		(SELECT E4
		FROM election
		JOIN voterinfo ON voterinfo.registr_dt = election.registr_dt
		WHERE voter_reg_num = user_num),
		E4_VotingMethod,
		E4_PartyCd
	FROM election_voting_party
	WHERE voter_reg_num = user_num
    ORDER BY election_ID;
    
END //
DELIMITER ;

-- Insert New Voter
SET SQL_SAFE_UPDATES = 0;

-- Create Trigger to update Party code to 'N/A' if invalid 
Drop TRIGGER if exists update_party_code;
DELIMITER //
CREATE TRIGGER update_party_code
BEFORE UPDATE 
ON election_voting_party
FOR EACH ROW
        IF NEW.E1_PartyCd NOT IN ('DEM', 'REP', 'UNA', 'LIB', 'CST', 'GRE') THEN SET NEW.E1_PartyCd = 'N/A';
        ELSEIF NEW.E2_PartyCd NOT IN ('DEM', 'REP', 'UNA', 'LIB', 'CST', 'GRE') THEN SET NEW.E2_PartyCd = 'N/A';
        ELSEIF NEW.E3_PartyCd NOT IN ('DEM', 'REP', 'UNA', 'LIB', 'CST', 'GRE') THEN SET NEW.E3_PartyCd = 'N/A';
        ELSEIF NEW.E4_PartyCd NOT IN ('DEM', 'REP', 'UNA', 'LIB', 'CST', 'GRE') THEN SET NEW.E4_PartyCd = 'N/A';
        END IF;
        
//
DELIMITER ;

-- audit insert table 
DROP TABLE IF EXISTS audit_insert;
CREATE TABLE IF NOT EXISTS audit_insert (
	id INT AUTO_INCREMENT PRIMARY KEY,
	voter_reg_num INT,
	election_id VARCHAR(5),
	vote_method VARCHAR(5),
	party_cd VARCHAR(5),
	insertion_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
    
Drop TRIGGER if exists audit_insert_trigger;
DELIMITER //
CREATE TRIGGER audit_insert_trigger
AFTER UPDATE 
ON election_voting_party
FOR EACH ROW
	
    IF NEW.E1_VotingMethod <> OLD.E1_VotingMethod OR NEW.E1_PartyCd <> OLD.E1_PartyCd THEN
        INSERT INTO audit_insert(voter_reg_num, election_id, vote_method, party_cd)
        VALUES (NEW.voter_reg_num, NEW.election_id, NEW.E1_VotingMethod, NEW.E1_PartyCd);

    ELSEIF NEW.E2_VotingMethod <> OLD.E2_VotingMethod OR NEW.E2_PartyCd <> OLD.E2_PartyCd THEN
        INSERT INTO audit_insert(voter_reg_num, election_id, vote_method, party_cd)
        VALUES (NEW.voter_reg_num, NEW.election_id, NEW.E2_VotingMethod, NEW.E2_PartyCd);

    ELSEIF NEW.E3_VotingMethod <> OLD.E3_VotingMethod OR NEW.E3_PartyCd <> OLD.E3_PartyCd THEN
        INSERT INTO audit_insert(voter_reg_num, election_id, vote_method, party_cd)
        VALUES (NEW.voter_reg_num, NEW.election_id, NEW.E3_VotingMethod, NEW.E3_PartyCd);

    ELSEIF NEW.E4_VotingMethod <> OLD.E4_VotingMethod OR NEW.E4_PartyCd <> OLD.E4_PartyCd THEN
        INSERT INTO audit_insert(voter_reg_num, election_id, vote_method, party_cd)
        VALUES (NEW.voter_reg_num, NEW.election_id, NEW.E4_VotingMethod, NEW.E4_PartyCd);
    END IF;

//
DELIMITER ;

DROP PROCEDURE IF EXISTS insert_record;
DELIMITER //


CREATE PROCEDURE insert_record(
    IN reg_num INT,
    IN e_id VARCHAR(5),
    IN vote_method VARCHAR(5),
    IN vote_party VARCHAR(5),
    OUT msg VARCHAR(255)
)
BEGIN
    
    -- Check if the voter_reg_num exists in the voterinfo table
    DECLARE regNumExists INT DEFAULT 0;
    SELECT COUNT(*) INTO regNumExists FROM voterinfo WHERE voter_reg_num = reg_num;
    
    IF regNumExists = 0 THEN
        SET msg = 'Error: Voter registration number does not exist';
    ELSE
        
        -- Update the corresponding columns based on e_id
        IF e_id = 'E1' THEN 
			UPDATE election_voting_party
            SET E1_VotingMethod = vote_method,
				E1_PartyCd = vote_party
			WHERE voter_reg_num = reg_num;
		ELSEIF e_id = 'E2' THEN 
			UPDATE election_voting_party
            SET E2_VotingMethod = vote_method,
				E2_PartyCd = vote_party
                WHERE voter_reg_num = reg_num;
		ELSEIF e_id = 'E3' THEN 
			UPDATE election_voting_party
            SET E3_VotingMethod = vote_method,
				E3_PartyCd = vote_party
			WHERE voter_reg_num = reg_num;
		ELSEIF e_id = 'E4' THEN 
			UPDATE election_voting_party
            SET E4_VotingMethod = vote_method,
				E4_PartyCd = vote_party
			WHERE voter_reg_num = reg_num;
		END IF;
        

		SET msg = 'Record updated successfully';

    END IF;
    
END //

DELIMITER ;


-- Delete Existing Voter function
-- audit_delete table
DROP TABLE IF EXISTS audit_delete;
CREATE TABLE audit_delete (
    voter_reg_num INT,
    party_cd VARCHAR(10),
    sex_code VARCHAR(2),
    full_name_mail VARCHAR(80),
    registr_dt DATETIME,
    delete_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Trigger for updating audit_delete table after deleting a voter
DROP TRIGGER IF EXISTS after_delete_voterinfo;
DELIMITER //
CREATE TRIGGER after_delete_voterinfo
AFTER DELETE ON voterinfo
FOR EACH ROW
BEGIN
    INSERT INTO audit_delete (voter_reg_num, party_cd, sex_code, full_name_mail, registr_dt, delete_timestamp)
    VALUES (OLD.voter_reg_num, OLD.party_cd, OLD.sex_code, OLD.full_name_mail, OLD.registr_dt, NOW());
END //
DELIMITER ;


-- Delete voter function
DROP PROCEDURE IF EXISTS delete_voter;
DELIMITER //
CREATE PROCEDURE delete_voter(
    IN p_voter_registration_num INT
)
BEGIN
    DECLARE v_count INT;

    -- Check if the voter registration number exists
    SELECT COUNT(*) INTO v_count FROM voterinfo WHERE voter_reg_num = p_voter_registration_num;

    IF v_count > 0 THEN
        -- Start transaction block
        START TRANSACTION;

        BEGIN
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                SELECT 'Error: Voter registration number does not exist';
                SIGNAL SQLSTATE '45000';
            END;

            -- Delete residential/personal information of the user
            DELETE FROM voterinfo WHERE voter_reg_num = p_voter_registration_num;

            -- Commit transaction
            COMMIT;
        END;

        SELECT 'Success: Voter deleted';
    ELSE
        SELECT 'Error: Voter registration number does not exist';
    END IF;
END //
DELIMITER ;


SET SQL_SAFE_UPDATES = 1;

-- Analytics 1
-- Get Constituents Stats (Party, Count, Percentage)
CREATE OR REPLACE VIEW constituent_stats AS
SELECT
	party_cd,
	COUNT(*),
    (COUNT(*) / (SELECT COUNT(*) FROM voterinfo)) * 100 AS percentage
FROM voterinfo
GROUP BY party_cd
ORDER BY COUNT(*) DESC;

-- Get Dem Regional Stats (City, Count, Percentage)
CREATE OR REPLACE VIEW dem_region_stats AS
SELECT
	res_city_desc,
    COUNT(*),
    (COUNT(*) / (SELECT COUNT(*) FROM voterinfo WHERE party_cd = 'DEM')) * 100 AS percentage
FROM voterinfo
WHERE party_cd = 'DEM'
GROUP BY res_city_desc
ORDER BY COUNT(*) DESC;

-- Get Dem Gender Stats (Gender, Count, Percentage)
CREATE OR REPLACE VIEW dem_gender_stats AS
SELECT
	sex_code,
    COUNT(sex_code),
    (COUNT(*) / (SELECT COUNT(*) FROM voterinfo WHERE party_cd = 'DEM')) * 100 AS percentage
FROM voterinfo
WHERE party_cd = 'DEM'
GROUP BY sex_code
ORDER BY COUNT(*) DESC;

-- Get Number of Switches (user inputs party_cd, election number 1/2/3/4)
DROP PROCEDURE IF EXISTS switched_election;
DELIMITER //
CREATE PROCEDURE switched_election(IN party VARCHAR(10), IN election_num INT)
BEGIN

	IF election_num = 1 THEN -- if election 1
		SELECT COUNT(*) -- count num of people with party as party_cd but not party as their E1_PartyCd
        FROM voterinfo JOIN election_voting_party ON voterinfo.voter_reg_num = election_voting_party.voter_reg_num
        WHERE
			party_cd = party
            AND party_cd <> E1_PartyCd
            AND E1_PartyCd IS NOT NULL
            AND E1_PartyCd != '';
	ELSEIF election_num = 2 THEN -- if election 2
		SELECT COUNT(*)
        FROM voterinfo JOIN election_voting_party ON voterinfo.voter_reg_num = election_voting_party.voter_reg_num
        WHERE
			party_cd = party
			AND party_cd <> E2_PartyCd
            AND E2_PartyCd IS NOT NULL
            AND E2_PartyCd != '';
	ELSEIF election_num = 3 THEN -- if election 3
		SELECT COUNT(*)
        FROM voterinfo JOIN election_voting_party ON voterinfo.voter_reg_num = election_voting_party.voter_reg_num
        WHERE
			party_cd = party
            AND party_cd <> E3_PartyCd
            AND E3_PartyCd IS NOT NULL
            AND E3_PartyCd != '';
	ELSEIF election_num = 4 THEN -- if election 4
		SELECT COUNT(*)
        FROM voterinfo JOIN election_voting_party ON voterinfo.voter_reg_num = election_voting_party.voter_reg_num
        WHERE
			party_cd = party
            AND party_cd <> E4_PartyCd
            AND E4_PartyCd IS NOT NULL
            AND E4_PartyCd != '';
	ELSE -- incorrect input (less than 1 or greater than 4) or E1/2/3/4_PartyCd is ''
		SELECT 0 AS "COUNT(*)";
	END IF;
		
END //
DELIMITER ;

-- Analytics 2
-- Get Party Demographic Data (Party, Num of F, Num of M, Num of U, Average Age)
CREATE OR REPLACE VIEW party_demographic_stats AS
SELECT
    party_cd,
    (SELECT COUNT(*) FROM voterinfo WHERE sex_code = 'F' AND party_cd = vi.party_cd) AS female_count,
    (SELECT COUNT(*) FROM voterinfo WHERE sex_code = 'M' AND party_cd = vi.party_cd) AS male_count,
    (SELECT COUNT(*) FROM voterinfo WHERE sex_code = 'U' AND party_cd = vi.party_cd) AS unisex_count,
    AVG(age)
FROM voterinfo vi
GROUP BY party_cd
ORDER BY female_count DESC, male_count DESC, unisex_count DESC;

-- Get Yearly Data (year, age of voters in that year, num of voters)
CREATE OR REPLACE VIEW get_yearly_stats AS
SELECT
	YEAR(registr_dt) as year,
    AVG(age),
    COUNT(*)
FROM voterinfo
GROUP BY year
ORDER BY year;