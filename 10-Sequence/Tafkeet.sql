alter FUNCTION dbo.Tafkeet (@TheNo  numeric(18,3),@Lang int ) 
returns varchar(1000) as 
begin 
if @TheNo <= 0   return 'zero' 
declare @TheNoAfterReplicate varchar(15) 
set @TheNoAfterReplicate = right(replicate('0',15)+cast(floor(@TheNo) as varchar(15)),15) 
declare @ComWithWord varchar(1000),@TheNoWithDecimal as varchar(400),@ThreeWords as int 
set @ThreeWords=0 
set @ComWithWord  = ' فقط ' 
if @Lang =1
	set @ComWithWord  = ' Only ' 

declare   @Tafket TABLE (num int,  NoName varchar(100)) 
INSERT INTO @Tafket VALUES (0,'')  
INSERT INTO @Tafket VALUES (1,'واحد') 
INSERT INTO @Tafket VALUES (2,'اثنان') 
INSERT INTO @Tafket VALUES (3,'ثلاثة') 
INSERT INTO @Tafket VALUES (4,'اربعة') 
INSERT INTO @Tafket VALUES (5,'خمسة') 
INSERT INTO @Tafket VALUES (6,'ستة') 
INSERT INTO @Tafket VALUES (7,'سبعة') 
INSERT INTO @Tafket VALUES (8,'ثمانية') 
INSERT INTO @Tafket VALUES (9,'تسعة') 
INSERT INTO @Tafket VALUES (10,'عشرة') 
INSERT INTO @Tafket VALUES (11,'احدى عشر') 
INSERT INTO @Tafket VALUES (12,'اثنى عشر') 
INSERT INTO @Tafket VALUES (13,'ثلاثة عشر') 
INSERT INTO @Tafket VALUES (14,'اربعة عشر') 
INSERT INTO @Tafket VALUES (15,'خمسة عشر') 
INSERT INTO @Tafket VALUES (16,'ستة عشر') 
INSERT INTO @Tafket VALUES (17,'سبعة عشر') 
INSERT INTO @Tafket VALUES (18,'ثمانية عشر') 
INSERT INTO @Tafket VALUES (19,'تسعة عشر') 
INSERT INTO @Tafket VALUES (20,'عشرون') 
INSERT INTO @Tafket VALUES (30,'ثلاثون') 
INSERT INTO @Tafket VALUES (40,'اربعون') 
INSERT INTO @Tafket VALUES (50,'خمسون') 
INSERT INTO @Tafket VALUES (60,'ستون') 
INSERT INTO @Tafket VALUES (70,'سبعون') 
INSERT INTO @Tafket VALUES (80,'ثمانون') 
INSERT INTO @Tafket VALUES (90,'تسعون') 
INSERT INTO @Tafket VALUES (100,'مائة') 
INSERT INTO @Tafket VALUES (200,'مائتان') 
INSERT INTO @Tafket VALUES (300,'ثلاثمائة') 
INSERT INTO @Tafket VALUES (400,'أربعمائة') 
INSERT INTO @Tafket VALUES (500,'خمسمائة') 
INSERT INTO @Tafket VALUES (600,'ستمائة') 
INSERT INTO @Tafket VALUES (700,'سبعمائة') 
INSERT INTO @Tafket VALUES (800,'ثمانمائة') 
INSERT INTO @Tafket VALUES (900,'تسعمائة') 
INSERT INTO @Tafket  SELECT FirstN.num+LasteN.num,LasteN.NoName+' و '+FirstN.NoName 
FROM (SELECT * FROM @Tafket WHERE num BETWEEN 20 AND 90) FirstN CROSS JOIN (SELECT * FROM @Tafket WHERE num BETWEEN 1 AND 9) LasteN 
INSERT INTO @Tafket  SELECT FirstN.num+LasteN.num,FirstN.NoName+' و '+LasteN.NoName 
FROM (SELECT * FROM @Tafket WHERE num BETWEEN 100 AND 900) FirstN CROSS JOIN (SELECT * FROM @Tafket WHERE num BETWEEN 1 AND 99) LasteN 
if left(@TheNoAfterReplicate,3) > 0 
    set @ComWithWord = @ComWithWord + ISNULL((select NoName  from  @Tafket where num=left(@TheNoAfterReplicate,3)),'')+  ' ترليون' 
