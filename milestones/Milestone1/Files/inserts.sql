-- Script name: inserts.sql
-- Author:      Joshua Hayes
-- Purpose:     sample data to test the integrity of the db system

-- the database used to insert the data into.
USE myTeamsDB;

-- Region table inserts
INSERT INTO `myTeamsDB`.`Region`
(`region_name`,
`region_UTC`)
VALUES
("West Coast",
"UTC-7"),
("South",
"UTC-5"),
("East Coast",
"UTC-4");

-- Budget table inserts
INSERT INTO `Budget`
(`amount_avail`)
VALUES(
555000
),
(612000
),
(910000
),
(13000
);

-- Company table inserts
INSERT INTO `myTeamsDB`.`Company`
(`region_id`,
`address`,
`city`,
`state`,
`zip`)
VALUES
(
1,
"10 Onion Ave",
"Los Angeles",
"CA",
"90012"),
(
2,
"15 Avocado Way",
"Miami",
"FL",
"65958"),
(
3,
"99 Problems",
"Chicago",
"IL",
"45009");

-- Department table inserts
INSERT INTO `myTeamsDB`.`Department`
(`company_id`,
`budget_id`,
`name`,
`phone_number`)
VALUES
(1,
1,
"Operations",
"500-567-9650"
),
(
1,
2,
"Marketing",
"500-567-9755"),
(
1,
3,
"Engineering",
"500-567-9758");

-- Employee table inserts
INSERT INTO `myTeamsDB`.`Employee`
(
`position`,
`first_name`,
`last_name`,
`department_id`)
VALUES
(
"Business Analyst",
"Micheal",
"Van Stoph",
1),
(
"Social Media Manager",
"Issac",
"Fig-Newton",
3),
(
"Data Architect",
"Adele",
"Loveletter",
2),
(
"Business Manager",
"Winnie",
"Midnight",
1),
(
"Social Media Associate",
"Jenna",
"Rocks",
3),
(
"Database Engineer",
"Mariah",
"Harrison",
2),
(
"Senior Software Engineer",
"Juan",
"Garcia",
3),
(
"IT Engineer",
"Ignrid",
"Brookes",
2),
(
"Network Technician",
"Sherrilyn",
"Watts",
2);

-- Test Termination Date
UPDATE Employee
SET TERMINATION_DATE = current_timestamp()
WHERE employee_id = '2';


-- Candidate table inserts
INSERT INTO `myTeamsDB`.`Candidate`
(`firstName`,
`lastName`,
`dob`,
`email`,
`phone`,
`last_application_date`)
VALUES
("John",
"Scott",
"1989-04-12",
"scottjohn89@ymail.com",
"5109011944",
"2023-04-08"),
("Trey",
"Mckullen",
"1971-12-15",
"macT43@amail.com",
"9169441249",
"2023-04-04"),
("Rachel",
"Nguyen",
"1991-09-01",
"r1991nguyen@email.com",
"2156041121",
"2023-02-19");

-- Clients table inserts
INSERT INTO `myTeamsDB`.`Clients`
(
`name`,
`phone`,
`address`,
`zip`,
`city`,
`state`)
VALUES
("Pasadena Wildlife",
"5019310393",
"99 Picaso",
90009,
"Los Angeles",
"CA"),
("Stella's Chips",
"9190212293",
"W Elm St",
99813,
"Juneau",
"AK"),
("InstaR",
"9108882719",
"1820 Calistoga Road",
33311,
"Fort Laurderdale",
"FL");
;


-- W2 table inserts
INSERT INTO `myTeamsDB`.`W2`
(`employee_id`,
`year`,
`eDocPath`,
`total_income`,
`total_tax`,
`total_take_home`)
VALUES
(1,
2021,
"Documents/Financial/2021/1W2",
50000,
30000,
20000),
(2,
2021,
"Documents/Financial/2021/2W2",
60000,
3000,
3000),
(3,
2021,
"Documents/Financial/2021/3W2",
50000,
30000,
20000);

-- Manager table inserts
INSERT INTO `myTeamsDB`.`Manager`
(`employee_id`,
`directReport_id`)
VALUES
(4,
1),
(3,
6),
(2,
5);

