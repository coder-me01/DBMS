create table tourist_place (tpid number primary key, history varchar(20), kilometers number(3) ,state varchar(20), tpname varchar(20));

create table tourist(tid number primary key, country varchar(20), age number, tname varchar(20));

create table visits (tpid number(3) references tourist_place(tpid), tid number references tourist(tid), vdate date, primary key(tpid,tid));

create table email (tid number references tourist(tid), email varchar(20), primary key(tid,email));

INSERT INTO tourist_place (tpid, history, kilometers, state, tpname) VALUES (11, 'beauty', 160, 'karnataka', 'ooty');
INSERT INTO tourist_place (tpid, history, kilometers, state, tpname) VALUES (12, 'monuments', 270, 'kerala', 'beluru');
INSERT INTO tourist_place (tpid, history, kilometers, state, tpname) VALUES (13, ' beach', 360, 'tamilnadu', 'marina');

INSERT INTO tourist (tid, country, age, tname) VALUES (22, 'india', 34, 'prakash');
INSERT INTO tourist (tid, country, age, tname) VALUES (23, 'orissa', 28, 'bhanu');
INSERT INTO tourist (tid, country, age, tname) VALUES (24, 'india', 30, 'nagesh');

INSERT INTO visits (tpid, tid, vdate) VALUES (12, 23, TO_DATE('13-NOV-2014', 'DD-MON-YYYY'));
INSERT INTO visits (tpid, tid, vdate) VALUES (11, 24, TO_DATE('24-JUN-2013', 'DD-MON-YYYY'));
INSERT INTO visits (tpid, tid, vdate) VALUES (13, 22, TO_DATE('25-SEP-2011', 'DD-MON-YYYY'));
INSERT INTO visits (tpid, tid, vdate) VALUES (11, 23, TO_DATE('23-FEB-2010', 'DD-MON-YYYY'));
INSERT INTO visits (tpid, tid, vdate) VALUES (13, 23, TO_DATE('12-JAN-2010', 'DD-MON-YYYY'));
INSERT INTO visits (tpid, tid, vdate) VALUES (14, 24, TO_DATE('10-JAN-2017', 'DD-MON-YYYY'));

INSERT INTO email (tid, email) VALUES (23, 'bhanu12@gmail.com');
INSERT INTO email (tid, email) VALUES (22, 'prakash242@gmail.com');
INSERT INTO email (tid, email) VALUES (24, 'nageshh@gmail.com');

Query
1. select state from tourist place group by state having count(state) (select max(count(state)) from tourist_place group by state);

2. select * from tourist place where tpid in (select tpid from visits group by tpid having count(tpid)= (select max(count(tpid)) from visits group by tpid));

3. select from tourist t where t.tid in (select tid from visits join tourist place on visits.tpid-tourist place.tpid where state karnataka' group by tid having count(state) in (select count(state) from tourist place where state-karnataka'));

4. select from tourist t where L.tid in (select tid from visits join tourist place on visits.tpid-tourist_place.tpid group by tid having count(distinct state) in (select count(distinct state) from tourist place));

5. select from tourist place where tpid in ( select tpid from visits join tourist on visits.tid-tourist.tid group by tpid having count(distinct country)= (select count(distinct country) from tourist));