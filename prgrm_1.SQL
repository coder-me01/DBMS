
CREATE TABLE BRANCH (
    Branchid INT PRIMARY KEY,
    Branchname VARCHAR(100),
    HOD VARCHAR(100)
);


CREATE TABLE STUDENT (
    USN VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Branchid INT,
    Sem INT,
    FOREIGN KEY (Branchid) REFERENCES BRANCH(Branchid)
);


CREATE TABLE BOOK (
    Bookid INT PRIMARY KEY,
    Bookname VARCHAR(255),
    Authorid INT,
    Publisher VARCHAR(100),
    Branchid INT,
    FOREIGN KEY (Branchid) REFERENCES BRANCH(Branchid)
);


CREATE TABLE AUTHOR (
    Authorid INT PRIMARY KEY,
    Authorname VARCHAR(100),
    Country VARCHAR(50),
    Age INT
);


CREATE TABLE BORROW (
    USN VARCHAR(10),
    Bookid INT,
    Borrowed_Date DATE,
    PRIMARY KEY (USN, Bookid),
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (Bookid) REFERENCES BOOK(Bookid)
);

INSERT INTO BRANCH (Branchid, Branchname, HOD) VALUES (1, 'MCA', 'npk');
INSERT INTO BRANCH (Branchid, Branchname, HOD) VALUES (2, 'MBA', 'bojanna');
INSERT INTO BRANCH (Branchid, Branchname, HOD) VALUES (3, 'CSE', 'gtr');
INSERT INTO BRANCH (Branchid, Branchname, HOD) VALUES (4, 'ISE', 'sudhamani');
INSERT INTO BRANCH (Branchid, Branchname, HOD) VALUES (5, 'Electrical', 'sumathi');


INSERT INTO STUDENT (USN, Name, Address, Branchid, Sem) VALUES ('1rn1', 'harish', 'bangalore', 1, 2);
INSERT INTO STUDENT (USN, Name, Address, Branchid, Sem) VALUES ('1rn2', 'bharath', 'mysore', 2, 3);
INSERT INTO STUDENT (USN, Name, Address, Branchid, Sem) VALUES ('1rn3', 'kiran', 'delhi', 3, 6);
INSERT INTO STUDENT (USN, Name, Address, Branchid, Sem) VALUES ('1rn4', 'mahi', 'chennai', 4, 7);
INSERT INTO STUDENT (USN, Name, Address, Branchid, Sem) VALUES ('1rn5', 'krishna', 'hubli', 5, 4);

Queries
1.	 SELECT * 
FROM STUDENT
WHERE Sem = 2 AND Branchid = (
    SELECT Branchid FROM BRANCH WHERE Branchname = 'MCA'
);

2.  SELECT * 
FROM STUDENT
WHERE USN NOT IN (SELECT USN FROM BORROW);

3.  SELECT S.USN, S.Name AS StudentName, B.Branchname, BK.Bookname, A.Authorname, BR.Borrowed_Date
FROM STUDENT S
JOIN BORROW BR ON S.USN = BR.USN
JOIN BOOK BK ON BR.Bookid = BK.Bookid
JOIN AUTHOR A ON BK.Authorid = A.Authorid
JOIN BRANCH B ON S.Branchid = B.Branchid
WHERE S.Sem = 2 AND B.Branchname = 'MCA';

4.  SELECT A.Authorname, COUNT(B.Bookid) AS NumberOfBooks
FROM AUTHOR A
LEFT JOIN BOOK B ON A.Authorid = B.Authorid
GROUP BY A.Authorname;

5. SELECT S.*
FROM STUDENT S
WHERE S.USN IN (
    SELECT USN
    FROM BORROW
    GROUP BY USN
    HAVING COUNT(Bookid) > 2
);

6. SELECT S.*
FROM STUDENT S
WHERE S.USN IN (
    SELECT USN
    FROM BORROW BR
    JOIN BOOK BK ON BR.Bookid = BK.Bookid
    GROUP BY USN
    HAVING COUNT(DISTINCT BK.Authorid) > 1
);

7 . SELECT Bookname
FROM BOOK
ORDER BY Bookname DESC;

8 . SELECT S.*
FROM STUDENT S
WHERE S.USN IN (
    SELECT USN
    FROM BORROW BR
    JOIN BOOK BK ON BR.Bookid = BK.Bookid
    GROUP BY USN
    HAVING COUNT(DISTINCT BK.Publisher) = 1
);




