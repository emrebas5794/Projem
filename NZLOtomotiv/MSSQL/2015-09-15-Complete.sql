USE [master]
GO
/****** Object:  Database [NazliOtomotiv]    Script Date: 15.9.2015 17:21:38 ******/
CREATE DATABASE [NazliOtomotiv]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NazliOtomotiv', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\NazliOtomotiv.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NazliOtomotiv_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\NazliOtomotiv_log.ldf' , SIZE = 3840KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NazliOtomotiv] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NazliOtomotiv].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NazliOtomotiv] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET ARITHABORT OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [NazliOtomotiv] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NazliOtomotiv] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NazliOtomotiv] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NazliOtomotiv] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NazliOtomotiv] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET RECOVERY FULL 
GO
ALTER DATABASE [NazliOtomotiv] SET  MULTI_USER 
GO
ALTER DATABASE [NazliOtomotiv] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NazliOtomotiv] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NazliOtomotiv] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NazliOtomotiv] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NazliOtomotiv', N'ON'
GO
USE [NazliOtomotiv]
GO
/****** Object:  StoredProcedure [dbo].[Create_Tables]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Create_Tables] 
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'Araclar') AND type in(N'U')) 
	BEGIN
		CREATE TABLE [dbo].[Araclar](
			[id] [int] IDENTITY(1,1) NOT NULL,
			[Ad] [nvarchar](50) NULL,
			[Arac_Uid] [nvarchar](50) NOT NULL,
			[Plaka] [nvarchar](50) NOT NULL,
			[Marka] [nvarchar](50) NOT NULL,
			[Seri] [nvarchar](50) NOT NULL,
			[Model] [nvarchar](50) NOT NULL,
			[Renk] [nvarchar](50) NOT NULL,
			[Yil] [nvarchar](50) NOT NULL,
			[KM] [nvarchar](50) NOT NULL,
			[Motor_Hacmi] [nvarchar](50) NULL,
			[Motor_Gucu] [nvarchar](50) NULL,
			[Motor_No] [nvarchar](50) NULL,
			[Yakit_Tipi] [nvarchar](50) NULL,
			[Sasi_No] [nvarchar](50) NULL,
			[Vites_Tipi] [nvarchar](50) NULL,
			[Kapi] [nvarchar](50) NULL,
			[Cekis] [nvarchar](50) NULL,
			[Sisteme_Giris_Tarihi] [date] NOT NULL,
			[Alinis_Tarihi] [date] NULL,
			[Alinis_Fiyati] [nvarchar](50) NULL,
			[Belirlenen_Satis_Fiyati] [nvarchar](50) NOT NULL,
			[Satis_Tarihi] [date] NULL,
			[Satis_Fiyati] [nvarchar](50) NULL,
			[Resmi_Satis_Fiyati] [nvarchar](50) NULL,
			[Noter_Devir_Tarihi] [date] NULL,
			[Arac_Durumu] [nvarchar](50) NOT NULL,
			[Giris_Durumu] [nvarchar](50) NOT NULL,
			[Cikis_Durumu] [nvarchar](50) NULL,
			[Ruhsat_Sahibi_ID] [nvarchar](50) NOT NULL,
			[Alici_ID] [nvarchar](50) NULL,
			[Satici_ID] [nvarchar](50) NULL,
			[Sahit_ID] [nvarchar](50) NULL
		)
	END

	IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'Iletisim') AND type in(N'U'))
	BEGIN
		CREATE TABLE [dbo].[Iletisim](
			[id] [int] IDENTITY(1,1) NOT NULL,
			[Contact_Uid] [nvarchar](50) UNIQUE NOT NULL,
			[Type] [nvarchar](10) NOT NULL,
			[Ad] [nvarchar](50) NOT NULL,
			[Kimlik_No] [nvarchar](50) NULL,
			[Adresler] [nvarchar](1200) NULL,
			[Telefonlar] [nvarchar](255) NULL,
			[Vergi_Dairesi] [nvarchar](255) NULL,
			[Vergi_No] [nvarchar](255) NULL
		)
	END

	IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'Iletisim') AND type in(N'U'))
	BEGIN
		CREATE TABLE [dbo].[Kullanicilar](
			[id] [int] IDENTITY(1,1) NOT NULL,
			[Contact_Uid] [nvarchar](50) UNIQUE NOT NULL,
			[Type] [nvarchar](10) NOT NULL,
			[Ad] [nvarchar](50) NOT NULL,
			[Kimlik_No] [nvarchar](50) NULL,
			[Adresler] [nvarchar](1200) NULL,
			[Telefonlar] [nvarchar](255) NULL,
			[Vergi_Dairesi] [nvarchar](255) NULL,
			[Vergi_No] [nvarchar](255) NULL
		)
	END

	IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'Vekaletler') AND type in(N'U'))
	BEGIN
		CREATE TABLE Vekaletler(
			id INT IDENTITY(1,1) NOT NULL,
			Vekalet_Uid NVARCHAR(50) NOT NULL UNIQUE,
			Arac_Uid NVARCHAR(50) NOT NULL UNIQUE,
			Vekalet_Bitis_Tarihi NVARCHAR(50) NOT NULL
		)
	END

	IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'Giderler') AND type in(N'U'))
	BEGIN
		CREATE TABLE Giderler(
			[id] [int] IDENTITY(1,1) NOT NULL,
			GiderID nvarchar(50) unique not null,
			GiderTipi nvarchar(50) not null,
			AracMaliyetTipi nvarchar(50) null,
			AracID nvarchar(50) null,
			Gider int not null,
			Aciklama nvarchar(50) null,
			Tarih date not null
		)
	END

	IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'Kullanicilar') AND type in(N'U'))
	BEGIN
		CREATE TABLE Kullanicilar(
			[id] [int] IDENTITY(1,1) NOT NULL,
			[username] [nvarchar](50) UNIQUE NOT NULL,
			[password_hash] [nvarchar](255) NOT NULL,
			[email] [nvarchar](255) UNIQUE NOT NULL,
			[phone] [nvarchar](20) NULL
		)
	END
END



GO
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegisterUser]
	@username NVARCHAR(50),
	@password NVARCHAR(255),
	@email NVARCHAR(255),
	@phone NVARCHAR(255) = NULL
AS
BEGIN
	INSERT INTO Kullanicilar (
		username,
		password_hash,
		email,
		phone
	)
	VALUES(
		@username,
		@password,
		@email,
		@phone
	)
END


GO
/****** Object:  UserDefinedFunction [dbo].[CekRiskiHesapla]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CekRiskiHesapla](@IletisimID nvarchar(36))
RETURNS int
AS
BEGIN
	DECLARE @Result int
	SELECT @Result = ISNULL((SELECT SUM(Miktar) FROM dbo.Cek WHERE CekAlinanKisi = @IletisimID), 0)
	RETURN @Result
END

GO
/****** Object:  UserDefinedFunction [dbo].[SenetRiskiHesapla]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SenetRiskiHesapla](@IletisimID nvarchar(36))
RETURNS int
AS
BEGIN
	DECLARE @Result int
	SELECT @Result = ISNULL((SELECT SUM(Kalan) FROM dbo.SenetBloklari WHERE Borclu = @IletisimID), 0)
	RETURN @Result
END

GO
/****** Object:  UserDefinedFunction [dbo].[ToplamRiskiHesapla]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ToplamRiskiHesapla](@IletisimID nvarchar(36))
RETURNS int
AS
BEGIN
	DECLARE @Result int
	SELECT @Result = dbo.CekRiskiHesapla(@IletisimID) + dbo.SenetRiskiHesapla(@IletisimID)
	RETURN @Result

END

GO
/****** Object:  Table [dbo].[Araclar]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Araclar](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Arac_Uid] [nvarchar](50) NOT NULL,
	[Plaka] [nvarchar](50) NOT NULL,
	[Marka] [nvarchar](50) NOT NULL,
	[Seri] [nvarchar](50) NOT NULL,
	[Model] [nvarchar](50) NOT NULL,
	[Renk] [nvarchar](50) NOT NULL,
	[Yil] [nvarchar](50) NOT NULL,
	[KM] [nvarchar](50) NOT NULL,
	[Motor_Hacmi] [nvarchar](50) NULL,
	[Motor_Gucu] [nvarchar](50) NULL,
	[Motor_No] [nvarchar](50) NULL,
	[Yakit_Tipi] [nvarchar](50) NULL,
	[Sasi_No] [nvarchar](50) NULL,
	[Vites_Tipi] [nvarchar](50) NULL,
	[Kapi] [nvarchar](50) NULL,
	[Cekis] [nvarchar](50) NULL,
	[Sisteme_Giris_Tarihi] [date] NOT NULL,
	[Alinis_Tarihi] [date] NULL,
	[Alinis_Fiyati] [nvarchar](50) NULL,
	[Belirlenen_Satis_Fiyati] [nvarchar](50) NOT NULL,
	[Satis_Tarihi] [date] NULL,
	[Satis_Fiyati] [nvarchar](50) NULL,
	[Resmi_Satis_Fiyati] [nvarchar](50) NULL,
	[Noter_Devir_Tarihi] [date] NULL,
	[Arac_Durumu] [nvarchar](50) NOT NULL,
	[Giris_Durumu] [nvarchar](50) NOT NULL,
	[Cikis_Durumu] [nvarchar](50) NULL,
	[Ruhsat_Sahibi_ID] [nvarchar](50) NOT NULL,
	[Alici_ID] [nvarchar](50) NULL,
	[Satici_ID] [nvarchar](50) NULL,
	[Sahit_ID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Araclar] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BOSTEST]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOSTEST](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[a1] [nvarchar](50) NULL,
	[a2] [int] NULL,
	[a3] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cek]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cek](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CekID] [nvarchar](36) NOT NULL,
	[CekNo] [varchar](12) NOT NULL,
	[Tarih] [date] NOT NULL,
	[Miktar] [int] NOT NULL,
	[CekAlinanKisi] [nvarchar](36) NOT NULL,
	[CekAsilSahibi] [nvarchar](50) NOT NULL,
	[Banka] [nvarchar](50) NOT NULL,
	[BankaSubesi] [nvarchar](50) NOT NULL,
	[TakastaOlduguHesap] [nvarchar](50) NULL,
	[CekNot] [text] NULL,
	[SistemeKayitTarihi] [datetime] NOT NULL,
 CONSTRAINT [PK_Cek] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CekArsiv]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CekArsiv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CekID] [nvarchar](36) NOT NULL,
	[CekNo] [varchar](12) NOT NULL,
	[Tarih] [date] NOT NULL,
	[Miktar] [int] NOT NULL,
	[CekAlinanKisi] [nvarchar](36) NOT NULL,
	[CekAsilSahibi] [nvarchar](50) NOT NULL,
	[Banka] [nvarchar](50) NOT NULL,
	[BankaSubesi] [nvarchar](50) NOT NULL,
	[TakastaOlduguHesap] [nvarchar](50) NULL,
	[CekNot] [text] NULL,
	[SistemeKayitTarihi] [datetime] NOT NULL,
	[ArsivlenmeTarihi] [datetime] NOT NULL,
	[ArsivleyenKisi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CekArsiv] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Giderler]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Giderler](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[GiderID] [nvarchar](50) NOT NULL,
	[GiderTipi] [nvarchar](50) NOT NULL,
	[AracMaliyetTipi] [nvarchar](50) NULL,
	[AracID] [nvarchar](50) NULL,
	[Gider] [int] NOT NULL,
	[Aciklama] [nvarchar](50) NULL,
	[Tarih] [date] NOT NULL,
 CONSTRAINT [PK_Giderler] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Iletisim]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Iletisim](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContactUID] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](10) NOT NULL,
	[Ad] [nvarchar](50) NOT NULL,
	[KimlikNo] [nvarchar](50) NULL,
	[Adresler] [nvarchar](1200) NULL,
	[Telefonlar] [nvarchar](255) NULL,
	[VergiDairesi] [nvarchar](50) NULL,
	[VergiNo] [nvarchar](50) NULL,
	[SenetNot] [text] NULL,
 CONSTRAINT [PK_Iletisim] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KasaFoyu]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KasaFoyu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Tip] [nvarchar](10) NOT NULL,
	[AltTip] [nvarchar](50) NULL,
	[Alt2Tip] [nvarchar](50) NULL,
	[BaglantiID] [nvarchar](50) NULL,
	[Miktar] [int] NOT NULL,
	[ParaBirimi] [nvarchar](10) NOT NULL,
	[Aciklama] [nvarchar](50) NOT NULL,
	[BaslangicTarihi] [date] NOT NULL,
 CONSTRAINT [PK_KasaFoyu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KasaFoyuArsiv]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KasaFoyuArsiv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[BaslangicTarihi] [date] NOT NULL,
	[BitisTarihi] [date] NOT NULL,
	[ArsivData] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Kullanicilar]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanicilar](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password_hash] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[phone] [nvarchar](20) NULL,
 CONSTRAINT [PK_Kullanicilar] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Maliyetler]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maliyetler](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Arac_ID] [nvarchar](50) NOT NULL,
	[Maliyet_KaportaBoya] [nvarchar](max) NULL,
	[Not_KaportaBoya] [nvarchar](max) NULL,
	[Hesap_KaportaBoya] [bit] NOT NULL,
	[Kesim_KaportaBoya] [date] NULL,
	[Maliyet_Yikama] [nvarchar](max) NULL,
	[Not_Yikama] [nvarchar](max) NULL,
	[Hesap_Yikama] [bit] NOT NULL,
	[Kesim_Yikama] [date] NULL,
	[Maliyet_Mekanik] [nvarchar](max) NULL,
	[Not_Mekanik] [nvarchar](max) NULL,
	[Hesap_Mekanik] [bit] NOT NULL,
	[Kesim_Mekanik] [date] NULL,
	[Maliyet_Diger] [nvarchar](max) NULL,
	[Not_Diger] [nvarchar](max) NULL,
	[Hesap_Diger] [bit] NULL,
	[Manuel_Veri] [bit] NOT NULL,
	[Manuel_Plaka] [nvarchar](50) NULL,
	[Manuel_Arac] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaliyetlerArsiv]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaliyetlerArsiv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ArsivTipi] [nvarchar](100) NOT NULL,
	[KayitTarihi] [date] NOT NULL,
	[ArsivData] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RiskLimitleri]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskLimitleri](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContactUID] [nvarchar](36) NOT NULL,
	[RiskLimit] [int] NULL,
 CONSTRAINT [PK_RiskLimitleri] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SenetBloklari]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SenetBloklari](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Borclu] [nvarchar](50) NOT NULL,
	[Kefil] [nvarchar](50) NULL,
	[SenetiImzalayan] [nvarchar](50) NULL,
	[SenetBlokID] [nvarchar](36) NOT NULL,
	[AlacakTipi] [nvarchar](50) NOT NULL,
	[SenetID] [nvarchar](36) NOT NULL,
	[SenetBlokNo] [nvarchar](6) NOT NULL,
	[Miktar] [int] NOT NULL,
	[Odenen] [int] NOT NULL,
	[Kalan]  AS ([Miktar]-[Odenen]),
	[OdemeTarihi] [date] NOT NULL,
	[VadeOrani] [float] NOT NULL,
	[SenetOlusturulmaTarihi] [date] NOT NULL,
	[SenetBlokNot] [text] NULL,
	[SenetNot] [text] NULL,
	[AracPlakasi] [nvarchar](50) NULL,
	[AracBasligi] [nvarchar](50) NULL,
	[SenetKagitiVerildi] [varchar](50) NULL,
 CONSTRAINT [PK_SenetBloklari] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SenetProfil]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SenetProfil](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContactUID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SenetProfil] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TadilatBaslik]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TadilatBaslik](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Oncelik] [bit] NOT NULL,
	[Ad] [nvarchar](255) NOT NULL,
	[Tip] [nvarchar](255) NOT NULL,
	[GorunenAd] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TadilatKesimler]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TadilatKesimler](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Hesap_Tipi] [nvarchar](50) NOT NULL,
	[Hesap_KesimTarih] [date] NOT NULL,
	[Hesap_Data] [nvarchar](max) NOT NULL,
	[Hesap_Miktar] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tadilatlar]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tadilatlar](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Arac_ID] [nvarchar](50) NULL,
	[Manuel_Veri] [bit] NOT NULL,
	[Manuel_AracPlaka] [nvarchar](50) NULL,
	[Manuel_AracAdi] [nvarchar](255) NULL,
	[Manuel_AracRenk] [nvarchar](255) NULL,
	[Manuel_AracYil] [nvarchar](255) NULL,
	[Tamamlanmis] [bit] NULL,
	[Maliyet_Kaporta_Boya_KEMAL_USTA] [int] NULL,
	[Not_Kaporta_Boya_KEMAL_USTA] [nvarchar](255) NULL,
	[Hesap_Kaporta_Boya_KEMAL_USTA] [bit] NULL,
	[Kayit_Kaporta_Boya_KEMAL_USTA] [bit] NULL,
	[Kesim_Kaporta_Boya_KEMAL_USTA] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vekaletler]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vekaletler](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Vekalet_Uid] [nvarchar](50) NOT NULL,
	[Arac_Uid] [nvarchar](50) NOT NULL,
	[Vekalet_Bitis_Tarihi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Vekaletler] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[RiskLimitleri_View]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RiskLimitleri_View]
AS
SELECT        ContactUID, Type, Ad, KimlikNo, VergiNo, dbo.SenetRiskiHesapla(ContactUID) AS SenetRiski, dbo.CekRiskiHesapla(ContactUID) AS CekRiski, dbo.ToplamRiskiHesapla(ContactUID) AS ToplamRisk,
                             (SELECT        RiskLimit
                               FROM            dbo.RiskLimitleri
                               WHERE        (ContactUID = dbo.Iletisim.ContactUID)) AS RiskLimit
FROM            dbo.Iletisim

GO
/****** Object:  View [dbo].[SenetProfil_View]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SenetProfil_View]
AS
SELECT        dbo.Iletisim.id, dbo.Iletisim.ContactUID, dbo.Iletisim.Type, dbo.Iletisim.Ad, dbo.Iletisim.KimlikNo, dbo.Iletisim.Adresler, dbo.Iletisim.Telefonlar, dbo.Iletisim.VergiDairesi, dbo.Iletisim.VergiNo, 
                         dbo.Iletisim.SenetNot, risk.SenetRiski, risk.CekRiski, risk.ToplamRisk, risk.RiskLimit
FROM            dbo.Iletisim LEFT OUTER JOIN
                             (SELECT        ContactUID, SenetRiski, CekRiski, ToplamRisk, RiskLimit
                               FROM            dbo.RiskLimitleri_View) AS risk ON dbo.Iletisim.ContactUID = risk.ContactUID
WHERE        (dbo.Iletisim.ContactUID IN
                             (SELECT        ContactUID
                               FROM            dbo.SenetProfil))

GO
/****** Object:  View [dbo].[SenetBloklari_View]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SenetBloklari_View]
AS
SELECT        senetler.id, senetler.Borclu, senetler.Kefil, senetler.SenetiImzalayan, senetler.SenetBlokID, senetler.AlacakTipi, senetler.SenetID, senetler.SenetBlokNo, senetler.Miktar, senetler.Odenen, senetler.Kalan, 
                         senetler.OdemeTarihi, senetler.VadeOrani, senetler.SenetOlusturulmaTarihi, senetler.SenetBlokNot, senetler.SenetNot, senetler.AracPlakasi, senetler.AracBasligi, senetler.SenetKagitiVerildi, borclu.BorcluAdi, 
                         borclu.BorcluTelefonlari, kefil.KefilAdi, kefil.KefilTelefonlari, imzalayan.SenetiImzalayanAdi, imzalayan.SenetiImzalayanTelefonlari
FROM            dbo.SenetBloklari AS senetler LEFT OUTER JOIN
                             (SELECT        Ad AS BorcluAdi, Telefonlar AS BorcluTelefonlari, ContactUID AS BorcluID
                               FROM            dbo.Iletisim) AS borclu ON borclu.BorcluID = senetler.Borclu LEFT OUTER JOIN
                             (SELECT        Ad AS KefilAdi, Telefonlar AS KefilTelefonlari, ContactUID AS KefilID
                               FROM            dbo.Iletisim AS Iletisim_2) AS kefil ON kefil.KefilID = senetler.Kefil LEFT OUTER JOIN
                             (SELECT        Ad AS SenetiImzalayanAdi, Telefonlar AS SenetiImzalayanTelefonlari, ContactUID AS SenetiImzalayanID
                               FROM            dbo.Iletisim AS Iletisim_1) AS imzalayan ON senetler.SenetiImzalayan = imzalayan.SenetiImzalayanID

GO
/****** Object:  View [dbo].[AlacakTipineGöreSenetBorclari_View]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AlacakTipineGöreSenetBorclari_View]
AS
SELECT        RET.AlacakTipi, RET.ToplamKalan, RET.SenetSayisi, TarihiGecmis.TarihiGecmisSenetSayisi, TarihiGecmis.TarihiGecmisToplamKalan
FROM            (SELECT        AlacakTipi, SUM(Kalan) AS ToplamKalan, COUNT(*) AS SenetSayisi
                          FROM            dbo.SenetBloklari_View
                          GROUP BY AlacakTipi) AS RET LEFT OUTER JOIN
                             (SELECT        AlacakTipi, COUNT(*) AS TarihiGecmisSenetSayisi, SUM(Kalan) AS TarihiGecmisToplamKalan
                               FROM            dbo.SenetBloklari_View AS SenetBloklari_View_1
                               WHERE        (OdemeTarihi < GETDATE()) AND (Kalan > 0)
                               GROUP BY AlacakTipi) AS TarihiGecmis ON TarihiGecmis.AlacakTipi = RET.AlacakTipi

GO
/****** Object:  UserDefinedFunction [dbo].[RiskleriHesapla]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2015-09-11
-- =============================================
CREATE FUNCTION [dbo].[RiskleriHesapla](@IletisimID nvarchar(36))
RETURNS TABLE 
AS
RETURN 
(
	SELECT dbo.SenetRiskiHesapla(@IletisimID) AS SenetRiski, dbo.CekRiskiHesapla(@IletisimID) AS CekRiski, dbo.ToplamRiskiHesapla(@IletisimID) AS ToplamRisk
)

GO
/****** Object:  View [dbo].[CekArsiv_View]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CekArsiv_View]
AS
SELECT        cekler.id, cekler.CekID, cekler.CekNo, cekler.Tarih, cekler.Miktar, cekler.CekAlinanKisi, cekler.CekAsilSahibi, cekler.Banka, cekler.BankaSubesi, cekler.TakastaOlduguHesap, cekler.CekNot, 
                         cekler.SistemeKayitTarihi, cekler.ArsivlenmeTarihi, cekler.ArsivleyenKisi, cekalinan.CekAlinanKisi_Ad
FROM            dbo.CekArsiv AS cekler LEFT OUTER JOIN
                             (SELECT        Ad AS CekAlinanKisi_Ad, ContactUID AS CekAlinanKisi_ID
                               FROM            dbo.Iletisim) AS cekalinan ON cekler.CekAlinanKisi = cekalinan.CekAlinanKisi_ID

GO
/****** Object:  View [dbo].[CekListesi_View]    Script Date: 15.9.2015 17:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CekListesi_View]
AS
SELECT        cekler.id, cekler.CekID, cekler.CekNo, cekler.Tarih, cekler.Miktar, cekler.CekAlinanKisi, cekler.CekAsilSahibi, cekler.Banka, cekler.BankaSubesi, cekler.TakastaOlduguHesap, cekler.CekNot, 
                         cekler.SistemeKayitTarihi, cekalinan.CekAlinanKisi_Ad
FROM            dbo.Cek AS cekler LEFT OUTER JOIN
                             (SELECT        Ad AS CekAlinanKisi_Ad, ContactUID AS CekAlinanKisi_ID
                               FROM            dbo.Iletisim) AS cekalinan ON cekler.CekAlinanKisi = cekalinan.CekAlinanKisi_ID

GO
SET IDENTITY_INSERT [dbo].[Araclar] ON 

INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (2, N'ALFA ROMEO 147', N'44a1febe-d43e-4887-a07c-a3797de488b5', N'34 CEA 174', N'ALFA ROMEO', N'147', N'1.6 TS Distinctive', N'BEJ', N'2005', N'117000', N'1600', N'125', N'', N'Benzin', N'', N'Manuel', N'2', N'', CAST(0x07240B00 AS Date), CAST(0xBD390B00 AS Date), N'21000', N'26750', NULL, NULL, NULL, NULL, N'Eldeki Araç', N'NZL Üzerine Alınmış', NULL, N'Elif Cantaş', NULL, N'J9G40J0GUD', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (3, N'ALFA ROMEO 147', N'6625aba7-bf68-4262-a240-b9909477b5ce', N'06 DMC 62', N'ALFA ROMEO', N'147', N'1.6 TS Distinctive', N'BEJ', N'2005', N'117000', N'1600', N'125', N'', N'Benzin', N'', N'Manuel', N'2', N'', CAST(0x07240B00 AS Date), CAST(0xC4390B00 AS Date), N'21000', N'26750', NULL, NULL, NULL, NULL, N'Eldeki Araç', N'Vekaleten (Vekaleti Alınmış)', NULL, N'Kemal Mustafa Nurlu', NULL, N'J9G40J0GUD', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (37, N'FORD FOCUS 1.6', N'4116db32-3c3f-46c6-84d8-d3689f109bc3', N'34 AFV 26', N'FORD', N'FOCUS', N'1.6 TDCi TREND X', N'Beyaz', N'2014', N'5000', N'1600', N'100', N'', N'Dizel', N'', N'Manuel', N'4', N'', CAST(0x07240B00 AS Date), CAST(0xC8390B00 AS Date), N'54000', N'60750', CAST(0xD8390B00 AS Date), N'60750', N'55000', CAST(0xD8390B00 AS Date), N'Satışı Yapılmış Araç', N'Vekaleten (Vekaleti Alınmış)', NULL, N'Zafer Ketenci', N'de42be6a-dc6a-4dcc-8bb6-849bbdb3364d', N'37b2293c-f6cb-48bb-aced-eb46da55fcc2', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (38, N'2011 CHEVROLET AVEO 1.4 LTZ', N'a85f3b3d-dc75-44b1-b547-9bab730c8ad8', N'34 AVC 654', N'CHEVROLET', N'AVEO', N'1.4 LTZ', N'GÜMÜŞ', N'2011', N'25000', N'1400', N'100', N'', N'Benzin', N'', N'Manuel', N'4', N'', CAST(0x07240B00 AS Date), CAST(0xC8390B00 AS Date), N'22000', N'28750', NULL, NULL, NULL, NULL, N'Eldeki Araç', N'Vekaleten (Vekaleti Alınmış)', NULL, N'Enes Çaylak', NULL, N'de42be6a-dc6a-4dcc-8bb6-849bbdb3364d', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (49, N'', N'5168febc-3309-421e-bd28-f70a5eff541e', N'34 BN 5763', N'HONDA', N'JAZZ', N'ES', N'GÜMÜŞ', N'2005', N'121000', N'1400', N'83', N'L13A13038990', N'Benzin', N'JHMGD17704S239242', N'Manuel', N'5', N'', CAST(0x07240B00 AS Date), CAST(0xC8390B00 AS Date), N'20000', N'26750', CAST(0x243A0B00 AS Date), N'26000', N'25000', CAST(0x6E390B00 AS Date), N'Satışı Yapılmış Araç', N'Vekaleten (Vekaleti Alınmış)', NULL, N'ZEYNEP DİLEK ERBİL', N'J3TH8Y94M', N'05d07e93-7205-495a-a0af-ffb5166a8d02', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (50, N'MERCEDES C 180', N'98b523be-b579-4e4a-9f48-8ed28dabfdb0', N'34 MVR 12', N'MERCEDES', N'C', N'180 BlueEfficiency Estate', N'BEYAZ', N'2012', N'43000', N'1600', N'175', N'', N'Benzin', N'', N'Otomatik', N'', N'', CAST(0x07240B00 AS Date), CAST(0xB4390B00 AS Date), N'80000', N'94500', NULL, NULL, NULL, NULL, N'Eldeki Araç', N'NZL Üzerine Alınmış', NULL, N'Cemal Alacalı', NULL, N'94J48G4JDS', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (1051, N'PEUGEOT 206 OTOMATİK', N'd3dc501e-0452-4e9f-9b74-a4106b5caf9d', N'34 VS 2885', N'PEUGEOT', N'206', N'2003', N'GÜMÜŞ', N'2003', N'202.000 KM', N'', N'', N'WAS34T5678', N'Benzin', N'NMT48000ATGD', N'Otomatik', N'5', N'', CAST(0xF8390B00 AS Date), CAST(0xF8390B00 AS Date), N'16.000 TL', N'18.000 TL', NULL, NULL, NULL, NULL, N'Eldeki Araç', N'Vekaleten (Vekaleti Henüz Alınmamış)', NULL, N'J3TH8Y94M', NULL, N'8546374d-41c0-4568-9e9c-905c5a103fba', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (1052, N'Nissan Skyline', N'5e739c2d-3871-48b6-81da-8f490e8a3044', N'34 ZAF 852', N'Nissan', N'Skyline', N'1998', N'Gri', N'1998', N'301.000', N'3800', N'680', N'55555', N'Benzin', N'8888', N'Manuel', N'4', N'', CAST(0xFB390B00 AS Date), CAST(0xFB390B00 AS Date), N'127.000', N'129.000', NULL, NULL, NULL, NULL, N'Eldeki Araç', N'NZL Üzerine Alınmış', NULL, N'', NULL, N'', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (1053, N'OPEL ASTRA ENJOY', N'ee038e4c-1b41-4065-bca4-8de9f0370546', N'34 TG 2686', N'OPEL', N'ASTRA ', N'ENJOY', N'BEYAZ', N'2011', N'103000', N'1600', N'156', N'45454', N'Dizel', N'WSFT', N'Manuel', N'6', N'', CAST(0x173A0B00 AS Date), CAST(0x173A0B00 AS Date), N'28250', N'31500', NULL, NULL, NULL, NULL, N'Eldeki Araç', N'NZL Üzerine Alınmış', NULL, N'e6f32f77-c537-4687-a677-edc931811f30', NULL, N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', NULL)
INSERT [dbo].[Araclar] ([id], [Ad], [Arac_Uid], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [Motor_Hacmi], [Motor_Gucu], [Motor_No], [Yakit_Tipi], [Sasi_No], [Vites_Tipi], [Kapi], [Cekis], [Sisteme_Giris_Tarihi], [Alinis_Tarihi], [Alinis_Fiyati], [Belirlenen_Satis_Fiyati], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Arac_Durumu], [Giris_Durumu], [Cikis_Durumu], [Ruhsat_Sahibi_ID], [Alici_ID], [Satici_ID], [Sahit_ID]) VALUES (2053, N'OPEL ASTRA', N'7f8b895b-2cd3-4abb-b113-7991da7826c1', N'34 VS 2788', N'OPEL', N'ASTRA', N'GTC', N'SİYAH', N'2005', N'136000', N'1300', N'90', N'WFJI244F835', N'Benzin', N'F1E8FE1F5E1', N'Manuel', N'5', N'', CAST(0x4C3A0B00 AS Date), CAST(0x4C3A0B00 AS Date), N'36500', N'46750', NULL, NULL, NULL, NULL, N'Eldeki Araç', N'Vekaleten (Vekaleti Henüz Alınmamış)', NULL, N'94J48G4JDS', NULL, N'94J48G4JDS', NULL)
SET IDENTITY_INSERT [dbo].[Araclar] OFF
SET IDENTITY_INSERT [dbo].[BOSTEST] ON 

INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (3, N'257637E2-85DE-4E40-B224-33D909E5B3DF', 0, CAST(0x0000A4DF00EB681E AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (4, N'4FFBB9D2-2D82-49FC-B773-EFBA62BCEAFE', 0, CAST(0x0000A4DF00EB6864 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (5, N'414D9D34-939E-472B-8801-2830D32717A1', 0, CAST(0x0000A4DF00EB689D AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (6, N'8F95512B-6952-48AD-B960-B62DB9905E92', 0, CAST(0x0000A4DF00EB68DC AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (7, N'4AD804C6-2720-4D0E-A160-AE461082B506', 0, CAST(0x0000A4DF00EB6971 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (8, N'8058D9CB-EFAE-4EA5-B416-2B3B4E918FEE', 0, CAST(0x0000A4DF00EB6989 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (9, N'EA242DDD-C940-4A05-AD50-23751E830AF0', 0, CAST(0x0000A4DF00EB69BE AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (10, N'E83455E6-747B-4B97-B61A-E2FF2117955A', 0, CAST(0x0000A4DF00EB6A0C AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (11, N'0A486EFF-076A-43FC-8ED6-E5D308A03FFF', 0, CAST(0x0000A4DF00EB6A50 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (12, N'55D63018-2C25-4760-BBD5-BB2D88007C78', 0, CAST(0x0000A4DF00EB6A8B AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (13, N'24EE8AF0-593B-4512-B8E4-2AAC2D3D8325', 0, CAST(0x0000A4DF00EB6ACB AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (14, N'C614C68A-F4CE-4487-A103-586F10956B10', 0, CAST(0x0000A4DF00EB6B0D AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (15, N'F05651C6-5AE8-4981-A778-C9F78840F3B3', 0, CAST(0x0000A4DF00EB6B51 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (16, N'C06F34A9-D34D-4DD6-BA9F-4189672835E2', 0, CAST(0x0000A4DF00EB6BA2 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (17, N'FEEF452A-443D-4C7E-BE99-656AF63BDFC7', 0, CAST(0x0000A4DF00EB6BE8 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (18, N'C5F417F5-C4DF-4554-ABAD-684996467342', 0, CAST(0x0000A4DF00EB6C2A AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (19, N'8562A75B-EB95-4961-ADA7-90A22FF2DA2F', 0, CAST(0x0000A4DF00EB6C6A AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (20, N'7FAC8BB2-87F6-452D-9949-A04C3E0A6CC0', 0, CAST(0x0000A4DF00EB6CAF AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (21, N'A3620457-9907-46F4-A103-F02C9CBFEDA3', 0, CAST(0x0000A4DF00EB6CF5 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (22, N'DBA9ED0C-45B6-48E8-B835-29D34D300E7E', 0, CAST(0x0000A4DF00EB6D32 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (23, N'FAD1F2DA-700A-42EC-89FB-6FA17359A0D6', 0, CAST(0x0000A4DF00EB6D84 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (24, N'4099A6C8-8C99-47C3-B82C-3F683A9BDD04', 0, CAST(0x0000A4DF00EB6DC7 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (25, N'4ACA759D-9E19-4309-B52F-1D73983AEFF0', 0, CAST(0x0000A4DF00EB6E0C AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (26, N'199B0BF1-AD0D-48D8-8422-C4F6B892ADC1', 0, CAST(0x0000A4DF00EB6E4E AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (27, N'1C5CFE83-5999-44EE-8D13-049877C04A40', 0, CAST(0x0000A4DF00EB6E92 AS DateTime))
INSERT [dbo].[BOSTEST] ([id], [a1], [a2], [a3]) VALUES (28, N'03D48C31-6EEB-40CC-9097-9C9BE770D705', 0, CAST(0x0000A4DF00EB6ED6 AS DateTime))
SET IDENTITY_INSERT [dbo].[BOSTEST] OFF
SET IDENTITY_INSERT [dbo].[Cek] ON 

INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (5, N'1F8019C2-B41A-4C5E-B473-E803CB63C447', N'68418965', CAST(0x8B3B0B00 AS Date), 12000, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'Cemal Han', N'Akbank', N'Bakırköy', N'', N'', CAST(0x0000A4E700A1B97A AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (1005, N'774EC7F5-AD97-4919-ABA3-A9FAB379FB4B', N'21684136', CAST(0xE73B0B00 AS Date), 8000, N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'', N'Yapı Kredi', N'Çengelköy', N'', N'', CAST(0x0000A4E70130DE97 AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (2008, N'6A81B585-03F4-423A-9837-15A9C02820A3', N'984584176420', CAST(0xD93A0B00 AS Date), 8000, N'94J48G4JDS', N'', N'İş Bankası', N'Ümraniye', N'', N'', CAST(0x0000A4F100C5837A AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (2017, N'8EB61727-E737-4B4E-9E07-8A7A7C0950DE', N'8215648', CAST(0x493C0B00 AS Date), 24000, N'e144bd22-6879-4609-a370-27abc98cf0c7', N'', N'Akbank', N'Pendik', N'', N'', CAST(0x0000A50700A22E0A AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (3017, N'924573BD-61C2-4970-B4F5-CFE957ABE0FD', N'48915164', CAST(0x6C3A0B00 AS Date), 7800, N'km23tsj0k2f', N'TURAP ÜLKÜ', N'YAPI KREDİ', N'KARTAL', N'', N'', CAST(0x0000A51300F8F711 AS DateTime))
SET IDENTITY_INSERT [dbo].[Cek] OFF
SET IDENTITY_INSERT [dbo].[CekArsiv] ON 

INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (9, N'CD110B6C-E01D-452C-8A39-090083E8DCA9', N'846548951', CAST(0x403A0B00 AS Date), 8000, N'94J48G4JDS', N'', N'Akbank', N'Bahçelievler', N'', N'', CAST(0x0000A4F100C618E1 AS DateTime), CAST(0x0000A502012B58D8 AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (11, N'C33E58B3-3E45-4125-A4EB-DF1CB5196623', N'8124981213', CAST(0x86390B00 AS Date), 8000, N'8546374d-41c0-4568-9e9c-905c5a103fba', N'Hasan Gelir', N'Akbank', N'Topkapı', N'', N'', CAST(0x0000A50300AE6A69 AS DateTime), CAST(0x0000A50300AE72E7 AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (12, N'A3DEB659-E98F-4ECC-8124-C8FB05D995E0', N'2168465498', CAST(0xF1390B00 AS Date), 1400, N'66b6de1c-7829-41d8-8506-ffec542910eb', N'Cemil Kaya', N'İşbankası', N'Avcılar', N'', N'', CAST(0x0000A50300AEDF1D AS DateTime), CAST(0x0000A50300AEE2F6 AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (13, N'F889ED6C-8C5A-4331-846B-83FA7164D10A', N'849186', CAST(0xB43D0B00 AS Date), 14000, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'Yapı Kredi', N'Şişli', N'', N'', CAST(0x0000A4E700CB9373 AS DateTime), CAST(0x0000A50300D5F5E9 AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (14, N'20122F8E-4BB6-4DAE-97CF-F3E17F6992D0', N'25948913', CAST(0x5F3A0B00 AS Date), 2500, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kamuran Günay', N'Akbank', N'Tarabya', N'', N'10. ayda ödeyecek', CAST(0x0000A50300C83DCD AS DateTime), CAST(0x0000A50601795E23 AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (15, N'0A3BB0A0-11CA-46B1-8D8C-1A2C3554DE42', N'25948913', CAST(0x643A0B00 AS Date), 2500, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kamuran Günay', N'Akbank', N'Tarabya', N'', N'', CAST(0x0000A50300C8E4B5 AS DateTime), CAST(0x0000A51300F7A421 AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (16, N'59BA40E4-9E53-4175-92B6-1AB5F72E5AC4', N'25948913', CAST(0x653A0B00 AS Date), 2500, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kamuran Günay', N'Akbank', N'Tarabya', N'', N'', CAST(0x0000A50300C8EC0E AS DateTime), CAST(0x0000A51300F800BE AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (17, N'FD6F63BD-0958-4EAA-89D6-F7AF39BA3B2B', N'25948913', CAST(0x663A0B00 AS Date), 2500, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kamuran Günay', N'Akbank', N'Tarabya', N'', N'', CAST(0x0000A50300C90504 AS DateTime), CAST(0x0000A51300F83BF9 AS DateTime), N'ozan')
SET IDENTITY_INSERT [dbo].[CekArsiv] OFF
SET IDENTITY_INSERT [dbo].[Giderler] ON 

INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (2, N'C0F1C74C-35E2-45D9-8DD1-A43E84247D75', N'Araç Maliyeti', N'Diğer', N'6625aba7-bf68-4262-a240-b9909477b5ce', 122, N'egerg', CAST(0x9E3A0B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (3, N'21ce8d44-4068-4856-bc36-b4e1f48b385a', N'Araç Maliyeti', N'Mekanik', N'6625aba7-bf68-4262-a240-b9909477b5ce', 1000, N'', CAST(0xCB390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (4, N'e015c520-4c83-4465-87df-973ab48e9711', N'Faaliyet Dışı Gider', N'', N'', 10000, N'Kira', CAST(0xC8390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (5, N'1da013ef-a01b-4f1b-a705-a08dfe429a3a', N'Araç Maliyeti', N'Diğer', N'4116db32-3c3f-46c6-84d8-d3689f109bc3', 1242, N'', CAST(0xCA390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (6, N'b13955e9-95f2-4b75-ab8c-505c16d6dd27', N'Araç Maliyeti', N'Mekanik', N'44a1febe-d43e-4887-a07c-a3797de488b5', 4000, N'Motor', CAST(0x78390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (7, N'4e01ab0f-bb09-4c55-a62c-99a1250ba28b', N'Dükkan Gideri', N'', N'', 7000, N'Kira', CAST(0x6E390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (8, N'e03ab7c7-7b31-49c9-86c4-5fb79030ac43', N'Araç Maliyeti', N'Kaporta-Boya', N'98b523be-b579-4e4a-9f48-8ed28dabfdb0', 1200, N'Boya yapıldı', CAST(0xD1390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (9, N'a8f26d5e-ec91-4987-8e90-17e54846d1eb', N'Araç Maliyeti', N'Mekanik', N'a85f3b3d-dc75-44b1-b547-9bab730c8ad8', 1500, N'', CAST(0xD7390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (10, N'5fe48ff3-f66a-49dc-b237-d837a5ee3f5f', N'Faaliyet Dışı Gider', N'', N'', 125000, N'Batak', CAST(0xC8390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (1016, N'fce54028-9e22-46bb-85bb-c6da7a1fcd6c', N'Araç Maliyeti', N'Kaporta-Boya', N'5e739c2d-3871-48b6-81da-8f490e8a3044', 744, N'', CAST(0xFC390B00 AS Date))
INSERT [dbo].[Giderler] ([id], [GiderID], [GiderTipi], [AracMaliyetTipi], [AracID], [Gider], [Aciklama], [Tarih]) VALUES (1017, N'cb69ce11-0d48-462c-91e5-46f1299b1b05', N'Araç Maliyeti', N'Mekanik', N'5e739c2d-3871-48b6-81da-8f490e8a3044', 50, N'', CAST(0xFC390B00 AS Date))
SET IDENTITY_INSERT [dbo].[Giderler] OFF
SET IDENTITY_INSERT [dbo].[Iletisim] ON 

INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1, N'94J48G4JDS', N'Kişi', N'OZAN ÜLKÜ', N'21431235476', N'Bahçelievler', N'532 324 45 32/*/212 435 12 54', NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (2, N'J9G40J0GUD', N'Kişi', N'TURAP ÜLKÜ', N'21634612564', N'Göksu Evleri', N'216 345 1235/*/0531 135 98 32', NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (3, N'J3TH8Y94M', N'Kişi', N'AHMET KAYA', N'21540583950', N'Ankara', N'312 987 7492', NULL, NULL, N'Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; 

Test')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (4, N'JOEJVENFDV', N'Kişi', N'KEMAL AKBAŞ', N'26438674584', N'Ankara', N'538 324 24 09', NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (11, N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'Kişi', N'CANAN HÜRCAN', N'31425963257', N'Üsküdar, İstanbul', N'555 214 61 37/*/532 643 75 12/*/212 321 43 54', NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (13, N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'Kişi', N'MELEK GÜLPINAR', N'53654825692', N'Beylikdüzü, İstanbul', N'544 851 54 95   /*/212 154 85 32', NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (14, N'37b2293c-f6cb-48bb-aced-eb46da55fcc2', N'Kişi', N'ZAFER KETENCİ', N'23541756743', N'Anadolu Hisarı, Kavacık, İstanbul', N'532 123 65 34/*/538 254 12 89/*/216 435 12 64', NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (15, N'de42be6a-dc6a-4dcc-8bb6-849bbdb3364d', N'Kişi', N'HASAN CEMAL', N'23654573245', N'Avcılar, İstanbul', N'545 852 45 98/*/212 458 54 84', NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (16, N'05d07e93-7205-495a-a0af-ffb5166a8d02', N'Kişi', N'MURAT ERBİL', N'51261367490', N'Çengelköy mahallesi, yalıboyu sokak no:12', N'532 315 35 90', NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (17, N'km23tsj0k2f', N'Kurum', N'TİARPİ YAZİLİM', NULL, N'Göksu Evleri, Kavacık, İstanbul', N'216 232 21 32', N'Üsküdar', N'6346753525', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (18, N'290f3d6c-ba5b-4633-9576-564aa63ca7a8', N'Kurum', N'GÜNAY PAZARLAMA', N'', N'Şirinevler, İstanbul', N'212 342 12 55/*/212 342 12 54', N'Kocasinan', N'2153565334', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (21, N'7a604ac2-10b5-41f9-b6a7-c4be3e15756a', N'Kurum', N'SAYAR GÜVENLİK', N'', N'Kadıköy, İstanbul', N'216 343 12 54', N'Kadıköy', N'635462365', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (22, N'ad3de6c5-7396-4901-b083-09c5bcf2daee', N'Kurum', N'MASAL BİLİŞİM', N'', N'Bağcılar, İstanbul', N'', N'Bağcılar', N'392482379', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (23, N'e144bd22-6879-4609-a370-27abc98cf0c7', N'Kurum', N'BAYAR MİMARLIK', N'', N'Beşiktaş, İstanbul', N'', N'Beşiktaş', N'3987823798', N'')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (24, N'8546374d-41c0-4568-9e9c-905c5a103fba', N'Kişi', N'HASAN GELİR', N'5485236547', N'İstanbul', N'(212) 454 85 16', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (25, N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'Kişi', N'KERİME HASTAŞLI', N'85648201564', N'Ankara', N'(312) 151 98 56', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (26, N'ae0e789f-976a-469b-a043-387da5576811', N'Kurum', N'CANPINAR SU', N'', N'Kadıköy', N'(216) 849 86 54/*/(216) 549 84 59', N'Kadıköy', N'24815684651', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1026, N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'Kişi', N'BURAK SELCUK', N'20312569895', N'dsdsdsdsdsdsdsds/*/hhdskldjsldlsjdlkslds/*/necıbbey cad', N'(455) 555 55 55/*/(021) 658 78 75/*/(053) 216 94 47', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1027, N'a9a43d5c-e8ee-4a76-a37c-e287a80a5aff', N'Kişi', N'TUĞRUL NAZLI', N'51286157094', N'SELAMİ ALİ MAH', N'(532) 256 44 57', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1028, N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'Kişi', N'BURAK SELÇUK', N'51284787598', N'ALTUNİZADE', N'(532) 487 85 89', N'', N'', N'
')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1029, N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'Kişi', N'AHMET ÇALIŞKAN', N'78541285147', N'ABC', N'(532) 256 44 57', N'', N'', N'test

boşluk

deneme

Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. ')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1030, N'e6f32f77-c537-4687-a677-edc931811f30', N'Kişi', N'FARUK COŞKUN', N'51286157184', N'SELAMİ', N'(532) 287 45 78', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1031, N'865a6d65-2352-42ad-a886-abcf4033f765', N'Kişi', N'TEST', N'43698965254sa', N'', N'(536) 989 98 98', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1032, N'1f5cb1f2-d404-411e-aab0-0f1131deb78c', N'Kişi', N'TEST22', N'436599aeae', N'adasdasd', N'(555) 555 55 55', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1033, N'988c1e06-531c-45c3-81d0-5724b6db1cdc', N'Kişi', N'DENEME123', N'4326998745', N'adsadasd', N'(555) 555 55 55', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1034, N'ca29abac-a5f3-4b09-8400-3c39b7243666', N'Kurum', N'DENEMEKURUM', N'', N'asdasd', N'(558) 899 66 66', N'kadıkoy', N'100', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (1035, N'f0df8ea2-2b1d-49d7-89d4-501833b5ca57', N'Kişi', N'TESETKİŞİ', N'4589665aas', N'sdasddsd', N'(559) 966 99 66', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (2033, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'Kişi', N'CEMAL HAN', N'216458960', N'Üsküdar/*/Kadıköy', N'(216) 521 52 05', N'', N'', N'30.05''de gelecektir.

