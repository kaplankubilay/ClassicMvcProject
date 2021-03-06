USE [master]
GO
/****** Object:  Database [NewsDb]    Script Date: 12.08.2020 01:25:40 ******/
CREATE DATABASE [NewsDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'News', FILENAME = N'D:\Program Dosyaları (x86)\MSSQL11.SQLEXPRESS\MSSQL\DATA\News.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'News_log', FILENAME = N'D:\Program Dosyaları (x86)\MSSQL11.SQLEXPRESS\MSSQL\DATA\News_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NewsDb] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NewsDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NewsDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NewsDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NewsDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NewsDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NewsDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [NewsDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NewsDb] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [NewsDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NewsDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NewsDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NewsDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NewsDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NewsDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NewsDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NewsDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NewsDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NewsDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NewsDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NewsDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NewsDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NewsDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NewsDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NewsDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NewsDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NewsDb] SET  MULTI_USER 
GO
ALTER DATABASE [NewsDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NewsDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NewsDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NewsDb] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [NewsDb]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCategories]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_DeleteCategories]
(
	@CId int
)
As
Begin
	Delete From Categories Where CId=@CId
End
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteNews]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_DeleteNews]
(
	@Id int
)
As
Begin
	Delete From News Where Id=@Id
End
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertCategories]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_InsertCategories]
(
	@CategoryName nvarchar(50)
)
As
Begin
	Insert into Categories(CategoryName)
	Values(@CategoryName)
End
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertNews]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_InsertNews]
(
	@CId int,
	@NewsTitle nvarchar(100),
	@NewsContent nvarchar(max)
)
As
Begin
	Insert into News(CId,NewsTitle,NewsContent)
	Values (@CId,@NewsTitle,@NewsContent)
End
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCategories]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_SelectCategories]
as
begin
select * from Categories
end
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCategoryById]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectCategoryById]
(
	@CId int
)
As
Begin
select * from Categories where CId=@CId
End
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectNews]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectNews]
As
Begin
select t1.Id, t2.CId, t2.CategoryName, t1.NewsTitle, t1.NewsContent from News t1 inner join Categories t2 on t1.CId = t2.CId 
End
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectNewsById]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectNewsById]
(
	@Id int
)
As
begin
select t1.Id,t1.CId,t2.CategoryName,t1.NewsTitle,t1.NewsContent from News t1 inner join Categories t2 on t1.CId=t2.CId where Id=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateNews]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_UpdateNews]
(
	@Id int,
	@CId int,
	@NewsTitle nvarchar(100),
	@NewsContent nvarchar(max)
)
As
Begin
Update News
Set 
	CId = @CId, 
	NewsTitle = @NewsTitle, 
	NewsContent = @NewsContent
Where Id=@Id
End
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[CId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[News]    Script Date: 12.08.2020 01:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CId] [int] NOT NULL,
	[NewsTitle] [nvarchar](100) NULL,
	[NewsContent] [nvarchar](max) NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CId], [CategoryName]) VALUES (1, N'Yerel Haber')
INSERT [dbo].[Categories] ([CId], [CategoryName]) VALUES (2, N'Yurtdışı Haber')
INSERT [dbo].[Categories] ([CId], [CategoryName]) VALUES (1010, N'Spor Haberleri')
INSERT [dbo].[Categories] ([CId], [CategoryName]) VALUES (1011, N'Gündüz kuşağı')
INSERT [dbo].[Categories] ([CId], [CategoryName]) VALUES (1018, N'Hava Durumu')
INSERT [dbo].[Categories] ([CId], [CategoryName]) VALUES (1019, N'Gece Haberleri')
INSERT [dbo].[Categories] ([CId], [CategoryName]) VALUES (1020, N'Sabah Haberleri')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (3, 1, N'Son Dakika', N'Çetin Emeç bulvarını su bastı.')
INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (4, 2, N'Akşam haberleri', N'ABD-Kuzey Kore gerilimi sürüyor.')
INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (1010, 2, N'Dünya Basını', N'Brezilya ekonomik krizle mücadele ediyor.')
INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (1011, 2, N'Şili de büyük deprem', N'7 büyüklüğündeki depremde can kaybı artıyor.')
INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (1012, 1011, N'Son Dakika', N'Dolu yağışı çiftçiyi vurdu.')
INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (1014, 1010, N'Spor gündemi', N'Türkiye den 3 takım UEFA ya katılacak.')
INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (1054, 1019, N'Güne Bakış', N'Ankara da hareketli saatler.')
INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (1055, 1020, N'Günaydın Türkiye', N'Gece saatlerinde yaşanan kazada ölen olmadı,yaralıların tedavisi sürüyor.')
INSERT [dbo].[News] ([Id], [CId], [NewsTitle], [NewsContent]) VALUES (1073, 1010, N'Spor gündemi', N'Başakşehir şampiyonluğu kutluyor')
SET IDENTITY_INSERT [dbo].[News] OFF
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_Categories] FOREIGN KEY([CId])
REFERENCES [dbo].[Categories] ([CId])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_Categories]
GO
USE [master]
GO
ALTER DATABASE [NewsDb] SET  READ_WRITE 
GO
