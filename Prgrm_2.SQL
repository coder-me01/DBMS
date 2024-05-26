create table team (tid int primary key, tname varchar(20), coach varchar(20), captain_pid int, city varchar(20));

create table player (pid int primary key, pname varchar(2), age int, tid int references team(tid));

create table stadium (sid int primary key, sname varchar(20), picode number(8), city varchar(20), area varchar(20));

create table match (mid int primary key, mdate date, time varchar(6), sid int references stadium(sid), team1_id int references team(tid), team2_id int references team(tid), winning_team_id int references team(tid), man_of_match int references player(pid), CHECK (team1_id!=team2_id));

create table player_phone (pid int references player(pid), phone int, primary key(pid,phone));



INSERT INTO team (tid, tname, coach, captain_pid, city) VALUES (123, 'rcb', 'sunil', 1, 'bangalore');
INSERT INTO team (tid, tname, coach, captain_pid, city) VALUES (124, 'csk', 'laxman', 3, 'chennai');
INSERT INTO team (tid, tname, coach, captain_pid, city) VALUES (125, 'royals', 'singh', 4, 'rajasthan');
INSERT INTO team (tid, tname, coach, captain_pid, city) VALUES (126, 'daredevils', 'sehwag', 2, 'delhi');

INSERT INTO player (pid, pname, age, tid) VALUES (1, 'sachin', 33, 123);
INSERT INTO player (pid, pname, age, tid) VALUES (2, 'dravid', 32, 124);
INSERT INTO player (pid, pname, age, tid) VALUES (3, 'dhoni', 30, 124);
INSERT INTO player (pid, pname, age, tid) VALUES (4, 'raina', 30, 125);
INSERT INTO player (pid, pname, age, tid) VALUES (5, 'kohli', 23, 126);

INSERT INTO stadium (sid, sname, pincode, city, area) VALUES (111, 'chinnaswamy', 56001, 'bangalore', 'mg road');
INSERT INTO stadium (sid, sname, pincode, city, area) VALUES (222, 'kotla', 460009, 'delhi', 'highway');
INSERT INTO stadium (sid, sname, pincode, city, area) VALUES (333, 'international', 38883, 'chennai', 'tr nagar');
INSERT INTO stadium (sid, sname, pincode, city, area) VALUES (444, 'ksca', 560098, 'bangalore', 'peenya');
INSERT INTO stadium (sid, sname, pincode, city, area) VALUES (555, 'csca', 567772, 'cochin', 'beach road');

INSERT INTO match (mid, mdate, time, sid, team1_id, team2_id, winning_team_id, man_of_match) 
VALUES (1, TO_DATE('10-JAN-17', 'DD-MON-YY'), '10am', 111, 123, 124, 123, 1);
INSERT INTO match (mid, mdate, time, sid, team1_id, team2_id, winning_team_id, man_of_match) 
VALUES (2, TO_DATE('11-JAN-17', 'DD-MON-YY'), 'pm', 222, 124, 126, 126, 5);
INSERT INTO match (mid, mdate, time, sid, team1_id, team2_id, winning_team_id, man_of_match) 
VALUES (3, TO_DATE('12-JAN-17', 'DD-MON-YY'), '11am', 111, 125, 126, 126, 5);
INSERT INTO match (mid, mdate, time, sid, team1_id, team2_id, winning_team_id, man_of_match) 
VALUES (4, TO_DATE('17-JAN-17', 'DD-MON-YY'), '12pm', 111, 125, 123, 123, 1);

INSERT INTO player_phone (pid, phone) VALUES (1, 9988829282);
INSERT INTO player_phone (pid, phone) VALUES (1, 8775637332);
INSERT INTO player_phone (pid, phone) VALUES (2, 9889288223);
INSERT INTO player_phone (pid, phone) VALUES (2, 877366383);

Queries 
1. SELECT p.pname, t.tname, p.age
FROM player p
JOIN team t ON p.tid = t.tid
WHERE p.age = (SELECT MIN(age) FROM player);

2. SELECT s.sid, s.sname, s.pincode, s.city, s.area
FROM stadium s
JOIN (
    SELECT sid, COUNT(*) AS match_count
    FROM match
    GROUP BY sid
    ORDER BY match_count DESC
    FETCH FIRST 1 ROWS ONLY
) m ON s.sid = m.sid;

3. SELECT p.pid, p.pname, p.age, p.tid
FROM player p
JOIN (
    SELECT man_of_match
    FROM match
    GROUP BY man_of_match
    HAVING COUNT(man_of_match) >= 2
) m ON p.pid = m.man_of_match
WHERE p.pid NOT IN (SELECT captain_pid FROM team);

4. SELECT t.tid, t.tname, t.coach, t.captain_pid, t.city
FROM team t
JOIN (
    SELECT winning_team_id, COUNT(*) AS win_count
    FROM match
    GROUP BY winning_team_id
    ORDER BY win_count DESC
    FETCH FIRST 1 ROWS ONLY
) w ON t.tid = w.winning_team_id;

5. SELECT t.tname
FROM team t
JOIN match m ON t.tid = m.winning_team_id
GROUP BY t.tid, t.tname
HAVING COUNT(DISTINCT m.sid) = 1;