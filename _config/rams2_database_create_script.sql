USE [master]
GO
/****** Object:  Database [rams]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE DATABASE [rams]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'rams', FILENAME = N'D:\MSSQL\Database\Data\rams.mdf' , SIZE = 827392KB , MAXSIZE = UNLIMITED, FILEGROWTH = 16384KB )
 LOG ON 
( NAME = N'rams_log', FILENAME = N'D:\MSSQL\Database\Data\rams_log.ldf' , SIZE = 327680KB , MAXSIZE = 2048GB , FILEGROWTH = 8192KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [rams] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [rams].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [rams] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [rams] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [rams] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [rams] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [rams] SET ARITHABORT OFF 
GO
ALTER DATABASE [rams] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [rams] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [rams] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [rams] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [rams] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [rams] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [rams] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [rams] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [rams] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [rams] SET  DISABLE_BROKER 
GO
ALTER DATABASE [rams] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [rams] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [rams] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [rams] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [rams] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [rams] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [rams] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [rams] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [rams] SET  MULTI_USER 
GO
ALTER DATABASE [rams] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [rams] SET DB_CHAINING OFF 
GO
ALTER DATABASE [rams] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [rams] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [rams] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [rams] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'rams', N'ON'
GO
ALTER DATABASE [rams] SET QUERY_STORE = OFF
GO
USE [rams]
GO
/****** Object:  User [rams]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE USER [rams] FOR LOGIN [rams] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [rams]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_birth2Grade]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_birth2Grade]
(
	@_birthday varchar(10)
)
RETURNS varchar(4)
AS
BEGIN
	DECLARE @_today date = GETDATE()
	DECLARE @_calcAge int
	DECLARE @_data varchar(4)
	SET @_calcAge = (SELECT (DATEDIFF(YEAR, @_birthday, @_today) + 1))

	SET @_data = (SELECT CASE WHEN @_calcAge BETWEEN '1' AND '6' THEN '유아'
	WHEN @_calcAge = '7' THEN '초0'
	WHEN @_calcAge = '8' THEN '초1'
	WHEN @_calcAge = '9' THEN '초2'
	WHEN @_calcAge = '10' THEN '초3'
	WHEN @_calcAge = '11' THEN '초4'
	WHEN @_calcAge = '12' THEN '초5'
	WHEN @_calcAge = '13' THEN '초6'
	WHEN @_calcAge = '14' THEN '중1'
	WHEN @_calcAge = '15' THEN '중2'
	WHEN @_calcAge = '16' THEN '중3'
	WHEN @_calcAge = '17' THEN '고1'
	WHEN @_calcAge = '18' THEN '고2'
	WHEN @_calcAge = '19' THEN '고3'
	ELSE '' END)
	RETURN @_data
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_birth2GradeCode]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_birth2GradeCode]
(
	@_birthday varchar(10)
)
RETURNS INT
AS
BEGIN
	DECLARE @_today date = GETDATE()
	DECLARE @_calcAge int
	DECLARE @_data varchar(4)
	SET @_calcAge = (SELECT (DATEDIFF(YEAR, @_birthday, @_today) + 1))

	SET @_data = (SELECT CASE WHEN @_calcAge BETWEEN '1' AND '6' THEN '05'
	WHEN @_calcAge = '7' THEN '10'
	WHEN @_calcAge = '8' THEN '11'
	WHEN @_calcAge = '9' THEN '12'
	WHEN @_calcAge = '10' THEN '13'
	WHEN @_calcAge = '11' THEN '14'
	WHEN @_calcAge = '12' THEN '15'
	WHEN @_calcAge = '13' THEN '16'
	WHEN @_calcAge = '14' THEN '21'
	WHEN @_calcAge = '15' THEN '22'
	WHEN @_calcAge = '16' THEN '23'
	WHEN @_calcAge = '17' THEN '31'
	WHEN @_calcAge = '18' THEN '32'
	WHEN @_calcAge = '19' THEN '33'
	ELSE '' END)
	RETURN @_data
END
GO
/****** Object:  UserDefinedFunction [dbo].[IPAddressAsNumber]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IPAddressAsNumber] (@IPAddress AS varchar(15))
RETURNS BIGINT
AS
BEGIN
	RETURN CONVERT (BIGINT,
	CONVERT(VARBINARY(1), CONVERT(INT, PARSENAME(@IPAddress, 4))) +
	CONVERT(VARBINARY(1), CONVERT(INT, PARSENAME(@IPAddress, 3))) +
	CONVERT(VARBINARY(1), CONVERT(INT, PARSENAME(@IPAddress, 2))) +
	CONVERT(VARBINARY(1), CONVERT(INT, PARSENAME(@IPAddress, 1))))
END
GO
/****** Object:  Table [dbo].[codeM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[codeM](
	[code_num1] [varchar](2) NOT NULL,
	[code_num2] [varchar](2) NOT NULL,
	[code_num3] [varchar](2) NOT NULL,
	[code_name] [varchar](50) NOT NULL,
	[detail] [varchar](50) NOT NULL,
	[is_necessary] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
	[code_use] [varchar](1) NOT NULL,
 CONSTRAINT [PK_codeM] PRIMARY KEY CLUSTERED 
(
	[code_num1] ASC,
	[code_num2] ASC,
	[code_num3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bookM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bookM](
	[book_idx] [int] IDENTITY(1,1) NOT NULL,
	[book_name] [varchar](100) NOT NULL,
	[book_isbn] [varchar](13) NOT NULL,
	[book_writer] [varchar](100) NOT NULL,
	[book_publisher] [varchar](100) NOT NULL,
	[book_category1] [varchar](2) NOT NULL,
	[book_category2] [varchar](2) NOT NULL,
	[book_category3] [varchar](2) NOT NULL,
	[img_link] [varchar](1000) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
	[useYn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_bookM] PRIMARY KEY CLUSTERED 
(
	[book_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_book_category_count]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_book_category_count]
AS
SELECT  ISNULL(B.book_category1, '89') AS category1, C.code_name, COUNT(B.book_category1) AS cnt
FROM     dbo.codeM AS C LEFT OUTER JOIN
               dbo.bookM AS B ON B.book_category1 = C.code_num1
WHERE  (C.code_num1 BETWEEN '81' AND '89') AND (C.code_num2 = '')
GROUP BY B.book_category1, C.code_num1, C.code_name
GO
/****** Object:  Table [dbo].[access_log]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[access_log](
	[log_idx] [int] IDENTITY(1,1) NOT NULL,
	[remote_address] [varchar](20) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_access_log] PRIMARY KEY CLUSTERED 
(
	[log_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activity_error_reportT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activity_error_reportT](
	[error_report_idx] [int] IDENTITY(1,1) NOT NULL,
	[writer_no] [int] NOT NULL,
	[title] [varchar](50) NOT NULL,
	[contents] [varchar](2000) NOT NULL,
	[file_name] [varchar](100) NOT NULL,
	[origin_name] [varchar](100) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[comments] [varchar](500) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_activity_error_reportT] PRIMARY KEY CLUSTERED 
(
	[error_report_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activitypaperT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activitypaperT](
	[activitypaper_idx] [int] IDENTITY(1,1) NOT NULL,
	[book_idx] [int] NOT NULL,
	[activity_student1] [varchar](100) NOT NULL,
	[activity_student2] [varchar](100) NOT NULL,
	[activity_teacher1] [varchar](100) NOT NULL,
	[activity_teacher2] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_activitypaperT] PRIMARY KEY CLUSTERED 
(
	[activitypaper_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bannerT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bannerT](
	[banner_idx] [int] IDENTITY(1,1) NOT NULL,
	[from_date] [varchar](10) NOT NULL,
	[to_date] [varchar](10) NOT NULL,
	[banner_link] [varchar](200) NOT NULL,
	[banner_image] [varchar](200) NOT NULL,
	[orders] [varchar](2) NOT NULL,
	[mainYn] [varchar](1) NOT NULL,
	[banner_visible] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_bannerT] PRIMARY KEY CLUSTERED 
(
	[banner_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[board_book_reportT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[board_book_reportT](
	[book_report_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[writer_no] [int] NOT NULL,
	[book_idx] [int] NOT NULL,
	[book_report_title] [varchar](50) NOT NULL,
	[book_report_contents] [varchar](1000) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_board_book_reportT] PRIMARY KEY CLUSTERED 
(
	[book_report_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[board_center_noticeT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[board_center_noticeT](
	[notice_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[notice_title] [varchar](50) NOT NULL,
	[notice_contents] [varchar](1000) NOT NULL,
	[notice_target] [varchar](1) NOT NULL,
	[notice_target_no] [varchar](10) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_board_center_noticeT] PRIMARY KEY CLUSTERED 
(
	[notice_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[board_inquiry_commentT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[board_inquiry_commentT](
	[inquiry_comment_idx] [int] IDENTITY(1,1) NOT NULL,
	[inquiry_idx] [int] NOT NULL,
	[inquiry_comment] [varchar](1000) NOT NULL,
	[file_name] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_board_inquiry_commentT] PRIMARY KEY CLUSTERED 
(
	[inquiry_comment_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[board_inquiryT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[board_inquiryT](
	[inquiry_idx] [int] IDENTITY(1,1) NOT NULL,
	[inquiry_title] [varchar](50) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[inquiry_writer] [int] NOT NULL,
	[inquiry_type] [varchar](2) NOT NULL,
	[inquiry_contents] [varchar](1000) NOT NULL,
	[origin_file_name] [varchar](100) NOT NULL,
	[file_name] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_board_inquiryT] PRIMARY KEY CLUSTERED 
(
	[inquiry_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[board_lessontip_commentT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[board_lessontip_commentT](
	[comment_idx] [int] IDENTITY(1,1) NOT NULL,
	[board_idx] [int] NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[comment] [varchar](200) NOT NULL,
	[head_write] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_board_lessontip_commentT] PRIMARY KEY CLUSTERED 
(
	[comment_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[board_lessontip_likes]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[board_lessontip_likes](
	[likes_idx] [int] IDENTITY(1,1) NOT NULL,
	[board_idx] [int] NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_board_lessontip_likes] PRIMARY KEY CLUSTERED 
(
	[likes_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[board_lessontipT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[board_lessontipT](
	[board_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[board_kind] [varchar](2) NOT NULL,
	[title] [varchar](50) NOT NULL,
	[contents] [varchar](max) NOT NULL,
	[file_name] [varchar](100) NOT NULL,
	[origin_name] [varchar](100) NOT NULL,
	[notice_yn] [varchar](1) NOT NULL,
	[head_write] [varchar](1) NOT NULL,
	[file_path] [varchar](100) NOT NULL,
	[likes_cnt] [int] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_board_lessontipT] PRIMARY KEY CLUSTERED 
(
	[board_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[boardM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[boardM](
	[board_idx] [int] IDENTITY(1,1) NOT NULL,
	[category1] [varchar](2) NOT NULL,
	[category2] [varchar](2) NOT NULL,
	[open_franchise] [varchar](2) NOT NULL,
	[open_target] [varchar](2) NOT NULL,
	[title] [varchar](100) NOT NULL,
	[contents] [varchar](max) NOT NULL,
	[files] [varchar](100) NOT NULL,
	[origin_file] [varchar](100) NOT NULL,
	[file_path] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_boardM] PRIMARY KEY CLUSTERED 
(
	[board_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[book_rentT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[book_rentT](
	[rent_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[student_no] [int] NOT NULL,
	[teacher_no] [int] NOT NULL,
	[book_idx] [int] NOT NULL,
	[book_status_idx] [int] NOT NULL,
	[rent_date] [date] NOT NULL,
	[ex_return_date] [date] NOT NULL,
	[return_date] [varchar](19) NOT NULL,
	[readYn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_book_rentT] PRIMARY KEY CLUSTERED 
(
	[rent_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[book_statusT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[book_statusT](
	[status_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[book_idx] [int] NOT NULL,
	[book_barcode] [varchar](5) NOT NULL,
	[last_teacher_no] [int] NOT NULL,
	[last_student_no] [int] NOT NULL,
	[last_rent_date] [varchar](10) NOT NULL,
	[last_return_date] [varchar](10) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_book_statusT] PRIMARY KEY CLUSTERED 
(
	[status_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bookRequestT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bookRequestT](
	[request_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[teacher_idx] [int] NOT NULL,
	[request_book_name] [varchar](100) NOT NULL,
	[request_book_isbn] [varchar](13) NOT NULL,
	[request_book_writer] [varchar](100) NOT NULL,
	[request_book_publisher] [varchar](100) NOT NULL,
	[request_book_category1] [varchar](2) NOT NULL,
	[request_book_category2] [varchar](2) NOT NULL,
	[request_book_category3] [varchar](2) NOT NULL,
	[request_state] [varchar](2) NOT NULL,
	[request_memo] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_bookRequestT] PRIMARY KEY CLUSTERED 
(
	[request_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[color_codeT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[color_codeT](
	[color_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[color_detail] [varchar](20) NOT NULL,
	[color_code] [varchar](7) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_color_codeT] PRIMARY KEY CLUSTERED 
(
	[color_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[commute_logT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[commute_logT](
	[commute_log_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[state] [varchar](4) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_commute_logT] PRIMARY KEY CLUSTERED 
(
	[commute_log_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[counsel_newT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[counsel_newT](
	[counsel_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[writer_no] [int] NOT NULL,
	[counselee_name] [varchar](20) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[counsel_teacher_no] [int] NOT NULL,
	[counsel_phone] [varchar](13) NOT NULL,
	[school_name] [varchar](50) NOT NULL,
	[counsel_grade] [varchar](2) NOT NULL,
	[counsel_date] [date] NOT NULL,
	[counsel_regist] [varchar](1) NOT NULL,
	[counsel_class] [varchar](2) NOT NULL,
	[counsel_result] [varchar](30) NOT NULL,
	[counsel_contents] [varchar](2000) NOT NULL,
	[counsel_know] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_counsel_newT] PRIMARY KEY CLUSTERED 
(
	[counsel_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[counselT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[counselT](
	[counsel_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[writer_no] [int] NOT NULL,
	[student_no] [int] NOT NULL,
	[counsel_date] [date] NOT NULL,
	[counsel_kind] [varchar](1) NOT NULL,
	[counsel_method] [varchar](1) NOT NULL,
	[counsel_contents] [varchar](1000) NOT NULL,
	[counsel_followup] [varchar](1000) NOT NULL,
	[counsel_request] [varchar](1000) NOT NULL,
	[counsel_discharge_reason] [varchar](2) NOT NULL,
	[counsel_discharge_contents] [varchar](300) NOT NULL,
	[counsel_open] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_counselT] PRIMARY KEY CLUSTERED 
(
	[counsel_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculumM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[curriculumM](
	[curriculum_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[book_idx] [int] NOT NULL,
	[orders] [int] NOT NULL,
	[months] [varchar](2) NOT NULL,
	[grade] [varchar](2) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_curriculumM] PRIMARY KEY CLUSTERED 
(
	[curriculum_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee_commuteM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee_commuteM](
	[employee_commute_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[from_time] [varchar](30) NOT NULL,
	[to_time] [varchar](30) NOT NULL,
	[paid_holiday] [varchar](1) NOT NULL,
	[unpaid_holiday] [varchar](1) NOT NULL,
 CONSTRAINT [PK_employee_commuteM] PRIMARY KEY CLUSTERED 
(
	[employee_commute_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee_eduM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee_eduM](
	[edu_idx] [int] IDENTITY(1,1) NOT NULL,
	[edu_name] [varchar](50) NOT NULL,
	[edu_type] [varchar](1) NOT NULL,
	[edu_target] [varchar](100) NOT NULL,
	[edu_way] [varchar](max) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_employee_eduM] PRIMARY KEY CLUSTERED 
(
	[edu_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee_eduscheduleT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee_eduscheduleT](
	[eduschedule_idx] [int] IDENTITY(1,1) NOT NULL,
	[edu_idx] [int] NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_list] [varchar](max) NOT NULL,
	[edu_from_time] [date] NOT NULL,
	[edu_to_time] [date] NOT NULL,
	[edu_flag] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_employee_eduscheduleT] PRIMARY KEY CLUSTERED 
(
	[eduschedule_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee_eduT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee_eduT](
	[employee_edu_idx] [int] IDENTITY(1,1) NOT NULL,
	[eduschedule_idx] [int] NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[file_name] [varchar](100) NOT NULL,
	[edu_complete_date] [varchar](10) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_employee_eduT] PRIMARY KEY CLUSTERED 
(
	[employee_edu_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[franchise_authT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[franchise_authT](
	[auth_idx] [int] IDENTITY(1,1) NOT NULL,
	[auth_code] [varchar](10) NOT NULL,
	[auth_expire] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_franchise_authT] PRIMARY KEY CLUSTERED 
(
	[auth_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[franchise_feeM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[franchise_feeM](
	[franchise_fee_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[order_num] [varchar](50) NOT NULL,
	[franchise_fee_ym] [varchar](7) NOT NULL,
	[franchise_fee_state] [varchar](2) NOT NULL,
	[franchise_fee_method] [varchar](2) NOT NULL,
	[franchise_fee_money] [int] NOT NULL,
	[franchise_fee_date] [varchar](10) NOT NULL,
	[refund_request_reason] [varchar](200) NOT NULL,
	[refund_request_amount] [int] NOT NULL,
	[refund_money] [int] NOT NULL,
	[refund_date] [varchar](10) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_franchise_feeM] PRIMARY KEY CLUSTERED 
(
	[franchise_fee_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[franchiseM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[franchiseM](
	[franchise_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_type] [varchar](2) NOT NULL,
	[center_name] [varchar](20) NOT NULL,
	[center_eng_name] [varchar](50) NOT NULL,
	[owner_name] [varchar](10) NOT NULL,
	[owner_id] [varchar](20) NOT NULL,
	[useyn] [varchar](1) NOT NULL,
	[address] [varchar](100) NOT NULL,
	[zipcode] [varchar](5) NOT NULL,
	[tel_num] [varchar](15) NOT NULL,
	[fax_num] [varchar](15) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[location] [varchar](2) NOT NULL,
	[biz_reg_date] [varchar](7) NOT NULL,
	[biz_no] [varchar](12) NOT NULL,
	[center_no] [varchar](20) NOT NULL,
	[class_no] [varchar](2) NOT NULL,
	[report_date] [varchar](1) NOT NULL,
	[franchisee_start] [varchar](10) NOT NULL,
	[franchisee_end] [varchar](10) NOT NULL,
	[rams_fee] [int] NOT NULL,
	[sales_confirm] [varchar](7) NOT NULL,
	[royalty] [int] NOT NULL,
	[sms_fee] [varchar](4) NOT NULL,
	[lms_fee] [varchar](4) NOT NULL,
	[mms_fee] [varchar](4) NOT NULL,
	[shop_id] [varchar](100) NOT NULL,
	[shop_key] [varchar](100) NOT NULL,
	[point] [int] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_franchiseM] PRIMARY KEY CLUSTERED 
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[goods_shippingT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[goods_shippingT](
	[shipping_idx] [int] IDENTITY(1,1) NOT NULL,
	[order_num] [varchar](50) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[teacher_idx] [int] NOT NULL,
	[teacher_name] [varchar](20) NOT NULL,
	[teacher_phone] [varchar](13) NOT NULL,
	[shipping_zipcode] [varchar](5) NOT NULL,
	[shipping_address] [varchar](100) NOT NULL,
	[shipping_date] [varchar](10) NOT NULL,
	[shipping_company] [varchar](10) NOT NULL,
	[shipping_state] [varchar](2) NOT NULL,
	[cancel_date] [varchar](10) NOT NULL,
	[invoice_number] [varchar](30) NOT NULL,
	[shipping_memo] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_goods_shippingT] PRIMARY KEY CLUSTERED 
(
	[shipping_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[goodsM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[goodsM](
	[goods_idx] [int] IDENTITY(1,1) NOT NULL,
	[goods_name] [varchar](100) NOT NULL,
	[goods_type] [varchar](2) NOT NULL,
	[order_unit] [varchar](20) NOT NULL,
	[cost_price] [int] NOT NULL,
	[sel_price] [int] NOT NULL,
	[min_quantity] [int] NOT NULL,
	[img_link] [varchar](255) NOT NULL,
	[memo] [varchar](200) NOT NULL,
	[useYn] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_goodsM] PRIMARY KEY CLUSTERED 
(
	[goods_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[holidayT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[holidayT](
	[holiday_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[reg_user_idx] [int] NOT NULL,
	[del_user_idx] [int] NOT NULL,
	[holiday_date] [varchar](10) NOT NULL,
	[holiday_memo] [varchar](30) NOT NULL,
	[useYn] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_holidayT] PRIMARY KEY CLUSTERED 
(
	[holiday_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[invoice_pointM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[invoice_pointM](
	[pay_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[user_name] [varchar](20) NOT NULL,
	[order_num] [varchar](50) NOT NULL,
	[order_money] [int] NOT NULL,
	[order_method] [varchar](2) NOT NULL,
	[order_state] [varchar](2) NOT NULL,
	[order_date] [varchar](10) NOT NULL,
	[pay_date] [varchar](10) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_invoice_pointM] PRIMARY KEY CLUSTERED 
(
	[pay_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[invoice_refundT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[invoice_refundT](
	[invoice_refund_idx] [int] IDENTITY(1,1) NOT NULL,
	[invoice_idx] [int] NOT NULL,
	[order_num] [varchar](50) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[teacher_idx] [int] NOT NULL,
	[student_idx] [int] NOT NULL,
	[refund_ym] [varchar](7) NOT NULL,
	[refund_amount] [int] NOT NULL,
	[refund_state] [varchar](2) NOT NULL,
	[refund_date] [varchar](10) NOT NULL,
	[refund_etc] [varchar](400) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_invoice_refundT] PRIMARY KEY CLUSTERED 
(
	[invoice_refund_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[invoiceM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[invoiceM](
	[invoice_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[teacher_idx] [int] NOT NULL,
	[student_idx] [int] NOT NULL,
	[order_num] [varchar](50) NOT NULL,
	[receipt_idx] [int] NOT NULL,
	[receipt_name] [varchar](100) NOT NULL,
	[order_quantity] [int] NOT NULL,
	[order_money] [int] NOT NULL,
	[order_method] [varchar](2) NOT NULL,
	[order_state] [varchar](2) NOT NULL,
	[order_date] [varchar](10) NOT NULL,
	[order_ym] [varchar](7) NOT NULL,
	[pay_date] [varchar](10) NOT NULL,
	[pay_memo] [varchar](400) NOT NULL,
	[refund_date] [varchar](10) NOT NULL,
	[refund_method] [varchar](2) NOT NULL,
	[refund_money] [int] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_invoiceM] PRIMARY KEY CLUSTERED 
(
	[invoice_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ip_countryT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ip_countryT](
	[ip_idx] [int] IDENTITY(1,1) NOT NULL,
	[start_ip] [varchar](15) NOT NULL,
	[end_ip] [varchar](15) NOT NULL,
	[country_code] [varchar](4) NOT NULL,
 CONSTRAINT [PK_ip_countryT] PRIMARY KEY CLUSTERED 
(
	[ip_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lesson_attendT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lesson_attendT](
	[schedule_idx] [int] NOT NULL,
	[student_idx] [int] NOT NULL,
	[attend_yn] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_lesson_attendT_1] PRIMARY KEY CLUSTERED 
(
	[schedule_idx] ASC,
	[student_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lesson_evaluationT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lesson_evaluationT](
	[eval_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[student_no] [int] NOT NULL,
	[writer_no] [int] NOT NULL,
	[eval_year] [varchar](4) NOT NULL,
	[eval_semiannual] [varchar](1) NOT NULL,
	[eval_content] [varchar](500) NOT NULL,
	[read_score] [varchar](1) NOT NULL,
	[read_content] [varchar](500) NOT NULL,
	[debate_score] [varchar](1) NOT NULL,
	[debate_content] [varchar](500) NOT NULL,
	[write_score] [varchar](1) NOT NULL,
	[write_content] [varchar](500) NOT NULL,
	[lead_score] [varchar](1) NOT NULL,
	[lead_content] [varchar](500) NOT NULL,
	[guide_content] [varchar](500) NOT NULL,
	[next_guide_content] [varchar](500) NOT NULL,
	[parent_request] [varchar](500) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_lesson_evaluationT] PRIMARY KEY CLUSTERED 
(
	[eval_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lesson_scoreT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lesson_scoreT](
	[schedule_idx] [varchar](10) NOT NULL,
	[franchise_idx] [varchar](10) NOT NULL,
	[student_idx] [varchar](10) NOT NULL,
	[score_read] [int] NOT NULL,
	[score_debate1] [int] NOT NULL,
	[score_debate2] [int] NOT NULL,
	[score_debate3] [int] NOT NULL,
	[score_debate4] [int] NOT NULL,
	[score_write1] [int] NOT NULL,
	[score_write2] [int] NOT NULL,
	[score_write3] [int] NOT NULL,
	[score_write4] [int] NOT NULL,
	[score_lead] [int] NOT NULL,
	[score_memo] [varchar](200) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_lesson_scoreT] PRIMARY KEY CLUSTERED 
(
	[schedule_idx] ASC,
	[franchise_idx] ASC,
	[student_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lessonM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lessonM](
	[schedule_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[teacher_idx] [int] NOT NULL,
	[lesson_book_idx] [int] NOT NULL,
	[lesson_type] [varchar](2) NOT NULL,
	[lesson_date] [varchar](10) NOT NULL,
	[lesson_fromtime] [varchar](5) NOT NULL,
	[lesson_totime] [varchar](5) NOT NULL,
	[lesson_room] [varchar](2) NOT NULL,
	[lesson_grade] [varchar](2) NOT NULL,
	[onoff_yn] [varchar](1) NOT NULL,
	[freehand_yn] [varchar](1) NOT NULL,
	[supple_yn] [varchar](1) NOT NULL,
	[supple_type] [varchar](1) NOT NULL,
	[receipt_idx] [int] NOT NULL,
	[over_idx] [int] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_lessonM] PRIMARY KEY CLUSTERED 
(
	[schedule_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lessonT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lessonT](
	[class_idx] [int] IDENTITY(1,1) NOT NULL,
	[schedule_idx] [int] NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[student_idx] [int] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_lessonT] PRIMARY KEY CLUSTERED 
(
	[class_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[magazine_produceT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[magazine_produceT](
	[produce_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[produce_year] [varchar](4) NOT NULL,
	[produce_season] [varchar](2) NOT NULL,
	[produce_file_type] [varchar](2) NOT NULL,
	[produce_origin_file_name] [varchar](100) NOT NULL,
	[produce_file_name] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_magazine_produceT] PRIMARY KEY CLUSTERED 
(
	[produce_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[magazineM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[magazineM](
	[magazine_idx] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NOT NULL,
	[magazine_year] [varchar](4) NOT NULL,
	[season] [varchar](2) NOT NULL,
	[thumbnail_name] [varchar](100) NOT NULL,
	[pdf_link] [varchar](200) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_magazineM] PRIMARY KEY CLUSTERED 
(
	[magazine_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member_centerM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_centerM](
	[user_no] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_id] [varchar](20) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[user_name] [varchar](20) NOT NULL,
	[user_phone] [varchar](13) NOT NULL,
	[emergencyhp] [varchar](13) NOT NULL,
	[birth] [varchar](10) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[position] [varchar](2) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[zipcode] [varchar](5) NOT NULL,
	[address] [varchar](200) NOT NULL,
	[hire_date] [varchar](10) NOT NULL,
	[resign_date] [varchar](10) NOT NULL,
	[school] [varchar](100) NOT NULL,
	[graduation_months] [varchar](7) NOT NULL,
	[major] [varchar](30) NOT NULL,
	[degree_number] [varchar](50) NOT NULL,
	[career] [varchar](20) NOT NULL,
	[career_year] [varchar](2) NOT NULL,
	[certificate] [varchar](50) NOT NULL,
	[bank_name] [varchar](10) NOT NULL,
	[account_number] [varchar](255) NOT NULL,
	[menu_group] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
	[is_admin] [varchar](1) NOT NULL,
	[show_yn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_member_centerM] PRIMARY KEY CLUSTERED 
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_member_center_user_id] UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member_employeeM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_employeeM](
	[user_no] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_id] [varchar](20) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[user_name] [varchar](10) NOT NULL,
	[user_phone] [varchar](13) NOT NULL,
	[emergencyhp] [varchar](13) NOT NULL,
	[birth] [varchar](10) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[position] [varchar](2) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[zipcode] [varchar](5) NOT NULL,
	[address] [varchar](100) NOT NULL,
	[hire_date] [varchar](10) NOT NULL,
	[resign_date] [varchar](10) NOT NULL,
	[school] [varchar](30) NOT NULL,
	[graduation_months] [varchar](7) NOT NULL,
	[major] [varchar](30) NOT NULL,
	[degree_number] [varchar](50) NOT NULL,
	[career] [varchar](20) NOT NULL,
	[career_year] [varchar](2) NOT NULL,
	[certificate] [varchar](50) NOT NULL,
	[bank_name] [varchar](10) NOT NULL,
	[account_number] [varbinary](255) NOT NULL,
	[menu_group] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
	[is_admin] [varchar](1) NOT NULL,
	[show_yn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_member_employeeM] PRIMARY KEY CLUSTERED 
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_member_employee_user_id] UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member_student_dormantT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_student_dormantT](
	[user_no] [int] NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_id] [varchar](20) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[user_name] [varchar](10) NOT NULL,
	[user_phone] [varchar](13) NOT NULL,
	[birth] [varchar](10) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[class_date] [varchar](10) NOT NULL,
	[zipcode] [varchar](5) NOT NULL,
	[address] [varchar](100) NOT NULL,
	[teacher_no] [int] NOT NULL,
	[color_tag] [varchar](2) NOT NULL,
	[user_memo] [varchar](max) NOT NULL,
	[dormant_code] [varchar](2) NOT NULL,
	[dormant_text] [varchar](100) NOT NULL,
	[logged_date] [datetime] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
	[show_yn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_member_student_dormantt] PRIMARY KEY CLUSTERED 
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_member_student_dormant_user_id] UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member_student_outT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_student_outT](
	[user_no] [int] NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_id] [varchar](20) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[user_name] [varchar](10) NOT NULL,
	[user_phone] [varchar](13) NOT NULL,
	[birth] [varchar](10) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[class_date] [varchar](10) NOT NULL,
	[zipcode] [varchar](5) NOT NULL,
	[address] [varchar](100) NOT NULL,
	[teacher_no] [int] NOT NULL,
	[color_tag] [varchar](2) NOT NULL,
	[user_memo] [varchar](max) NOT NULL,
	[dormant_code] [varchar](2) NOT NULL,
	[dormant_text] [varchar](100) NOT NULL,
	[logged_date] [datetime] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
	[show_yn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_member_student_outt] PRIMARY KEY CLUSTERED 
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_member_student_out_user_id] UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member_studentM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_studentM](
	[user_no] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_id] [varchar](20) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[user_name] [varchar](10) NOT NULL,
	[user_phone] [varchar](13) NOT NULL,
	[birth] [varchar](10) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[school_name] [varchar](50) NOT NULL,
	[zipcode] [varchar](5) NOT NULL,
	[address] [varchar](100) NOT NULL,
	[teacher_no] [int] NOT NULL,
	[color_tag] [varchar](2) NOT NULL,
	[user_memo] [varchar](max) NOT NULL,
	[logged_date] [datetime] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
	[show_yn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_member_studentM] PRIMARY KEY CLUSTERED 
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_member_student_user_id] UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[menu_link]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[menu_link](
	[menu_idx] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](10) NOT NULL,
	[menu_name] [varchar](50) NOT NULL,
	[link] [varchar](50) NOT NULL,
	[useyn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_menu_link] PRIMARY KEY CLUSTERED 
(
	[menu_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messageT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messageT](
	[msg_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[send_user_idx] [int] NOT NULL,
	[from_no] [varchar](15) NOT NULL,
	[to_name] [varchar](50) NOT NULL,
	[to_no] [varchar](15) NOT NULL,
	[msg_contents] [varchar](2000) NOT NULL,
	[file_nm] [varchar](100) NOT NULL,
	[file_path1] [varchar](200) NOT NULL,
	[file_path2] [varchar](200) NOT NULL,
	[msgType] [varchar](1) NOT NULL,
	[msg_state] [varchar](2) NOT NULL,
	[rev_datetime] [varchar](20) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[send_date] [varchar](20) NOT NULL,
	[msg_seq] [int] NULL,
	[cont_seq] [int] NULL,
	[syncYn] [varchar](1) NOT NULL,
 CONSTRAINT [PK_messageT] PRIMARY KEY CLUSTERED 
(
	[msg_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[meta_tagM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[meta_tagM](
	[meta_idx] [int] IDENTITY(1,1) NOT NULL,
	[og_title] [varchar](50) NOT NULL,
	[og_image] [varchar](100) NOT NULL,
	[og_url] [varchar](255) NOT NULL,
 CONSTRAINT [PK_meta_tagM] PRIMARY KEY CLUSTERED 
(
	[meta_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[msg_groupM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msg_groupM](
	[group_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_idx] [int] NOT NULL,
	[group_name] [varchar](50) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_msg_groupM] PRIMARY KEY CLUSTERED 
(
	[group_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[msg_groupT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msg_groupT](
	[group_reg_idx] [int] IDENTITY(1,1) NOT NULL,
	[group_idx] [int] NOT NULL,
	[group_user_name] [varchar](20) NOT NULL,
	[group_user_hp] [varchar](13) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_msg_groupT] PRIMARY KEY CLUSTERED 
(
	[group_reg_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[newspaper_columnT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[newspaper_columnT](
	[news_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[newspaper_title] [varchar](100) NOT NULL,
	[news_code] [varchar](2) NOT NULL,
	[column_code] [varchar](2) NOT NULL,
	[news_date] [varchar](10) NOT NULL,
	[column_file] [varchar](100) NOT NULL,
	[column_origin] [varchar](100) NOT NULL,
	[teaching_file] [varchar](100) NOT NULL,
	[teaching_origin] [varchar](100) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_newspaper_columnT] PRIMARY KEY CLUSTERED 
(
	[news_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_goodsT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_goodsT](
	[order_goods_idx] [int] IDENTITY(1,1) NOT NULL,
	[order_num] [varchar](50) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[teacher_idx] [int] NOT NULL,
	[teacher_name] [varchar](20) NOT NULL,
	[goods_idx] [int] NOT NULL,
	[goods_name] [varchar](100) NOT NULL,
	[order_quantity] [int] NOT NULL,
	[order_money] [int] NOT NULL,
	[order_method] [varchar](2) NOT NULL,
	[order_state] [varchar](2) NOT NULL,
	[order_date] [datetime] NOT NULL,
	[pay_date] [varchar](10) NOT NULL,
	[refund_date] [varchar](10) NOT NULL,
	[refund_method] [varchar](2) NOT NULL,
	[refund_money] [int] NOT NULL,
 CONSTRAINT [PK_order_goodsT] PRIMARY KEY CLUSTERED 
(
	[order_goods_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment_logT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_logT](
	[payment_idx] [int] IDENTITY(1,1) NOT NULL,
	[paymentKey] [varchar](200) NOT NULL,
	[orderId] [varchar](64) NOT NULL,
	[status] [varchar](20) NOT NULL,
	[orderName] [varchar](200) NOT NULL,
	[requestedAt] [varchar](30) NOT NULL,
	[approvedAt] [varchar](30) NOT NULL,
	[totalAmount] [int] NOT NULL,
	[vat] [int] NOT NULL,
	[taxFreeAmount] [int] NOT NULL,
	[method] [varchar](30) NOT NULL,
	[cancels_cancelReason] [varchar](400) NOT NULL,
	[cancels_cancelAmount] [int] NOT NULL,
	[cancels_taxFreeAmount] [int] NOT NULL,
	[cancels_refundableAmount] [int] NOT NULL,
	[cancels_lastTransactionKey] [varchar](64) NOT NULL,
	[cancels_canceledAt] [varchar](30) NOT NULL,
 CONSTRAINT [PK_payment_logT] PRIMARY KEY CLUSTERED 
(
	[payment_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[receiptT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[receiptT](
	[receipt_item_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[receipt_type] [varchar](2) NOT NULL,
	[receipt_lesson_type] [varchar](2) NOT NULL,
	[receipt_grade] [varchar](2) NOT NULL,
	[receipt_name] [varchar](100) NOT NULL,
	[receipt_amount] [int] NOT NULL,
	[headYn] [varchar](1) NOT NULL,
	[useYn] [varchar](1) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_receiptT] PRIMARY KEY CLUSTERED 
(
	[receipt_item_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report_settingM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report_settingM](
	[report_setting_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[title1] [varchar](30) NOT NULL,
	[title2] [varchar](30) NOT NULL,
	[title3] [varchar](30) NOT NULL,
	[title4] [varchar](30) NOT NULL,
	[title5] [varchar](30) NOT NULL,
	[title6] [varchar](30) NOT NULL,
	[title7] [varchar](30) NOT NULL,
	[title8] [varchar](30) NOT NULL,
	[title9] [varchar](30) NOT NULL,
	[title10] [varchar](30) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_report_settingM] PRIMARY KEY CLUSTERED 
(
	[report_setting_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reportT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reportT](
	[report_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[title1] [varchar](30) NOT NULL,
	[title2] [varchar](30) NOT NULL,
	[title3] [varchar](30) NOT NULL,
	[title4] [varchar](30) NOT NULL,
	[title5] [varchar](30) NOT NULL,
	[title6] [varchar](30) NOT NULL,
	[title7] [varchar](30) NOT NULL,
	[title8] [varchar](30) NOT NULL,
	[title9] [varchar](30) NOT NULL,
	[title10] [varchar](30) NOT NULL,
	[content1] [varchar](max) NOT NULL,
	[content2] [varchar](max) NOT NULL,
	[content3] [varchar](max) NOT NULL,
	[content4] [varchar](max) NOT NULL,
	[content5] [varchar](max) NOT NULL,
	[content6] [varchar](max) NOT NULL,
	[content7] [varchar](max) NOT NULL,
	[content8] [varchar](max) NOT NULL,
	[content9] [varchar](max) NOT NULL,
	[content10] [varchar](max) NOT NULL,
	[months] [varchar](7) NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_reportT] PRIMARY KEY CLUSTERED 
(
	[report_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[save_msgT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[save_msgT](
	[msg_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_idx] [int] NOT NULL,
	[msg_title] [varchar](50) NOT NULL,
	[msg_contents] [varchar](3000) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_save_msgT] PRIMARY KEY CLUSTERED 
(
	[msg_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[school_infoM]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[school_infoM](
	[school_idx] [int] IDENTITY(1,1) NOT NULL,
	[school_type] [varchar](2) NOT NULL,
	[school_name] [varchar](50) NOT NULL,
	[manager_name] [varchar](30) NOT NULL,
	[manager_email] [varchar](100) NOT NULL,
	[manager_password] [varchar](255) NOT NULL,
	[manager_tel] [varchar](15) NOT NULL,
	[manager_hp] [varchar](15) NOT NULL,
	[start_date] [varchar](10) NOT NULL,
	[expire_date] [varchar](10) NOT NULL,
	[access_token] [varchar](20) NOT NULL,
	[order_num] [varchar](64) NOT NULL,
	[order_state] [varchar](2) NOT NULL,
	[order_method] [varchar](2) NOT NULL,
	[order_money] [int] NOT NULL,
	[contract_no] [int] NOT NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NOT NULL,
 CONSTRAINT [PK_school_infoM] PRIMARY KEY CLUSTERED 
(
	[school_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[school_rd_infoT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[school_rd_infoT](
	[diagnosis_idx] [int] IDENTITY(1,1) NOT NULL,
	[school_idx] [int] NOT NULL,
	[std_gender] [varchar](1) NOT NULL,
	[std_grade] [varchar](2) NOT NULL,
	[std_class] [varchar](3) NOT NULL,
	[std_no] [varchar](3) NOT NULL,
	[std_answer] [varchar](150) NOT NULL,
	[score_a_1] [float] NOT NULL,
	[score_a_2] [float] NOT NULL,
	[score_b_1] [float] NOT NULL,
	[score_b_2] [float] NOT NULL,
	[score_b_3] [float] NOT NULL,
	[score_c] [float] NOT NULL,
	[score_d] [float] NOT NULL,
	[score_a_1_sum] [float] NOT NULL,
	[score_a_2_sum] [float] NOT NULL,
	[score_b_1_sum] [float] NOT NULL,
	[score_b_2_sum] [float] NOT NULL,
	[score_b_3_sum] [float] NOT NULL,
	[score_c_sum] [float] NOT NULL,
	[score_d_sum] [float] NOT NULL,
	[score_pliterary] [float] NOT NULL,
	[score_literary] [float] NOT NULL,
	[score_nliterary] [float] NOT NULL,
	[score_pnliterary] [float] NOT NULL,
	[rq_rate] [float] NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_school_rd_infoT] PRIMARY KEY CLUSTERED 
(
	[diagnosis_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sql_log]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sql_log](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[error_log] [varchar](max) NOT NULL,
	[error_query] [varchar](max) NOT NULL,
	[error_location] [varchar](max) NOT NULL,
	[error_address] [varchar](max) NOT NULL,
	[log_date] [datetime] NOT NULL,
 CONSTRAINT [PK_sql_log] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teacher_evaluationT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teacher_evaluationT](
	[teval_idx] [int] IDENTITY(1,1) NOT NULL,
	[franchise_idx] [int] NOT NULL,
	[user_no] [int] NOT NULL,
	[teval_sub1] [varchar](100) NOT NULL,
	[teval_score1] [varchar](2) NOT NULL,
	[teval_sub2] [varchar](100) NOT NULL,
	[teval_score2] [varchar](2) NOT NULL,
	[teval_sub3] [varchar](100) NOT NULL,
	[teval_score3] [varchar](2) NOT NULL,
	[teval_sub4] [varchar](100) NOT NULL,
	[teval_score4] [varchar](2) NOT NULL,
	[teval_sub5] [varchar](100) NOT NULL,
	[teval_score5] [varchar](2) NOT NULL,
	[teval_sub6] [varchar](100) NOT NULL,
	[teval_score6] [varchar](2) NOT NULL,
	[teval_sub7] [varchar](100) NOT NULL,
	[teval_score7] [varchar](2) NOT NULL,
	[teval_sub8] [varchar](100) NOT NULL,
	[teval_score8] [varchar](2) NOT NULL,
	[teval_sub9] [varchar](100) NOT NULL,
	[teval_score9] [varchar](2) NOT NULL,
	[teval_sub10] [varchar](100) NOT NULL,
	[teval_score10] [varchar](2) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_teacher_evaluationT] PRIMARY KEY CLUSTERED 
(
	[teval_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[weekT]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[weekT](
	[week_idx] [int] IDENTITY(1,1) NOT NULL,
	[weekYear] [varchar](4) NOT NULL,
	[weekMonth] [varchar](2) NOT NULL,
	[weekCount] [varchar](1) NOT NULL,
	[weekStartDate] [varchar](10) NOT NULL,
	[weekEndDate] [varchar](10) NOT NULL,
	[weekDetail] [varchar](50) NOT NULL,
	[reg_date] [datetime] NOT NULL,
 CONSTRAINT [PK_weekT] PRIMARY KEY CLUSTERED 
(
	[week_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_remote_address]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_remote_address] ON [dbo].[access_log]
(
	[remote_address] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_activity_error_report_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_activity_error_report_state] ON [dbo].[activity_error_reportT]
(
	[state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_activity_error_report_writer_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_activity_error_report_writer_no] ON [dbo].[activity_error_reportT]
(
	[writer_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_activitypaper_book_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_activitypaper_book_idx] ON [dbo].[activitypaperT]
(
	[book_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_book_report_book_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_book_report_book_idx] ON [dbo].[board_book_reportT]
(
	[book_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_book_report_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_book_report_franchise_idx] ON [dbo].[board_book_reportT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_book_report_writer_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_book_report_writer_no] ON [dbo].[board_book_reportT]
(
	[writer_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_center_notice_notice_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_center_notice_notice_franchise_idx] ON [dbo].[board_center_noticeT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_board_center_notice_notice_target_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_center_notice_notice_target_no] ON [dbo].[board_center_noticeT]
(
	[notice_target_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_inquiry_comment_inquiry_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_inquiry_comment_inquiry_idx] ON [dbo].[board_inquiry_commentT]
(
	[inquiry_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_inquiry_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_inquiry_franchise_idx] ON [dbo].[board_inquiryT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_board_inquiry_type]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_inquiry_type] ON [dbo].[board_inquiryT]
(
	[inquiry_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_inquiry_writer_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_inquiry_writer_no] ON [dbo].[board_inquiryT]
(
	[inquiry_writer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_lessontip_comment_board_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_comment_board_idx] ON [dbo].[board_lessontip_commentT]
(
	[board_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_lessontip_comment_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_comment_franchise_idx] ON [dbo].[board_lessontip_commentT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_lessontip_comment_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_comment_user_no] ON [dbo].[board_lessontip_commentT]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_lessontip_likes_board_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_likes_board_idx] ON [dbo].[board_lessontip_likes]
(
	[board_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_lessontip_likes_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_likes_franchise_idx] ON [dbo].[board_lessontip_likes]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_lessontip_likes_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_likes_user_no] ON [dbo].[board_lessontip_likes]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_board_lessontip_board_kind]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_board_kind] ON [dbo].[board_lessontipT]
(
	[board_kind] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_lessontip_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_franchise_idx] ON [dbo].[board_lessontipT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_board_lessontip_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_lessontip_user_no] ON [dbo].[board_lessontipT]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_board_category1]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_category1] ON [dbo].[boardM]
(
	[category1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_board_category2]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_category2] ON [dbo].[boardM]
(
	[category2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_board_franchise]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_franchise] ON [dbo].[boardM]
(
	[open_franchise] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_board_target]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_board_target] ON [dbo].[boardM]
(
	[open_target] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_book_rent_book_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_rent_book_idx] ON [dbo].[book_rentT]
(
	[book_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_book_rent_book_status_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_rent_book_status_idx] ON [dbo].[book_rentT]
(
	[book_status_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_book_rent_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_rent_franchise_idx] ON [dbo].[book_rentT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_rent_readYn]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_rent_readYn] ON [dbo].[book_rentT]
(
	[readYn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_rent_return_date]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_rent_return_date] ON [dbo].[book_rentT]
(
	[return_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_book_rent_student_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_rent_student_no] ON [dbo].[book_rentT]
(
	[student_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_book_rent_teacher_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_rent_teacher_no] ON [dbo].[book_rentT]
(
	[teacher_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_book_status_book_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_status_book_idx] ON [dbo].[book_statusT]
(
	[book_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_book_status_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_status_franchise_idx] ON [dbo].[book_statusT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_category]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_category] ON [dbo].[bookM]
(
	[book_category1] ASC,
	[book_category2] ASC,
	[book_category3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_category1]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_category1] ON [dbo].[bookM]
(
	[book_category1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_category2]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_category2] ON [dbo].[bookM]
(
	[book_category2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_category3]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_category3] ON [dbo].[bookM]
(
	[book_category3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_isbn]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_isbn] ON [dbo].[bookM]
(
	[book_isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_name]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_name] ON [dbo].[bookM]
(
	[book_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_publisher]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_publisher] ON [dbo].[bookM]
(
	[book_publisher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_book_writer]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_book_writer] ON [dbo].[bookM]
(
	[book_writer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_bookRequestT_book_isbn]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_bookRequestT_book_isbn] ON [dbo].[bookRequestT]
(
	[request_book_isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_bookRequestT_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_bookRequestT_franchise_idx] ON [dbo].[bookRequestT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_bookRequestT_teacher_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_bookRequestT_teacher_idx] ON [dbo].[bookRequestT]
(
	[teacher_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_code_code_name]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_code_code_name] ON [dbo].[codeM]
(
	[code_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_code_detail]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_code_detail] ON [dbo].[codeM]
(
	[detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_franchise_idx] ON [dbo].[color_codeT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_commute_log_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_commute_log_franchise_idx] ON [dbo].[commute_logT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_commute_log_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_commute_log_user_no] ON [dbo].[commute_logT]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_counsel_new_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_counsel_new_franchise_idx] ON [dbo].[counsel_newT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_counsel_new_writer_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_counsel_new_writer_no] ON [dbo].[counsel_newT]
(
	[writer_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_counsel_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_counsel_franchise_idx] ON [dbo].[counselT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_counsel_open]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_counsel_open] ON [dbo].[counselT]
(
	[counsel_open] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_counsel_teacher_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_counsel_teacher_no] ON [dbo].[counselT]
(
	[writer_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_counsel_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_counsel_user_no] ON [dbo].[counselT]
(
	[student_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_curriculum_book_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_curriculum_book_idx] ON [dbo].[curriculumM]
(
	[book_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_curriculum_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_curriculum_franchise_idx] ON [dbo].[curriculumM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_curriculum_grade]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_curriculum_grade] ON [dbo].[curriculumM]
(
	[grade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_curriculum_months]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_curriculum_months] ON [dbo].[curriculumM]
(
	[months] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_employee_commute_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_employee_commute_franchise_idx] ON [dbo].[employee_commuteM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_employee_commute_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_employee_commute_user_no] ON [dbo].[employee_commuteM]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_employee_eduschedule_edu_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_employee_eduschedule_edu_idx] ON [dbo].[employee_eduscheduleT]
(
	[edu_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_employee_eduschedule_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_employee_eduschedule_franchise_idx] ON [dbo].[employee_eduscheduleT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_employee_edu_eduschedule_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_employee_edu_eduschedule_idx] ON [dbo].[employee_eduT]
(
	[eduschedule_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_employee_edu_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_employee_edu_franchise_idx] ON [dbo].[employee_eduT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_employee_edu_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_employee_edu_user_no] ON [dbo].[employee_eduT]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_franchise_auth_auth_code]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_franchise_auth_auth_code] ON [dbo].[franchise_authT]
(
	[auth_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_franchise_fee_fee_method]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_franchise_fee_fee_method] ON [dbo].[franchise_feeM]
(
	[franchise_fee_method] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_franchise_fee_fee_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_franchise_fee_fee_state] ON [dbo].[franchise_feeM]
(
	[franchise_fee_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_franchise_fee_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_franchise_fee_franchise_idx] ON [dbo].[franchise_feeM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_franchise_fee_order_num]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_franchise_fee_order_num] ON [dbo].[franchise_feeM]
(
	[order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_franchise_fee_ym]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_franchise_fee_ym] ON [dbo].[franchise_feeM]
(
	[franchise_fee_ym] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_franchise_useYn]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_franchise_useYn] ON [dbo].[franchiseM]
(
	[useyn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_goods_shipping_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_goods_shipping_franchise_idx] ON [dbo].[goods_shippingT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_goods_shipping_order_num]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_goods_shipping_order_num] ON [dbo].[goods_shippingT]
(
	[order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_goods_shipping_shipping_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_goods_shipping_shipping_state] ON [dbo].[goods_shippingT]
(
	[shipping_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_goods_shipping_teacher_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_goods_shipping_teacher_idx] ON [dbo].[goods_shippingT]
(
	[teacher_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_goods_type]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_goods_type] ON [dbo].[goodsM]
(
	[goods_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_goods_useYn]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_goods_useYn] ON [dbo].[goodsM]
(
	[useYn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_holidayT_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_holidayT_franchise_idx] ON [dbo].[holidayT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_holidayT_holiday_date]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_holidayT_holiday_date] ON [dbo].[holidayT]
(
	[holiday_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_holidayT_user_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_holidayT_user_idx] ON [dbo].[holidayT]
(
	[reg_user_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_point_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_point_franchise_idx] ON [dbo].[invoice_pointM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_invoice_point_order_method]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_point_order_method] ON [dbo].[invoice_pointM]
(
	[order_method] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_invoice_point_order_num]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_point_order_num] ON [dbo].[invoice_pointM]
(
	[order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_invoice_point_order_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_point_order_state] ON [dbo].[invoice_pointM]
(
	[order_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_point_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_point_user_no] ON [dbo].[invoice_pointM]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_invoice_refund_order_num]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_refund_order_num] ON [dbo].[invoice_refundT]
(
	[order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_refundT_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_refundT_franchise_idx] ON [dbo].[invoice_refundT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_refundT_invoice_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_refundT_invoice_idx] ON [dbo].[invoice_refundT]
(
	[invoice_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_refundT_student_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_refundT_student_idx] ON [dbo].[invoice_refundT]
(
	[student_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_refundT_teacher_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_refundT_teacher_idx] ON [dbo].[invoice_refundT]
(
	[teacher_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_franchise_idx] ON [dbo].[invoiceM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_invoice_order_method]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_order_method] ON [dbo].[invoiceM]
(
	[order_method] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_invoice_order_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_order_state] ON [dbo].[invoiceM]
(
	[order_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_invoice_order_ym]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_order_ym] ON [dbo].[invoiceM]
(
	[order_ym] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_receipt_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_receipt_idx] ON [dbo].[invoiceM]
(
	[receipt_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_invoice_refund_method]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_refund_method] ON [dbo].[invoiceM]
(
	[refund_method] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_student_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_student_idx] ON [dbo].[invoiceM]
(
	[student_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_invoice_teacher_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_invoice_teacher_idx] ON [dbo].[invoiceM]
(
	[teacher_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ip_country_country_code]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_ip_country_country_code] ON [dbo].[ip_countryT]
(
	[country_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ip_country_end_ip]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_ip_country_end_ip] ON [dbo].[ip_countryT]
(
	[end_ip] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ip_country_start_ip]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_ip_country_start_ip] ON [dbo].[ip_countryT]
(
	[start_ip] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_schedule_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_schedule_idx] ON [dbo].[lesson_attendT]
(
	[schedule_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_student_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_student_idx] ON [dbo].[lesson_attendT]
(
	[student_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_evaluation_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_evaluation_franchise_idx] ON [dbo].[lesson_evaluationT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_lesson_evaluation_semiannual]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_evaluation_semiannual] ON [dbo].[lesson_evaluationT]
(
	[eval_semiannual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_evaluation_student_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_evaluation_student_no] ON [dbo].[lesson_evaluationT]
(
	[student_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_evaluation_writer_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_evaluation_writer_no] ON [dbo].[lesson_evaluationT]
(
	[writer_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_lesson_evaluation_year]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_evaluation_year] ON [dbo].[lesson_evaluationT]
(
	[eval_year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_book_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_book_idx] ON [dbo].[lessonM]
(
	[lesson_book_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_franchise_idx] ON [dbo].[lessonM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_lesson_lesson_type]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_lesson_type] ON [dbo].[lessonM]
(
	[lesson_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_over_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_over_idx] ON [dbo].[lessonM]
(
	[over_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_receipt_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_receipt_idx] ON [dbo].[lessonM]
(
	[receipt_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_teacher_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_teacher_idx] ON [dbo].[lessonM]
(
	[teacher_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_franchise_idx] ON [dbo].[lessonT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_schedule_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_schedule_idx] ON [dbo].[lessonT]
(
	[schedule_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lesson_student_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_lesson_student_idx] ON [dbo].[lessonT]
(
	[student_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_magazine_produce_file_type]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_magazine_produce_file_type] ON [dbo].[magazine_produceT]
(
	[produce_file_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_magazine_produce_season]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_magazine_produce_season] ON [dbo].[magazine_produceT]
(
	[produce_season] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_magazine_produce_year]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_magazine_produce_year] ON [dbo].[magazine_produceT]
(
	[produce_year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_produce_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_produce_franchise_idx] ON [dbo].[magazine_produceT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_magazine_year_season]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_magazine_year_season] ON [dbo].[magazineM]
(
	[magazine_year] ASC,
	[season] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_member_center_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_center_franchise_idx] ON [dbo].[member_centerM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_center_password]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_center_password] ON [dbo].[member_centerM]
(
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_center_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_center_state] ON [dbo].[member_centerM]
(
	[state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_center_user_id]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_center_user_id] ON [dbo].[member_centerM]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_member_employee_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_employee_franchise_idx] ON [dbo].[member_employeeM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_employee_password]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_employee_password] ON [dbo].[member_employeeM]
(
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_employee_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_employee_state] ON [dbo].[member_employeeM]
(
	[state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_employee_user_id]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_employee_user_id] ON [dbo].[member_employeeM]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_dormant_email]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_dormant_email] ON [dbo].[member_student_dormantT]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_dormant_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_dormant_state] ON [dbo].[member_student_dormantT]
(
	[state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_dormant_user_id_password]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_dormant_user_id_password] ON [dbo].[member_student_dormantT]
(
	[user_id] ASC,
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_out_dormant_code]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_out_dormant_code] ON [dbo].[member_student_outT]
(
	[dormant_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_out_email]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_out_email] ON [dbo].[member_student_outT]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_member_student_out_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_out_franchise_idx] ON [dbo].[member_student_outT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_out_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_out_state] ON [dbo].[member_student_outT]
(
	[state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_color_tag]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_color_tag] ON [dbo].[member_studentM]
(
	[color_tag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_email]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_email] ON [dbo].[member_studentM]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_member_student_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_franchise_idx] ON [dbo].[member_studentM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_password]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_password] ON [dbo].[member_studentM]
(
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_member_student_regdate]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_regdate] ON [dbo].[member_studentM]
(
	[reg_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_member_student_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_member_student_state] ON [dbo].[member_studentM]
(
	[state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_menu_type]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_menu_type] ON [dbo].[menu_link]
(
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_messageT_cont_seq]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_messageT_cont_seq] ON [dbo].[messageT]
(
	[cont_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_messageT_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_messageT_franchise_idx] ON [dbo].[messageT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_messageT_msg_seq]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_messageT_msg_seq] ON [dbo].[messageT]
(
	[msg_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_messageT_msg_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_messageT_msg_state] ON [dbo].[messageT]
(
	[msg_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_messageT_msgType]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_messageT_msgType] ON [dbo].[messageT]
(
	[msgType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_messageT_reg_date]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_messageT_reg_date] ON [dbo].[messageT]
(
	[reg_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_messageT_send_date]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_messageT_send_date] ON [dbo].[messageT]
(
	[send_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_messageT_send_user_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_messageT_send_user_idx] ON [dbo].[messageT]
(
	[send_user_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_meta_tag_url]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_meta_tag_url] ON [dbo].[meta_tagM]
(
	[og_url] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_msg_groupM_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_msg_groupM_franchise_idx] ON [dbo].[msg_groupM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_msg_groupM_user_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_msg_groupM_user_idx] ON [dbo].[msg_groupM]
(
	[user_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_msg_groupT_group_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_msg_groupT_group_idx] ON [dbo].[msg_groupT]
(
	[group_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_newspaper_column_columncode]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_newspaper_column_columncode] ON [dbo].[newspaper_columnT]
(
	[column_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_newspaper_column_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_newspaper_column_franchise_idx] ON [dbo].[newspaper_columnT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_newspaper_column_newscode]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_newspaper_column_newscode] ON [dbo].[newspaper_columnT]
(
	[news_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_newspaper_column_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_newspaper_column_user_no] ON [dbo].[newspaper_columnT]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_order_goods_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_order_goods_franchise_idx] ON [dbo].[order_goodsT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_order_goods_goods_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_order_goods_goods_idx] ON [dbo].[order_goodsT]
(
	[goods_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_order_goods_order_method]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_order_goods_order_method] ON [dbo].[order_goodsT]
(
	[order_method] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_order_goods_order_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_order_goods_order_state] ON [dbo].[order_goodsT]
(
	[order_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_order_goods_teacher_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_order_goods_teacher_idx] ON [dbo].[order_goodsT]
(
	[teacher_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_payment_log_orderId]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_payment_log_orderId] ON [dbo].[payment_logT]
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_payment_log_paymentKey]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_payment_log_paymentKey] ON [dbo].[payment_logT]
(
	[paymentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_receipt_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_receipt_franchise_idx] ON [dbo].[receiptT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_receipt_grade]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_receipt_grade] ON [dbo].[receiptT]
(
	[receipt_grade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_receipt_lesson_type]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_receipt_lesson_type] ON [dbo].[receiptT]
(
	[receipt_lesson_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_receipt_type]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_receipt_type] ON [dbo].[receiptT]
(
	[receipt_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_report_setting_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_report_setting_franchise_idx] ON [dbo].[report_settingM]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_report_setting_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_report_setting_user_no] ON [dbo].[report_settingM]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_report_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_report_franchise_idx] ON [dbo].[reportT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_report_months]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_report_months] ON [dbo].[reportT]
(
	[months] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_report_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_report_user_no] ON [dbo].[reportT]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_save_msg_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_save_msg_franchise_idx] ON [dbo].[save_msgT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_save_msg_user_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_save_msg_user_idx] ON [dbo].[save_msgT]
(
	[user_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_school_info_access_token]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_school_info_access_token] ON [dbo].[school_infoM]
(
	[access_token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_school_info_email]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_school_info_email] ON [dbo].[school_infoM]
(
	[manager_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_school_info_order_method]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_school_info_order_method] ON [dbo].[school_infoM]
(
	[order_method] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_school_info_order_num]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_school_info_order_num] ON [dbo].[school_infoM]
(
	[order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_school_info_order_state]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_school_info_order_state] ON [dbo].[school_infoM]
(
	[order_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_school_info_password]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_school_info_password] ON [dbo].[school_infoM]
(
	[manager_password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_school_rd_info_gender]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_school_rd_info_gender] ON [dbo].[school_rd_infoT]
(
	[std_gender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_school_rd_info_school_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_school_rd_info_school_idx] ON [dbo].[school_rd_infoT]
(
	[school_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_teacher_evaluation_franchise_idx]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_teacher_evaluation_franchise_idx] ON [dbo].[teacher_evaluationT]
(
	[franchise_idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_teacher_evaluation_regdate]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_teacher_evaluation_regdate] ON [dbo].[teacher_evaluationT]
(
	[reg_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_teacher_evaluation_user_no]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_teacher_evaluation_user_no] ON [dbo].[teacher_evaluationT]
(
	[user_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_week_month]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_week_month] ON [dbo].[weekT]
(
	[weekMonth] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_week_year]    Script Date: 2023-10-27 오후 05:35:51 ******/
