EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'OutputDataSet = InputDataSet'
    , @input_data_1 = N'SELECT 1 AS hello'
WITH RESULT SETS(([Hello World] INT));
GO

select QuestionID,[QuestionArabicName] as qname from QuestionsTypes
go
sp_help QuestionsTypes
go
EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'OutputDataSet = InputDataSet;'
    , @input_data_1 = N'select QuestionID,[QuestionArabicName] from QuestionsTypes;'
WITH RESULT SETS((QuestionID int not null,QuestionArabicName nvarchar(20) NOT NULL));

/*using inputdataset as dataframe*/
EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'OutputDataSet = InputDataSet.head(10)'
    , @input_data_1 = N'select QuestionID,[QuestionArabicName] from QuestionsTypes;'
WITH RESULT SETS((QuestionID int not null,QuestionArabicName nvarchar(20) NOT NULL));



/*using inputdataset as dataframe and getback the describe,We make it as a matrix*/
EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'OutputDataSet = InputDataSet.describe().T'
    , @input_data_1 = N'select QuestionID,[QuestionArabicName] from QuestionsTypes;'
WITH RESULT SETS((count_measure float,mean float,std float,min_measure float,q1_measure float,q2_measure float,q3_measure float,max_measure float));



/*using inputdataset as dataframe and getback the describe,We make it as a matrix*/
EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'
import pandas as pd
c = InputDataSet.QuestionID.mean()
d = InputDataSet.QuestionID.median()
data = [[''MEAN'', c], [''MEDIAN'', d]]
details = {"mean":c,"median":d}
print(InputDataSet.QuestionID.mean())
print(details)
df = pd.DataFrame(details,index = [1])
OutputDataSet = df
'
    , @input_data_1 = N'select QuestionID,[QuestionArabicName] from QuestionsTypes;'

WITH RESULT SETS((measurement varchar(20),ResultValue FLOAT))


/*using inputdataset as dataframe and getback the describe,We make it as a matrix*/
EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'
import pandas as pd
c = InputDataSet.QuestionID.mean()
d = InputDataSet.QuestionID.median()
data = [[''MEAN'', c], [''MEDIAN'', d]]
details = {"mean":c,"median":d}
print(InputDataSet.QuestionID.mean())
print(details)
df = pd.DataFrame(data, columns = [''Name'', ''Age''])
OutputDataSet = df
'
    , @input_data_1 = N'select QuestionID,[QuestionArabicName] from QuestionsTypes;'

WITH RESULT SETS((measurement varchar(20),ResultValue FLOAT))