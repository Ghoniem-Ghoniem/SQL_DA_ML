ALTER FUNCTION dbo.GetBlockTags()
RETURNS @TagTable table([BlockedTagName] [varchar](400),[TagType] [varchar](20),[LangID] [int])
WITH ENCRYPTION
AS
BEGIN

declare @TagType varchar(20);
declare @LangID int = 1;--arabic, 0 for english
set @TagType = 'حروف العطف';

insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values('و',@TagType,@LangID),('ف',@TagType,@LangID), ('أو',@TagType,@LangID)  ,('او',@TagType,@LangID) , ('ثم',@TagType,@LangID) , ('ثم',@TagType,@LangID) , ('ثم',@TagType,@LangID) , ('أيضا',@TagType,@LangID), ('أيضا',@TagType,@LangID), ('أيضا',@TagType,@LangID) 
set @TagType = 'حروف الجر';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('من',@TagType,@LangID),  ('عن',@TagType,@LangID), ('إلى',@TagType,@LangID) ,('إلي',@TagType,@LangID) , ('على',@TagType,@LangID) , ('في',@TagType,@LangID) , ('مع',@TagType,@LangID), ('ب',@TagType,@LangID), ('ل',@TagType,@LangID)
, ('رب',@TagType,@LangID), ('مذ',@TagType,@LangID), ('منذ',@TagType,@LangID), ('عدا',@TagType,@LangID)
, ('خلا',@TagType,@LangID), ('حاشا',@TagType,@LangID)

set @TagType = 'التبعيض';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('كل',@TagType,@LangID), ('لكل',@TagType,@LangID), ('بعض',@TagType,@LangID) 

set @TagType = 'حروف نصب المضارع';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('أن',@TagType,@LangID), ('لن',@TagType,@LangID), ('كي',@TagType,@LangID), ('ل',@TagType,@LangID) 

set @TagType = 'إن وأخواتها';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('إن',@TagType,@LangID), ('أن',@TagType,@LangID) , ('وأن',@TagType,@LangID) 
, ('وإن',@TagType,@LangID) 
, ('أنما',@TagType,@LangID) 
, ('إنما',@TagType,@LangID) 
, ('لكن',@TagType,@LangID) 
, ('كأن',@TagType,@LangID) 
, ('ليت',@TagType,@LangID) 
, ('لعل',@TagType,@LangID) 
, ('لات',@TagType,@LangID) 

set @TagType = 'كان وأخواتها';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('كان',@TagType,@LangID), ('يكون',@TagType,@LangID) , ('كن',@TagType,@LangID) , ('كانت',@TagType,@LangID) 


set @TagType = 'أسماء الإشارة';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values('هذا',@TagType,@LangID), ('هذه',@TagType,@LangID)  ,('هذان',@TagType,@LangID) , ('هاتان',@TagType,@LangID) , ('هؤلاء',@TagType,@LangID) 

set @TagType = 'الأسماء الموصولة';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values('الذي',@TagType,@LangID), ('التي',@TagType,@LangID)  ,('اللذان',@TagType,@LangID) , ('اللتان',@TagType,@LangID) ,('الذين',@TagType,@LangID) ,('اللاتي',@TagType,@LangID) , ('اللائي',@TagType,@LangID) , ('ه',@TagType,@LangID)  

set @TagType = 'ضمائر الغائب';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values('هو',@TagType,@LangID), ('هي',@TagType,@LangID)  ,('هما',@TagType,@LangID) , ('هم',@TagType,@LangID) , ('هن',@TagType,@LangID) 

set @TagType = 'أسماء الاستفهام';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values('ماذا',@TagType,@LangID), ('متى',@TagType,@LangID)  , ('ما',@TagType,@LangID)  
, ('كيف',@TagType,@LangID) , ('ماذا',@TagType,@LangID)  , ('هل',@TagType,@LangID)  

set @TagType = 'حروف النداء والتنبيه';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values('يا',@TagType,@LangID), ('أي',@TagType,@LangID), ('أ',@TagType,@LangID), ('ا',@TagType,@LangID),('ها',@TagType,@LangID)  

set @TagType = 'حروف التصديق والجواب';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values('نعم',@TagType,@LangID), ('بلى',@TagType,@LangID)

set @TagType = 'حروف الحث والحض';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values('هلا',@TagType,@LangID), ('ألا',@TagType,@LangID)

