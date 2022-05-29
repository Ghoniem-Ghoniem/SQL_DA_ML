USE [master]
GO
/****** Object:  Database [MLSAMPLES]    Script Date: 06/08/2019 3:09:54 PM ******/
CREATE DATABASE [MLDATABASE]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MLDATABASE].[dbo].[sp_fulltext_database] @action = 'enable'
end
ALTER DATABASE [MLDATABASE] SET  MULTI_USER 


CREATE DATABASE [ECOMMERCEDB]
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECOMMERCEDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECOMMERCEDB] SET  MULTI_USER 
GO


--Reading database name
select DB_NAME()