Kemal Bey''in kardeşi')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (2034, N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'Kişi', N'MURAT ÇIRAK', N'51248789562', N'Burhaniye mah. Çeşmeci Sk No : 25 ( İş Adresi )/*/Elamlıkent mh No : 80 ( Ev Adresi )', N'(216) 541 85 71/*/(532) 256 44 87', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (3034, N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'Kişi', N'ABDURRAHİM BEYTULLAH KOCAKOÇLUOĞULLARI', N'65851025478', N'Topkapı', N'(212) 515 05 80', N'', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (4034, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kurum', N'KARAAY PAZARLAMA LTD. AŞ.', N'', N'Hadımköy/*/Avcılar', N'(212) 345 12 45/*/(212) 345 12 44/*/(212) 345 12 43/*/444 8 123', N'Avcılar', N'85695103541', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [Adresler], [Telefonlar], [VergiDairesi], [VergiNo], [SenetNot]) VALUES (5034, N'66b6de1c-7829-41d8-8506-ffec542910eb', N'Kişi', N'CEMİL KANKAYA', N'21521452548', N'Baakırköy', N'(216) 512 85 31', N'', N'', NULL)
SET IDENTITY_INSERT [dbo].[Iletisim] OFF
SET IDENTITY_INSERT [dbo].[KasaFoyu] ON 

INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (15, N'Giriş', N'Kasa Açılışı', NULL, NULL, -2868, N'TR', N'Kasa Açılışı', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (18, N'Giriş', N'Giriş', N'Çek', NULL, 22, N'TR', N'asdasd', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (19, N'Çıkış', NULL, NULL, NULL, 22, N'TR', N'Test', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (1015, N'Giriş', NULL, NULL, NULL, 5000, N'TR', N'NİYAZİ YILMAZ KİRA GELİRİ', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (1016, N'Giriş', NULL, NULL, NULL, 50, N'TR', N'AHMET', CAST(0xF0390B00 AS Date))
SET IDENTITY_INSERT [dbo].[KasaFoyu] OFF
SET IDENTITY_INSERT [dbo].[KasaFoyuArsiv] ON 

INSERT [dbo].[KasaFoyuArsiv] ([id], [BaslangicTarihi], [BitisTarihi], [ArsivData]) VALUES (1, CAST(0xF0390B00 AS Date), CAST(0xF0390B00 AS Date), N'[
  {
    "id": "9",
    "Tip": "Giriş",
    "AltTip": "Kasa Açılışı",
    "Alt2Tip": "",
    "BaglantiID": "",
    "Miktar": "-8463",
    "ParaBirimi": "TR",
    "Aciklama": "Kasa Açılışı",
    "BaslangicTarihi": "11.5.2015 00:00:00"
  },
  {
    "id": "10",
    "Tip": "Giriş",
    "AltTip": "",
    "Alt2Tip": "",
    "BaglantiID": "",
    "Miktar": "23",
    "ParaBirimi": "TR",
    "Aciklama": "Test",
    "BaslangicTarihi": "11.5.2015 00:00:00"
  }
]')
INSERT [dbo].[KasaFoyuArsiv] ([id], [BaslangicTarihi], [BitisTarihi], [ArsivData]) VALUES (2, CAST(0xF0390B00 AS Date), CAST(0xF0390B00 AS Date), N'[
  {
    "id": "11",
    "Tip": "Giriş",
    "AltTip": "Kasa Açılışı",
    "Alt2Tip": "",
    "BaglantiID": "",
    "Miktar": "-8440",
    "ParaBirimi": "TR",
    "Aciklama": "Kasa Açılışı",
    "BaslangicTarihi": "11.05.2015"
  },
  {
    "id": "12",
    "Tip": "Giriş",
    "AltTip": "",
    "Alt2Tip": "",
    "BaglantiID": "",
    "Miktar": "5584",
    "ParaBirimi": "TR",
    "Aciklama": "Test 2",
    "BaslangicTarihi": "11.05.2015"
  }
]')
INSERT [dbo].[KasaFoyuArsiv] ([id], [BaslangicTarihi], [BitisTarihi], [ArsivData]) VALUES (3, CAST(0xF0390B00 AS Date), CAST(0xF0390B00 AS Date), N'[
  {
    "id": "13",
    "Tip": "Giriş",
    "AltTip": "Kasa Açılışı",
    "Alt2Tip": "",
    "BaglantiID": "",
    "Miktar": "-2856",
    "ParaBirimi": "TR",
    "Aciklama": "Kasa Açılışı",
    "BaslangicTarihi": "11.05.2015"
  },
  {
    "id": "14",
    "Tip": "Çıkış",
    "AltTip": "Kaporta-Boya",
    "Alt2Tip": "",
    "BaglantiID": "",
    "Miktar": "12",
    "ParaBirimi": "TR",
    "Aciklama": "Deneme",
    "BaslangicTarihi": "11.05.2015"
  }
]')
SET IDENTITY_INSERT [dbo].[KasaFoyuArsiv] OFF
SET IDENTITY_INSERT [dbo].[Kullanicilar] ON 

INSERT [dbo].[Kullanicilar] ([id], [username], [password_hash], [email], [phone]) VALUES (1, N'ozan', N'1000:WwI9KBFSfyWly0W056SaGPVNN+WqUbxac5XXE1WN8Tc=:d3BZHZ5gAk0U8EoubymRyl/F77hIM7SUm3Q6EGB+6RY=', N'test', NULL)
INSERT [dbo].[Kullanicilar] ([id], [username], [password_hash], [email], [phone]) VALUES (1002, N'admin', N'1000:HCL6aW14uAwpH02UoOOyjItkEQR0wmZWEFshju65ozo=:klLSzLIJco4RXYSnqhnlKIdhO3aF3XKSVExBgSdks4E=', N'admin@nzl.com', NULL)
SET IDENTITY_INSERT [dbo].[Kullanicilar] OFF
SET IDENTITY_INSERT [dbo].[Maliyetler] ON 

INSERT [dbo].[Maliyetler] ([id], [Arac_ID], [Maliyet_KaportaBoya], [Not_KaportaBoya], [Hesap_KaportaBoya], [Kesim_KaportaBoya], [Maliyet_Yikama], [Not_Yikama], [Hesap_Yikama], [Kesim_Yikama], [Maliyet_Mekanik], [Not_Mekanik], [Hesap_Mekanik], [Kesim_Mekanik], [Maliyet_Diger], [Not_Diger], [Hesap_Diger], [Manuel_Veri], [Manuel_Plaka], [Manuel_Arac]) VALUES (1, N'44a1febe-d43e-4887-a07c-a3797de488b5', N'100', NULL, 1, NULL, N'74', NULL, 1, NULL, N'45', NULL, 1, NULL, NULL, NULL, 0, 0, NULL, NULL)
INSERT [dbo].[Maliyetler] ([id], [Arac_ID], [Maliyet_KaportaBoya], [Not_KaportaBoya], [Hesap_KaportaBoya], [Kesim_KaportaBoya], [Maliyet_Yikama], [Not_Yikama], [Hesap_Yikama], [Kesim_Yikama], [Maliyet_Mekanik], [Not_Mekanik], [Hesap_Mekanik], [Kesim_Mekanik], [Maliyet_Diger], [Not_Diger], [Hesap_Diger], [Manuel_Veri], [Manuel_Plaka], [Manuel_Arac]) VALUES (2, N'd3dc501e-0452-4e9f-9b74-a4106b5caf9d', N'150', N'FALAN DDS', 1, NULL, N'128', NULL, 1, NULL, N'87', NULL, 1, NULL, NULL, NULL, 0, 0, NULL, NULL)
INSERT [dbo].[Maliyetler] ([id], [Arac_ID], [Maliyet_KaportaBoya], [Not_KaportaBoya], [Hesap_KaportaBoya], [Kesim_KaportaBoya], [Maliyet_Yikama], [Not_Yikama], [Hesap_Yikama], [Kesim_Yikama], [Maliyet_Mekanik], [Not_Mekanik], [Hesap_Mekanik], [Kesim_Mekanik], [Maliyet_Diger], [Not_Diger], [Hesap_Diger], [Manuel_Veri], [Manuel_Plaka], [Manuel_Arac]) VALUES (3, N'0', N'50', NULL, 0, NULL, N'45', NULL, 0, NULL, N'', NULL, 0, NULL, N'100', NULL, 0, 1, N'34 RYT 86', N'PEUGEOT 206')
INSERT [dbo].[Maliyetler] ([id], [Arac_ID], [Maliyet_KaportaBoya], [Not_KaportaBoya], [Hesap_KaportaBoya], [Kesim_KaportaBoya], [Maliyet_Yikama], [Not_Yikama], [Hesap_Yikama], [Kesim_Yikama], [Maliyet_Mekanik], [Not_Mekanik], [Hesap_Mekanik], [Kesim_Mekanik], [Maliyet_Diger], [Not_Diger], [Hesap_Diger], [Manuel_Veri], [Manuel_Plaka], [Manuel_Arac]) VALUES (4, N'0', N'', NULL, 0, NULL, N'54', NULL, 0, NULL, N'0', NULL, 0, NULL, NULL, NULL, 0, 1, N'34 abc 123', N'opel astra')
SET IDENTITY_INSERT [dbo].[Maliyetler] OFF
SET IDENTITY_INSERT [dbo].[MaliyetlerArsiv] ON 

INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (1, N'Kaporta-Boya', CAST(0xF0390B00 AS Date), N'[
  {
    "id": "7",
    "Maliyet_Tipi": "Kaporta-Boya",
    "Maliyet_Arac": "6625aba7-bf68-4262-a240-b9909477b5ce",
    "Maliyet_Miktar": "543",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  }
]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (2, N'Kaporta-Boya', CAST(0xF0390B00 AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (3, N'Kaporta-Boya', CAST(0xF0390B00 AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (4, N'Kaporta-Boya', CAST(0xF0390B00 AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (5, N'Kaporta-Boya', CAST(0xF0390B00 AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (6, N'Kaporta-Boya', CAST(0xF0390B00 AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (7, N'Yikama', CAST(0xF0390B00 AS Date), N'[
  {
    "id": "9",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "5168febc-3309-421e-bd28-f70a5eff541e",
    "Maliyet_Miktar": "100",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  },
  {
    "id": "10",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "6625aba7-bf68-4262-a240-b9909477b5ce",
    "Maliyet_Miktar": "100",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  },
  {
    "id": "11",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "98b523be-b579-4e4a-9f48-8ed28dabfdb0",
    "Maliyet_Miktar": "100",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  },
  {
    "id": "12",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "5168febc-3309-421e-bd28-f70a5eff541e",
    "Maliyet_Miktar": "50",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  },
  {
    "id": "13",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "6625aba7-bf68-4262-a240-b9909477b5ce",
    "Maliyet_Miktar": "222",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  },
  {
    "id": "14",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "6625aba7-bf68-4262-a240-b9909477b5ce",
    "Maliyet_Miktar": "232",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  },
  {
    "id": "15",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "6625aba7-bf68-4262-a240-b9909477b5ce",
    "Maliyet_Miktar": "33",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  },
  {
    "id": "16",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "6625aba7-bf68-4262-a240-b9909477b5ce",
    "Maliyet_Miktar": "11",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  },
  {
    "id": "20",
    "Maliyet_Tipi": "Yikama",
    "Maliyet_Arac": "6625aba7-bf68-4262-a240-b9909477b5ce",
    "Maliyet_Miktar": "222",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  }
]')
SET IDENTITY_INSERT [dbo].[MaliyetlerArsiv] OFF
SET IDENTITY_INSERT [dbo].[RiskLimitleri] ON 

INSERT [dbo].[RiskLimitleri] ([id], [ContactUID], [RiskLimit]) VALUES (1, N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', 10000)
INSERT [dbo].[RiskLimitleri] ([id], [ContactUID], [RiskLimit]) VALUES (2, N'94J48G4JDS', 10000)
SET IDENTITY_INSERT [dbo].[RiskLimitleri] OFF
SET IDENTITY_INSERT [dbo].[SenetBloklari] ON 

INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (14, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'035C3569-E611-4A47-B12B-A05C4BB4F89F', N'1', 1850, 1850, CAST(0x463A0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'30 Kasım''da gelecekti, gelemedi.  Yurtdışına çıkmış dönünce gelecek.', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (15, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'76A44758-F00B-4F27-BEE3-F9E4A44951C0', N'2', 1850, 0, CAST(0x653A0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (16, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'63A093B9-B60D-47CD-8763-FAE6260C9760', N'3', 1850, 0, CAST(0x833A0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (17, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'D2EBF99B-62EF-4C2E-AD59-4B5821D1D6AE', N'4', 2300, 0, CAST(0xA23A0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (18, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'EF4B6984-C4EE-4CDD-A296-8765BC33C858', N'5', 2300, 0, CAST(0xC03A0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (19, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'6939AC7C-6962-4BCC-B01C-247BE67C7627', N'6', 2300, 0, CAST(0xDF3A0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (20, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'72326733-D031-4DDC-8D6F-41460230CD8D', N'7', 6000, 0, CAST(0xFE3A0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (21, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'8BF8BA5F-F978-4ED4-97AA-93C27C0C687E', N'8', 1850, 0, CAST(0x1B3B0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (22, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'6DD20181-C783-4276-90A5-975CB15038C5', N'9', 1850, 0, CAST(0x3A3B0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (23, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'74388F55-2D6F-41BD-ACCF-364BF546957F', N'10', 1850, 0, CAST(0x583B0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (24, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'D41EFE0B-49FC-48F5-9130-482C1F27A318', N'11', 3500, 0, CAST(0x773B0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (25, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'53D61EB5-BF15-48E9-A3E0-989D7AE63B3F', N'12', 2400, 0, CAST(0x953B0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (26, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'DA389619-1B1E-476F-93D3-27DE3806CBFC', N'13', 1500, 0, CAST(0xB43B0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (27, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'B2E62D4B-53D7-4CF1-A8C5-4C185EAE195B', N'14', 2850, 0, CAST(0xD33B0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (28, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'0259A4BF-29DE-41B5-9D71-777B60E70667', N'15', 1750, 0, CAST(0xF13B0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (29, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'50AD654A-FE3D-4859-85FB-DE497FC706BD', N'16', 1600, 0, CAST(0x103C0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (30, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'8A36FFF3-25ED-44F5-A537-1FE684E77BA3', N'17', 1500, 0, CAST(0x2E3C0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (31, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'TUĞRUL NAZLI', N'F10763A9-4634-4785-96C7-9539D1F187A6', N'18', 1500, 0, CAST(0x4D3C0B00 AS Date), 3, CAST(0x243A0B00 AS Date), N'İSMAİL KAÇAK İLE KONUŞALACAK', N'', N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (50, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'D610A12B-ED91-4233-9D93-058510723DB9', N'2', 4000, 4000, CAST(0x8D390B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verildi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (51, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'DBDFB0D5-C03A-46C5-AE00-A23CFE6A5ACD', N'3', 4000, 4000, CAST(0xA9390B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verildi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (52, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'5DCA75D1-98ED-440B-8552-76F0BA398C8D', N'4', 4000, 4000, CAST(0xC8390B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verildi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (53, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'D5AD8F43-7062-477D-BACD-7EE8C3CCB729', N'5', 4000, 4000, CAST(0xE6390B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (54, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'B4325A7C-6007-4DC8-BF6D-D98845DE6120', N'6', 4000, 0, CAST(0x053A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (55, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'489E4C07-0E0B-4D57-9D2E-0DE0F7287A86', N'7', 4000, 2500, CAST(0x233A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (56, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'4FA5A2FA-DEF7-4A7C-AE68-291B1E89849C', N'8', 4000, 4000, CAST(0x423A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (57, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'133DBAA4-4E30-4B45-B0A9-32C6CBEA8512', N'9', 4000, 4000, CAST(0x613A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (58, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'047FC35C-B522-42A1-A6EA-12D204D80D81', N'10', 4000, 0, CAST(0x7F3A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (59, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'5F51C1B1-6C2A-40C5-AD15-323C6AA69F69', N'11', 4000, 0, CAST(0x9E3A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (60, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'80E5E78D-2F2A-4554-B04C-3DF725D4D9AB', N'12', 4000, 0, CAST(0xBC3A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (61, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'2FCEC01E-59B2-43B0-B73E-B07B0B463A54', N'13', 4000, 0, CAST(0xDB3A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (62, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'33AC19F3-AFB4-4637-8EBD-D3F11B0A0B7B', N'14', 4000, 0, CAST(0xFA3A0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (63, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'DC6AB4BD-F840-423E-99FF-ED53DAA90874', N'15', 4000, 0, CAST(0x173B0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (74, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'D3826B7F-9F4E-4F93-8647-B3E8DB27518B', N'26', 4000, 0, CAST(0x683C0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (75, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'4FAAB570-5285-47A4-9EDD-DCAA7E3C66C2', N'27', 4000, 0, CAST(0x843C0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (76, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'4244A443-0CE9-41DF-8F00-D7F17CBB365C', N'28', 4000, 0, CAST(0xA33C0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (77, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'3FDA68C7-AB47-4F7F-8D6B-AA65E995DDC7', N'29', 4000, 0, CAST(0xC13C0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (78, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'9A620B42-D495-4F40-A1BE-38D7BD250F70', N'30', 4000, 0, CAST(0xE03C0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (79, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'BA11EF50-AD1A-4146-8468-40396B5ECBA8', N'31', 4000, 0, CAST(0xFE3C0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (85, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'7BC46DB1-0FA6-40FB-9F65-E0FFC1DC869D', N'A:25', 5000, 0, CAST(0x5D3C0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (86, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'DENEME', N'F5920AAE-A477-4266-AC1B-B046EE4F10F9', N'A:32', 1000, 0, CAST(0x273D0B00 AS Date), 4, CAST(0x3A3A0B00 AS Date), N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 


Deneme notu uzun bir not Deneme notu uzun bir not ', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (87, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'ŞİRKET', N'F60A9CC1-6A4C-49C0-A819-3E1F4B3F3760', N'1', 5000, 0, CAST(0x603A0B00 AS Date), 3.5, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (88, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'ŞİRKET', N'68AA0277-5618-468E-BD8E-11578C82EA9D', N'2', 5000, 0, CAST(0x7E3A0B00 AS Date), 3.5, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (89, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'ŞİRKET', N'B6DE527B-6489-4EDA-A70D-8BE632E18FE4', N'3', 5000, 0, CAST(0x9D3A0B00 AS Date), 3.5, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (90, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'ŞİRKET', N'7DA96DCD-3580-43C7-8778-8344567744D2', N'4', 5000, 0, CAST(0xBB3A0B00 AS Date), 3.5, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (91, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'ŞİRKET', N'6DFEFE75-9E7F-48C6-A6DD-8EA1B5E8CEB9', N'5', 5000, 0, CAST(0xDA3A0B00 AS Date), 3.5, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (92, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'ŞİRKET', N'AC55D210-08B0-44A0-846B-AAF9ED9D6590', N'6', 5000, 0, CAST(0xF93A0B00 AS Date), 3.5, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (93, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'ŞİRKET', N'FE960E2C-FE53-4373-A142-E9A471F9A361', N'7', 5000, 0, CAST(0x163B0B00 AS Date), 3.5, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (94, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'ŞİRKET', N'922A3ACC-514C-4DDD-A831-0A7F00F19ED5', N'8', 5000, 0, CAST(0x353B0B00 AS Date), 3.5, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (1087, N'94J48G4JDS', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ŞİRKET', N'5D8B07BC-C76B-404B-BB11-26E3892D3E19', N'1', 1200, 0, CAST(0x603A0B00 AS Date), 2.4, CAST(0x603A0B00 AS Date), N'', N'', N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (1088, N'94J48G4JDS', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ŞİRKET', N'B01FC384-2289-4981-970D-87AD84CC4F8C', N'2', 1200, 0, CAST(0x7E3A0B00 AS Date), 2.4, CAST(0x603A0B00 AS Date), N'', N'', N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (1089, N'94J48G4JDS', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ŞİRKET', N'F1FE4DD9-0437-4CF8-BAD1-9FE87B9C295A', N'3', 1200, 0, CAST(0x9D3A0B00 AS Date), 2.4, CAST(0x603A0B00 AS Date), N'', N'', N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (1090, N'94J48G4JDS', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ŞİRKET', N'EFEDE67F-9700-4CDC-A599-85D3C7675CFA', N'4', 1200, 0, CAST(0xBB3A0B00 AS Date), 2.4, CAST(0x603A0B00 AS Date), N'', N'', N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (1091, N'94J48G4JDS', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ŞİRKET', N'4E39AA2D-1626-4499-8809-65AE3D200CA2', N'5', 1200, 0, CAST(0xDA3A0B00 AS Date), 2.4, CAST(0x603A0B00 AS Date), N'', N'', N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (1092, N'94J48G4JDS', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ŞİRKET', N'62741510-7DF9-48B0-ADF2-8457147F8A51', N'6', 1200, 0, CAST(0xF93A0B00 AS Date), 2.4, CAST(0x603A0B00 AS Date), N'', N'', N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (1093, N'94J48G4JDS', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ŞİRKET', N'C1889089-A41B-49B8-91E8-77C754A6A605', N'7', 1200, 0, CAST(0x163B0B00 AS Date), 2.4, CAST(0x603A0B00 AS Date), N'', N'', N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'Verilmedi')
INSERT [dbo].[SenetBloklari] ([id], [Borclu], [Kefil], [SenetiImzalayan], [SenetBlokID], [AlacakTipi], [SenetID], [SenetBlokNo], [Miktar], [Odenen], [OdemeTarihi], [VadeOrani], [SenetOlusturulmaTarihi], [SenetBlokNot], [SenetNot], [AracPlakasi], [AracBasligi], [SenetKagitiVerildi]) VALUES (1094, N'94J48G4JDS', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ŞİRKET', N'22272094-443A-4BD1-AF26-A4792AE7D078', N'8', 1200, 0, CAST(0x353B0B00 AS Date), 2.4, CAST(0x603A0B00 AS Date), N'', N'', N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'Verilmedi')
SET IDENTITY_INSERT [dbo].[SenetBloklari] OFF
SET IDENTITY_INSERT [dbo].[SenetProfil] ON 

INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (16, N'05d07e93-7205-495a-a0af-ffb5166a8d02')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (14, N'1c011d86-77b9-49c9-9701-4ba68b1c12e8')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (23, N'290f3d6c-ba5b-4633-9576-564aa63ca7a8')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (6, N'2c278c98-bbc6-465c-a4d2-ffe611df885a')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (5, N'36c931c9-e75f-4c85-b6f5-7680bcc66e71')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (20, N'37b2293c-f6cb-48bb-aced-eb46da55fcc2')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (2, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (2003, N'66b6de1c-7829-41d8-8506-ffec542910eb')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (25, N'7a604ac2-10b5-41f9-b6a7-c4be3e15756a')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (11, N'8546374d-41c0-4568-9e9c-905c5a103fba')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (7, N'8be63a09-92f8-442b-99f2-7cde5f545d5f')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (18, N'94J48G4JDS')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (19, N'a9a43d5c-e8ee-4a76-a37c-e287a80a5aff')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (1003, N'ac1efd39-c961-4371-bab1-63d6fb9f31a2')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (24, N'ad3de6c5-7396-4901-b083-09c5bcf2daee')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (22, N'ae0e789f-976a-469b-a043-387da5576811')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (10, N'de42be6a-dc6a-4dcc-8bb6-849bbdb3364d')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (21, N'e144bd22-6879-4609-a370-27abc98cf0c7')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (9, N'e6f32f77-c537-4687-a677-edc931811f30')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (15, N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (13, N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (3, N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (4, N'J3TH8Y94M')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (1, N'J9G40J0GUD')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (12, N'JOEJVENFDV')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (26, N'km23tsj0k2f')
SET IDENTITY_INSERT [dbo].[SenetProfil] OFF
SET IDENTITY_INSERT [dbo].[TadilatBaslik] ON 

INSERT [dbo].[TadilatBaslik] ([id], [Oncelik], [Ad], [Tip], [GorunenAd]) VALUES (2, 0, N'Plaka', N'Varsayilan', N'Plaka')
INSERT [dbo].[TadilatBaslik] ([id], [Oncelik], [Ad], [Tip], [GorunenAd]) VALUES (3, 0, N'Arac_TamAd', N'Varsayilan', N'Araç')
INSERT [dbo].[TadilatBaslik] ([id], [Oncelik], [Ad], [Tip], [GorunenAd]) VALUES (4, 0, N'Arac_Yil', N'Varsayilan', N'Yıl')
INSERT [dbo].[TadilatBaslik] ([id], [Oncelik], [Ad], [Tip], [GorunenAd]) VALUES (5, 0, N'Arac_Renk', N'Varsayilan', N'Renk')
INSERT [dbo].[TadilatBaslik] ([id], [Oncelik], [Ad], [Tip], [GorunenAd]) VALUES (3003, 1, N'Kaporta_Boya_KEMAL_USTA', N'Kaporta-Boya', N'Kaporta-Boya(KEMAL USTA)')
SET IDENTITY_INSERT [dbo].[TadilatBaslik] OFF
SET IDENTITY_INSERT [dbo].[Tadilatlar] ON 

INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (1006, NULL, 1, N'34 AZR 12', N'FORD FOCUS', N'BEYAZ', N'2009', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (1007, NULL, 1, N'34 KSJ 12', N'FORD FOCUS', N'BEYAZ', N'2009', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tadilatlar] OFF
SET IDENTITY_INSERT [dbo].[Vekaletler] ON 

INSERT [dbo].[Vekaletler] ([id], [Vekalet_Uid], [Arac_Uid], [Vekalet_Bitis_Tarihi]) VALUES (1, N'6ac02858-69b3-4307-b77e-e66ec8648f7a', N'6625aba7-bf68-4262-a240-b9909477b5ce', N'12/06/2015')
INSERT [dbo].[Vekaletler] ([id], [Vekalet_Uid], [Arac_Uid], [Vekalet_Bitis_Tarihi]) VALUES (2, N'f324927c-78fd-4929-88de-d8ca3662d9bc', N'4116db32-3c3f-46c6-84d8-d3689f109bc3', N'01/05/2015')
INSERT [dbo].[Vekaletler] ([id], [Vekalet_Uid], [Arac_Uid], [Vekalet_Bitis_Tarihi]) VALUES (3, N'66fe2527-8a23-49bf-a3f4-19601fcb6178', N'a85f3b3d-dc75-44b1-b547-9bab730c8ad8', N'0')
SET IDENTITY_INSERT [dbo].[Vekaletler] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Araclar__830E30F7172E9480]    Script Date: 15.9.2015 17:21:38 ******/
ALTER TABLE [dbo].[Araclar] ADD  CONSTRAINT [UQ__Araclar__830E30F7172E9480] UNIQUE NONCLUSTERED 
(
	[Plaka] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Giderler__60E504D716395583]    Script Date: 15.9.2015 17:21:38 ******/
ALTER TABLE [dbo].[Giderler] ADD  CONSTRAINT [UQ__Giderler__60E504D716395583] UNIQUE NONCLUSTERED 
(
	[GiderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Iletisim__5B18F5F26F30B5C7]    Script Date: 15.9.2015 17:21:38 ******/
ALTER TABLE [dbo].[Iletisim] ADD  CONSTRAINT [UQ__Iletisim__5B18F5F26F30B5C7] UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Unique_Kullanicilar]    Script Date: 15.9.2015 17:21:38 ******/
ALTER TABLE [dbo].[Kullanicilar] ADD  CONSTRAINT [Unique_Kullanicilar] UNIQUE NONCLUSTERED 
(
	[username] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__RiskLimi__867C578E2B2879C1]    Script Date: 15.9.2015 17:21:38 ******/
ALTER TABLE [dbo].[RiskLimitleri] ADD UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_SenetProfil]    Script Date: 15.9.2015 17:21:38 ******/
ALTER TABLE [dbo].[SenetProfil] ADD  CONSTRAINT [IX_SenetProfil] UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Vekaletl__A014CAB62CDFED5F]    Script Date: 15.9.2015 17:21:38 ******/
ALTER TABLE [dbo].[Vekaletler] ADD UNIQUE NONCLUSTERED 
(
	[Vekalet_Uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Vekaletl__D4EF8D43A6D0B4F1]    Script Date: 15.9.2015 17:21:38 ******/
ALTER TABLE [dbo].[Vekaletler] ADD UNIQUE NONCLUSTERED 
(
	[Arac_Uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BOSTEST] ADD  CONSTRAINT [DF_BOSTEST_a3]  DEFAULT (getdate()) FOR [a3]
GO
ALTER TABLE [dbo].[Cek] ADD  CONSTRAINT [DF__Cek__CekID__30C33EC3]  DEFAULT (newid()) FOR [CekID]
GO
ALTER TABLE [dbo].[Cek] ADD  CONSTRAINT [DF_Cek_SistemeKayitTarihi]  DEFAULT (getdate()) FOR [SistemeKayitTarihi]
GO
ALTER TABLE [dbo].[Maliyetler] ADD  DEFAULT ((0)) FOR [Hesap_Diger]
GO
ALTER TABLE [dbo].[SenetBloklari] ADD  CONSTRAINT [DF_SenetBloklari_Odenen]  DEFAULT ((0)) FOR [Odenen]
GO
ALTER TABLE [dbo].[SenetBloklari] ADD  CONSTRAINT [DF__SenetBlok__Senet__36B12243]  DEFAULT (getdate()) FOR [SenetOlusturulmaTarihi]
GO
ALTER TABLE [dbo].[SenetBloklari] ADD  CONSTRAINT [DF_SenetBloklari_SenetKagitiVerildi]  DEFAULT ('Verilmedi') FOR [SenetKagitiVerildi]
GO
ALTER TABLE [dbo].[SenetProfil]  WITH CHECK ADD  CONSTRAINT [FK_SenetProfil_Iletisim] FOREIGN KEY([ContactUID])
REFERENCES [dbo].[Iletisim] ([ContactUID])
GO
ALTER TABLE [dbo].[SenetProfil] CHECK CONSTRAINT [FK_SenetProfil_Iletisim]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 => İçerde/Elde Olan Araçlar | 
		2 => Çıkışı Yapılmış/Satılmış Araçlar | 
		3 => Misafir Araçlar' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Araclar', @level2type=N'COLUMN',@level2name=N'Arac_Durumu'
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
         Begin Table = "RET"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TarihiGecmis"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 474
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AlacakTipineGöreSenetBorclari_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AlacakTipineGöreSenetBorclari_View'
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
         Begin Table = "cekler"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cekalinan"
            Begin Extent = 
               Top = 6
               Left = 278
               Bottom = 102
               Right = 459
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CekArsiv_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CekArsiv_View'
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
         Begin Table = "cekler"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cekalinan"
            Begin Extent = 
               Top = 6
               Left = 278
               Bottom = 102
               Right = 459
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
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 5055
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2505
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CekListesi_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CekListesi_View'
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
         Begin Table = "Iletisim"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 7050
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RiskLimitleri_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RiskLimitleri_View'
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
         Configuration = "(H (1[42] 2[33] 3) )"
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
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "senetler"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "borclu"
            Begin Extent = 
               Top = 6
               Left = 290
               Bottom = 119
               Right = 469
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "kefil"
            Begin Extent = 
               Top = 6
               Left = 766
               Bottom = 119
               Right = 936
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "imzalayan"
            Begin Extent = 
               Top = 6
               Left = 498
               Bottom = 119
               Right = 728
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
      Begin ColumnWidths = 26
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2580
         Width = 2535
         Width = 1500
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SenetBloklari_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SenetBloklari_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SenetBloklari_View'
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
         Begin Table = "Iletisim"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "risk"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
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
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 8445
         Alias = 1770
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 4170
         Or = 1110
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SenetProfil_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SenetProfil_View'
GO
USE [master]
GO
ALTER DATABASE [NazliOtomotiv] SET  READ_WRITE 
GO