set @LangID =0;
set @TagType = 'conjunction,definition,prepositions';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('And',@TagType,@LangID), ('or',@TagType,@LangID) , ('of',@TagType,@LangID) , ('on',@TagType,@LangID) , ('in',@TagType,@LangID), ('an',@TagType,@LangID), ('a',@TagType,@LangID),('the',@TagType,@LangID),('also',@TagType,@LangID),('either',@TagType,@LangID),('such',@TagType,@LangID),('niether',@TagType,@LangID),('like',@TagType,@LangID),('same',@TagType,@LangID)
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('From',@TagType,@LangID), ('To',@TagType,@LangID) ,  ('Above',@TagType,@LangID) , ('Below',@TagType,@LangID), ('front',@TagType,@LangID), ('back',@TagType,@LangID)


set @TagType = 'Demonistrative pronouns';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('This',@TagType,@LangID), ('That',@TagType,@LangID), ('These',@TagType,@LangID), ('Those',@TagType,@LangID)


set @TagType = 'object,Subject and possisive pronoun';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('Who',@TagType,@LangID), ('Whom',@TagType,@LangID), ('Which',@TagType,@LangID), ('Whose',@TagType,@LangID)


set @TagType = 'personal pronouns';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('he',@TagType,@LangID), ('she',@TagType,@LangID), ('it',@TagType,@LangID), ('him',@TagType,@LangID), ('his',@TagType,@LangID), ('her',@TagType,@LangID), ('us',@TagType,@LangID), ('our',@TagType,@LangID), ('mine',@TagType,@LangID) , ('your',@TagType,@LangID), ('yours',@TagType,@LangID)

set @TagType = 'verb to do';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('do',@TagType,@LangID), ('does',@TagType,@LangID), ('did',@TagType,@LangID), ('has',@TagType,@LangID), ('have',@TagType,@LangID), ('is',@TagType,@LangID), ('are',@TagType,@LangID)

set @TagType = 'verb to be';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('is',@TagType,@LangID), ('was',@TagType,@LangID), ('are',@TagType,@LangID), ('were',@TagType,@LangID), ('be',@TagType,@LangID), ('been',@TagType,@LangID)

set @TagType = 'questionin words';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('what',@TagType,@LangID), ('how',@TagType,@LangID)

set @TagType = 'quantitative words';
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) values ('some',@TagType,@LangID), ('much',@TagType,@LangID), ('few',@TagType,@LangID),('many',@TagType,@LangID)



--INSERTING THE CONCATENATION OF WORDS
SET @TagType = 'CONCATENATIONS'
insert into @TagTable ([BlockedTagName] ,[TagType],[LangID]) 
select (A.blockedtagname + ' ' + B.blockedtagname) AS BLOCKEDWORD,@TagType,a.LangID 

from @TagTable A inner join @TagTable B on a.LangID = b.LangID
WHERE A.blockedtagname <> B.blockedtagname
AND A.[TagType] <> B.[TagType]

UNION
select B.blockedtagname + ' ' + A.blockedtagname ,@TagType ,a.LangID
from @TagTable A inner join @TagTable B on a.LangID = b.LangID
WHERE A.blockedtagname <> B.blockedtagname 
AND A.[TagType] <> B.[TagType]
UNION
select (A.blockedtagname + B.blockedtagname) AS BLOCKEDWORD,@TagType ,a.LangID
from @TagTable A inner join @TagTable B on a.LangID = b.LangID
WHERE A.blockedtagname <> B.blockedtagname
AND A.[TagType] <> B.[TagType]
UNION
select B.blockedtagname + A.blockedtagname,@TagType ,a.LangID
from @TagTable A inner join @TagTable B on a.LangID = b.LangID
WHERE A.blockedtagname <> B.blockedtagname
AND A.[TagType] <> B.[TagType]
return
END
go

select * from dbo.GetBlockTags()
go

select distinct * from dbo.GetMetaTagsInfo('إنما الأعمال بالنيات ، وإنما لكل امرئ ما نوى ، فمن كانت هجرته إلى الله ورسوله فهجرته إلى الله ورسوله ، ومن كانت هجرته إلى دنيا يصيبها أو امرأة ينكحها فهجرته إلى ما هاجر إليه','salah ghoniem abdel azim azim azim salah azim',3,2,1)

GO
select * from dbo.GetBlockTags() where tagtype = 'CONCATENATIONS'
and blockedtagname like '%لو%'
order by blockedtagname desc
GO

select blockedtagname,count(1) from dbo.GetBlockTags() 
group by blockedtagname order by 2 desc


--drop function GetMetaTags
alter FUNCTION dbo.CountOccurancesOfString
(
    @searchString nvarchar(max),
    @searchTerm nvarchar(max)
)
RETURNS INT
WITH ENCRYPTION
AS
BEGIN
    return (LEN(@searchString)-LEN(REPLACE(@searchString,@searchTerm,'')))/LEN(@searchTerm)