-- Position table inserts
INSERT INTO `myTeamsDB`.`Position`
(`title`,
`description`,
`min_pay`,
`level`)
VALUES
("Senior Software Engineer",
"Job description info for senior software engineer!",
200000,
6),
("Chief Financial Officer",
"Job description info for chief financial officer",
350000,
9),
("Security Analyst",
"Job description info for a security analyst",
180000,
4);

-- EmployeeInfo table inserts
INSERT INTO `myTeamsDB`.`EmployeeInfo`
(`employee_id`,
`ssn`,
`address1`,
`zip_code`,
`city`,
`state`,
`dob`,
`salary`,
`num_dependents`,
`phone_number`)
VALUES
(1,
"oiewrngoi24",
"132 West Way",
991092,
"Wegowest",
"CA",
"1990-11-10",
90000,
2,
9126299012),
(2,
"hioq3434bji22",
"991 Employee Dr",
94122,
"Mocha",
"CA",
"1994-04-19",
104400,
0,
4940012932),
(3,
"iwneorfibo34",
"852 Thunde",
82011,
"Houst",
"CA",
"1998-01-31",
95600,
4,
9160021823);


-- SkillCerts table inserts
INSERT INTO `myTeamsDB`.`SkillCerts`
(`skillCerts_name`,
`employee_id`)
VALUES
("Google Data Analytics ",
1),
("AWS Database",
2),
("Salesforce Administrator",
3);

-- JobPosting table inserts
INSERT INTO `myTeamsDB`.`JobPosting`
(`position_id`,
`candidate_id`)
VALUES
(1,
2),
(1,
2),
(2,
2);

-- Invoices table inserts
INSERT INTO `myTeamsDB`.`Invoices`
(`client_id`,
`description`,
`amount_due`,
`amount_paid`,
`due_date`)
VALUES
(1,
"Consultation",
3500,
3500,
"2023-04-15"),
(2,
"Consultation",
3500,
500,
"2023-03-30"),
(3,
"Services",
9499,
9499,
"2023-05-01");

-- Teams table inserts
INSERT INTO `myTeamsDB`.`Teams`
(`name`,
`manager_id`,
`employee_id`)
VALUES
("Alpha",
1,
1),
("Llama",
1,
2),
("BufferZone",
2,
3);



-- Documents table inserts
INSERT INTO `myTeamsDB`.`Documents`
(`candidate_id`,
`title`,
`document`)
VALUES
(1,
"resume10.pdf",
"/Candidates/1/resume10.pdf"),
(1,
"myCoverLetter.pdf",
"/Candidates/1/myCoverLetter.pdf"),
(2,
"resume.pdf",
"/Candidates/2/resume.pdf");

-- Projects table inserts
INSERT INTO `myTeamsDB`.`Projects`
(`name`,
`priority`,
`department_id`,
`team_id`,
`client_id`)
VALUES
("Socially",
1,
2,
1,
1),
("West Credit",
3,
1,
1,
2),
("Buyforce",
2,
2,
2,
2);

-- clientAssignments table inserts
INSERT INTO `myTeamsDB`.`clientAssignments`
(`department_id`,
`client_id`)
VALUES
(1,
1),
(2,
2),
(1,
2);

-- Payroll table inserts
INSERT INTO `myTeamsDB`.`Payroll`
(`pay_period`,
`employee_id`,
`gross_pay`)
VALUES
("2023/03/20 - 2023/04/02",
1,
3500),
("2023/03/20 - 2023/04/02",
2,
3400),
("2023/03/20 - 2023/04/02",
3,
3000);

-- EmployeeLogin table inserts
INSERT INTO `myTeamsDB`.`EmployeeLogin`
(`employee_id`,
`email`,
`username`,
`password`)
VALUES
(1,
"mvanstoph@companyEmail.com",
"mvanstoph",
"sioerngois293SHA"),
(2,
"ifignewton@companyEmail.com",
"ifignewton",
"sieronsreSHA"),
(3,
"aloveletter@companyEmail.com",
"aloveletter",
"ifnqoeirf23SHA");
INSERT INTO `myTeamsDB`.`internalJobs`
(
`position`,
`employee`)
VALUES
(
1,
3),
(
2,
3),
(
2,
2);
INSERT INTO `myTeamsDB`.`Notes`
(
`manager`,
`candidate`,
`note`,
`public`)
VALUES
(1,
3,
"Does not optimize solutions",
1),
(1,
1,
"Ask candidate for supporting documents next meeting",
0),
(1,
2,
"Very good with sql",
1);

