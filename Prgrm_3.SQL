create table employee(eid int primary key,ename varchar(10),address varchar(10),supeid int,dno int);

alter table employeee add constraint fk_supeid foreignkey(supeid) references employeee(eid));

create table department(dno int primary key,dname varchar(20),dlocation varchar(10),mgrid int references employeee(eid));

alter table employeee add constraint fk_dno foreign key(dno)references department(dno));

create table project(pno int primary key,pname varchar(20),plocation varchar(20),dno int references department(dno));

create table dependent(name varchar(20),gender varchar(6),age int,addr varchar(20),eid int references employeee(eid),primary key(name,eid));

create table empproj(eid int references employeee(eid),pno int references project(pno),hpw int,primary key(eid,pno));

create table empphno(eid int references employeee(eid),phno int,primary key(eid,phno));

INSERT INTO employee (eid, name, address, supeid, dno) VALUES (4, 'spurthy', 'chikmangalore', 3, 200);
INSERT INTO employee (eid, name, address, supeid, dno) VALUES (5, 'raghavi', 'bangalore', 4, 500);

INSERT INTO department (dno, dname, dlocation, mgrid) VALUES (100, 'mea', 'blore', 4);
INSERT INTO department (dno, dname, dlocation, mgrid) VALUES (200, 'mba', 'mlore', 5);
INSERT INTO department (dno, dname, dlocation, mgrid) VALUES (300, 'ese', 'mumbai', 2);
INSERT INTO department (dno, dname, dlocation, mgrid) VALUES (400, 'mech', 'delhi', 3);
INSERT INTO department (dno, dname, dlocation, mgrid) VALUES (500, 'ece', 'chennai', 1);

INSERT INTO project (pno, pname, plocation, dno) VALUES (111, 'student', 'blore', 100);
INSERT INTO project (pno, pname, plocation, dno) VALUES (222, 'library', 'madurai', 300);
INSERT INTO project (pno, pname, plocation, dno) VALUES (333, 'hotel', 'chennai', 100);
INSERT INTO project (pno, pname, plocation, dno) VALUES (444, 'railway', 'delhi', 500);
INSERT INTO project (pno, pname, plocation, dno) VALUES (555, 'airline', 'ranchi', 400);
INSERT INTO project (pno, pname, plocation, dno) VALUES (5, 'sp', 'mysore', 100);
INSERT INTO project (pno, pname, plocation, dno) VALUES (10, 'raji', 'kolkata', 200);

INSERT INTO dependent (name, gender, age, addr, eid) VALUES ('priya', 'f', 20, 'mumbai', 1);
INSERT INTO dependent (name, gender, age, addr, eid) VALUES ('divya', 'f', 19, 'blore', 2);
INSERT INTO dependent (name, gender, age, addr, eid) VALUES ('priyanka', 'f', 18, 'madurai', 3);
INSERT INTO dependent (name, gender, age, addr, eid) VALUES ('sarvan', 'm', 24, 'delhi', 3);
INSERT INTO dependent (name, gender, age, addr, eid) VALUES ('jothi', 'f', 40, 'madurai', 5);
INSERT INTO dependent (name, gender, age, addr, eid) VALUES ('lakshmi', 'f', 23, 'udupi', 1);

INSERT INTO empproj (eid, pno, hpw) VALUES (1, 111, 5);
INSERT INTO empproj (eid, pno, hpw) VALUES (3, 222, 4);
INSERT INTO empproj (eid, pno, hpw) VALUES (2, 333, 7);
INSERT INTO empproj (eid, pno, hpw) VALUES (4, 111, 10);
INSERT INTO empproj (eid, pno, hpw) VALUES (5, 444, 20);
INSERT INTO empproj (eid, pno, hpw) VALUES (1, 5, 4);
INSERT INTO empproj (eid, pno, hpw) VALUES (1, 10, 8);

INSERT INTO empphno (eid, phno) VALUES (3, 9025678934);
INSERT INTO empphno (eid, phno) VALUES (4, 9807654323);
INSERT INTO empphno (eid, phno) VALUES (5, 8907654323);
INSERT INTO empphno (eid, phno) VALUES (2, 7896897654);
INSERT INTO empphno (eid, phno) VALUES (1, 9087654321);

Queries

1.
SELECT e.*
FROM employee e
JOIN empproj ep1 ON e.eid = ep1.eid AND ep1.pno = 5
JOIN empproj ep2 ON e.eid = ep2.eid AND ep2.pno = 10;


2. 
SELECT e.*
FROM employee e
JOIN dependent d ON e.eid = d.eid
GROUP BY e.eid, e.name, e.address, e.supeid, e.dno
HAVING COUNT(d.name) >= 2;


3.
SELECT p.pname
FROM project p
JOIN empproj ep ON p.pno = ep.pno
GROUP BY p.pname
ORDER BY COUNT(ep.eid) DESC
FETCH FIRST 1 ROWS ONLY;


4. 
SELECT e.*
FROM employee e
LEFT JOIN dependent d ON e.eid = d.eid
WHERE d.eid IS NULL;


5.
SELECT e.*
FROM employee e
JOIN (
    SELECT eid, SUM(hpw) AS total_hours
    FROM empproj
    GROUP BY eid
    ORDER BY total_hours DESC
    FETCH FIRST 1 ROWS ONLY
) max_hours ON e.eid = max_hours.eid;


6. 
CREATE VIEW DeptEmployeeCount AS
SELECT d.dname, COUNT(e.eid) AS EmployeeCount
FROM department d
LEFT JOIN employee e ON d.dno = e.dno
GROUP BY d.dname;


