create procedure MaintainData 

as 
SET NOCOUNT ON;  



--Group data and update statistics
--measure1
--measure2
--measure3
--measure4


--tables to be dropped--add try and catch for all statements
BEGIN TRY	
END TRY
BEGIN CATCH
END CATCH
--Data to be reviewed for delete
--Log
--Notifications
--Quizes_Questions
--Exams_Questions
--UserSpentTime
--UsersActions
--Quizes
--QRStatistics
--AdwaaCompetitions_UserAnswer
--PreviousExams_Questions
--MidtermExams_Questions
--Exams



delete from log where [Date] < getdate()-365;

delete from Notifications where [Date] < getdate()-365;
delete from Quizes where StartDate < getdate()-365
delete from Quizes_Questions where Quizes_Questions.QuizId NOT IN (SELECT Quizes.ID FROM Quizes);
delete from Exams_Questions where StartDate < getdate()-365;
delete from UserSpentTime where [Date] < getdate()-365;
delete from Quizes where StartDate < getdate()-365
delete from Quizes_Questions where Quizes_Questions.QuizId NOT IN (SELECT Quizes.ID FROM Quizes)



--duplicated data to be resolved  (distinct)

--Shrink the database

DBCC SHRINKDATABASE (lo_editor,0);
DBCC SHRINKDATABASE (lo_editor,0,truncateonly);
alter database lo_editor set recovery simple
dbcc shrinkfile (lo_editor_log,5)
alter database testdb set recovery full