END
go

alter function dbo.GetMetaTagsInfo(@ContentString varchar(400),@RepeatedContentString varchar(max),@nLengthRule int,@nCompositionCount int,@nRepeatedWords int)
returns @TagTable table([TagName] [varchar](400))
WITH ENCRYPTION
as
begin
declare @CompositeWord varchar(100)='';
declare @nLoop int =0;

declare @NewContentString varchar(max) = @ContentString+ '.'
set @NewContentString = REPLACE(@NewContentString,' ','.')
set @NewContentString = REPLACE(@NewContentString,']','.')
set @NewContentString = REPLACE(@NewContentString,',','.')
set @NewContentString = REPLACE(@NewContentString,'[','.')
set @NewContentString = REPLACE(@NewContentString,'{','.')
set @NewContentString = REPLACE(@NewContentString,'}','.')
set @NewContentString = REPLACE(@NewContentString,'?','.')
set @NewContentString = REPLACE(@NewContentString,'/','.')
set @NewContentString = REPLACE(@NewContentString,'\','.')
set @NewContentString = REPLACE(@NewContentString,'|','.')
set @NewContentString = REPLACE(@NewContentString,'+','.')
set @NewContentString = REPLACE(@NewContentString,'=','.')
set @NewContentString = REPLACE(@NewContentString,'-','.')
set @NewContentString = REPLACE(@NewContentString,':','.')
set @NewContentString = REPLACE(@NewContentString,'َ','')
set @NewContentString = REPLACE(@NewContentString,'ً','')
set @NewContentString = REPLACE(@NewContentString,'ُ','')
set @NewContentString = REPLACE(@NewContentString,'ٌ','')
set @NewContentString = REPLACE(@NewContentString,'ِ','')
set @NewContentString = REPLACE(@NewContentString,'ٍ','')
set @NewContentString = REPLACE(@NewContentString,'ّ','')
set @NewContentString = REPLACE(@NewContentString,'ْ','')

set @ContentString = REPLACE(@ContentString,'َ','')
set @ContentString = REPLACE(@ContentString,'ً','')
set @ContentString = REPLACE(@ContentString,'ُ','')
set @ContentString = REPLACE(@ContentString,'ٌ','')
set @ContentString = REPLACE(@ContentString,'ِ','')
set @ContentString = REPLACE(@ContentString,'ٍ','')
set @ContentString = REPLACE(@ContentString,'ّ','')
set @ContentString = REPLACE(@ContentString,'ْ','')

declare @nCurrentPosition int;
declare @strMetaTag varchar(20);

if LEN(@NewContentString)>0
insert into @TagTable([TagName]) values(@ContentString)
begin
   while CHARINDEX('.',@NewContentString,0)>0
		   begin
			   set @nLoop = @nLoop+1;
			   set @nCurrentPosition = CHARINDEX('.',@NewContentString,0);
			   set @strMetaTag = SUBSTRING(@NewContentString,0,@nCurrentPosition);
			   set @NewContentString = SUBSTRING(@NewContentString,@nCurrentPosition+1,len(@NewContentString));
			   if(len(@strMetaTag)>=@nLengthRule)
					   begin
						   insert into @TagTable([TagName]) values(@strMetaTag)
						   set @CompositeWord = @CompositeWord+' '+ @strMetaTag;
					   end
					   if @nLoop%@nCompositionCount = 0 and @CompositeWord is not null and @CompositeWord <>''
					   begin
							   insert into @TagTable([TagName]) values(@CompositeWord)
							   set @CompositeWord = '';
					   end
		   end
end
set @strMetaTag = '';
set @RepeatedContentString= LTRIM(@RepeatedContentString);
set @RepeatedContentString= RTRIM(@RepeatedContentString);
   while CHARINDEX(' ',@RepeatedContentString,0)>0
       begin
	     set @nCurrentPosition = CHARINDEX(' ',@RepeatedContentString,0);
		 set @strMetaTag = SUBSTRING(@RepeatedContentString,0,@nCurrentPosition);
		 if(@strMetaTag <> '' and @strMetaTag <> ' ' and @strMetaTag is not null)
		 begin
		if dbo.CountOccurancesOfString(@RepeatedContentString,@strMetaTag)>= @nRepeatedWords
			 insert into @TagTable([TagName]) values(@strMetaTag)
		end
		 set @RepeatedContentString = replace(@RepeatedContentString,@strMetaTag+ ' ','');
		 set @RepeatedContentString = ltrim(@RepeatedContentString);

	end
	UPDATE @TagTable SET TagName = LTRIM(RTRIM(TagName ));
	DELETE FROM @TagTable WHERE TagName IN (select A.blockedtagname  from dbo.GetBlockTags() A)
return
end
go
--function to compare to paragraphs by metadata to help assessment in paragraphs
ALTER function [dbo].[EvaluateParagraph](@SourceParagraph varchar(max),@DestParagraph varchar(max))
returns float
--WITH ENCRYPTION
AS
BEGIN
declare @nSourceMetaTagsCount float=0;
declare @nDestMetaTagsCount float=0;
declare @nAccumelatedTagsCount float=0;
declare @TagName nvarchar(max);


if (CHARINDEX (@DestParagraph,@SourceParagraph)> 0  or dbo.soundexAr(@DestParagraph,@SourceParagraph)=1)
return(1)
select @nDestMetaTagsCount = count(1) from (select distinct * from dbo.GetMetaTagsInfo(@DestParagraph,'',3,1,1) where TagName <> @DestParagraph) DestDataSet --excluding the original full paragraph


--@@CURSOR_ROWS  
DECLARE vendor_cursor CURSOR FOR 
select distinct SourceDS.TagName from dbo.GetMetaTagsInfo(@DestParagraph,'',3,1,1) SourceDS where TagName <> @DestParagraph;
OPEN vendor_cursor  

FETCH NEXT FROM vendor_cursor   
INTO @TagName;  

WHILE @@FETCH_STATUS = 0  
begin
set @nSourceMetaTagsCount = 0;
if exists(select 1 from dbo.GetMetaTagsInfo(@SourceParagraph,'',3,1,1) DestDSRecSet
 where dbo.soundexAr(DestDSRecSet.TagName,@TagName)=1)--excluding the original full paragraph
set @nAccumelatedTagsCount = @nAccumelatedTagsCount+ 1;

FETCH NEXT FROM vendor_cursor   
    INTO @TagName  
end
CLOSE vendor_cursor;  
DEALLOCATE vendor_cursor;
if (@nDestMetaTagsCount =0) set @nDestMetaTagsCount =1;
return(@nAccumelatedTagsCount/@nDestMetaTagsCount)

end
go



declare @DestParagraph varchar(max) = ' هي هذه نظرية فيثاغورث مثلث'
declare @SourceParagraph  varchar(max) = ' نظرية فيثاغورث مثلث'


select distinct TagName from dbo.GetMetaTagsInfo(@DestParagraph,'',3,1,1) DestDS where  TagName <> @DestParagraph

select distinct TagName from dbo.GetMetaTagsInfo(@SourceParagraph,'',3,1,1) DestDS  where  TagName <> @SourceParagraph


 where dbo.soundexAr('فثاغورث',DestDS.TagName)=1;-- and DestDS.TagName <> @DestParagraph;--excluding the original full paragraph

 select @@ROWCOUNT

declare @SourceParagraph varchar(max) = 'قالت أمل أن العلمة نور'
declare @DestParagraph varchar(max) = 'قالت لهم أن العلم نور رحمة '
select dbo.EvaluateParagraph(@SourceParagraph,@DestParagraph);


declare @SourceParagraph varchar(max) = 'قلت أمل أن العلمة '
declare @DestParagraph varchar(max) = 'قالت لهم أن العلم نور '
select dbo.EvaluateParagraph(@SourceParagraph,@DestParagraph);


declare @DestParagraph varchar(max) = 'تطبيق  نظرية فثاغورث مثلث'
declare @SourceParagraph  varchar(max) = '  نظرية فيثاغورث مثلس'
select dbo.EvaluateParagraph(@SourceParagraph,@DestParagraph);




declare @DestParagraph varchar(max) = 'الضمة'
declare @SourceParagraph  varchar(max) = 'الضم'
select dbo.EvaluateParagraph(@SourceParagraph,@DestParagraph);




declare @DestParagraph varchar(max) = 'ذكي'
declare @SourceParagraph  varchar(max) = 'زكي'
select dbo.EvaluateParagraph(@SourceParagraph,@DestParagraph);



declare @DestParagraph varchar(max) = 'محمود'
declare @SourceParagraph  varchar(max) = 'محمد'
select dbo.EvaluateParagraph(@SourceParagraph,@DestParagraph);

declare @DestParagraph varchar(max) = 'العلم'
declare @SourceParagraph  varchar(max) = 'العالم'
select dbo.EvaluateParagraph(@SourceParagraph,@DestParagraph);

declare @DestParagraph varchar(max) = 'المعلم'
declare @SourceParagraph  varchar(max) = 'المعلمة'
select dbo.EvaluateParagraph(@SourceParagraph,@DestParagraph);







