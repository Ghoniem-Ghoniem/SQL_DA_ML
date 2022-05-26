USE [master]
GO
/****** Object:  Database [MLSAMPLES]    Script Date: 06/08/2019 3:09:54 PM ******/
CREATE DATABASE [MLSAMPLES]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MLSAMPLES', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MLSAMPLES.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MLSAMPLES_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MLSAMPLES_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [MLSAMPLES] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MLSAMPLES].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MLSAMPLES] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MLSAMPLES] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MLSAMPLES] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MLSAMPLES] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MLSAMPLES] SET ARITHABORT OFF 
GO
ALTER DATABASE [MLSAMPLES] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MLSAMPLES] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MLSAMPLES] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MLSAMPLES] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MLSAMPLES] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MLSAMPLES] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MLSAMPLES] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MLSAMPLES] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MLSAMPLES] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MLSAMPLES] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MLSAMPLES] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MLSAMPLES] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MLSAMPLES] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MLSAMPLES] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MLSAMPLES] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MLSAMPLES] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MLSAMPLES] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MLSAMPLES] SET RECOVERY FULL 
GO
ALTER DATABASE [MLSAMPLES] SET  MULTI_USER 
GO
ALTER DATABASE [MLSAMPLES] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MLSAMPLES] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MLSAMPLES] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MLSAMPLES] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MLSAMPLES] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MLSAMPLES', N'ON'
GO
ALTER DATABASE [MLSAMPLES] SET QUERY_STORE = OFF
GO
USE [MLSAMPLES]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [MLSAMPLES]
GO
/****** Object:  UserDefinedFunction [dbo].[GetFAEL]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetFAEL]
(
	@Verb varchar(20), @wordtype varchar(10)
)
RETURNS varchar(20)
AS
BEGIN
if lower(@wordtype) !='verb'
return null

declare  @faelstring varchar(20)
	if (len(@Verb)=3)
	begin
		begin
				set @faelstring=  STUFF(@verb, 2, 0, 'ا');
		end
		if(LEFT(@faelstring,2)= 'أا')
					SET @faelstring = REPLACE(@faelstring,'أا','آ')
	
		else if(charindex('اا',@faelstring,1)>0 or charindex('اأ',@faelstring,1)>0)
		begin
			SET @faelstring = REPLACE(@faelstring,'اا','ائ')
			SET @faelstring = REPLACE(@faelstring,'اأ','ائ')
		end
		if(right(@faelstring,1)= 'أ')
			SET @faelstring = substring(@faelstring,1,len(@faelstring)-1) + 'ئ'
	end
	else if (len(@Verb)=4)
	begin
			set @faelstring=  STUFF(@verb, 1, 0, 'م');
	end

	else if (len(@Verb)=6)
	begin
			set @faelstring=  STUFF(@verb, 1, 1, 'م');
			if (SUBSTRING(@verb,LEN(@verb)-1,1)= 'ا')
			begin
				set @faelstring = substring(@faelstring,1,len(@faelstring)-2) + 'ي' + right(@verb,1)
			end
	
	end
	RETURN @faelstring

END


GO
/****** Object:  Table [dbo].[Words_Metadata]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Words_Metadata](
	[WordID] [int] NULL,
	[WordText] [varchar](20) NOT NULL,
	[WordType] [varchar](10) NULL,
	[VerbLength]  AS (len([WordText])),
	[WordGroup] [varchar](20) NULL,
	[Definition] [nchar](10) NULL,
	[Example] [nchar](10) NULL,
	[WordLevel] [nchar](10) NULL,
	[Published] [nchar](10) NULL,
	[Enabled] [nchar](10) NULL,
	[CreationDate] [nchar](10) NULL,
	[CreatedBy] [nchar](10) NULL,
	[ModificationDate] [nchar](10) NULL,
	[ModifiedBy] [nchar](10) NULL,
 CONSTRAINT [PK_Words_Metadata] PRIMARY KEY CLUSTERED 
(
	[WordText] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwWords_Metadata]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vwWords_Metadata] as 
select 
[WordText], 
[VerbLength], 
[WordGroup],[dbo].[GetFAEL]([WordText],[WordType]) as Metadata_Fael,
null as MAFOOL,
null as MASDAR,
null as [MODAREMALE],
null as [MODAREFEMALE],
 null as [AMRMALE],
  null as [AMRFEMALE],
 null as [MOTHANAVERBMALE],
  null as [MOTHANAVERFEMALE],
 null as [GAMAVERBMALE],
  null as [GAMAVERBFEMALE],
 null as [GAMATYPE], 
 null as [GAMANAMEBMALE],
  null as [GAMANAMEMALE],
 [WordType], 
--[SingleImage], [DoubleImage], [GAMAImage], 
[WordID] from Words_Metadata 
GO
/****** Object:  Table [dbo].[ExtentionsTypes]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExtentionsTypes](
	[id] [nchar](10) NULL,
	[Extention_Name] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupID] [varchar](20) NOT NULL,
	[GroupArabicName] [varchar](50) NULL,
	[GroupEnglishName] [varchar](50) NULL,
	[BackgroundImage] [nchar](10) NULL,
	[GroupOrder] [nchar](10) NULL,
	[Sound] [nchar](10) NULL,
	[Definition] [nchar](10) NULL,
	[Example] [nchar](10) NULL,
	[GroupLevel] [nchar](10) NULL,
	[Published] [nchar](10) NULL,
	[Enabled] [nchar](10) NULL,
	[Createdate] [nchar](10) NULL,
	[CreatebBy] [nchar](10) NULL,
	[ModificationDate] [nchar](10) NULL,
	[ModifiedBy] [nchar](10) NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Metadata_Extension]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Metadata_Extension](
	[Word] [nchar](10) NULL,
	[Extension_Type] [nchar](10) NULL,
	[Value] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionsTypes]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionsTypes](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionArabicName] [varchar](50) NULL,
	[QuestionEnglishName] [varchar](50) NULL,
	[QuestionLevel] [int] NULL,
	[SQLStatement] [varchar](1000) NULL,
	[Enabled] [nchar](10) NULL,
	[Publuished] [nchar](10) NULL,
	[Creationdate] [nchar](10) NULL,
	[CreatedBy] [nchar](10) NULL,
	[ModificationDate] [nchar](10) NULL,
	[ModifiedBy] [nchar](10) NULL,
 CONSTRAINT [PK_QuestionsTypes] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WordImages]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WordImages](
	[WordID] [nchar](10) NULL,
	[WordImage] [nchar](10) NULL,
	[ImageOrder] [nchar](10) NULL,
	[ImageName] [nchar](10) NULL,
	[ImageType] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WordSounds]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WordSounds](
	[WordID] [nchar](10) NULL,
	[WordSound] [nchar](10) NULL,
	[SoundType] [nchar](10) NULL,
	[SoundName] [nchar](10) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Words_Metadata]  WITH CHECK ADD  CONSTRAINT [FK_Words_Metadata_Words_Metadata] FOREIGN KEY([WordGroup])
REFERENCES [dbo].[Groups] ([GroupID])
GO
ALTER TABLE [dbo].[Words_Metadata] CHECK CONSTRAINT [FK_Words_Metadata_Words_Metadata]
GO
/****** Object:  StoredProcedure [dbo].[GenerateQuestions]    Script Date: 06/08/2019 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateQuestions]
	@level int
AS
BEGIN
DECLARE @sqlCommand nvarchar(MAX) 
declare @sqlstatementperlinenvarchar nvarchar(500)
set @sqlCommand  = ''


DECLARE db_cursor CURSOR FOR 
SELECT UPPER(sqlstatement) sqlstatement from QuestionsTypes 
where 
questionlevel = @level and sqlstatement  is not null
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @sqlstatementperlinenvarchar  

WHILE @@FETCH_STATUS = 0  
BEGIN  
	 set @sqlCommand  =  @sqlCommand  + @sqlstatementperlinenvarchar + ' UNION ';
      FETCH NEXT FROM db_cursor INTO @sqlstatementperlinenvarchar 
END 

CLOSE db_cursor  
DEALLOCATE db_cursor 

if LEN(@sqlCommand)>0
	begin
		set @sqlCommand = SUBSTRING(@sqlCommand,1,len(@sqlCommand)-6) 
		exec sp_executesql @sqlCommand
	end
END
GO
USE [master]
GO
ALTER DATABASE [MLSAMPLES] SET  READ_WRITE 
GO
