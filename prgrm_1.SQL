
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

-- Insert data into BRANCH table
INSERT INTO BRANCH (Branchid, Branchname, HOD)
VALUES
(1, 'mca', 'npk'),
(2, 'mba', 'bojanna'),
(3, 'cse', 'gtr'),
(4, 'ise', 'sudhamani'),
(5, 'electrical', 'sumathi');

-- Insert data into STUDENT table
INSERT INTO STUDENT (USN, Name, Address, Branchid, Sem)
VALUES
('1rn1', 'harish', 'bangalore', 1, 2),
('1rn2', 'bharath', 'mysore', 2, 3),
('1rn3', 'kiran', 'delhi', 3, 6),
('1rn4', 'mahi', 'chennai', 4, 7),
('1rn5', 'krishna', 'hubli', 5, 4);

-- Insert data into BOOK table
INSERT INTO BOOK (Bookid, Bookname, Authorid, Publisher, Branchid)
VALUES
(123, 'c prog', 1111, 'peanson', 1),
(124, 'doms', 2222, 'murawhill', 1),
(125, 'oops', 3333, 'sapna', 1),
(126, 'unix', 4444, 'subhash', 1),
(127, 'cprog', 5555, 'pearson', 1);

-- Insert data into AUTHOR table
INSERT INTO AUTHOR (Authorid, Authorname, Country, Age)
VALUES
(1111, 'navathe', 'india', 55),
(2222, 'ritche', NULL, 44),
(3333, 'RAMKRISHN', 'india', 55),
(4444, 'sumitabha dennis', 'india', 38),
(5555, 'ghjj', NULL, 66);

-- Insert data into BORROW table
INSERT INTO BORROW (USN, Bookid, Borrowed_Date)
VALUES
('Im1', 2222, '2000-01-10'),
('Im2', 3333, '2016-03-05'),
('Im3', 5555, '2010-06-01'),
('Im5', 2222, '2000-05-19');


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