if left(right(@TheNoAfterReplicate,12),3) > 0 and  left(@TheNoAfterReplicate,3) > 0 
    set @ComWithWord=@ComWithWord+ ' و ' 
if left(right(@TheNoAfterReplicate,12),3) > 0 
    set @ComWithWord = @ComWithWord +ISNULL((select NoName from @Tafket where num=left(right(@TheNoAfterReplicate,12),3)),'') +  ' بليون' 
if left(right(@TheNoAfterReplicate,9),3) > 0 
begin 
    set @ComWithWord=@ComWithWord + case  when @TheNo>999000000  then ' و'  else '' end 
set @ThreeWords=left(right(@TheNoAfterReplicate,9),3) 
       set @ComWithWord = @ComWithWord + ISNULL((select case when   @ThreeWords>2 then NoName end  from @Tafket  where num=left(right(@TheNoAfterReplicate,9),3)),'')  + case when  @ThreeWords=2 then ' مليونان' when   @ThreeWords between 3 and 10 then ' ملايين' else ' مليون' end 
end 
if left(right(@TheNoAfterReplicate,6),3) > 0 
begin 
    set @ComWithWord=@ComWithWord + case  when @TheNo>999000  then ' و'  else '' end 
    set @ThreeWords=left(right(@TheNoAfterReplicate,6),3) 
    set @ComWithWord = @ComWithWord + ISNULL((select case when  @ThreeWords>2 then NoName  end from @Tafket where num=left(right(@TheNoAfterReplicate,6),3)),'')+ case when  @ThreeWords=2 then ' الفان' when @ThreeWords between 3 and 10 then ' الاف'  else ' الف' end 
end

  if right(@TheNoAfterReplicate,3) > 0 
  begin 
    if @TheNo>999 
begin 
    set @ComWithWord=@ComWithWord + ' و' 
end

    set @ThreeWords=right(@TheNoAfterReplicate,2) 
if @ThreeWords=0 
begin 
   set @ComWithWord=@ComWithWord + ' و' 
   set @ComWithWord = @ComWithWord + ISNULL((select NoName  from @Tafket where @ThreeWords=0 AND num=right(@TheNoAfterReplicate,3)),'') 
end

end

set @ThreeWords=right(@TheNoAfterReplicate,2) 
set @ComWithWord =  @ComWithWord  +   ISNULL((select  NoName  from @Tafket where @ThreeWords>2 AND num=right(@TheNoAfterReplicate,3)),'') 
set @ComWithWord = @ComWithWord +' '+ case when  @ThreeWords=2 then ' ديناران' when @ThreeWords between 3 and 10 then ' دنانير'  else ' دينارا' end 
if right(rtrim(@ComWithWord),1)=',' set @ComWithWord = substring(@ComWithWord,1,len(@ComWithWord)-1) 
if  right(@TheNo,len(@TheNo)-charindex('.',@TheNo)) >0 and charindex('.',@TheNo)>0 
    begin 
        set @ThreeWords=left(right(round(@TheNo,3),3),3) 
        SELECT @TheNoWithDecimal=  ' و' + ISNULL((SELECT NoName from @Tafket where num=left(right(round(@TheNo,3),3),3)  AND @ThreeWords >3),'') 
        set @TheNoWithDecimal = @TheNoWithDecimal+  case when  @ThreeWords=2 then ' فلسان' when @ThreeWords between 3 and 10 then ' فلسات'  else '  فلس' end 
set @ComWithWord = @ComWithWord + @TheNoWithDecimal 
END 
set @ComWithWord = @ComWithWord + ' اردني لا غير' 
return  rtrim(@ComWithWord) 
end

go
select dbo.Tafkeet (10.3,0)