CREATE NONCLUSTERED INDEX [IX_week_year] ON [dbo].[weekT]
(
	[weekYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[access_log] ADD  CONSTRAINT [DF_access_log_remote_address]  DEFAULT ('') FOR [remote_address]
GO
ALTER TABLE [dbo].[access_log] ADD  CONSTRAINT [DF_access_log_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_writer_no]  DEFAULT ((0)) FOR [writer_no]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_contents]  DEFAULT ('') FOR [contents]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_file_name]  DEFAULT ('') FOR [file_name]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_origin_name]  DEFAULT ('') FOR [origin_name]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_state]  DEFAULT ('') FOR [state]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_comment]  DEFAULT ('') FOR [comments]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[activity_error_reportT] ADD  CONSTRAINT [DF_activity_error_reportT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[activitypaperT] ADD  CONSTRAINT [DF_activitypaperT_book_idx]  DEFAULT ((0)) FOR [book_idx]
GO
ALTER TABLE [dbo].[activitypaperT] ADD  CONSTRAINT [DF_activitypaperT_activity_student1]  DEFAULT ('') FOR [activity_student1]
GO
ALTER TABLE [dbo].[activitypaperT] ADD  CONSTRAINT [DF_activitypaperT_activity_student2]  DEFAULT ('') FOR [activity_student2]
GO
ALTER TABLE [dbo].[activitypaperT] ADD  CONSTRAINT [DF_activitypaperT_activity_teacher1]  DEFAULT ('') FOR [activity_teacher1]
GO
ALTER TABLE [dbo].[activitypaperT] ADD  CONSTRAINT [DF_activitypaperT_activity_teacher2]  DEFAULT ('') FOR [activity_teacher2]
GO
ALTER TABLE [dbo].[activitypaperT] ADD  CONSTRAINT [DF_Table_1_regdate]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[activitypaperT] ADD  CONSTRAINT [DF_activitypaperT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[bannerT] ADD  CONSTRAINT [DF_bannerT_from_date]  DEFAULT ('') FOR [from_date]
GO
ALTER TABLE [dbo].[bannerT] ADD  CONSTRAINT [DF_bannerT_to_date]  DEFAULT ('') FOR [to_date]
GO
ALTER TABLE [dbo].[bannerT] ADD  CONSTRAINT [DF_bannerT_banner_link]  DEFAULT ('') FOR [banner_link]
GO
ALTER TABLE [dbo].[bannerT] ADD  CONSTRAINT [DF_bannerT_orders]  DEFAULT ('') FOR [orders]
GO
ALTER TABLE [dbo].[bannerT] ADD  CONSTRAINT [DF_bannerT_mainYn]  DEFAULT ('') FOR [mainYn]
GO
ALTER TABLE [dbo].[bannerT] ADD  CONSTRAINT [DF_bannerT_useYn]  DEFAULT ('') FOR [banner_visible]
GO
ALTER TABLE [dbo].[bannerT] ADD  CONSTRAINT [DF_bannerT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[bannerT] ADD  CONSTRAINT [DF_bannerT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[board_book_reportT] ADD  CONSTRAINT [DF_board_book_reportT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[board_book_reportT] ADD  CONSTRAINT [DF_board_book_reportT_writer_no]  DEFAULT ((0)) FOR [writer_no]
GO
ALTER TABLE [dbo].[board_book_reportT] ADD  CONSTRAINT [DF_board_book_reportT_book_idx]  DEFAULT ((0)) FOR [book_idx]
GO
ALTER TABLE [dbo].[board_book_reportT] ADD  CONSTRAINT [DF_board_book_reportT_book_report_title]  DEFAULT ('') FOR [book_report_title]
GO
ALTER TABLE [dbo].[board_book_reportT] ADD  CONSTRAINT [DF_board_book_reportT_book_report_contents]  DEFAULT ('') FOR [book_report_contents]
GO
ALTER TABLE [dbo].[board_book_reportT] ADD  CONSTRAINT [DF_board_book_reportT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[board_book_reportT] ADD  CONSTRAINT [DF_board_book_reportT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[board_center_noticeT] ADD  CONSTRAINT [DF_board_center_noticeT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[board_center_noticeT] ADD  CONSTRAINT [DF_board_center_noticeT_notice_title]  DEFAULT ('') FOR [notice_title]
GO
ALTER TABLE [dbo].[board_center_noticeT] ADD  CONSTRAINT [DF_board_center_noticeT_notice_contents]  DEFAULT ('') FOR [notice_contents]
GO
ALTER TABLE [dbo].[board_center_noticeT] ADD  CONSTRAINT [DF_board_center_noticeT_notice_target]  DEFAULT ('') FOR [notice_target]
GO
ALTER TABLE [dbo].[board_center_noticeT] ADD  CONSTRAINT [DF_board_center_noticeT_notice_target_no]  DEFAULT ('') FOR [notice_target_no]
GO
ALTER TABLE [dbo].[board_center_noticeT] ADD  CONSTRAINT [DF_board_center_noticeT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[board_center_noticeT] ADD  CONSTRAINT [DF_board_center_noticeT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[board_inquiry_commentT] ADD  CONSTRAINT [DF_board_inquiry_commentT_inquiry_idx]  DEFAULT ((0)) FOR [inquiry_idx]
GO
ALTER TABLE [dbo].[board_inquiry_commentT] ADD  CONSTRAINT [DF_board_inquiry_commentT_inquiry_comment]  DEFAULT ('') FOR [inquiry_comment]
GO
ALTER TABLE [dbo].[board_inquiry_commentT] ADD  CONSTRAINT [DF_board_inquiry_commentT_file_name]  DEFAULT ('') FOR [file_name]
GO
ALTER TABLE [dbo].[board_inquiry_commentT] ADD  CONSTRAINT [DF_board_inquiry_commentT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[board_inquiry_commentT] ADD  CONSTRAINT [DF_board_inquiry_commentT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_inquiry_title]  DEFAULT ('') FOR [inquiry_title]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_inquiry_writer]  DEFAULT ((0)) FOR [inquiry_writer]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_inquiry_type]  DEFAULT ('') FOR [inquiry_type]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_inquiry_contents]  DEFAULT ('') FOR [inquiry_contents]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_origin_file_name]  DEFAULT ('') FOR [origin_file_name]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_file_name]  DEFAULT ('') FOR [file_name]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[board_inquiryT] ADD  CONSTRAINT [DF_board_inquiryT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[board_lessontip_commentT] ADD  CONSTRAINT [DF_board_lessontip_commentT_board_idx]  DEFAULT ((0)) FOR [board_idx]
GO
ALTER TABLE [dbo].[board_lessontip_commentT] ADD  CONSTRAINT [DF_board_lessontip_commentT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[board_lessontip_commentT] ADD  CONSTRAINT [DF_board_lessontip_commentT_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[board_lessontip_commentT] ADD  CONSTRAINT [DF_board_lessontip_commentT_comment]  DEFAULT ('') FOR [comment]
GO
ALTER TABLE [dbo].[board_lessontip_commentT] ADD  CONSTRAINT [DF_board_lessontip_commentT_head_write]  DEFAULT ('') FOR [head_write]
GO
ALTER TABLE [dbo].[board_lessontip_commentT] ADD  CONSTRAINT [DF_board_lessontip_commentT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[board_lessontip_commentT] ADD  CONSTRAINT [DF_board_lessontip_commentT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[board_lessontip_likes] ADD  CONSTRAINT [DF_board_lessontip_likes_board_idx]  DEFAULT ((0)) FOR [board_idx]
GO
ALTER TABLE [dbo].[board_lessontip_likes] ADD  CONSTRAINT [DF_board_lessontip_likes_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[board_lessontip_likes] ADD  CONSTRAINT [DF_board_lessontip_likes_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[board_lessontip_likes] ADD  CONSTRAINT [DF_board_lessontip_likes_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_board_kind]  DEFAULT ('') FOR [board_kind]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_contents]  DEFAULT ('') FOR [contents]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_file_name]  DEFAULT ('') FOR [file_name]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_origin_name]  DEFAULT ('') FOR [origin_name]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_notice_yn]  DEFAULT ('') FOR [notice_yn]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_head_write]  DEFAULT ('') FOR [head_write]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_file_path]  DEFAULT ('') FOR [file_path]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_likes_cnt]  DEFAULT ((0)) FOR [likes_cnt]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[board_lessontipT] ADD  CONSTRAINT [DF_board_lessontipT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_category1]  DEFAULT ('') FOR [category1]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_category2]  DEFAULT ('') FOR [category2]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_open_franchise]  DEFAULT ('') FOR [open_franchise]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_open_target]  DEFAULT ('') FOR [open_target]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_contents]  DEFAULT ('') FOR [contents]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_files]  DEFAULT ('') FOR [files]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_origin_file]  DEFAULT ('') FOR [origin_file]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_file_path]  DEFAULT ('') FOR [file_path]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[boardM] ADD  CONSTRAINT [DF_boardM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_farnchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_student_no]  DEFAULT ((0)) FOR [student_no]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_teacher_no]  DEFAULT ((0)) FOR [teacher_no]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_book_idx]  DEFAULT ((0)) FOR [book_idx]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_book_status_idx]  DEFAULT ((0)) FOR [book_status_idx]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_rent_date]  DEFAULT (getdate()) FOR [rent_date]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_ex_return_date]  DEFAULT (dateadd(day,(7),getdate())) FOR [ex_return_date]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_return_date]  DEFAULT ('') FOR [return_date]
GO
ALTER TABLE [dbo].[book_rentT] ADD  CONSTRAINT [DF_book_rentT_readYn]  DEFAULT ('') FOR [readYn]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_book_idx]  DEFAULT ((0)) FOR [book_idx]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_book_amount]  DEFAULT ('') FOR [book_barcode]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_last_teacher_no]  DEFAULT ((0)) FOR [last_teacher_no]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_last_student_no]  DEFAULT ((0)) FOR [last_student_no]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_last_rent_date]  DEFAULT ('') FOR [last_rent_date]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_last_return_date]  DEFAULT ('') FOR [last_return_date]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[book_statusT] ADD  CONSTRAINT [DF_book_statusT_mod_date_1]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_book_name]  DEFAULT ('') FOR [book_name]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_book_isbn]  DEFAULT ('') FOR [book_isbn]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_book_writer]  DEFAULT ('') FOR [book_writer]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_book_publisher]  DEFAULT ('') FOR [book_publisher]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_book_category1]  DEFAULT ('') FOR [book_category1]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_book_category2]  DEFAULT ('') FOR [book_category2]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_book_category3]  DEFAULT ('') FOR [book_category3]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_img_link]  DEFAULT ('') FOR [img_link]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[bookM] ADD  CONSTRAINT [DF_bookM_useYn]  DEFAULT ('Y') FOR [useYn]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_teacher_idx]  DEFAULT ((0)) FOR [teacher_idx]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_book_name]  DEFAULT ('') FOR [request_book_name]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_book_isbn]  DEFAULT ('') FOR [request_book_isbn]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_book_writer]  DEFAULT ('') FOR [request_book_writer]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_book_publisher]  DEFAULT ('') FOR [request_book_publisher]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_book_category1]  DEFAULT ('') FOR [request_book_category1]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_book_category2]  DEFAULT ('') FOR [request_book_category2]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_book_category3]  DEFAULT ('') FOR [request_book_category3]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_request_state]  DEFAULT ('') FOR [request_state]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_request_memo]  DEFAULT ('') FOR [request_memo]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[bookRequestT] ADD  CONSTRAINT [DF_bookRequestT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_code_num1]  DEFAULT ('') FOR [code_num1]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_code_num2]  DEFAULT ('') FOR [code_num2]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_code_num3]  DEFAULT ('') FOR [code_num3]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_code_name]  DEFAULT ('') FOR [code_name]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_detail]  DEFAULT ('') FOR [detail]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_is_necessary]  DEFAULT ('N') FOR [is_necessary]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[codeM] ADD  CONSTRAINT [DF_codeM_code_use]  DEFAULT ('Y') FOR [code_use]
GO
ALTER TABLE [dbo].[color_codeT] ADD  CONSTRAINT [DF_color_codeT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[color_codeT] ADD  CONSTRAINT [DF_color_codeT_color_detail]  DEFAULT ('') FOR [color_detail]
GO
ALTER TABLE [dbo].[color_codeT] ADD  CONSTRAINT [DF_color_codeT_color_code]  DEFAULT ('') FOR [color_code]
GO
ALTER TABLE [dbo].[color_codeT] ADD  CONSTRAINT [DF_color_codeT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[color_codeT] ADD  CONSTRAINT [DF_color_codeT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[commute_logT] ADD  CONSTRAINT [DF_commute_logT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[commute_logT] ADD  CONSTRAINT [DF_commute_logT_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[commute_logT] ADD  CONSTRAINT [DF_commute_logT_state]  DEFAULT ('') FOR [state]
GO
ALTER TABLE [dbo].[commute_logT] ADD  CONSTRAINT [DF_commute_logT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_writer_no]  DEFAULT ((0)) FOR [writer_no]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counselee_name]  DEFAULT ('') FOR [counselee_name]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_gender]  DEFAULT ('') FOR [gender]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counsel_phone]  DEFAULT ('') FOR [counsel_phone]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_school_name]  DEFAULT ('') FOR [school_name]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counsel_grade]  DEFAULT ('') FOR [counsel_grade]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counsel_date]  DEFAULT (getdate()) FOR [counsel_date]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counsel_regist]  DEFAULT ('') FOR [counsel_regist]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counsel_class]  DEFAULT ('') FOR [counsel_class]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counsel_result]  DEFAULT ('') FOR [counsel_result]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counsel_contents]  DEFAULT ('') FOR [counsel_contents]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_counsel_know]  DEFAULT ('') FOR [counsel_know]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[counsel_newT] ADD  CONSTRAINT [DF_counsel_newT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_writer_no]  DEFAULT ((0)) FOR [writer_no]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_student_no]  DEFAULT ((0)) FOR [student_no]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_date]  DEFAULT (getdate()) FOR [counsel_date]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_kind]  DEFAULT ('') FOR [counsel_kind]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_method]  DEFAULT ('') FOR [counsel_method]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_contents]  DEFAULT ('') FOR [counsel_contents]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_followup]  DEFAULT ('') FOR [counsel_followup]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_request]  DEFAULT ('') FOR [counsel_request]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_discharge_reason]  DEFAULT ('') FOR [counsel_discharge_reason]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_discharge_contents]  DEFAULT ('') FOR [counsel_discharge_contents]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_counsel_open]  DEFAULT ('') FOR [counsel_open]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[counselT] ADD  CONSTRAINT [DF_counselT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[curriculumM] ADD  CONSTRAINT [DF_curriculumM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[curriculumM] ADD  CONSTRAINT [DF_curriculumM_book_idx]  DEFAULT ((0)) FOR [book_idx]
GO
ALTER TABLE [dbo].[curriculumM] ADD  CONSTRAINT [DF_curriculumM_orders]  DEFAULT ((0)) FOR [orders]
GO
ALTER TABLE [dbo].[curriculumM] ADD  CONSTRAINT [DF_curriculumM_months]  DEFAULT ('') FOR [months]
GO
ALTER TABLE [dbo].[curriculumM] ADD  CONSTRAINT [DF_curriculumM_grade]  DEFAULT ('') FOR [grade]
GO
ALTER TABLE [dbo].[curriculumM] ADD  CONSTRAINT [DF_curriculumM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[curriculumM] ADD  CONSTRAINT [DF_curriculumM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[employee_commuteM] ADD  CONSTRAINT [DF_employee_commuteM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[employee_commuteM] ADD  CONSTRAINT [DF_employee_commuteM_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[employee_commuteM] ADD  CONSTRAINT [DF_employee_commuteM_from_time]  DEFAULT ('') FOR [from_time]
GO
ALTER TABLE [dbo].[employee_commuteM] ADD  CONSTRAINT [DF_employee_commuteM_to_time]  DEFAULT ('') FOR [to_time]
GO
ALTER TABLE [dbo].[employee_commuteM] ADD  CONSTRAINT [DF_employee_commuteM_paid_holiday]  DEFAULT ('') FOR [paid_holiday]
GO
ALTER TABLE [dbo].[employee_commuteM] ADD  CONSTRAINT [DF_employee_commuteM_unpaid_holiday]  DEFAULT ('') FOR [unpaid_holiday]
GO
ALTER TABLE [dbo].[employee_eduM] ADD  CONSTRAINT [DF_employee_eduM_edu_name]  DEFAULT ('') FOR [edu_name]
GO
ALTER TABLE [dbo].[employee_eduM] ADD  CONSTRAINT [DF_employee_eduM_edu_type]  DEFAULT ('') FOR [edu_type]
GO
ALTER TABLE [dbo].[employee_eduM] ADD  CONSTRAINT [DF_employee_eduM_edu_target]  DEFAULT ('') FOR [edu_target]
GO
ALTER TABLE [dbo].[employee_eduM] ADD  CONSTRAINT [DF_employee_eduM_edu_way]  DEFAULT ('') FOR [edu_way]
GO
ALTER TABLE [dbo].[employee_eduM] ADD  CONSTRAINT [DF_employee_eduM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[employee_eduM] ADD  CONSTRAINT [DF_employee_eduM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[employee_eduscheduleT] ADD  CONSTRAINT [DF_employee_eduscheduleT_edu_idx]  DEFAULT ((0)) FOR [edu_idx]
GO
ALTER TABLE [dbo].[employee_eduscheduleT] ADD  CONSTRAINT [DF_employee_eduscheduleT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[employee_eduscheduleT] ADD  CONSTRAINT [DF_employee_eduscheduleT_user_list]  DEFAULT ('') FOR [user_list]
GO
ALTER TABLE [dbo].[employee_eduscheduleT] ADD  CONSTRAINT [DF_employee_eduscheduleT_edu_from_time]  DEFAULT (getdate()) FOR [edu_from_time]
GO
ALTER TABLE [dbo].[employee_eduscheduleT] ADD  CONSTRAINT [DF_employee_eduscheduleT_edu_to_time]  DEFAULT (getdate()) FOR [edu_to_time]
GO
ALTER TABLE [dbo].[employee_eduscheduleT] ADD  CONSTRAINT [DF_employee_eduscheduleT_edu_flag]  DEFAULT ('') FOR [edu_flag]
GO
ALTER TABLE [dbo].[employee_eduscheduleT] ADD  CONSTRAINT [DF_employee_eduscheduleT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[employee_eduT] ADD  CONSTRAINT [DF_employee_eduT_eduschedule_idx]  DEFAULT ((0)) FOR [eduschedule_idx]
GO
ALTER TABLE [dbo].[employee_eduT] ADD  CONSTRAINT [DF_employee_eduT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[employee_eduT] ADD  CONSTRAINT [DF_employee_eduT_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[employee_eduT] ADD  CONSTRAINT [DF_employee_eduT_file_name]  DEFAULT ('') FOR [file_name]
GO
ALTER TABLE [dbo].[employee_eduT] ADD  CONSTRAINT [DF_employee_eduT_edu_complete_date]  DEFAULT ('') FOR [edu_complete_date]
GO
ALTER TABLE [dbo].[employee_eduT] ADD  CONSTRAINT [DF_employee_eduT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[franchise_authT] ADD  CONSTRAINT [DF_franchise_authT_auth_code]  DEFAULT ('') FOR [auth_code]
GO
ALTER TABLE [dbo].[franchise_authT] ADD  CONSTRAINT [DF_franchise_authT_auth_expire]  DEFAULT ('') FOR [auth_expire]
GO
ALTER TABLE [dbo].[franchise_authT] ADD  CONSTRAINT [DF_franchise_authT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_order_num]  DEFAULT ('') FOR [order_num]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_franchise_fee_ym]  DEFAULT ('') FOR [franchise_fee_ym]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_franchise_fee_state]  DEFAULT ('') FOR [franchise_fee_state]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_franchise_fee_method]  DEFAULT ('') FOR [franchise_fee_method]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_franchise_fee_money]  DEFAULT ((0)) FOR [franchise_fee_money]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_franchise_fee_date]  DEFAULT ('') FOR [franchise_fee_date]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_refund_request_reason]  DEFAULT ('') FOR [refund_request_reason]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_refund_request_amount]  DEFAULT ((0)) FOR [refund_request_amount]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_refund_money]  DEFAULT ((0)) FOR [refund_money]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_refund_date]  DEFAULT ('') FOR [refund_date]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[franchise_feeM] ADD  CONSTRAINT [DF_franchise_feeM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_franchise_type]  DEFAULT ('') FOR [franchise_type]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_center_name]  DEFAULT ('') FOR [center_name]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_center_eng_name]  DEFAULT ('') FOR [center_eng_name]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_owner_name]  DEFAULT ('') FOR [owner_name]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_owner_id]  DEFAULT ('') FOR [owner_id]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_useyn]  DEFAULT ('Y') FOR [useyn]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_address]  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_zipcode]  DEFAULT ('') FOR [zipcode]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_tel_num]  DEFAULT ('') FOR [tel_num]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_fax_num]  DEFAULT ('') FOR [fax_num]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_location]  DEFAULT ('') FOR [location]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_biz_reg_date]  DEFAULT ('') FOR [biz_reg_date]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_biz_no]  DEFAULT ('') FOR [biz_no]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_center_no]  DEFAULT ('') FOR [center_no]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_class_no]  DEFAULT ('') FOR [class_no]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_report_date]  DEFAULT ('') FOR [report_date]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_franchisee_start]  DEFAULT ('') FOR [franchisee_start]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_franchisee_end]  DEFAULT ('') FOR [franchisee_end]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_rams_fee]  DEFAULT ((0)) FOR [rams_fee]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_sales_confirm]  DEFAULT ('') FOR [sales_confirm]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_royalty]  DEFAULT ((0)) FOR [royalty]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_sms_fee]  DEFAULT ('') FOR [sms_fee]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_lms_fee]  DEFAULT ('') FOR [lms_fee]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_mms_fee]  DEFAULT ('') FOR [mms_fee]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_shop_id]  DEFAULT ('') FOR [shop_id]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_shop_key]  DEFAULT ('') FOR [shop_key]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_point]  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[franchiseM] ADD  CONSTRAINT [DF_franchiseM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_order_num]  DEFAULT ('') FOR [order_num]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_teacher_idx]  DEFAULT ((0)) FOR [teacher_idx]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_teacher_name]  DEFAULT ('') FOR [teacher_name]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_teacher_phone]  DEFAULT ('') FOR [teacher_phone]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_shipping_zipcode]  DEFAULT ('') FOR [shipping_zipcode]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_shipping_address]  DEFAULT ('') FOR [shipping_address]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_shipping_date]  DEFAULT ('') FOR [shipping_date]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_shipping_company]  DEFAULT ('') FOR [shipping_company]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_shipping_state]  DEFAULT ('') FOR [shipping_state]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_cancle_date]  DEFAULT ('') FOR [cancel_date]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_invoice_number]  DEFAULT ('') FOR [invoice_number]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_shipping_memo]  DEFAULT ('') FOR [shipping_memo]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[goods_shippingT] ADD  CONSTRAINT [DF_goods_shippingT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_goods_name]  DEFAULT ('') FOR [goods_name]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_goods_type]  DEFAULT ('') FOR [goods_type]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_order_unit]  DEFAULT ('') FOR [order_unit]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_cost_price]  DEFAULT ((0)) FOR [cost_price]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_sel_price]  DEFAULT ((0)) FOR [sel_price]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_min_quantity]  DEFAULT ((0)) FOR [min_quantity]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_img_link]  DEFAULT ('') FOR [img_link]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_memo]  DEFAULT ('') FOR [memo]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_useYn]  DEFAULT ('') FOR [useYn]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[goodsM] ADD  CONSTRAINT [DF_goodsM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[holidayT] ADD  CONSTRAINT [DF_holidayT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[holidayT] ADD  CONSTRAINT [DF_holidayT_reg_user_idx]  DEFAULT ((0)) FOR [reg_user_idx]
GO
ALTER TABLE [dbo].[holidayT] ADD  CONSTRAINT [DF_holidayT_del_user_idx]  DEFAULT ((0)) FOR [del_user_idx]
GO
ALTER TABLE [dbo].[holidayT] ADD  CONSTRAINT [DF_holidayT_holiday_date]  DEFAULT ('') FOR [holiday_date]
GO
ALTER TABLE [dbo].[holidayT] ADD  CONSTRAINT [DF_holidayT_memo]  DEFAULT ('') FOR [holiday_memo]
GO
ALTER TABLE [dbo].[holidayT] ADD  CONSTRAINT [DF_holidayT_useYn]  DEFAULT ('Y') FOR [useYn]
GO
ALTER TABLE [dbo].[holidayT] ADD  CONSTRAINT [DF_holidayT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[holidayT] ADD  CONSTRAINT [DF_holidayT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_user_name]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_order_num]  DEFAULT ('') FOR [order_num]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_order_money]  DEFAULT ((0)) FOR [order_money]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_order_method]  DEFAULT ('') FOR [order_method]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_order_state]  DEFAULT ('') FOR [order_state]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_order_date]  DEFAULT ('') FOR [order_date]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_pay_date]  DEFAULT ('') FOR [pay_date]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[invoice_pointM] ADD  CONSTRAINT [DF_invoice_pointM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_invoice_idx]  DEFAULT ((0)) FOR [invoice_idx]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_order_num]  DEFAULT ('') FOR [order_num]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_teacher_idx]  DEFAULT ((0)) FOR [teacher_idx]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_student_idx]  DEFAULT ((0)) FOR [student_idx]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_refund_ym]  DEFAULT ('') FOR [refund_ym]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_refund_amount]  DEFAULT ((0)) FOR [refund_amount]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_refund_state]  DEFAULT ('') FOR [refund_state]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_refund_date]  DEFAULT ('') FOR [refund_date]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_refund_etc]  DEFAULT ('') FOR [refund_etc]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[invoice_refundT] ADD  CONSTRAINT [DF_invoice_refundT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_teacher_idx]  DEFAULT ((0)) FOR [teacher_idx]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_student_idx]  DEFAULT ((0)) FOR [student_idx]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_order_num]  DEFAULT ('') FOR [order_num]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_receipt_idx]  DEFAULT ((0)) FOR [receipt_idx]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_receipt_name]  DEFAULT ('') FOR [receipt_name]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_order_quantity]  DEFAULT ((0)) FOR [order_quantity]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_order_money]  DEFAULT ((0)) FOR [order_money]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_order_method]  DEFAULT ('') FOR [order_method]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_order_state]  DEFAULT ('') FOR [order_state]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_order_date]  DEFAULT ('') FOR [order_date]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_order_ym]  DEFAULT ('') FOR [order_ym]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_pay_date]  DEFAULT ('') FOR [pay_date]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_pay_memo]  DEFAULT ('') FOR [pay_memo]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_refund_date]  DEFAULT ('') FOR [refund_date]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_refund_method]  DEFAULT ('') FOR [refund_method]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_refund_money]  DEFAULT ((0)) FOR [refund_money]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[invoiceM] ADD  CONSTRAINT [DF_invoiceM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[ip_countryT] ADD  CONSTRAINT [DF_ip_countryT_start_ip]  DEFAULT ('') FOR [start_ip]
GO
ALTER TABLE [dbo].[ip_countryT] ADD  CONSTRAINT [DF_ip_countryT_end_ip]  DEFAULT ('') FOR [end_ip]
GO
ALTER TABLE [dbo].[ip_countryT] ADD  CONSTRAINT [DF_ip_countryT_country_code]  DEFAULT ('') FOR [country_code]
GO
ALTER TABLE [dbo].[lesson_attendT] ADD  CONSTRAINT [DF_lesson_attendT_class_idx]  DEFAULT ((0)) FOR [schedule_idx]
GO
ALTER TABLE [dbo].[lesson_attendT] ADD  CONSTRAINT [DF_lesson_attendT_student_idx]  DEFAULT ((0)) FOR [student_idx]
GO
ALTER TABLE [dbo].[lesson_attendT] ADD  CONSTRAINT [DF_lesson_attendT_attent_yn]  DEFAULT ('') FOR [attend_yn]
GO
ALTER TABLE [dbo].[lesson_attendT] ADD  CONSTRAINT [DF_lesson_attendT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[lesson_attendT] ADD  CONSTRAINT [DF_lesson_attendT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_student_no]  DEFAULT ((0)) FOR [student_no]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_writer_no]  DEFAULT ((0)) FOR [writer_no]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_eval_year]  DEFAULT ('') FOR [eval_year]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_eval_semiannual]  DEFAULT ('') FOR [eval_semiannual]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_eval_content]  DEFAULT ('') FOR [eval_content]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_read_score]  DEFAULT ('') FOR [read_score]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_read_content]  DEFAULT ('') FOR [read_content]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_debate_score]  DEFAULT ('') FOR [debate_score]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_debate_content]  DEFAULT ('') FOR [debate_content]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_write_score]  DEFAULT ('') FOR [write_score]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_write_content]  DEFAULT ('') FOR [write_content]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_lead_score]  DEFAULT ('') FOR [lead_score]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_lead_content]  DEFAULT ('') FOR [lead_content]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_guide_content]  DEFAULT ('') FOR [guide_content]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_next_guide_content]  DEFAULT ('') FOR [next_guide_content]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_parent_request]  DEFAULT ('') FOR [parent_request]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[lesson_evaluationT] ADD  CONSTRAINT [DF_lesson_evaluationT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_schedule_idx]  DEFAULT ('') FOR [schedule_idx]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_franchise_idx]  DEFAULT ('') FOR [franchise_idx]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_student_idx]  DEFAULT ('') FOR [student_idx]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_read]  DEFAULT ((0)) FOR [score_read]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_debate1]  DEFAULT ((0)) FOR [score_debate1]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_debate2]  DEFAULT ((0)) FOR [score_debate2]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_debate3]  DEFAULT ((0)) FOR [score_debate3]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_debate4]  DEFAULT ((0)) FOR [score_debate4]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_write1]  DEFAULT ((0)) FOR [score_write1]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_write2]  DEFAULT ((0)) FOR [score_write2]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_write3]  DEFAULT ((0)) FOR [score_write3]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_write4]  DEFAULT ((0)) FOR [score_write4]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_lead]  DEFAULT ((0)) FOR [score_lead]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_score_memo]  DEFAULT ('') FOR [score_memo]
GO
ALTER TABLE [dbo].[lesson_scoreT] ADD  CONSTRAINT [DF_lesson_scoreT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_Table_1_lesson_teacher]  DEFAULT ((0)) FOR [teacher_idx]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_lesson_book_idx]  DEFAULT ((0)) FOR [lesson_book_idx]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_lesson_type]  DEFAULT ('') FOR [lesson_type]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_lesson_date]  DEFAULT ('') FOR [lesson_date]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_lesson_fromtime]  DEFAULT ('') FOR [lesson_fromtime]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_lesson_totime]  DEFAULT ('') FOR [lesson_totime]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_lesson_room]  DEFAULT ('') FOR [lesson_room]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_lesson_grade]  DEFAULT ('') FOR [lesson_grade]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_onoff_yn]  DEFAULT ('') FOR [onoff_yn]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_Table_1_free_lesson]  DEFAULT ('') FOR [freehand_yn]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_supple_yn]  DEFAULT ('') FOR [supple_yn]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_supple_type]  DEFAULT ('') FOR [supple_type]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_receipt_idx]  DEFAULT ((0)) FOR [receipt_idx]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_over_idx]  DEFAULT ((0)) FOR [over_idx]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[lessonM] ADD  CONSTRAINT [DF_lessonM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[lessonT] ADD  CONSTRAINT [DF_lessonT_lesson_idx]  DEFAULT ((0)) FOR [schedule_idx]
GO
ALTER TABLE [dbo].[lessonT] ADD  CONSTRAINT [DF_lessonT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[lessonT] ADD  CONSTRAINT [DF_lessonT_student_idx]  DEFAULT ((0)) FOR [student_idx]
GO
ALTER TABLE [dbo].[lessonT] ADD  CONSTRAINT [DF_lessonT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[lessonT] ADD  CONSTRAINT [DF_lessonT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[magazine_produceT] ADD  CONSTRAINT [DF_magazine_produceT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[magazine_produceT] ADD  CONSTRAINT [DF_magazine_produceT_produce_year]  DEFAULT ('') FOR [produce_year]
GO
ALTER TABLE [dbo].[magazine_produceT] ADD  CONSTRAINT [DF_magazine_produceT_produce_season]  DEFAULT ('') FOR [produce_season]
GO
ALTER TABLE [dbo].[magazine_produceT] ADD  CONSTRAINT [DF_magazine_produceT_produce_file_type]  DEFAULT ('') FOR [produce_file_type]
GO
ALTER TABLE [dbo].[magazine_produceT] ADD  CONSTRAINT [DF_magazine_produceT_produce_origin_file_name]  DEFAULT ('') FOR [produce_origin_file_name]
GO
ALTER TABLE [dbo].[magazine_produceT] ADD  CONSTRAINT [DF_magazine_produceT_produce_file_name]  DEFAULT ('') FOR [produce_file_name]
GO
ALTER TABLE [dbo].[magazine_produceT] ADD  CONSTRAINT [DF_magazine_produceT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[magazineM] ADD  CONSTRAINT [DF_magazineM_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[magazineM] ADD  CONSTRAINT [DF_magazineM_magazine_year]  DEFAULT ('') FOR [magazine_year]
GO
ALTER TABLE [dbo].[magazineM] ADD  CONSTRAINT [DF_magazineM_season]  DEFAULT ('') FOR [season]
GO
ALTER TABLE [dbo].[magazineM] ADD  CONSTRAINT [DF_magazineM_thumbnail_name]  DEFAULT ('') FOR [thumbnail_name]
GO
ALTER TABLE [dbo].[magazineM] ADD  CONSTRAINT [DF_magazineM_pdf_link]  DEFAULT ('') FOR [pdf_link]
GO
ALTER TABLE [dbo].[magazineM] ADD  CONSTRAINT [DF_magazineM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[magazineM] ADD  CONSTRAINT [DF_magazineM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_user_id]  DEFAULT ('') FOR [user_id]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_password]  DEFAULT ('') FOR [password]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_state]  DEFAULT ('99') FOR [state]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_user_name]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_user_phone]  DEFAULT ('') FOR [user_phone]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_emergencyhp]  DEFAULT ('') FOR [emergencyhp]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_birth]  DEFAULT ('') FOR [birth]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_gender]  DEFAULT ('') FOR [gender]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_position]  DEFAULT ('') FOR [position]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_zipcode]  DEFAULT ('') FOR [zipcode]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_address]  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_hire_date]  DEFAULT ('') FOR [hire_date]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_resign_date]  DEFAULT ('') FOR [resign_date]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_school]  DEFAULT ('') FOR [school]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_graduation_months]  DEFAULT ('') FOR [graduation_months]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_major]  DEFAULT ('') FOR [major]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_degree_number]  DEFAULT ('') FOR [degree_number]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_career]  DEFAULT ('') FOR [career]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_career_year]  DEFAULT ('') FOR [career_year]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_certificate]  DEFAULT ('') FOR [certificate]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_bank_name]  DEFAULT ('') FOR [bank_name]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_account_number]  DEFAULT ('') FOR [account_number]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_menu_group]  DEFAULT ('') FOR [menu_group]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_is_admin]  DEFAULT ('N') FOR [is_admin]
GO
ALTER TABLE [dbo].[member_centerM] ADD  CONSTRAINT [DF_member_centerM_show_yn]  DEFAULT ('Y') FOR [show_yn]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_user_id]  DEFAULT ('') FOR [user_id]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_password]  DEFAULT ('') FOR [password]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_state]  DEFAULT ('99') FOR [state]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_user_name]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_user_phone]  DEFAULT ('') FOR [user_phone]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_emergencyhp]  DEFAULT ('') FOR [emergencyhp]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_birth]  DEFAULT ('') FOR [birth]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_gender]  DEFAULT ('') FOR [gender]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_position]  DEFAULT ('') FOR [position]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_zipcode]  DEFAULT ('') FOR [zipcode]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_address]  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_hire_date]  DEFAULT ('') FOR [hire_date]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_resign_date]  DEFAULT ('') FOR [resign_date]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_school]  DEFAULT ('') FOR [school]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_graduation_months]  DEFAULT ('') FOR [graduation_months]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_major]  DEFAULT ('') FOR [major]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_degree_number]  DEFAULT ('') FOR [degree_number]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_career]  DEFAULT ('') FOR [career]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_career_year]  DEFAULT ('') FOR [career_year]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_certificate]  DEFAULT ('') FOR [certificate]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_bank_name]  DEFAULT ('') FOR [bank_name]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_menu_group]  DEFAULT ('') FOR [menu_group]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_is_admin]  DEFAULT ('N') FOR [is_admin]
GO
ALTER TABLE [dbo].[member_employeeM] ADD  CONSTRAINT [DF_member_employeeM_show_yn]  DEFAULT ('Y') FOR [show_yn]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_usre_id]  DEFAULT ('') FOR [user_id]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_password]  DEFAULT ('') FOR [password]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_]  DEFAULT ('99') FOR [state]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_user_name]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_user_phone]  DEFAULT ('') FOR [user_phone]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_birth]  DEFAULT ('') FOR [birth]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_gender]  DEFAULT ('') FOR [gender]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_class_date]  DEFAULT ('') FOR [class_date]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_zipcode]  DEFAULT ('') FOR [zipcode]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_address]  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_teacher_no]  DEFAULT ((0)) FOR [teacher_no]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_color_tag]  DEFAULT ('') FOR [color_tag]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_user_memo]  DEFAULT ('') FOR [user_memo]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_dormant_code]  DEFAULT ('') FOR [dormant_code]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_dormant_text]  DEFAULT ('') FOR [dormant_text]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_logged_date]  DEFAULT (getdate()) FOR [logged_date]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[member_student_dormantT] ADD  CONSTRAINT [DF_member_student_dormantt_show_yn]  DEFAULT ('Y') FOR [show_yn]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outT_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_usre_id]  DEFAULT ('') FOR [user_id]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_password]  DEFAULT ('') FOR [password]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_state]  DEFAULT ('99') FOR [state]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_user_name]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_user_phone]  DEFAULT ('') FOR [user_phone]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_birth]  DEFAULT ('') FOR [birth]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_gender]  DEFAULT ('') FOR [gender]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_class_date]  DEFAULT ('') FOR [class_date]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_zipcode]  DEFAULT ('') FOR [zipcode]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_address]  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_teacher_no]  DEFAULT ((0)) FOR [teacher_no]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_color_tag]  DEFAULT ('') FOR [color_tag]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_user_memo]  DEFAULT ('') FOR [user_memo]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_dormant_code]  DEFAULT ('') FOR [dormant_code]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_dormant_text]  DEFAULT ('') FOR [dormant_text]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_logged_date]  DEFAULT (getdate()) FOR [logged_date]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[member_student_outT] ADD  CONSTRAINT [DF_member_student_outt_show_yn]  DEFAULT ('Y') FOR [show_yn]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_user_id]  DEFAULT ('') FOR [user_id]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_password]  DEFAULT ('') FOR [password]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_state]  DEFAULT ('99') FOR [state]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_user_name]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_user_phone]  DEFAULT ('') FOR [user_phone]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_birth]  DEFAULT ('') FOR [birth]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_gender]  DEFAULT ('') FOR [gender]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_school_name]  DEFAULT ('') FOR [school_name]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_zipcode]  DEFAULT ('') FOR [zipcode]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_address]  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_teacher_no]  DEFAULT ((0)) FOR [teacher_no]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_color_tag]  DEFAULT ('') FOR [color_tag]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_user_memo]  DEFAULT ('') FOR [user_memo]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_logged_date]  DEFAULT (getdate()) FOR [logged_date]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[member_studentM] ADD  CONSTRAINT [DF_member_studentM_show_yn]  DEFAULT ('Y') FOR [show_yn]
GO
ALTER TABLE [dbo].[menu_link] ADD  CONSTRAINT [DF_menu_link_type]  DEFAULT ('') FOR [type]
GO
ALTER TABLE [dbo].[menu_link] ADD  CONSTRAINT [DF_menu_link_menu_name]  DEFAULT ('') FOR [menu_name]
GO
ALTER TABLE [dbo].[menu_link] ADD  CONSTRAINT [DF_menu_link_link]  DEFAULT ('') FOR [link]
GO
ALTER TABLE [dbo].[menu_link] ADD  CONSTRAINT [DF_menu_link_useyn]  DEFAULT ('') FOR [useyn]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_center_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_from_no]  DEFAULT ('') FOR [from_no]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_from_name]  DEFAULT ('') FOR [to_name]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_to_no]  DEFAULT ('') FOR [to_no]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_msg_contents]  DEFAULT ('') FOR [msg_contents]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_file_nm]  DEFAULT ('') FOR [file_nm]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_file_path1]  DEFAULT ('') FOR [file_path1]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_file_path11]  DEFAULT ('') FOR [file_path2]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_msgType]  DEFAULT ('') FOR [msgType]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_msg_state]  DEFAULT ('') FOR [msg_state]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_rev_datetime]  DEFAULT ('') FOR [rev_datetime]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_send_date]  DEFAULT ('') FOR [send_date]
GO
ALTER TABLE [dbo].[messageT] ADD  CONSTRAINT [DF_messageT_syncYn]  DEFAULT ('') FOR [syncYn]
GO
ALTER TABLE [dbo].[meta_tagM] ADD  CONSTRAINT [DF_meta_tagM_og_title]  DEFAULT ('') FOR [og_title]
GO
ALTER TABLE [dbo].[meta_tagM] ADD  CONSTRAINT [DF_meta_tagM_og_image]  DEFAULT ('/img/mainlogo.jpg') FOR [og_image]
GO
ALTER TABLE [dbo].[meta_tagM] ADD  CONSTRAINT [DF_meta_tagM_og_url]  DEFAULT ('') FOR [og_url]
GO
ALTER TABLE [dbo].[msg_groupM] ADD  CONSTRAINT [DF_msg_groupM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[msg_groupM] ADD  CONSTRAINT [DF_msg_groupM_user_idx]  DEFAULT ((0)) FOR [user_idx]
GO
ALTER TABLE [dbo].[msg_groupM] ADD  CONSTRAINT [DF_msg_groupM_group_name]  DEFAULT ('') FOR [group_name]
GO
ALTER TABLE [dbo].[msg_groupM] ADD  CONSTRAINT [DF_msg_groupM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[msg_groupT] ADD  CONSTRAINT [DF_msg_groupT_group_idx]  DEFAULT ((0)) FOR [group_idx]
GO
ALTER TABLE [dbo].[msg_groupT] ADD  CONSTRAINT [DF_msg_groupT_group_user_name]  DEFAULT ('') FOR [group_user_name]
GO
ALTER TABLE [dbo].[msg_groupT] ADD  CONSTRAINT [DF_msg_groupT_group_user_hp]  DEFAULT ('') FOR [group_user_hp]
GO
ALTER TABLE [dbo].[msg_groupT] ADD  CONSTRAINT [DF_msg_groupT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_newpaper_title]  DEFAULT ('') FOR [newspaper_title]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_news_code]  DEFAULT ('') FOR [news_code]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_column_code]  DEFAULT ('') FOR [column_code]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_news_date]  DEFAULT ('') FOR [news_date]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_column_file]  DEFAULT ('') FOR [column_file]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_column_origin]  DEFAULT ('') FOR [column_origin]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_teaching_file]  DEFAULT ('') FOR [teaching_file]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_teaching_origin]  DEFAULT ('') FOR [teaching_origin]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[newspaper_columnT] ADD  CONSTRAINT [DF_newspaper_columnT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_order_num]  DEFAULT ('') FOR [order_num]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_teacher_idx]  DEFAULT ((0)) FOR [teacher_idx]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_teacher_name]  DEFAULT ('') FOR [teacher_name]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_goods_idx]  DEFAULT ((0)) FOR [goods_idx]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_goods_name]  DEFAULT ('') FOR [goods_name]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_order_quantity]  DEFAULT ((0)) FOR [order_quantity]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_order_money]  DEFAULT ((0)) FOR [order_money]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_order_method]  DEFAULT ('') FOR [order_method]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_order_state]  DEFAULT ('') FOR [order_state]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_order_date]  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_pay_date]  DEFAULT ('') FOR [pay_date]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_refund_date]  DEFAULT ('') FOR [refund_date]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_refund_method]  DEFAULT ('') FOR [refund_method]
GO
ALTER TABLE [dbo].[order_goodsT] ADD  CONSTRAINT [DF_order_goodsT_refund_money]  DEFAULT ((0)) FOR [refund_money]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_paymentKey]  DEFAULT ('') FOR [paymentKey]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_orderId]  DEFAULT ('') FOR [orderId]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_status]  DEFAULT ('') FOR [status]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_orderName]  DEFAULT ('') FOR [orderName]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_requestedAt]  DEFAULT ('') FOR [requestedAt]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_approvedAt]  DEFAULT ('') FOR [approvedAt]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_totalAmount]  DEFAULT ((0)) FOR [totalAmount]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_vat]  DEFAULT ((0)) FOR [vat]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_taxFreeAmount]  DEFAULT ((0)) FOR [taxFreeAmount]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_method]  DEFAULT ('') FOR [method]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_cancels_cancelReason]  DEFAULT ('') FOR [cancels_cancelReason]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_cancels_cancelAmount]  DEFAULT ((0)) FOR [cancels_cancelAmount]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_cancels_taxFreeAmount]  DEFAULT ((0)) FOR [cancels_taxFreeAmount]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_cancels_taxExemptionAmount]  DEFAULT ((0)) FOR [cancels_refundableAmount]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_cancels_transactionKey]  DEFAULT ('') FOR [cancels_lastTransactionKey]
GO
ALTER TABLE [dbo].[payment_logT] ADD  CONSTRAINT [DF_payment_logT_cancels_canceledAt]  DEFAULT ('') FOR [cancels_canceledAt]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_receipt_type]  DEFAULT ('') FOR [receipt_type]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_receipt_lesson_type]  DEFAULT ('') FOR [receipt_lesson_type]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_receipt_grade]  DEFAULT ('') FOR [receipt_grade]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_receipt_name]  DEFAULT ('') FOR [receipt_name]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_receipt_amount]  DEFAULT ((0)) FOR [receipt_amount]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_headYn]  DEFAULT ('') FOR [headYn]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_Table_1_delYn]  DEFAULT ('Y') FOR [useYn]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[receiptT] ADD  CONSTRAINT [DF_receiptT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title1]  DEFAULT ('') FOR [title1]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title2]  DEFAULT ('') FOR [title2]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title3]  DEFAULT ('') FOR [title3]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title4]  DEFAULT ('') FOR [title4]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title5]  DEFAULT ('') FOR [title5]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title6]  DEFAULT ('') FOR [title6]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title7]  DEFAULT ('') FOR [title7]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title8]  DEFAULT ('') FOR [title8]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title9]  DEFAULT ('') FOR [title9]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_title10]  DEFAULT ('') FOR [title10]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[report_settingM] ADD  CONSTRAINT [DF_report_settingM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title1]  DEFAULT ('') FOR [title1]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title2]  DEFAULT ('') FOR [title2]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title3]  DEFAULT ('') FOR [title3]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title4]  DEFAULT ('') FOR [title4]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title5]  DEFAULT ('') FOR [title5]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title6]  DEFAULT ('') FOR [title6]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title7]  DEFAULT ('') FOR [title7]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title8]  DEFAULT ('') FOR [title8]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title9]  DEFAULT ('') FOR [title9]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_title10]  DEFAULT ('') FOR [title10]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content1]  DEFAULT ('') FOR [content1]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content2]  DEFAULT ('') FOR [content2]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content3]  DEFAULT ('') FOR [content3]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content4]  DEFAULT ('') FOR [content4]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content5]  DEFAULT ('') FOR [content5]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content6]  DEFAULT ('') FOR [content6]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content7]  DEFAULT ('') FOR [content7]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content8]  DEFAULT ('') FOR [content8]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content9]  DEFAULT ('') FOR [content9]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_content10]  DEFAULT ('') FOR [content10]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_months]  DEFAULT ('') FOR [months]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[reportT] ADD  CONSTRAINT [DF_reportT_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[save_msgT] ADD  CONSTRAINT [DF_save_msgT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[save_msgT] ADD  CONSTRAINT [DF_save_msgT_user_idx]  DEFAULT ((0)) FOR [user_idx]
GO
ALTER TABLE [dbo].[save_msgT] ADD  CONSTRAINT [DF_save_msgT_msg_title]  DEFAULT ('') FOR [msg_title]
GO
ALTER TABLE [dbo].[save_msgT] ADD  CONSTRAINT [DF_save_msgT_msg_contents]  DEFAULT ('') FOR [msg_contents]
GO
ALTER TABLE [dbo].[save_msgT] ADD  CONSTRAINT [DF_save_msgT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_school_type]  DEFAULT ('') FOR [school_type]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_school_name]  DEFAULT ('') FOR [school_name]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_manager_name]  DEFAULT ('') FOR [manager_name]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_manager_email]  DEFAULT ('') FOR [manager_email]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_manager_password]  DEFAULT ('') FOR [manager_password]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_manager_hp]  DEFAULT ('') FOR [manager_hp]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_start_date]  DEFAULT ('') FOR [start_date]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_expired_date]  DEFAULT ('') FOR [expire_date]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_access_token]  DEFAULT ('') FOR [access_token]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_paymentKey]  DEFAULT ('') FOR [order_num]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_order_state]  DEFAULT ('') FOR [order_state]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_order_method]  DEFAULT ('') FOR [order_method]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_order_money]  DEFAULT ((0)) FOR [order_money]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_school_state]  DEFAULT ((0)) FOR [contract_no]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[school_infoM] ADD  CONSTRAINT [DF_school_infoM_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_school_idx]  DEFAULT ((0)) FOR [school_idx]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_std_gender]  DEFAULT ('') FOR [std_gender]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_std_grade]  DEFAULT ('') FOR [std_grade]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_std_class]  DEFAULT ('') FOR [std_class]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_std_no]  DEFAULT ('') FOR [std_no]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_std_answer]  DEFAULT ('') FOR [std_answer]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_scorea_1]  DEFAULT ((0)) FOR [score_a_1]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_a_2]  DEFAULT ((0)) FOR [score_a_2]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_b_1]  DEFAULT ((0)) FOR [score_b_1]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_b_2]  DEFAULT ((0)) FOR [score_b_2]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_b_3]  DEFAULT ((0)) FOR [score_b_3]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_c]  DEFAULT ((0)) FOR [score_c]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_d]  DEFAULT ((0)) FOR [score_d]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_a_1_sum]  DEFAULT ((0)) FOR [score_a_1_sum]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_a_2_sum]  DEFAULT ((0)) FOR [score_a_2_sum]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_b_1_sum]  DEFAULT ((0)) FOR [score_b_1_sum]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_b_2_sum]  DEFAULT ((0)) FOR [score_b_2_sum]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_b_3_sum]  DEFAULT ((0)) FOR [score_b_3_sum]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_c_sum]  DEFAULT ((0)) FOR [score_c_sum]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_d_sum]  DEFAULT ((0)) FOR [score_d_sum]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_literaray]  DEFAULT ((0)) FOR [score_pliterary]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_literaray1]  DEFAULT ((0)) FOR [score_literary]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_nliterary]  DEFAULT ((0)) FOR [score_nliterary]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_score_nliterary1]  DEFAULT ((0)) FOR [score_pnliterary]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_rq_rate]  DEFAULT ((0)) FOR [rq_rate]
GO
ALTER TABLE [dbo].[school_rd_infoT] ADD  CONSTRAINT [DF_school_rd_infoT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[sql_log] ADD  CONSTRAINT [DF_sql_log_error_log]  DEFAULT ('') FOR [error_log]
GO
ALTER TABLE [dbo].[sql_log] ADD  CONSTRAINT [DF_sql_log_error_query]  DEFAULT ('') FOR [error_query]
GO
ALTER TABLE [dbo].[sql_log] ADD  CONSTRAINT [DF_sql_log_error_location]  DEFAULT ('') FOR [error_location]
GO
ALTER TABLE [dbo].[sql_log] ADD  CONSTRAINT [DF_sql_log_error_address]  DEFAULT ('') FOR [error_address]
GO
ALTER TABLE [dbo].[sql_log] ADD  CONSTRAINT [DF_sql_log_log_date]  DEFAULT (getdate()) FOR [log_date]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_franchise_idx]  DEFAULT ((0)) FOR [franchise_idx]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_user_no]  DEFAULT ((0)) FOR [user_no]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub1]  DEFAULT ('') FOR [teval_sub1]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_score1]  DEFAULT ('') FOR [teval_score1]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub2]  DEFAULT ('') FOR [teval_sub2]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score12]  DEFAULT ('') FOR [teval_score2]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub3]  DEFAULT ('') FOR [teval_sub3]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score13]  DEFAULT ('') FOR [teval_score3]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub4]  DEFAULT ('') FOR [teval_sub4]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score14]  DEFAULT ('') FOR [teval_score4]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub5]  DEFAULT ('') FOR [teval_sub5]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score15]  DEFAULT ('') FOR [teval_score5]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub6]  DEFAULT ('') FOR [teval_sub6]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score16]  DEFAULT ('') FOR [teval_score6]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub7]  DEFAULT ('') FOR [teval_sub7]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score17]  DEFAULT ('') FOR [teval_score7]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub8]  DEFAULT ('') FOR [teval_sub8]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score18]  DEFAULT ('') FOR [teval_score8]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub9]  DEFAULT ('') FOR [teval_sub9]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score19]  DEFAULT ('') FOR [teval_score9]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_teval_sub10]  DEFAULT ('') FOR [teval_sub10]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_Table_1_teval_score110]  DEFAULT ('') FOR [teval_score10]
GO
ALTER TABLE [dbo].[teacher_evaluationT] ADD  CONSTRAINT [DF_teacher_evaluationT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
ALTER TABLE [dbo].[weekT] ADD  CONSTRAINT [DF_weekT_weekYear]  DEFAULT ('') FOR [weekYear]
GO
ALTER TABLE [dbo].[weekT] ADD  CONSTRAINT [DF_weekT_weekMonth]  DEFAULT ('') FOR [weekMonth]
GO
ALTER TABLE [dbo].[weekT] ADD  CONSTRAINT [DF_weekT_weekCount]  DEFAULT ('') FOR [weekCount]
GO
ALTER TABLE [dbo].[weekT] ADD  CONSTRAINT [DF_weekT_weekStartDate]  DEFAULT ('') FOR [weekStartDate]
GO
ALTER TABLE [dbo].[weekT] ADD  CONSTRAINT [DF_weekT_weekEndDate]  DEFAULT ('') FOR [weekEndDate]
GO
ALTER TABLE [dbo].[weekT] ADD  CONSTRAINT [DF_weekT_weekDetail]  DEFAULT ('') FOR [weekDetail]
GO
ALTER TABLE [dbo].[weekT] ADD  CONSTRAINT [DF_weekT_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO
/****** Object:  StoredProcedure [dbo].[sp_book_category_statistic]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 본사 도서관리 카테고리별 도서 권수 집계
CREATE PROCEDURE [dbo].[sp_book_category_statistic] (@_student_no int, @_franchise_idx int)
AS
BEGIN
	SELECT DISTINCT
	-- 문학 인문
    (SELECT COUNT(distinct r0.book_idx) FROM book_rentT r0
	LEFT OUTER JOIN bookM b0 ON r0.book_idx = b0.book_idx
	WHERE r0.student_no = @_student_no AND r0.readYn = '1' AND r0.franchise_idx = @_franchise_idx AND b0.book_category1 = '81') AS cnt_user_c0,

	-- 남자 문학 권수
	(SELECT COUNT(r1.book_idx) FROM book_rentT r1
	LEFT OUTER JOIN member_studentM m1 ON r1.student_no = m1.user_no
	LEFT OUTER JOIN bookM b1 ON r1.book_idx = b1.book_idx
	WHERE r1.readYn = '1' AND m1.gender = 'M' AND m1.state <> '99' AND b1.book_category1 = '81') AS cnt_c0m,
    
	-- 여자 문학 권수
	(SELECT COUNT(r2.book_idx) FROM book_rentT r2
	LEFT OUTER JOIN member_studentM m2 ON r2.student_no = m2.user_no
	LEFT OUTER JOIN bookM b2 ON r2.book_idx = b2.book_idx
	WHERE r2.readYn = '1' AND m2.gender = 'F' AND m2.state <> '99' AND b2.book_category1 = '81') AS cnt_c0f,
    -- 비문학 인문
    (SELECT COUNT(distinct r3.book_idx) FROM book_rentT r3
	LEFT OUTER JOIN bookM b3 ON r3.book_idx = b3.book_idx
	WHERE r3.student_no = @_student_no AND r3.readYn = '1' AND r3.franchise_idx = @_franchise_idx AND b3.book_category1 = '82') AS cnt_user_c1,

	-- 남자 인문 권수
	(SELECT COUNT(r4.book_idx) FROM book_rentT r4
	LEFT OUTER JOIN member_studentM m4 ON r4.student_no = m4.user_no
	LEFT OUTER JOIN bookM b4 ON r4.book_idx = b4.book_idx
	WHERE r4.readYn = '1' AND m4.gender = 'M' AND m4.state <> '99' AND b4.book_category1 = '82') AS cnt_c1m,
    
	-- 여자 인문 권수
	(SELECT COUNT(r5.book_idx) FROM book_rentT r5
	LEFT OUTER JOIN member_studentM m5 ON r5.student_no = m5.user_no
	LEFT OUTER JOIN bookM b5 ON r5.book_idx = b5.book_idx
	WHERE r5.readYn = '1' AND m5.gender = 'F' AND m5.state <> '99' AND b5.book_category1 = '82') AS cnt_c1f,
    
    -- 비문학 사회
    (SELECT COUNT(distinct r6.book_idx) FROM book_rentT r6
	LEFT OUTER JOIN bookM b6 ON r6.book_idx = b6.book_idx
	WHERE r6.student_no = @_student_no AND r6.readYn = '1' AND r6.franchise_idx = @_franchise_idx AND b6.book_category1 = '83') AS cnt_user_c2,

	-- 남자 사회 권수
	(SELECT COUNT(r7.book_idx) FROM book_rentT r7
	LEFT OUTER JOIN member_studentM m7 ON r7.student_no = m7.user_no
	LEFT OUTER JOIN bookM b7 ON r7.book_idx = b7.book_idx
	WHERE r7.readYn = '1' AND m7.gender = 'M' AND m7.state <> '99' AND b7.book_category1 = '83') AS cnt_c2m,
    
	-- 여자 사회 권수
	(SELECT COUNT(r8.book_idx) FROM book_rentT r8
	LEFT OUTER JOIN member_studentM m8 ON r8.student_no = m8.user_no
	LEFT OUTER JOIN bookM b8 ON r8.book_idx = b8.book_idx
	WHERE r8.readYn = '1' AND m8.gender = 'F' AND m8.state <> '99' AND b8.book_category1 = '83') AS cnt_c2f,
    
    -- 비문학 과학
    (SELECT COUNT(distinct r9.book_idx) FROM book_rentT r9
	LEFT OUTER JOIN bookM b9 ON r9.book_idx = b9.book_idx
	WHERE r9.student_no = @_student_no AND r9.readYn = '1' AND r9.franchise_idx = @_franchise_idx AND b9.book_category1 = '84') AS cnt_user_c3,

	-- 남자 과학 권수
	(SELECT COUNT(r10.book_idx) FROM book_rentT r10
	LEFT OUTER JOIN member_studentM m10 ON r10.student_no = m10.user_no
	LEFT OUTER JOIN bookM b10 ON r10.book_idx = b10.book_idx
	WHERE r10.readYn = '1' AND m10.gender = 'M' AND m10.state <> '99' AND b10.book_category1 = '84') AS cnt_c3m,
    
	-- 여자 과학 권수
	(SELECT COUNT(r11.book_idx) FROM book_rentT r11
	LEFT OUTER JOIN member_studentM m11 ON r11.student_no = m11.user_no
	LEFT OUTER JOIN bookM b11 ON r11.book_idx = b11.book_idx
	WHERE r11.readYn = '1' AND m11.gender = 'F' AND m11.state <> '99' AND b11.book_category1 = '84') AS cnt_c3f,

	-- 비문학 체육예술
    (SELECT COUNT(distinct r12.book_idx) FROM book_rentT r12
	LEFT OUTER JOIN bookM b12 ON r12.book_idx = b12.book_idx
	WHERE r12.student_no = @_student_no AND r12.readYn = '1' AND r12.franchise_idx = @_franchise_idx AND b12.book_category1 = '85') AS cnt_user_c4,
    
	-- 남자 체육예술 권수
	(SELECT COUNT(r13.book_idx) FROM book_rentT r13
	LEFT OUTER JOIN member_studentM m13 ON r13.student_no = m13.user_no
	LEFT OUTER JOIN bookM b13 ON r13.book_idx = b13.book_idx
	WHERE r13.readYn = '1' AND m13.gender = 'M' AND m13.state <> '99' AND b13.book_category1 = '85') AS cnt_c4m,
    
	-- 여자 체육예술 권수
	(SELECT COUNT(r14.book_idx) FROM book_rentT r14
	LEFT OUTER JOIN member_studentM m14 ON r14.student_no = m14.user_no
	LEFT OUTER JOIN bookM b14 ON r14.book_idx = b14.book_idx
	WHERE r14.readYn = '1' AND m14.gender = 'F' AND m14.state <> '99' AND b14.book_category1 = '85') AS cnt_c4f,

	-- 비문학 진로
    (SELECT COUNT(distinct r15.book_idx) FROM book_rentT r15
	LEFT OUTER JOIN bookM b15 ON r15.book_idx = b15.book_idx
	WHERE r15.student_no = @_student_no AND r15.readYn = '1' AND r15.franchise_idx = @_franchise_idx AND b15.book_category1 = '86') AS cnt_user_c5,

	-- 남자 진로 권수
	(SELECT COUNT(r16.book_idx) FROM book_rentT r16
	LEFT OUTER JOIN member_studentM m16 ON r16.student_no = m16.user_no
	LEFT OUTER JOIN bookM b16 ON r16.book_idx = b16.book_idx
	WHERE r16.readYn = '1' AND m16.gender = 'M' AND m16.state <> '99' AND b16.book_category1 = '86') AS cnt_c5m,
    
	-- 여자 진로 권수
	(SELECT COUNT(r17.book_idx) FROM book_rentT r17
	LEFT OUTER JOIN member_studentM m17 ON r17.student_no = m17.user_no
	LEFT OUTER JOIN bookM b17 ON r17.book_idx = b17.book_idx
	WHERE r17.readYn = '1' AND m17.gender = 'F' AND m17.state <> '99' AND b17.book_category1 = '86') AS cnt_c5f,

	-- 기타
    (SELECT COUNT(distinct r18.book_idx) FROM book_rentT r18
	LEFT OUTER JOIN bookM b18 ON r18.book_idx = b18.book_idx
	WHERE r18.student_no = @_student_no AND r18.readYn = '1' AND r18.franchise_idx = @_franchise_idx AND b18.book_category1 = '89') AS cnt_user_c6,

	-- 남자 진로 권수
	(SELECT COUNT(r19.book_idx) FROM book_rentT r19
	LEFT OUTER JOIN member_studentM m19 ON r19.student_no = m19.user_no
	LEFT OUTER JOIN bookM b19 ON r19.book_idx = b19.book_idx
	WHERE r19.readYn = '1' AND m19.gender = 'M' AND m19.state <> '99' AND b19.book_category1 = '89') AS cnt_c6m,
    
	-- 여자 진로 권수
	(SELECT COUNT(r20.book_idx) FROM book_rentT r20
	LEFT OUTER JOIN member_studentM m20 ON r20.student_no = m20.user_no
	LEFT OUTER JOIN bookM b20 ON r20.book_idx = b20.book_idx
	WHERE r20.readYn = '1' AND m20.gender = 'F' AND m20.state <> '99' AND b20.book_category1 = '89') AS cnt_c6f

	FROM book_rentT br
	--WHERE br.student_no = @_student_no
    group by br.student_no
END
GO
/****** Object:  StoredProcedure [dbo].[sp_literary_statistic]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 학생 읽은 책 분석 문학 비문학 권수 집계
CREATE PROCEDURE [dbo].[sp_literary_statistic] (@_student_no int, @_franchise_idx int)
AS
BEGIN
	SELECT DISTINCT
	-- 문학 권수
	(SELECT ISNULL(COUNT(distinct book_rentT.book_idx), 0) FROM book_rentt
	LEFT OUTER JOIN bookm b ON book_rentt.book_idx = b.book_idx
	WHERE book_rentt.student_no = @_student_no AND book_rentt.readYn = '1' AND book_rentt.franchise_idx = @_franchise_idx AND b.book_category1 = '81') cnt_user_l, 
	-- 남자 문학 권수
	(SELECT ISNULL(COUNT(book_rentT.book_idx), 0) FROM book_rentt 
	LEFT OUTER JOIN member_studentm ON book_rentt.student_no = member_studentM.user_no 
	LEFT OUTER JOIN bookm ON book_rentt.book_idx = bookm.book_idx
	WHERE book_rentt.readYn = '1' AND member_studentM.gender = 'M' AND member_studentM.state <> '99' AND bookm.book_category1 = '81') cnt_lm, 
	-- 여자 문학 권수
	(SELECT ISNULL(COUNT(book_rentT.book_idx), 0) FROM book_rentt 
	LEFT OUTER JOIN member_studentm ON book_rentT.student_no = member_studentM.user_no 
	LEFT OUTER JOIN bookm ON book_rentT.book_idx = bookm.book_idx
	WHERE book_rentT.readYn = '1' AND member_studentM.gender = 'F' AND member_studentM.state <> '99' AND bookm.book_category1 = '81') cnt_lf, 
	-- 문학 합계
	(SELECT 
	(SELECT ISNULL(COUNT(book_rentT.book_idx), 0) FROM book_rentt 
	LEFT OUTER JOIN member_studentm ON book_rentT.student_no = member_studentM.user_no 
	LEFT OUTER JOIN bookm ON book_rentT.book_idx = bookm.book_idx
	WHERE book_rentT.readYn = '1' AND member_studentM.gender = 'M' AND member_studentM.state <> '99' AND bookm.book_category1 = '81') + 
	(SELECT ISNULL(COUNT(book_rentT.book_idx), 0) FROM book_rentt 
	LEFT OUTER JOIN member_studentm ON book_rentT.student_no = member_studentM.user_no 
	LEFT OUTER JOIN bookm ON book_rentT.book_idx = bookm.book_idx
	WHERE book_rentT.readYn = '1' AND member_studentM.gender = 'F' AND member_studentM.state <> '99' AND bookm.book_category1 = '81')) total_l,

	-- 비문학 권수
	(SELECT ISNULL(COUNT(distinct book_rentT.book_idx), 0) FROM book_rentt
	LEFT OUTER JOIN bookm b ON book_rentt.book_idx = b.book_idx
	WHERE book_rentt.student_no = @_student_no AND book_rentt.readYn = '1' AND book_rentt.franchise_idx = @_franchise_idx  AND b.book_category1 <> '81') cnt_user_nl, 
	-- 남자 비문학 권수
	(SELECT ISNULL(COUNT(book_rentT.book_idx), 0) FROM book_rentt
	LEFT OUTER JOIN member_studentm ON book_rentt.student_no = member_studentM.user_no 
	LEFT OUTER JOIN bookm ON book_rentt.book_idx = bookm.book_idx
	WHERE book_rentt.readYn = '1' AND member_studentM.gender = 'M' AND member_studentM.state <> '99' AND bookm.book_category1 <> '81') cnt_nlm, 
	-- 여자 문학 권수
	(SELECT ISNULL(COUNT(book_rentT.book_idx), 0) FROM book_rentt 
	LEFT OUTER JOIN member_studentm ON book_rentT.student_no = member_studentM.user_no 
	LEFT OUTER JOIN bookm ON book_rentT.book_idx = bookm.book_idx
	WHERE book_rentT.readYn = '1' AND member_studentM.gender = 'F' AND member_studentM.state <> '99' AND bookm.book_category1 <> '81') cnt_nlf, 
	-- 비문학 합계
	(SELECT (SELECT ISNULL(COUNT(book_rentT.book_idx), 0) FROM book_rentt 
	LEFT OUTER JOIN member_studentm ON book_rentT.student_no = member_studentM.user_no 
	LEFT OUTER JOIN bookm ON book_rentT.book_idx = bookm.book_idx
	WHERE book_rentT.readYn = '1' AND member_studentM.gender = 'M' AND member_studentM.state <> '99' AND bookm.book_category1 <> '81') + 
	(SELECT ISNULL(COUNT(book_rentT.book_idx), 0) FROM book_rentt 
	LEFT OUTER JOIN member_studentm ON book_rentT.student_no = member_studentM.user_no 
	LEFT OUTER JOIN bookm ON book_rentT.book_idx = bookm.book_idx
	WHERE book_rentT.readYn = '1' AND member_studentM.gender = 'F' AND member_studentM.state <> '99' AND bookm.book_category1 <> '81')) total_nl
	FROM book_rentt br
	--WHERE student_no = @_student_no
    group by student_no
END
GO
/****** Object:  StoredProcedure [dbo].[sp_msg_group_share]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 센터 문자 메시지 그룹 공유 INSERT
CREATE PROCEDURE [dbo].[sp_msg_group_share]
(
	@_franchise_idx int,
	@_user_idx int,
	@_target_user_idx int,
	@_target_group_idx int
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @_inserted_idx int
    INSERT INTO msg_groupM (franchise_idx, user_idx, group_name)
    SELECT franchise_idx, @_target_user_idx, group_name FROM msg_groupM 
	WHERE group_idx = @_target_group_idx AND franchise_idx = @_franchise_idx AND user_idx = @_user_idx

	SET @_inserted_idx = (SELECT @@IDENTITY)
	IF @_inserted_idx > 0
	BEGIN
		INSERT INTO msg_groupT (group_idx, group_user_name, group_user_hp)
		SELECT @_inserted_idx, group_user_name, group_user_hp FROM msg_groupT WHERE group_idx = @_target_group_idx
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_schedule_holdover]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 센터 수업, 수강 학생정보 이월
CREATE PROCEDURE [dbo].[sp_schedule_holdover](
	@_franchise_idx int, 
	@_from_date varchar(10), 
	@_to_date varchar(10),
	@_weekcnt int
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO lessonM (franchise_idx, teacher_idx, lesson_type, lesson_date, lesson_fromtime, lesson_totime, lesson_room, lesson_grade, over_idx)
	(SELECT 
	franchise_idx,
	teacher_idx, 
	lesson_type, 
	FORMAT(DATEADD(day, @_weekcnt, lesson_date), 'yyyy-MM-dd') lesson_date, 
	lesson_fromtime, 
	lesson_totime, 
	lesson_room, 
	lesson_grade,
	schedule_idx
	FROM lessonM
	WHERE franchise_idx = @_franchise_idx AND lesson_date BETWEEN @_from_date AND @_to_date AND lesson_type IN ('01','04','05')
	AND FORMAT(DATEADD(day, @_weekcnt, lesson_date), 'yyyy-MM-dd') NOT IN (SELECT H.holiday_date FROM holidayT H WHERE H.franchise_idx = @_franchise_idx AND H.useYn = 'Y'))
	

	INSERT INTO lessonT (schedule_idx, franchise_idx, student_idx)
	SELECT ms.schedule_idx, tt.franchise_idx, tt.student_idx FROM lessonT tt
	LEFT OUTER JOIN lessonM ms ON tt.schedule_idx = ms.over_idx AND 
	ms.lesson_date BETWEEN FORMAT(DATEADD(day, @_weekcnt, @_from_date), 'yyyy-MM-dd') AND FORMAT(DATEADD(day, @_weekcnt, @_to_date), 'yyyy-MM-dd') AND ms.lesson_type IN ('01','04','05')
	LEFT OUTER JOIN member_studentM sm ON sm.user_no = tt.student_idx AND sm.franchise_idx = tt.franchise_idx 
	WHERE tt.franchise_idx = @_franchise_idx AND ms.over_idx <> '0' AND sm.state = '00'
	AND FORMAT(DATEADD(day, @_weekcnt, ms.lesson_date), 'yyyy-MM-dd') NOT IN (SELECT H2.holiday_date FROM holidayT H2 WHERE H2.franchise_idx = @_franchise_idx AND H2.useYn = 'Y')
END
GO
/****** Object:  StoredProcedure [dbo].[sp_schedule_holdover_week]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 센터 수업, 수강 학생정보 이월
CREATE PROCEDURE [dbo].[sp_schedule_holdover_week](
	@_franchise_idx int, 
	@_from_date1 varchar(10), 
	@_to_date1 varchar(10),
	@_from_date2 varchar(10), 
	@_to_date2 varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @num int, @num2 int, @idx int
	SET @num = 0
	SET @num2 = 6
	BEGIN
		DELETE FROM lessonT WHERE schedule_idx IN (SELECT schedule_idx FROM lessonM WHERE franchise_idx = @_franchise_idx AND lesson_date between @_from_date2 AND @_to_date2)
		DELETE FROM lessonM WHERE franchise_idx = @_franchise_idx AND lesson_date between @_from_date2 AND @_to_date2
	END
	
	WHILE @num <= @num2
	BEGIN
		IF ((SELECT FORMAT(DATEADD(D, @num, @_from_date2), 'yyyy-MM-dd')) <> 
		(SELECT H.holiday_date FROM holidayT H WHERE  H.franchise_idx = @_franchise_idx
		AND H.holiday_date = FORMAT(DATEADD(D, @num, @_from_date2), 'yyyy-MM-dd') AND H.useYn = 'Y'))
			BEGIN
				BEGIN
					INSERT INTO lessonM (franchise_idx, teacher_idx, lesson_type, lesson_date, lesson_fromtime, lesson_totime
					, lesson_room, lesson_grade, over_idx)
					(SELECT 
					franchise_idx,
					teacher_idx, 
					lesson_type, 
					FORMAT(DATEADD(D, @num, @_from_date2), 'yyyy-MM-dd'), 
					lesson_fromtime, 
					lesson_totime, 
					lesson_room, 
					lesson_grade,
					schedule_idx
					FROM lessonM
					WHERE franchise_idx = @_franchise_idx
					AND lesson_date = FORMAT(DATEADD(D, @num, @_from_date1), 'yyyy-MM-dd')
					AND lesson_type IN ('01','04','05'));
					SET @idx = @@identity;
				END
				BEGIN
					INSERT INTO lessonT (schedule_idx, franchise_idx, student_idx)
					(SELECT @idx, tt.franchise_idx, tt.student_idx FROM lessonT tt
					LEFT OUTER JOIN lessonM ms ON tt.schedule_idx = ms.over_idx AND 
					ms.lesson_date = FORMAT(DATEADD(D, @num, @_from_date2), 'yyyy-MM-dd') AND ms.lesson_type IN ('01','04','05')
					LEFT OUTER JOIN member_studentM sm ON sm.user_no = tt.student_idx AND sm.franchise_idx = tt.franchise_idx 
					WHERE tt.franchise_idx = @_franchise_idx AND ms.over_idx <> '0' AND sm.state = '00');
				END
			END
		SET @num = @num + 1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_student_invoice_calc]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 센터 학생 원비 수납 금액 계산
CREATE PROCEDURE [dbo].[sp_student_invoice_calc] (
	@_franchise_idx int,
	@_student_idx int,
	@_from_date varchar(10),
	@_to_date varchar(10)
)

AS
BEGIN
	SET NOCOUNT ON;

    SELECT 
	ms.user_name AS Member_Name, c1.code_name AS Lesson_Type,
	COUNT(lt.student_idx) Lesson_Cnt, 
	(COUNT(lt.student_idx) * 
	(SELECT rt.receipt_amount FROM receiptT rt 
	WHERE rt.franchise_idx = @_franchise_idx AND rt.receipt_lesson_type = lm.lesson_type AND rt.receipt_grade = lm.lesson_grade)) Lesson_Amount
	FROM lessonT lt
	LEFT OUTER JOIN lessonM lm ON lt.schedule_idx = lm.schedule_idx
	LEFT OUTER JOIN lesson_attendT la ON lt.schedule_idx = la.schedule_idx AND lt.student_idx = la.student_idx
	LEFT OUTER JOIN member_studentM ms ON lt.student_idx = ms.user_no AND ms.franchise_idx = @_franchise_idx
	LEFT OUTER JOIN codeM c1 ON c1.code_num1 = '04' AND c1.code_num2 = lm.lesson_type
	WHERE lt.franchise_idx = @_franchise_idx AND lm.lesson_date BETWEEN @_from_date AND @_to_date
	AND lm.supple_yn = '' AND la.attend_yn = 'Y' AND lt.student_idx = @_student_idx
	GROUP BY ms.user_name, lm.lesson_type, c1.code_name, lm.lesson_grade
END
GO
/****** Object:  StoredProcedure [dbo].[sp_student_statistic_franchise]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 센터 지난 해, 올해 등록원생 수 계산
CREATE PROCEDURE [dbo].[sp_student_statistic_franchise] (@_from_date varchar(20), @_to_date varchar(20), @_franchise_idx int)
AS
BEGIN
	(SELECT
	concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) ym, 
	count(ms.user_no) cnt from member_studentm ms
	left outer join franchiseM fm on fm.franchise_idx = ms.franchise_idx
	Where ms.state = '00' and ms.reg_date between DATEADD(YEAR,-1, @_from_date) and DATEADD(YEAR,-1,@_to_date) and fm.franchise_idx = @_franchise_idx
	Group by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2'))
	UNION ALL
	SELECT
	concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) ym, 
	count(ms.user_no) cnt
	from member_studentm ms
	left outer join franchiseM fm on fm.franchise_idx = ms.franchise_idx
	Where ms.state = '00' and ms.reg_date between @_from_date and @_to_date and fm.franchise_idx  = @_franchise_idx
	Group by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2'))) order by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) desc;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_student_statistic_month]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 본사 지난 해, 올해 등록원생 수 계산 (전체, 직영, 가맹)
CREATE PROCEDURE [dbo].[sp_student_statistic_month] (@_from_date varchar(20), @_to_date varchar(20), @_franchise_type varchar(1))
AS
BEGIN
BEGIN
	IF @_franchise_type = 'a'
	(SELECT
	concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) ym, 
	count(ms.user_no) cnt from member_studentm ms
	left outer join franchiseM fm on fm.franchise_idx = ms.franchise_idx
	Where ms.state = '00' and ms.reg_date between DATEADD(YEAR,-1, @_from_date) and DATEADD(YEAR,-1,@_to_date) and fm.franchise_type in ('01','02')
	Group by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')))
	UNION ALL
	SELECT
	concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) ym, 
	count(ms.user_no) cnt
	from member_studentm ms
	left outer join franchiseM fm on fm.franchise_idx = ms.franchise_idx
	Where ms.state = '00' and ms.reg_date between @_from_date and @_to_date and fm.franchise_type in ('01','02')
	Group by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2'));
	ELSE IF @_franchise_type = 'd'
	(SELECT
	concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) ym, 
	count(ms.user_no) cnt from member_studentm ms
	left outer join franchiseM fm on fm.franchise_idx = ms.franchise_idx
	Where ms.state = '00' and ms.reg_date between DATEADD(YEAR,-1, @_from_date) and DATEADD(YEAR,-1,@_to_date) and fm.franchise_type = '01'
	Group by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')))
	UNION ALL
	SELECT
	concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) ym, 
	count(ms.user_no) cnt
	from member_studentm ms
	left outer join franchiseM fm on fm.franchise_idx = ms.franchise_idx
	Where ms.state = '00' and ms.reg_date between @_from_date and @_to_date and fm.franchise_type = '01'
	Group by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2'));
	ELSE IF @_franchise_type = 'f'
	(SELECT
	concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) ym, 
	count(ms.user_no) cnt from member_studentm ms
	left outer join franchiseM fm on fm.franchise_idx = ms.franchise_idx
	Where ms.state = '00' and ms.reg_date between DATEADD(YEAR,-1, @_from_date) and DATEADD(YEAR,-1,@_to_date) and fm.franchise_type = '02'
	Group by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2'))
	UNION ALL
	SELECT
	concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')) ym, 
	count(ms.user_no) cnt
	from member_studentm ms
	left outer join franchiseM fm on fm.franchise_idx = ms.franchise_idx
	Where ms.state = '00' and ms.reg_date between @_from_date and @_to_date and fm.franchise_type  = '02'
	Group by concat (DATEPART(YYYY, ms.reg_date), '-',FORMAT(DATEPART(MM, ms.reg_date), 'D2')));
	ELSE
	select 0
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_student_statistic_week]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 주별 등록원생 수 계산
CREATE PROCEDURE [dbo].[sp_student_statistic_week] (@_from_date varchar(20), @_to_date varchar(20))
AS
BEGIN
	SELECT
	DATEPART(WEEK, reg_date) w, 
	count(user_no) cnt
	from member_studentM
	Where state = '00' and reg_date between @_from_date and @_to_date
	Group by DATEPART(WEEK, reg_date);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_student_statistic_weekday]    Script Date: 2023-10-27 오후 05:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 요일별 등록원생 수 계산
CREATE PROCEDURE [dbo].[sp_student_statistic_weekday] (@_from_date varchar(20), @_to_date varchar(20))
AS
BEGIN
	SELECT
	CASE WHEN DATEPART(DW, reg_date) = '1' then '월'
	WHEN DATEPART(DW, reg_date) = '2' then '화'
	WHEN DATEPART(DW, reg_date) = '3' then '수'
	WHEN DATEPART(DW, reg_date) = '4' then '목'
	WHEN DATEPART(DW, reg_date) = '5' then '금'
	WHEN DATEPART(DW, reg_date) = '6' then '토'
	WHEN DATEPART(DW, reg_date) = '7' then '일'
	else '' end dw, 
	count(user_no) cnt
	from member_studentM
	Where state = '00' and reg_date between @_from_date and @_to_date
	Group by DATEPART(DW, reg_date);
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'로그번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'access_log', @level2type=N'COLUMN',@level2name=N'log_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'접근 아이피' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'access_log', @level2type=N'COLUMN',@level2name=N'remote_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'접근일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'access_log', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'접근 로그 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'access_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오류신고 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'error_report_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오류신고 작성자 회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'writer_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오류신고 제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오류신고 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'file_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일 원본명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'origin_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (접수중, 접수완료, 수정완료, 답변완료)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'답변내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오류신고 등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오류신고 수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'활동지 오류신고 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activity_error_reportT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'활동지 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT', @level2type=N'COLUMN',@level2name=N'activitypaper_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT', @level2type=N'COLUMN',@level2name=N'book_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학생용 활동지1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT', @level2type=N'COLUMN',@level2name=N'activity_student1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학생용 활동지2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT', @level2type=N'COLUMN',@level2name=N'activity_student2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교사용 지도서1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT', @level2type=N'COLUMN',@level2name=N'activity_teacher1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교사용 지도서2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT', @level2type=N'COLUMN',@level2name=N'activity_teacher2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'활동지 등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'활동지 수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'활동지 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'activitypaperT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'배너 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bannerT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'독서글쓰기번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT', @level2type=N'COLUMN',@level2name=N'book_report_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT', @level2type=N'COLUMN',@level2name=N'writer_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT', @level2type=N'COLUMN',@level2name=N'book_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'글쓰기 제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT', @level2type=N'COLUMN',@level2name=N'book_report_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'글쓰기 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT', @level2type=N'COLUMN',@level2name=N'book_report_contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'글쓰기 게시판 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_book_reportT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터알림 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT', @level2type=N'COLUMN',@level2name=N'notice_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'알림 제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT', @level2type=N'COLUMN',@level2name=N'notice_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'알림 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT', @level2type=N'COLUMN',@level2name=N'notice_contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'알림 대상 (a - 전체, t - 선생, s - 학생)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT', @level2type=N'COLUMN',@level2name=N'notice_target'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교사, 학생 회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT', @level2type=N'COLUMN',@level2name=N'notice_target_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터 알림 게시판 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_center_noticeT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문의 및 요청사항 답변번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiry_commentT', @level2type=N'COLUMN',@level2name=N'inquiry_comment_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문의번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiry_commentT', @level2type=N'COLUMN',@level2name=N'inquiry_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'답변내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiry_commentT', @level2type=N'COLUMN',@level2name=N'inquiry_comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiry_commentT', @level2type=N'COLUMN',@level2name=N'file_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiry_commentT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiry_commentT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문의및요청사항 답변 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiry_commentT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문의 및 요청번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'inquiry_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'inquiry_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성자 회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'inquiry_writer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구분' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'inquiry_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'inquiry_contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일 원본명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'origin_file_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'file_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문의및요청사항 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_inquiryT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수업TIP 댓글번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_commentT', @level2type=N'COLUMN',@level2name=N'comment_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'게시글 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_commentT', @level2type=N'COLUMN',@level2name=N'board_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_commentT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_commentT', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'본사 작성여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_commentT', @level2type=N'COLUMN',@level2name=N'head_write'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_commentT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수업TIP 게시판 댓글 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_commentT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좋아요 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_likes', @level2type=N'COLUMN',@level2name=N'likes_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'게시글 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_likes', @level2type=N'COLUMN',@level2name=N'board_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_likes', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_likes', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수업TIP 게시판 좋아요 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontip_likes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'게시글번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'board_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'머리글' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'board_kind'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'file_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일 원본명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'origin_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지사항 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'notice_yn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'본사작성 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'head_write'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'파일 경로' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'file_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좋아요 수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'likes_cnt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수업TIP게시판 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'board_lessontipT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'게시판 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boardM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대출번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'rent_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학생 회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'student_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대출 교사 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'teacher_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'book_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대출일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'rent_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반납예정일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'ex_return_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반납일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'return_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'읽음 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT', @level2type=N'COLUMN',@level2name=N'readYn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서 대출 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_rentT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서수량번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_statusT', @level2type=N'COLUMN',@level2name=N'status_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_statusT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_statusT', @level2type=N'COLUMN',@level2name=N'book_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서 보유수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_statusT', @level2type=N'COLUMN',@level2name=N'book_barcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_statusT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_statusT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서 수량 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'book_statusT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'book_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'book_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'isbn' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'book_isbn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'저자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'book_writer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출판사' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'book_publisher'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서카테고리1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'book_category1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서카테고리2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'book_category2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서카테고리3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'book_category3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서표지이미지링크' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'img_link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용여부(절판, 단종시 N으로 변경)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM', @level2type=N'COLUMN',@level2name=N'useYn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서 등록 요청 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bookRequestT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1차코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'code_num1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'2차코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'code_num2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'3차코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'code_num3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코드이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'code_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'설명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'detail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'필수(Y-> 삭제불가, N -> 삭제가능)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'is_necessary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM', @level2type=N'COLUMN',@level2name=N'code_use'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코드 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'codeM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원 색상 코드 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'color_codeT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'근태번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'commute_logT', @level2type=N'COLUMN',@level2name=N'commute_log_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'commute_logT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'commute_logT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (출근/퇴근)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'commute_logT', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'로그 등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'commute_logT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'근태 로그 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'commute_logT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'신규상담번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호(작성자)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'writer_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'피상담자 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counselee_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성별' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교사번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_teacher_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학부모연락처' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학교명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'school_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학년' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상담일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록가능성' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_regist'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'희망수업' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상담결과' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_result'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상담내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'알게된 경로' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'counsel_know'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'신규 상담 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counsel_newT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상담번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성자 회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'writer_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'피상담자 회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'student_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상담일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상담종류' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_kind'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상담방법' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_method'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상담내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'후속조치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_followup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'요청사항' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_request'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퇴원사유분류' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_discharge_reason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퇴원사유내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'counsel_discharge_contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'정규 상담 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'counselT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'커리큘럼 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM', @level2type=N'COLUMN',@level2name=N'curriculum_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도서번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM', @level2type=N'COLUMN',@level2name=N'book_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'커리큘럼순서' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM', @level2type=N'COLUMN',@level2name=N'orders'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대상 월' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM', @level2type=N'COLUMN',@level2name=N'months'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학년' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM', @level2type=N'COLUMN',@level2name=N'grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'커리큘럼 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'curriculumM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'근태 설정 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_commuteM', @level2type=N'COLUMN',@level2name=N'employee_commute_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_commuteM', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_commuteM', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출근시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_commuteM', @level2type=N'COLUMN',@level2name=N'from_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퇴근시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_commuteM', @level2type=N'COLUMN',@level2name=N'to_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유급휴일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_commuteM', @level2type=N'COLUMN',@level2name=N'paid_holiday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'무급휴일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_commuteM', @level2type=N'COLUMN',@level2name=N'unpaid_holiday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'근태 설정 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_commuteM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육 계획 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduM', @level2type=N'COLUMN',@level2name=N'edu_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduM', @level2type=N'COLUMN',@level2name=N'edu_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육분류(법정의무, 사내교육)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduM', @level2type=N'COLUMN',@level2name=N'edu_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육대상' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduM', @level2type=N'COLUMN',@level2name=N'edu_target'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육방법' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduM', @level2type=N'COLUMN',@level2name=N'edu_way'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직원교육 계획 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육일정 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT', @level2type=N'COLUMN',@level2name=N'eduschedule_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육계획 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT', @level2type=N'COLUMN',@level2name=N'edu_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육대상 회원 회원번호 목록' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT', @level2type=N'COLUMN',@level2name=N'user_list'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육 시작 기간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT', @level2type=N'COLUMN',@level2name=N'edu_from_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육 종료 기간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT', @level2type=N'COLUMN',@level2name=N'edu_to_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT', @level2type=N'COLUMN',@level2name=N'edu_flag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육 세부 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduscheduleT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직원 교육 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduT', @level2type=N'COLUMN',@level2name=N'employee_edu_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육 일정 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduT', @level2type=N'COLUMN',@level2name=N'eduschedule_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수료증 파일명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduT', @level2type=N'COLUMN',@level2name=N'file_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이수일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduT', @level2type=N'COLUMN',@level2name=N'edu_complete_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직원 교육 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'employee_eduT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터등록인증 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchise_authT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계속가맹금 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchise_feeM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육센터 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가맹구분' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'franchise_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육센터명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'center_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'램스용 학원 영문명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'center_eng_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대표자명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'owner_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대표자 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'owner_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용유무 (O,X)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'useyn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'tel_num'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fax 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'fax_num'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지역' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사업자 등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'biz_reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사업자 등록번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'biz_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학원등록번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'center_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'강의실 수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'class_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고서 마감일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'report_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가맹시작일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'franchisee_start'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가맹종료일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'franchisee_end'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'램스월이용료' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'rams_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'매출확정시작월' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'sales_confirm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'로열티비율' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'royalty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SMS 가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'sms_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MMS 가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'mms_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상점 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'shop_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상점키' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'shop_key'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'rams 포인트' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교육센터 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'franchiseM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'배송정보 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goods_shippingT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'물품번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'goods_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'goods_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'분류' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'goods_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단위' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'order_unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단가' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'cost_price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'sel_price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최소주문수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'min_quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'미리보기 이미지 링크' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'img_link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'memo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'useYn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'물품 정보 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'goodsM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'포인트 충전 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'invoice_pointM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'원비 환불 테이블 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'invoice_refundT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'원비 결제 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'invoiceM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이피 국가코드 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ip_countryT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수업출결석 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_attendT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'eval_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학생번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'student_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성 직원 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'writer_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'관찰 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'eval_content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'책읽기 평가 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'read_score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'책읽기 평가 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'read_content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'토론참여 평가 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'debate_score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'토론참여 평가 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'debate_content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'글쓰기 평가 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'write_score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'글쓰기 평가 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'write_content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주도/인성 평가 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'lead_score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주도/인성 평가 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'lead_content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지도내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'guide_content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지도방향' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'next_guide_content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학부모 요청사항' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'parent_request'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종합평가 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_evaluationT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수업 평가 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lesson_scoreT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수업 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lessonM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수강번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lessonT', @level2type=N'COLUMN',@level2name=N'class_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lessonT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학생번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lessonT', @level2type=N'COLUMN',@level2name=N'student_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lessonT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lessonT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수업 세부정보 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lessonT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'매거진번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazineM', @level2type=N'COLUMN',@level2name=N'magazine_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazineM', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'년도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazineM', @level2type=N'COLUMN',@level2name=N'magazine_year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계절호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazineM', @level2type=N'COLUMN',@level2name=N'season'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'썸내일 이미지 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazineM', @level2type=N'COLUMN',@level2name=N'thumbnail_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PDF 링크 (아임북)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazineM', @level2type=N'COLUMN',@level2name=N'pdf_link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazineM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'매거진 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazineM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비밀번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (00:재직, 01: 휴직, 02: 퇴직, 99:승인대기) (코드 테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'user_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비상연락처' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'emergencyhp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'birth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성별' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직책 (코드 테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'position'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'zipcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입사일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'hire_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퇴사일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'resign_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출신학교' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'school'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'졸업년월' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'graduation_months'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전공' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'major'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학위번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'degree_number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주요경력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'career'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'경력년수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'career_year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자격증' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'certificate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'은행명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'bank_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계좌번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'account_number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'권한 가진 메뉴 idx' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'menu_group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'관리자 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'is_admin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'리스트 노출여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM', @level2type=N'COLUMN',@level2name=N'show_yn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직원 테이블(센터)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_centerM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비밀번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (00:재직, 01: 휴직, 02: 퇴직, 99:승인대기) (코드 테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'user_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비상연락처' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'emergencyhp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'birth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성별' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직책 (코드 테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'position'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'zipcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입사일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'hire_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퇴사일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'resign_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출신학교' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'school'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'졸업년월' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'graduation_months'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전공' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'major'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학위번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'degree_number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주요경력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'career'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'경력년수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'career_year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자격증' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'certificate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'은행명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'bank_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계좌번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'account_number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'권한 가진 메뉴 idx' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'menu_group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'관리자 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'is_admin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'리스트 노출여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM', @level2type=N'COLUMN',@level2name=N'show_yn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직원 테이블(본사)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_employeeM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비밀번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (00:재원, 01: 휴원, 02: 퇴원, 99:승인대기) (코드 테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'user_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'birth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성별' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첫수업일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'class_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'zipcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'담임선생님 번호 (member_centerm 직원 번호)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'teacher_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'색깔태그' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'color_tag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메모란' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'user_memo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'휴퇴원사유(코드테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'dormant_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'휴퇴원 사유(기타)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'dormant_text'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최근 접속일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'logged_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'리스트 노출여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT', @level2type=N'COLUMN',@level2name=N'show_yn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'휴면계정 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_dormantT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비밀번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (00:재원, 01: 휴원, 02: 퇴원, 99:승인대기) (코드 테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'user_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'birth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성별' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첫수업일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'class_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'zipcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'담임선생님 번호 (member_centerm 직원 번호)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'teacher_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'색깔태그' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'color_tag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메모란' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'user_memo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'휴퇴원사유(코드테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'dormant_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'휴퇴원 사유(기타)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'dormant_text'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최근 접속일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'logged_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'리스트 노출여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT', @level2type=N'COLUMN',@level2name=N'show_yn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'탈퇴계정 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_student_outT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비밀번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (00:재원, 01: 휴원, 02: 퇴원, 99:승인대기) (코드 테이블)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'user_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'birth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성별' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'학교명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'school_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'zipcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'담임선생님 번호 (member_centerm 직원 번호)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'teacher_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'색깔태그' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'color_tag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메모란' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'user_memo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최근 접속일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'logged_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'리스트 노출여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM', @level2type=N'COLUMN',@level2name=N'show_yn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원 테이블(학생)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_studentM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메뉴번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'menu_link', @level2type=N'COLUMN',@level2name=N'menu_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종류' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'menu_link', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'menu_link', @level2type=N'COLUMN',@level2name=N'menu_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'링크 주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'menu_link', @level2type=N'COLUMN',@level2name=N'link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'menu_link', @level2type=N'COLUMN',@level2name=N'useyn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메뉴 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'menu_link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메시지 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'messageT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메타태그 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'meta_tagM', @level2type=N'COLUMN',@level2name=N'meta_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'meta_tagM', @level2type=N'COLUMN',@level2name=N'og_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'썸네일 이미지 경로' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'meta_tagM', @level2type=N'COLUMN',@level2name=N'og_image'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'표시 URL 주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'meta_tagM', @level2type=N'COLUMN',@level2name=N'og_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메타태그 지정용 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'meta_tagM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메시지 그룹 테이블 세부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_groupT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'신문칼럼 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'news_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호(작성자)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'표제' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'newspaper_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'신문사 코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'news_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'칼럼 주제 코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'column_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'신문 일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'news_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'칼럼파일명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'column_file'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'칼럼 파일원본명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'column_origin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교안파일명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'teaching_file'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교안 파일원본명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'teaching_origin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주제별 신문칼럼 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'newspaper_columnT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'물품 주문정보 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'order_goodsT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수납항목 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'receiptT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업무보고 양식번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'report_setting_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'title10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업무보고 양식 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'report_settingM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업무보고번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'report_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'title10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보고 내용10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'content10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록 년월' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'months'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT', @level2type=N'COLUMN',@level2name=N'mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업무보고 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reportT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'독서이력진단 학교 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'school_infoM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'독서이력진단결과 테이블 학교' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'school_rd_infoT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sql 에러로그 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sql_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'근무평가 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'센터번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'franchise_idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회원번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'user_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목1 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목2 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목3 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목4 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목5 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목6 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목7 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목8 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목9 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_sub10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평가항목10 점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'teval_score10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT', @level2type=N'COLUMN',@level2name=N'reg_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'교사 근무평가 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'teacher_evaluationT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주차 정보 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'weekT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 306
               Right = 542
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 14
               Left = 568
               Bottom = 299
               Right = 1138
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_book_category_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_book_category_count'
GO
USE [master]
GO
ALTER DATABASE [rams] SET  READ_WRITE 
GO
