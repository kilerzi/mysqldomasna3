--prvo baranje 
-- selectiram t id da mi e teacher id 
SELECT 
    t.ID AS TeacherID,
	-- adnuva first name i last name zaedno kako teacher name
    CONCAT(t.FirstName, ' ', t.LastName) AS TeacherName,
	-- posle counts kolku grades imaa dadeno each teacher
    COUNT(g.ID) AS GradeCount
FROM 
-- od koj database
    dbo.Teacher t
LEFT JOIN 
--left join za da gi vneseme site teachers 
    dbo.Grade g ON t.ID = g.TeacherID
GROUP BY 
    t.ID, t.FirstName, t.LastName
ORDER BY 
    GradeCount DESC;




	SELECT 
    t.ID AS TeacherID,
    CONCAT(t.FirstName, ' ', t.LastName) AS TeacherName,
    COUNT(g.ID) AS GradeCount
FROM 
    dbo.Teacher t
JOIN 
    dbo.Grade g ON t.ID = g.TeacherID
	--ova pogore od ovoj comment go imase gore objasneto copy paste 
	--pod filtrirame za prvite 100 students
WHERE 
    g.StudentID < 100
GROUP BY 
    t.ID, t.FirstName, t.LastName;






	SELECT 
    s.ID AS StudentID,
	--ziame student id 
    MAX(g.Grade) AS MaxGrade,
	-- stavame 10 kako da e max grade 
    AVG(CAST(g.Grade AS FLOAT)) AS AvgGrade
	--ova tuka e za da se najde avrage grade za sekoj student 
FROM 
    dbo.Student s
JOIN 
--ova sekoj student da go opfatime
    dbo.Grade g ON s.ID = g.StudentID
GROUP BY 
    s.ID;





	--ova e slicno kako baranje prvo i dva samo filtrirame nad 200
SELECT 
    t.ID AS TeacherID,
    CONCAT(t.FirstName, ' ', t.LastName) AS TeacherName,
    COUNT(g.ID) AS GradeCount
FROM dbo.Teacher t
JOIN dbo.Grade g ON t.ID = g.TeacherID
GROUP BY t.ID, t.FirstName, t.LastName
HAVING COUNT(g.ID) > 200;



--tuka baranje 5 e kade sto barame maximal grade e equal na avarageot u koj studenti e maximumot negoviot avarage 
--tuka go napraviv i baranje 6 bidejki ne go razbiram dali samo trebase da gi listnam kako sto napraviv?
	SELECT 
    s.FirstName,
    s.LastName,
    COUNT(g.ID) AS GradeCount,
    MAX(g.Grade) AS MaxGrade,
    AVG(CAST(g.Grade AS FLOAT)) AS AvgGrade
FROM 
    dbo.Student s
JOIN 
    dbo.Grade g ON s.ID = g.StudentID
GROUP BY 
    s.ID, s.FirstName, s.LastName
HAVING 
    MAX(g.Grade) = AVG(CAST(g.Grade AS FLOAT));



-- create view baranje 7

	CREATE VIEW vv_StudentGrades AS
SELECT 
    StudentID,
    COUNT(*) AS GradeCount
FROM 
    dbo.Grade
GROUP BY 
    StudentID;




	--tuka baranje 8 se bara da se pokazuva name i last name mesto id taka da samo selectnav first name i last name 
	ALTER VIEW vv_StudentGrades AS
SELECT 
    s.FirstName,
    s.LastName,
    COUNT(g.ID) AS GradeCount
FROM 
    dbo.Student s
JOIN 
    dbo.Grade g ON s.ID = g.StudentID
GROUP BY 
    s.FirstName, s.LastName;



	--i tuka samo da gi listnat site so grade count od najgolemo do najmalo

	SELECT *
FROM vv_StudentGrades
ORDER BY GradeCount DESC;
