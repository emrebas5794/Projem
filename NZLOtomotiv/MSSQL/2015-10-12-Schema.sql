USE [NazliOtomotiv]
GO
/****** Object:  StoredProcedure [dbo].[Create_Tables]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  UserDefinedFunction [dbo].[CekRiskiHesapla]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  UserDefinedFunction [dbo].[SenetRiskiHesapla]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  UserDefinedFunction [dbo].[ToplamRiskiHesapla]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[Araclar]    Script Date: 12.10.2015 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Araclar](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AddDate] [date] NOT NULL,
	[AracUID] [nvarchar](50) NOT NULL,
	[Plaka] [nvarchar](12) NOT NULL,
	[Marka] [nvarchar](15) NOT NULL,
	[Seri] [nvarchar](15) NOT NULL,
	[Model] [nvarchar](15) NOT NULL,
	[Renk] [nvarchar](15) NOT NULL,
	[Yil] [nvarchar](4) NOT NULL,
	[KM] [int] NOT NULL,
	[YakitTipi] [nvarchar](25) NOT NULL,
	[VitesTipi] [nvarchar](25) NOT NULL,
	[Kapi] [nvarchar](12) NULL,
	[Cekis] [nvarchar](25) NULL,
	[MotorHacmi] [int] NULL,
	[MotorGucu] [int] NULL,
	[MotorNo] [nvarchar](50) NOT NULL,
	[SasiNo] [nvarchar](50) NOT NULL,
	[AlinisTarihi] [date] NOT NULL,
	[AlinisFiyati] [int] NULL,
	[Liste] [nvarchar](15) NOT NULL,
	[Durum] [nvarchar](50) NOT NULL,
	[Opsiyon] [bit] NULL,
	[EtiketFiyati] [int] NULL,
	[RuhsatSahibi] [nvarchar](36) NULL,
	[Satici] [nvarchar](36) NULL,
	[Alici] [nvarchar](50) NULL,
	[Sahit] [nvarchar](50) NULL,
	[Satis_Tarihi] [date] NULL,
	[Satis_Fiyati] [nvarchar](50) NULL,
	[Resmi_Satis_Fiyati] [nvarchar](50) NULL,
	[Noter_Devir_Tarihi] [date] NULL,
	[Cikis_Durumu] [nvarchar](50) NULL,
 CONSTRAINT [PK_Araclar] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Araclar] UNIQUE NONCLUSTERED 
(
	[AracUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BOSTEST]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[Cek]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[CekArsiv]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[Giderler]    Script Date: 12.10.2015 17:14:15 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Giderler__60E504D716395583] UNIQUE NONCLUSTERED 
(
	[GiderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Iletisim]    Script Date: 12.10.2015 17:14:15 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Iletisim__5B18F5F26F30B5C7] UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KasaFoyu]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[KasaFoyuArsiv]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[Kullanicilar]    Script Date: 12.10.2015 17:14:15 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Unique_Kullanicilar] UNIQUE NONCLUSTERED 
(
	[username] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Maliyetler]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[MaliyetlerArsiv]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[RiskLimitleri]    Script Date: 12.10.2015 17:14:15 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SenetBloklari]    Script Date: 12.10.2015 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
 CONSTRAINT [PK_SenetBloklari] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SenetProfil]    Script Date: 12.10.2015 17:14:15 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_SenetProfil] UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TadilatBaslik]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[TadilatKesimler]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[Tadilatlar]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  Table [dbo].[Vekaletler]    Script Date: 12.10.2015 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vekaletler](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[VekaletUID] [nvarchar](50) NOT NULL,
	[AracUID] [nvarchar](50) NOT NULL,
	[VekaletBitisTarihi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Vekaletler] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[VekaletUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[AracUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[RiskLimitleri_View]    Script Date: 12.10.2015 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RiskLimitleri_View]
AS
SELECT        ContactUID, Type, Ad, KimlikNo, VergiDairesi, VergiNo, SenetRiski, CekRiski, ToplamRisk, RiskLimit, RiskLimit - ToplamRisk AS RiskMargin
FROM            (SELECT        ContactUID, Type, Ad, KimlikNo, VergiDairesi, VergiNo, dbo.SenetRiskiHesapla(ContactUID) AS SenetRiski, dbo.CekRiskiHesapla(ContactUID) AS CekRiski, dbo.ToplamRiskiHesapla(ContactUID) 
                                                    AS ToplamRisk,
                                                        (SELECT        RiskLimit
                                                          FROM            dbo.RiskLimitleri
                                                          WHERE        (ContactUID = dbo.Iletisim.ContactUID)) AS RiskLimit
                          FROM            dbo.Iletisim) AS derivedtbl_1

GO
/****** Object:  View [dbo].[SenetProfil_View]    Script Date: 12.10.2015 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SenetProfil_View]
AS
SELECT        dbo.Iletisim.ContactUID, dbo.Iletisim.Type, dbo.Iletisim.Ad, dbo.Iletisim.KimlikNo, dbo.Iletisim.Adresler, dbo.Iletisim.Telefonlar, dbo.Iletisim.VergiDairesi, dbo.Iletisim.VergiNo, dbo.Iletisim.SenetNot, 
                         risk.SenetRiski, risk.CekRiski, risk.ToplamRisk, risk.RiskLimit
FROM            dbo.Iletisim LEFT OUTER JOIN
                             (SELECT        ContactUID, SenetRiski, CekRiski, ToplamRisk, RiskLimit
                               FROM            dbo.RiskLimitleri_View) AS risk ON dbo.Iletisim.ContactUID = risk.ContactUID
WHERE        (dbo.Iletisim.ContactUID IN
                             (SELECT        ContactUID
                               FROM            dbo.SenetProfil))

GO
/****** Object:  View [dbo].[SenetBloklari_View]    Script Date: 12.10.2015 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SenetBloklari_View]
AS
SELECT        senetler.id, senetler.Borclu, senetler.Kefil, senetler.SenetiImzalayan, senetler.SenetBlokID, senetler.AlacakTipi, senetler.SenetID, senetler.SenetBlokNo, senetler.Miktar, senetler.Odenen, senetler.Kalan, 
                         senetler.OdemeTarihi, senetler.VadeOrani, senetler.SenetOlusturulmaTarihi, senetler.SenetBlokNot, senetler.SenetNot, senetler.AracPlakasi, senetler.AracBasligi, borclu.BorcluAdi, borclu.BorcluTelefonlari, 
                         kefil.KefilAdi, kefil.KefilTelefonlari, imzalayan.SenetiImzalayanAdi, imzalayan.SenetiImzalayanTelefonlari
FROM            dbo.SenetBloklari AS senetler LEFT OUTER JOIN
                             (SELECT        Ad AS BorcluAdi, Telefonlar AS BorcluTelefonlari, ContactUID AS BorcluID
                               FROM            dbo.Iletisim) AS borclu ON borclu.BorcluID = senetler.Borclu LEFT OUTER JOIN
                             (SELECT        Ad AS KefilAdi, Telefonlar AS KefilTelefonlari, ContactUID AS KefilID
                               FROM            dbo.Iletisim AS Iletisim_2) AS kefil ON kefil.KefilID = senetler.Kefil LEFT OUTER JOIN
                             (SELECT        Ad AS SenetiImzalayanAdi, Telefonlar AS SenetiImzalayanTelefonlari, ContactUID AS SenetiImzalayanID
                               FROM            dbo.Iletisim AS Iletisim_1) AS imzalayan ON senetler.SenetiImzalayan = imzalayan.SenetiImzalayanID

GO
/****** Object:  View [dbo].[AlacakTipineGoreSenetBorclari_View]    Script Date: 12.10.2015 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AlacakTipineGoreSenetBorclari_View]
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
/****** Object:  UserDefinedFunction [dbo].[RiskleriHesapla]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  View [dbo].[Araclar_View]    Script Date: 12.10.2015 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Araclar_View]
AS
SELECT        dbo.Araclar.id, dbo.Araclar.AddDate, dbo.Araclar.AracUID, dbo.Araclar.Plaka, dbo.Araclar.Marka, dbo.Araclar.Seri, dbo.Araclar.Model, dbo.Araclar.Renk, dbo.Araclar.Yil, dbo.Araclar.KM, dbo.Araclar.YakitTipi, 
                         dbo.Araclar.VitesTipi, dbo.Araclar.Kapi, dbo.Araclar.Cekis, dbo.Araclar.MotorHacmi, dbo.Araclar.MotorGucu, dbo.Araclar.MotorNo, dbo.Araclar.SasiNo, dbo.Araclar.AlinisTarihi, dbo.Araclar.AlinisFiyati, 
                         dbo.Araclar.Liste, dbo.Araclar.Durum, dbo.Araclar.EtiketFiyati, dbo.Araclar.RuhsatSahibi, dbo.Araclar.Satici, dbo.Araclar.Alici, dbo.Araclar.Sahit, dbo.Araclar.Satis_Tarihi, dbo.Araclar.Satis_Fiyati, 
                         dbo.Araclar.Resmi_Satis_Fiyati, dbo.Araclar.Noter_Devir_Tarihi, dbo.Araclar.Cikis_Durumu, ruhsat.RuhsatSahibiAd, ruhsat.RuhsatSahibiType, ruhsat.RuhsatSahibiKimlikNo, ruhsat.RuhsatSahibiAdresler, 
                         ruhsat.RuhsatSahibiTelefon, ruhsat.RuhsatSahibiVergiDairesi, ruhsat.RuhsatSahibiVergiNo, alici.AliciAd, alici.AliciType, alici.AliciKimlikNo, alici.AliciAdres, alici.AliciTelefon, alici.AliciVergiDairesi, 
                         alici.AliciVergiNo, satici.SaticiAd, satici.SaticiType, satici.SaticiKimlikNo, satici.SaticiAdres, satici.SaticiTelefon, satici.SaticiVergiDairesi, satici.SaticiVergiNo, sahit.SahitAd, sahit.SahitType, sahit.SahitKimlikNo, 
                         sahit.SahitAdres, sahit.SahitTelefon, sahit.SahitVergiDairesi, sahit.SahitVergiNo, vekalet.VekaletBitisTarihi, dbo.Araclar.Opsiyon
FROM            dbo.Araclar LEFT OUTER JOIN
                             (SELECT        ContactUID, Ad AS RuhsatSahibiAd, Type AS RuhsatSahibiType, KimlikNo AS RuhsatSahibiKimlikNo, Adresler AS RuhsatSahibiAdresler, Telefonlar AS RuhsatSahibiTelefon, 
                                                         VergiDairesi AS RuhsatSahibiVergiDairesi, VergiNo AS RuhsatSahibiVergiNo
                               FROM            dbo.Iletisim) AS ruhsat ON dbo.Araclar.RuhsatSahibi = ruhsat.ContactUID LEFT OUTER JOIN
                             (SELECT        ContactUID, Ad AS AliciAd, Type AS AliciType, KimlikNo AS AliciKimlikNo, Adresler AS AliciAdres, Telefonlar AS AliciTelefon, VergiDairesi AS AliciVergiDairesi, VergiNo AS AliciVergiNo
                               FROM            dbo.Iletisim AS Iletisim_3) AS alici ON dbo.Araclar.Alici = alici.ContactUID LEFT OUTER JOIN
                             (SELECT        ContactUID, Ad AS SaticiAd, Type AS SaticiType, KimlikNo AS SaticiKimlikNo, Adresler AS SaticiAdres, Telefonlar AS SaticiTelefon, VergiDairesi AS SaticiVergiDairesi, VergiNo AS SaticiVergiNo
                               FROM            dbo.Iletisim AS Iletisim_2) AS satici ON dbo.Araclar.Satici = satici.ContactUID LEFT OUTER JOIN
                             (SELECT        ContactUID, Ad AS SahitAd, Type AS SahitType, KimlikNo AS SahitKimlikNo, Adresler AS SahitAdres, Telefonlar AS SahitTelefon, VergiDairesi AS SahitVergiDairesi, VergiNo AS SahitVergiNo
                               FROM            dbo.Iletisim AS Iletisim_1) AS sahit ON dbo.Araclar.Sahit = sahit.ContactUID LEFT OUTER JOIN
                             (SELECT        AracUID, VekaletBitisTarihi
                               FROM            dbo.Vekaletler) AS vekalet ON dbo.Araclar.AracUID = vekalet.AracUID

GO
/****** Object:  View [dbo].[CekArsiv_View]    Script Date: 12.10.2015 17:14:15 ******/
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
/****** Object:  View [dbo].[CekListesi_View]    Script Date: 12.10.2015 17:14:15 ******/
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
ALTER TABLE [dbo].[Araclar] ADD  CONSTRAINT [DF_Araclar_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO
ALTER TABLE [dbo].[Araclar] ADD  CONSTRAINT [DF_Araclar_Opsiyon]  DEFAULT ((0)) FOR [Opsiyon]
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
ALTER TABLE [dbo].[SenetProfil]  WITH CHECK ADD  CONSTRAINT [FK_SenetProfil_Iletisim] FOREIGN KEY([ContactUID])
REFERENCES [dbo].[Iletisim] ([ContactUID])
GO
ALTER TABLE [dbo].[SenetProfil] CHECK CONSTRAINT [FK_SenetProfil_Iletisim]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 => İçerde/Elde Olan Araçlar | 
		2 => Çıkışı Yapılmış/Satılmış Araçlar | 
		3 => Misafir Araçlar' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Araclar', @level2type=N'COLUMN',@level2name=N'Durum'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AlacakTipineGoreSenetBorclari_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AlacakTipineGoreSenetBorclari_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[31] 2[13] 3) )"
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
         Left = -1
      End
      Begin Tables = 
         Begin Table = "Araclar"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 327
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 18
         End
         Begin Table = "ruhsat"
            Begin Extent = 
               Top = 6
               Left = 255
               Bottom = 136
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "alici"
            Begin Extent = 
               Top = 6
               Left = 512
               Bottom = 136
               Right = 686
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "satici"
            Begin Extent = 
               Top = 6
               Left = 724
               Bottom = 136
               Right = 903
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sahit"
            Begin Extent = 
               Top = 6
               Left = 941
               Bottom = 136
               Right = 1118
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vekalet"
            Begin Extent = 
               Top = 138
               Left = 255
               Bottom = 234
               Right = 434
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
      Begin ColumnWidths = 67
         Width = 284
         Width = 1500
         Width = 1500
         Wid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Araclar_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'th = 1500
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
         Width = 2025
         Width = 2385
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
         Column = 2550
         Alias = 2670
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Araclar_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Araclar_View'
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
         Begin Table = "derivedtbl_1"
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
      Begin ColumnWidths = 12
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
