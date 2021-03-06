USE [NazliOtomotiv]
GO
/****** Object:  StoredProcedure [dbo].[Create_Tables]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  UserDefinedFunction [dbo].[CekRiskiHesapla]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  UserDefinedFunction [dbo].[SenetRiskiHesapla]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  UserDefinedFunction [dbo].[ToplamRiskiHesapla]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[Araclar]    Script Date: 11.11.2015 15:52:43 ******/
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
	[Yil] [int] NOT NULL,
	[KM] [int] NOT NULL,
	[YakitTipi] [nvarchar](25) NOT NULL,
	[VitesTipi] [nvarchar](25) NOT NULL,
	[Kapi] [int] NULL,
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BOSTEST]    Script Date: 11.11.2015 15:52:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOSTEST](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[a1] [nvarchar](50) NULL,
	[a2] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cek]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[CekArsiv]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[Giderler]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[Iletisim]    Script Date: 11.11.2015 15:52:43 ******/
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
	[BirincilTelefon] [nvarchar](20) NULL,
	[Telefonlar] [nvarchar](255) NULL,
	[BirincilAdres] [nvarchar](120) NULL,
	[Adresler] [nvarchar](1200) NULL,
	[VergiDairesi] [nvarchar](50) NULL,
	[VergiNo] [nvarchar](50) NULL,
	[SenetNot] [text] NULL,
	[IletisimNot] [text] NULL,
 CONSTRAINT [PK_Iletisim] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KasaFoyu]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[KasaFoyuArsiv]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[Kullanicilar]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[Maliyetler]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[MaliyetlerArsiv]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[RiskLimitleri]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[SenetBloklari]    Script Date: 11.11.2015 15:52:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SenetBloklari](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AddDate] [datetime] NOT NULL,
	[Borclu] [nvarchar](50) NOT NULL,
	[SenetBlokID] [nvarchar](36) NOT NULL,
	[Kefil] [nvarchar](50) NULL,
	[SenetiImzalayan] [nvarchar](50) NULL,
	[AlacakTipi] [nvarchar](50) NOT NULL,
	[VadeOrani] [float] NOT NULL,
	[AnaPara] [int] NULL,
	[SenetOlusturulmaTarihi] [date] NOT NULL,
	[AracPlakasi] [nvarchar](50) NULL,
	[AracBasligi] [nvarchar](50) NULL,
	[SenetBlokNot] [text] NULL,
	[SenetID] [nvarchar](36) NOT NULL,
	[SenetBlokNo] [nvarchar](12) NOT NULL,
	[OdemeTarihi] [date] NOT NULL,
	[Miktar] [int] NOT NULL,
	[Odenen] [int] NOT NULL,
	[Kalan]  AS ([Miktar]-[Odenen]),
	[SenetNot] [text] NULL,
 CONSTRAINT [PK_SenetBloklari] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SenetProfil]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[TadilatBaslik]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[TadilatKesimler]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[Tadilatlar]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  Table [dbo].[Vekaletler]    Script Date: 11.11.2015 15:52:43 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[RiskLimitleri_View]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  View [dbo].[SenetProfil_View]    Script Date: 11.11.2015 15:52:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SenetProfil_View]
AS
SELECT        dbo.Iletisim.ContactUID, dbo.Iletisim.Type, dbo.Iletisim.Ad, dbo.Iletisim.KimlikNo, dbo.Iletisim.Adresler, dbo.Iletisim.Telefonlar, dbo.Iletisim.VergiDairesi, dbo.Iletisim.VergiNo, dbo.Iletisim.SenetNot, 
                         risk.SenetRiski, risk.CekRiski, risk.ToplamRisk, risk.RiskLimit, dbo.Iletisim.BirincilTelefon, dbo.Iletisim.BirincilAdres
FROM            dbo.Iletisim LEFT OUTER JOIN
                             (SELECT        ContactUID, SenetRiski, CekRiski, ToplamRisk, RiskLimit
                               FROM            dbo.RiskLimitleri_View) AS risk ON dbo.Iletisim.ContactUID = risk.ContactUID
WHERE        (dbo.Iletisim.ContactUID IN
                             (SELECT        ContactUID
                               FROM            dbo.SenetProfil))

GO
/****** Object:  View [dbo].[SenetBloklari_View]    Script Date: 11.11.2015 15:52:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SenetBloklari_View]
AS
SELECT        senetler.id, senetler.Borclu, senetler.Kefil, senetler.SenetiImzalayan, senetler.SenetBlokID, senetler.AlacakTipi, senetler.SenetID, senetler.SenetBlokNo, senetler.Miktar, senetler.Odenen, senetler.Kalan, 
                         senetler.OdemeTarihi, senetler.VadeOrani, senetler.SenetOlusturulmaTarihi, senetler.SenetBlokNot, senetler.SenetNot, senetler.AracPlakasi, senetler.AracBasligi, borclu.BorcluAdi, kefil.KefilAdi, 
                         imzalayan.SenetiImzalayanAdi, borclu.BorcluTelefon, kefil.KefilTelefon, imzalayan.SenetiImzalayanTelefon, borclu.BorcluTelefonlari, kefil.KefilTelefonlari, imzalayan.SenetiImzalayanTelefonlari
FROM            dbo.SenetBloklari AS senetler LEFT OUTER JOIN
                             (SELECT        Ad AS BorcluAdi, BirincilTelefon AS BorcluTelefon, Telefonlar AS BorcluTelefonlari, ContactUID AS BorcluID
                               FROM            dbo.Iletisim) AS borclu ON borclu.BorcluID = senetler.Borclu LEFT OUTER JOIN
                             (SELECT        Ad AS KefilAdi, BirincilTelefon AS KefilTelefon, Telefonlar AS KefilTelefonlari, ContactUID AS KefilID
                               FROM            dbo.Iletisim AS Iletisim_2) AS kefil ON kefil.KefilID = senetler.Kefil LEFT OUTER JOIN
                             (SELECT        Ad AS SenetiImzalayanAdi, BirincilTelefon AS SenetiImzalayanTelefon, Telefonlar AS SenetiImzalayanTelefonlari, ContactUID AS SenetiImzalayanID
                               FROM            dbo.Iletisim AS Iletisim_1) AS imzalayan ON senetler.SenetiImzalayan = imzalayan.SenetiImzalayanID

GO
/****** Object:  View [dbo].[AlacakTipineGoreSenetBorclari_View]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  UserDefinedFunction [dbo].[RiskleriHesapla]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  View [dbo].[Araclar_View]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  View [dbo].[CekArsiv_View]    Script Date: 11.11.2015 15:52:43 ******/
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
/****** Object:  View [dbo].[CekListesi_View]    Script Date: 11.11.2015 15:52:43 ******/
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

INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu]) VALUES (1, CAST(0x883A0B00 AS Date), N'f1b5af03-11e9-4184-8287-a6c094761c00', N'34 KD 184', N'OPEL', N'ASTRA', N'1.6DTİ', N'BEYAZ', 2008, 412000, N'Benzin', N'Manuel', 5, N'ÖNDEN', 1600, 140, N'ERTG23452134', N'TRTG2353235235', CAST(0x883A0B00 AS Date), 29000, N'NZL Oto Listesi', N'Belirsiz', 0, 35000, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu]) VALUES (2, CAST(0x883A0B00 AS Date), N'504fa294-a1a0-46fa-a746-247ab5258cf4', N'34 KD 185', N'OPEL', N'ASTRA', N'1.6DTİ', N'BEYAZ', 2008, 412000, N'Benzin', N'Manuel', 5, N'ÖNDEN', 1600, 140, N'ERTG23452134', N'TRTG2353235235', CAST(0x883A0B00 AS Date), 29000, N'NZL Oto Listesi', N'Belirsiz', 0, 35000, N'94J48G4JDS', N'94J48G4JDS', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu]) VALUES (3, CAST(0x883A0B00 AS Date), N'7e66de3a-d1c7-4281-9980-669dba3c6dae', N'34 KD 186', N'OPEL', N'ASTRA', N'1.6DTİ', N'BEYAZ', 2008, 412000, N'Benzin', N'Manuel', 5, N'ÖNDEN', 1600, 140, N'ERTG23452134', N'TRTG2353235235', CAST(0x96390B00 AS Date), 29000, N'NZL Oto Listesi', N'Belirsiz', 0, 35000, N'94J48G4JDS', N'94J48G4JDS', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu]) VALUES (13, CAST(0x883A0B00 AS Date), N'c260092d-68cd-4eef-b522-dbf5d1c0707a', N'34 KD 187', N'OPEL', N'ASTRA', N'1.6DTİ', N'BEYAZ', 2008, 412000, N'Benzin', N'Manuel', 5, N'ÖNDEN', 1600, 140, N'ERTG23452134', N'TRTG2353235235', CAST(0x803A0B00 AS Date), 29000, N'NZL Oto Listesi', N'Belirsiz', 0, 35000, N'94J48G4JDS', N'94J48G4JDS', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Araclar] OFF
SET IDENTITY_INSERT [dbo].[BOSTEST] ON 

INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (3, N'a', N'0')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (4, N'a', N'1')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (5, N'b', N'1')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (6, N'b', N'1')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (7, N'c', N'1')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (8, N'c', N'1')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (9, N'c', N'1')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (10, N'd', NULL)
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (11, N'd', NULL)
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (12, N'e', N'1')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (13, N'e', N'1')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (14, N'e', N'0')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (15, N'e', N'0')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (16, N'f', N'0')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (17, N'f', N'0')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (18, N'f', N'0')
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (19, N'g', NULL)
INSERT [dbo].[BOSTEST] ([id], [a1], [a2]) VALUES (20, N'h', NULL)
SET IDENTITY_INSERT [dbo].[BOSTEST] OFF
SET IDENTITY_INSERT [dbo].[Cek] ON 

INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (5, N'1F8019C2-B41A-4C5E-B473-E803CB63C447', N'68418965', CAST(0x8B3B0B00 AS Date), 12000, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'Cemal Han', N'Akbank', N'Bakırköy', N'', N'', CAST(0x0000A4E700A1B97A AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (1005, N'774EC7F5-AD97-4919-ABA3-A9FAB379FB4B', N'21684136', CAST(0xE73B0B00 AS Date), 8000, N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'', N'Yapı Kredi', N'Çengelköy', N'', N'', CAST(0x0000A4E70130DE97 AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (2008, N'6A81B585-03F4-423A-9837-15A9C02820A3', N'984584176420', CAST(0xD93A0B00 AS Date), 8000, N'94J48G4JDS', N'', N'İş Bankası', N'Ümraniye', N'', N'', CAST(0x0000A4F100C5837A AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (2017, N'8EB61727-E737-4B4E-9E07-8A7A7C0950DE', N'8215648', CAST(0x493C0B00 AS Date), 24000, N'e144bd22-6879-4609-a370-27abc98cf0c7', N'', N'Akbank', N'Pendik', N'', N'', CAST(0x0000A50700A22E0A AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (4017, N'E8F4E9D6-B750-4C25-8F51-E9CF1025C94A', N'8458941', CAST(0x793A0B00 AS Date), 2600, N'e144bd22-6879-4609-a370-27abc98cf0c7', N'', N'YAPIKREDİ', N'ÜMRANİYE', N'AKBANK BAĞLARBAŞI', N'Deneme', CAST(0x0000A51A0160B598 AS DateTime))
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
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (1015, N'924573BD-61C2-4970-B4F5-CFE957ABE0FD', N'48915164', CAST(0x6C3A0B00 AS Date), 7800, N'km23tsj0k2f', N'TURAP ÜLKÜ', N'YAPI KREDİ', N'KARTAL', N'', N'', CAST(0x0000A51300F8F711 AS DateTime), CAST(0x0000A51A0160EDFA AS DateTime), N'ozan')
SET IDENTITY_INSERT [dbo].[CekArsiv] OFF
SET IDENTITY_INSERT [dbo].[Iletisim] ON 

INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1, N'94J48G4JDS', N'Kişi', N'OZAN ÜLKÜ', N'21431235476', NULL, N'532 324 45 32/*/212 435 12 54', NULL, N'Bahçelievler', NULL, NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (2, N'J9G40J0GUD', N'Kişi', N'TURAP ÜLKÜ', N'21634612564', NULL, N'216 345 1235/*/0531 135 98 32', NULL, N'Göksu Evleri', NULL, NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (3, N'J3TH8Y94M', N'Kişi', N'AHMET KAYA', N'21540583950', NULL, N'312 987 7492', NULL, N'Ankara', NULL, NULL, N'Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; Uzun bir not girdisi '' / * . , ; 

Test', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (4, N'JOEJVENFDV', N'Kişi', N'KEMAL AKBAŞ', N'26438674584', NULL, N'538 324 24 09', NULL, N'Ankara', NULL, NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (11, N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'Kişi', N'CANAN HÜRCAN', N'31425963257', NULL, N'555 214 61 37/*/532 643 75 12/*/212 321 43 54', NULL, N'Üsküdar, İstanbul', NULL, NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (13, N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'Kişi', N'MELEK GÜLPINAR', N'53654825692', NULL, N'544 851 54 95   /*/212 154 85 32', NULL, N'Beylikdüzü, İstanbul', NULL, NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (14, N'37b2293c-f6cb-48bb-aced-eb46da55fcc2', N'Kişi', N'ZAFER KETENCİ', N'23541756743', NULL, N'532 123 65 34/*/538 254 12 89/*/216 435 12 64', NULL, N'Anadolu Hisarı, Kavacık, İstanbul', NULL, NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (15, N'de42be6a-dc6a-4dcc-8bb6-849bbdb3364d', N'Kişi', N'HASAN CEMAL', N'23654573245', NULL, N'545 852 45 98/*/212 458 54 84', NULL, N'Avcılar, İstanbul', NULL, NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (16, N'05d07e93-7205-495a-a0af-ffb5166a8d02', N'Kişi', N'MURAT ERBİL', N'51261367490', NULL, N'532 315 35 90', NULL, N'Çengelköy mahallesi, yalıboyu sokak no:12', NULL, NULL, NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (17, N'km23tsj0k2f', N'Kurum', N'TİARPİ YAZİLİM', NULL, NULL, N'216 232 21 32', NULL, N'Göksu Evleri, Kavacık, İstanbul', N'Üsküdar', N'6346753525', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (18, N'290f3d6c-ba5b-4633-9576-564aa63ca7a8', N'Kurum', N'GÜNAY PAZARLAMA', N'', NULL, N'212 342 12 55/*/212 342 12 54', NULL, N'Şirinevler, İstanbul', N'Kocasinan', N'2153565334', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (21, N'7a604ac2-10b5-41f9-b6a7-c4be3e15756a', N'Kurum', N'SAYAR GÜVENLİK', N'', NULL, N'216 343 12 54', NULL, N'Kadıköy, İstanbul', N'Kadıköy', N'635462365', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (22, N'ad3de6c5-7396-4901-b083-09c5bcf2daee', N'Kurum', N'MASAL BİLİŞİM', N'', NULL, N'', NULL, N'Bağcılar, İstanbul', N'Bağcılar', N'392482379', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (23, N'e144bd22-6879-4609-a370-27abc98cf0c7', N'Kurum', N'BAYAR MİMARLIK', N'', NULL, N'', NULL, N'Beşiktaş, İstanbul', N'Beşiktaş', N'3987823798', N'', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (24, N'8546374d-41c0-4568-9e9c-905c5a103fba', N'Kişi', N'HASAN GELİR', N'5485236547', NULL, N'(212) 454 85 16', NULL, N'İstanbul', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (25, N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'Kişi', N'KERİME HASTAŞLI', N'85648201564', NULL, N'(312) 151 98 56', NULL, N'Ankara', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (26, N'ae0e789f-976a-469b-a043-387da5576811', N'Kurum', N'CANPINAR SU', N'', NULL, N'(216) 849 86 54/*/(216) 549 84 59', NULL, N'Kadıköy', N'Kadıköy', N'24815684651', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1026, N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'Kişi', N'BURAK SELCUK', N'20312569895', N'(053) 216 94 47', N'(455) 555 55 55/*/(212) 165 87 87', NULL, N'necıbbey cad', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1027, N'a9a43d5c-e8ee-4a76-a37c-e287a80a5aff', N'Kişi', N'TUĞRUL NAZLI', N'51286157094', NULL, N'(532) 256 44 57', NULL, N'SELAMİ ALİ MAH', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1028, N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'Kişi', N'BURAK SELÇUK', N'51284787598', NULL, N'(532) 487 85 89', NULL, N'ALTUNİZADE', N'', N'', N'
', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1029, N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'Kişi', N'AHMET ÇALIŞKAN', N'78541285147', N'(212) 189 41 65', N'(532) 256 44 57', N'XRKIJ', N'ABCD', N'', N'', N'test

boşluk

deneme

Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. Uzun bir not girdisi. ', N'Deneme Notu

1 2')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1030, N'e6f32f77-c537-4687-a677-edc931811f30', N'Kişi', N'FARUK COŞKUN', N'51286157184', NULL, N'(532) 287 45 78', NULL, N'SELAMİ', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1031, N'865a6d65-2352-42ad-a886-abcf4033f765', N'Kişi', N'KERİME CANDAN', N'159651841651', N'(536) 989 98 98', N'', N'KAVACIK, İSTANBUL', N'', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1032, N'1f5cb1f2-d404-411e-aab0-0f1131deb78c', N'Kişi', N'TEST22', N'436599aeae', NULL, N'(555) 555 55 55', NULL, N'adasdasd', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1033, N'988c1e06-531c-45c3-81d0-5724b6db1cdc', N'Kişi', N'DEMİR MELEK', N'4326998745', NULL, N'(555) 555 55 55', N'AS', N'A', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1034, N'ca29abac-a5f3-4b09-8400-3c39b7243666', N'Kurum', N'DENEMEKURUM', N'', NULL, N'(558) 899 66 66', NULL, N'asdasd', N'kadıkoy', N'100', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (1035, N'f0df8ea2-2b1d-49d7-89d4-501833b5ca57', N'Kişi', N'MİNE KARAKAŞ', N'124125312314', N'(559) 966 99 66', N'', NULL, N'', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (2033, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'Kişi', N'CEMAL HANLI', N'216458960', NULL, N'(216) 521 52 05', NULL, N'Üsküdar/*/Kadıköy', N'', N'', N'30.05''de gelecektir.

Kemal Bey''in kardeşi', NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (2034, N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'Kişi', N'MURAT ÇIRAK', N'51248789562', NULL, N'(216) 541 85 71/*/(532) 256 44 87', NULL, N'Burhaniye mah. Çeşmeci Sk No : 25 ( İş Adresi )/*/Elamlıkent mh No : 80 ( Ev Adresi )', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (3034, N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'Kişi', N'ABDURRAHİM BEYTULLAH KOCAKOÇLUOĞULLARI', N'65851025478', NULL, N'(212) 515 05 80', NULL, N'Topkapı', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (4034, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kurum', N'KARAAY PAZARLAMA LTD. AŞ.', N'', NULL, N'(212) 345 12 45/*/(212) 345 12 44/*/(212) 345 12 43/*/444 8 123', NULL, N'Hadımköy/*/Avcılar', N'Avcılar', N'85695103541', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (5034, N'66b6de1c-7829-41d8-8506-ffec542910eb', N'Kişi', N'CEMİL KANKAYA', N'21521452548', NULL, N'(216) 512 85 31', NULL, N'Baakırköy', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (5035, N'7be14562-8fcb-4642-934d-6b39f1199f18', N'Kurum', N'CAZ PAZARLAMA', N'', NULL, N'(212) 423 90 38 (141 Dahili)/*/+47 389 98 12/*/(532) 158 69 48/*/(532) 545 12 19/*/(212) 651 65 46', N'ÜMRANİYE', N'ÜMRANİYE', N'ÜMRANİYE', N'23684986531', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (5036, N'afdb6668-a17d-432f-8c9e-3c42c080f200', N'Kişi', N'BURAK SELCUK', N'20312569895', NULL, N'(455) 555 55 55/*/(021) 658 78 75/*/(053) 216 94 47', NULL, N'', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (5037, N'8975f9d4-ba70-4637-965b-ab1d87d3205b', N'Kişi', N'ZEHRA KARTEPE', N'23143531275', N'(212) 516 51 65', N'(212) 516 51 65', N'İSTANBUL', N'İSTANBUL', N'', N'', NULL, NULL)
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (6035, N'5683568c-2fb0-4740-a209-c36f5a4bc398', N'Kişi', N'ÇİĞDEM HASOĞLAN', N'54842019873', N'(532) 458 52 15', N'(532) 458 52 15', N'İSTANBUL', N'İSTANBUL', N'', N'', NULL, N'')
SET IDENTITY_INSERT [dbo].[Iletisim] OFF
SET IDENTITY_INSERT [dbo].[KasaFoyu] ON 

INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (15, N'Giriş', N'Kasa Açılışı', NULL, NULL, -2868, N'TR', N'Kasa Açılışı', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (18, N'Giriş', N'Giriş', N'Çek', NULL, 22, N'TR', N'asdasd', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (19, N'Çıkış', NULL, NULL, NULL, 22, N'TR', N'Test', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (1015, N'Giriş', N'Giriş', N'Senet', NULL, 5000, N'TR', N'NİYAZİ YILMAZ KİRA GELİRİ', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (1016, N'Giriş', N'Giriş', N'Senet', NULL, 50, N'TR', N'AHMET', CAST(0xF0390B00 AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (2015, N'Giriş', N'Giriş', N'Senet', NULL, 1250, N'TR', N'muhittin akça', CAST(0xF0390B00 AS Date))
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
INSERT [dbo].[Kullanicilar] ([id], [username], [password_hash], [email], [phone]) VALUES (1003, N'admin', N'1000:Zyg+FYZJI7K5leomLrAF9SiN6EZwOK87pMGgvSRX0MQ=:ae6wqRG70IAXTBWtXcGjwmCZagsC7v8PUILWWXbXv18=', N'ozan@tiarpi.com', NULL)
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
INSERT [dbo].[RiskLimitleri] ([id], [ContactUID], [RiskLimit]) VALUES (1002, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', 150000)
INSERT [dbo].[RiskLimitleri] ([id], [ContactUID], [RiskLimit]) VALUES (2002, N'J3TH8Y94M', 2000)
SET IDENTITY_INSERT [dbo].[RiskLimitleri] OFF
SET IDENTITY_INSERT [dbo].[SenetBloklari] ON 

INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (14, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'035C3569-E611-4A47-B12B-A05C4BB4F89F', N'1', CAST(0x463A0B00 AS Date), 1850, 1850, N'30 Kasım''da gelecekti, gelemedi.  Yurtdışına çıkmış dönünce gelecek.')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (15, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'76A44758-F00B-4F27-BEE3-F9E4A44951C0', N'2', CAST(0x653A0B00 AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (16, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'63A093B9-B60D-47CD-8763-FAE6260C9760', N'3', CAST(0x833A0B00 AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (17, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'D2EBF99B-62EF-4C2E-AD59-4B5821D1D6AE', N'4', CAST(0xA23A0B00 AS Date), 2300, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (18, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'EF4B6984-C4EE-4CDD-A296-8765BC33C858', N'5', CAST(0xC03A0B00 AS Date), 2300, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (19, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'6939AC7C-6962-4BCC-B01C-247BE67C7627', N'6', CAST(0xDF3A0B00 AS Date), 2300, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (20, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'72326733-D031-4DDC-8D6F-41460230CD8D', N'7', CAST(0xFE3A0B00 AS Date), 6000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (21, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'8BF8BA5F-F978-4ED4-97AA-93C27C0C687E', N'8', CAST(0x1B3B0B00 AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (22, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'6DD20181-C783-4276-90A5-975CB15038C5', N'9', CAST(0x3A3B0B00 AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (23, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'74388F55-2D6F-41BD-ACCF-364BF546957F', N'10', CAST(0x583B0B00 AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (24, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'D41EFE0B-49FC-48F5-9130-482C1F27A318', N'11', CAST(0x773B0B00 AS Date), 3500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (25, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'53D61EB5-BF15-48E9-A3E0-989D7AE63B3F', N'12', CAST(0x953B0B00 AS Date), 2400, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (26, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'DA389619-1B1E-476F-93D3-27DE3806CBFC', N'13', CAST(0xB43B0B00 AS Date), 1500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (27, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'B2E62D4B-53D7-4CF1-A8C5-4C185EAE195B', N'14', CAST(0xD33B0B00 AS Date), 2850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (28, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'0259A4BF-29DE-41B5-9D71-777B60E70667', N'15', CAST(0xF13B0B00 AS Date), 1750, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (29, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'50AD654A-FE3D-4859-85FB-DE497FC706BD', N'16', CAST(0x103C0B00 AS Date), 1600, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (30, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'8A36FFF3-25ED-44F5-A537-1FE684E77BA3', N'17', CAST(0x2E3C0B00 AS Date), 1500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (31, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(0x243A0B00 AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'F10763A9-4634-4785-96C7-9539D1F187A6', N'18', CAST(0x4D3C0B00 AS Date), 1500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (54, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'B4325A7C-6007-4DC8-BF6D-D98845DE6120', N'6', CAST(0x053A0B00 AS Date), 4000, 4000, N'2.000 tl 05/06 wkeıhfo0wıehf weıufy9ıweuohfoıw ıuewyf9ıuwheofuıwhepıfhu weıugf97wıeugfoıwugef9uwgeıufgweıf')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (55, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'489E4C07-0E0B-4D57-9D2E-0DE0F7287A86', N'7', CAST(0x233A0B00 AS Date), 4000, 4000, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (58, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'047FC35C-B522-42A1-A6EA-12D204D80D81', N'10', CAST(0x7F3A0B00 AS Date), 4000, 4000, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (59, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'5F51C1B1-6C2A-40C5-AD15-323C6AA69F69', N'11', CAST(0x9E3A0B00 AS Date), 4000, 4000, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (60, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'80E5E78D-2F2A-4554-B04C-3DF725D4D9AB', N'12', CAST(0xBC3A0B00 AS Date), 4000, 3000, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (61, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'2FCEC01E-59B2-43B0-B73E-B07B0B463A54', N'13', CAST(0xDB3A0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (62, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'33AC19F3-AFB4-4637-8EBD-D3F11B0A0B7B', N'14', CAST(0xFA3A0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (63, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'DC6AB4BD-F840-423E-99FF-ED53DAA90874', N'15', CAST(0x173B0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (74, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'D3826B7F-9F4E-4F93-8647-B3E8DB27518B', N'26', CAST(0x683C0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (75, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'4FAAB570-5285-47A4-9EDD-DCAA7E3C66C2', N'27', CAST(0x843C0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (76, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'4244A443-0CE9-41DF-8F00-D7F17CBB365C', N'28', CAST(0xA33C0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (77, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'3FDA68C7-AB47-4F7F-8D6B-AA65E995DDC7', N'29', CAST(0xC13C0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (78, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'9A620B42-D495-4F40-A1BE-38D7BD250F70', N'30', CAST(0xE03C0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (79, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'BA11EF50-AD1A-4146-8468-40396B5ECBA8', N'31', CAST(0xFE3C0B00 AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (85, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'7BC46DB1-0FA6-40FB-9F65-E0FFC1DC869D', N'A:25', CAST(0x5D3C0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (86, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'F5920AAE-A477-4266-AC1B-B046EE4F10F9', N'A:32', CAST(0x273D0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (87, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'F60A9CC1-6A4C-49C0-A819-3E1F4B3F3760', N'1', CAST(0x603A0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (88, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'68AA0277-5618-468E-BD8E-11578C82EA9D', N'2', CAST(0x7E3A0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (89, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'B6DE527B-6489-4EDA-A70D-8BE632E18FE4', N'3', CAST(0x9D3A0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (90, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'7DA96DCD-3580-43C7-8778-8344567744D2', N'4', CAST(0xBB3A0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (91, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'6DFEFE75-9E7F-48C6-A6DD-8EA1B5E8CEB9', N'5', CAST(0xDA3A0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (92, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'AC55D210-08B0-44A0-846B-AAF9ED9D6590', N'6', CAST(0xF93A0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (93, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'FE960E2C-FE53-4373-A142-E9A471F9A361', N'7', CAST(0x163B0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (94, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'', N'922A3ACC-514C-4DDD-A831-0A7F00F19ED5', N'8', CAST(0x353B0B00 AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1087, CAST(0x0000A540009DF274 AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, NULL, CAST(0x603A0B00 AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'5D8B07BC-C76B-404B-BB11-26E3892D3E19', N'1', CAST(0x603A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1088, CAST(0x0000A540009DF274 AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, NULL, CAST(0x603A0B00 AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'B01FC384-2289-4981-970D-87AD84CC4F8C', N'2', CAST(0x7E3A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1089, CAST(0x0000A540009DF274 AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, NULL, CAST(0x603A0B00 AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'F1FE4DD9-0437-4CF8-BAD1-9FE87B9C295A', N'3', CAST(0x9D3A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1090, CAST(0x0000A540009DF274 AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, NULL, CAST(0x603A0B00 AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'EFEDE67F-9700-4CDC-A599-85D3C7675CFA', N'4', CAST(0xBB3A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1091, CAST(0x0000A540009DF274 AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, NULL, CAST(0x603A0B00 AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'4E39AA2D-1626-4499-8809-65AE3D200CA2', N'5', CAST(0xDA3A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1092, CAST(0x0000A540009DF274 AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, NULL, CAST(0x603A0B00 AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'62741510-7DF9-48B0-ADF2-8457147F8A51', N'6', CAST(0xF93A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1093, CAST(0x0000A540009DF274 AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, NULL, CAST(0x603A0B00 AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'C1889089-A41B-49B8-91E8-77C754A6A605', N'7', CAST(0x163B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1094, CAST(0x0000A540009DF274 AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, NULL, CAST(0x603A0B00 AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'22272094-443A-4BD1-AF26-A4792AE7D078', N'8', CAST(0x353B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1095, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'D1836947-087C-40CA-B8FE-BA4D701099E4', N'1', CAST(0x923A0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1096, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'9493E79A-BDE2-4FA1-8147-ADA0B7DC27C2', N'2', CAST(0xB13A0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1097, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'2F8D5504-D852-49D4-B2EC-CC864402FC01', N'3', CAST(0xCF3A0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1098, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'D27E5588-5082-4636-B49F-FAED9B860A1C', N'4', CAST(0xEE3A0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1099, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'09023AE3-8F26-4FC5-9806-CB7428BE7E21', N'A:4', CAST(0x083B0B00 AS Date), 5000, 0, N'Günü geldiğinde çek vericek')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1100, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'5A811349-236D-4FDB-8CC1-A5BB29F8B87D', N'5', CAST(0x0D3B0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1101, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'F0435216-0F17-44DD-AB47-FF8BC4A083DE', N'6', CAST(0x2A3B0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1102, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'7472B255-1008-4C8E-9E0A-95CAD760F1AD', N'7', CAST(0x493B0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1103, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'03DB896F-8C8C-4E9F-840C-3215F7D05F00', N'8', CAST(0x673B0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1104, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'E47F1ED8-C9BF-46F7-B814-B9637B4320E3', N'9', CAST(0x863B0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1105, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'F0077258-CA35-445B-B346-B98D7EB720D3', N'10', CAST(0xA43B0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1106, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'413D18A4-3E7F-46A5-98F2-3C094B7BB3C7', N'11', CAST(0xC33B0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1107, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'31D06F80-CB2A-45C5-8AC7-0A7B5F775B50', N'12', CAST(0xE23B0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1108, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'E56CB1D9-9706-4A24-9E03-D00D4FD16447', N'13', CAST(0x003C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1109, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'11BB5423-3452-467A-9751-92CD8745E698', N'14', CAST(0x1F3C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1110, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'C501A63A-4BC4-4AA1-BF3A-68FEB2C6BF4C', N'15', CAST(0x3D3C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1111, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'1E003674-42E0-4FAB-83D4-D1C1D547DB83', N'16', CAST(0x5C3C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1112, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'0EA7B511-F012-4161-8C3A-11C31F830AFD', N'17', CAST(0x7B3C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1113, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'BD9DC5B8-F49A-41E0-B153-5796F48742C5', N'18', CAST(0x973C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1114, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'D6B291A3-4A43-436D-AB47-86A799BC33F1', N'19', CAST(0xB63C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1115, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'ADA43EA5-3B8B-4B9B-9D09-7FE27976B88B', N'20', CAST(0xD43C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1116, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'F229765F-9EA4-4B7C-9C16-4CBB458C6EE1', N'21', CAST(0xF33C0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1117, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'CA8CD5BE-E2B7-49EA-AD3F-0026EAFB602B', N'22', CAST(0x113D0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1118, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'050F0E04-0135-4968-A319-6F6DA72402CB', N'23', CAST(0x303D0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1119, CAST(0x0000A540009DF274 AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, NULL, CAST(0x7F3A0B00 AS Date), N'34 KSD 98', N'MERCEDES', N'', N'5FEA4A00-003A-4078-99E0-B6ACAA066B53', N'24', CAST(0x4F3D0B00 AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2095, CAST(0x0000A540009DF274 AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, NULL, CAST(0x3A3A0B00 AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'C12AEF25-BF18-497B-9402-B64020D25956', N'A:6', CAST(0x92390B00 AS Date), 12000, 5000, N'grer')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2097, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'2EBD51A7-E0F8-4D95-AA0E-D1F0BACCDD39', N'1', CAST(0x9C3A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2098, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'FC16F8D1-52C8-436B-8549-2A92E69806F5', N'2', CAST(0xBB3A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2099, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'E76E7945-2E93-4F89-B9E1-A9D8609A6DA7', N'3', CAST(0xD93A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2100, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'DB7695DF-864B-46A5-9765-B7BEC2E33031', N'4', CAST(0xF83A0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2101, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'BBF50DAD-FBE9-42E4-9631-492472AC5409', N'5', CAST(0x163B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2102, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'EC6C37B6-9BCD-433E-9AE3-FD1BDC25DE84', N'6', CAST(0x343B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2103, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'F520C69B-3A3D-482D-8240-C96456FB271C', N'7', CAST(0x533B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2104, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'04EB0496-A3B5-4469-9C80-8853DC4B637B', N'8', CAST(0x713B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2105, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'0CC7CC88-02B2-4DE0-8F4D-1764D922604E', N'55', CAST(0x713B0B00 AS Date), 800, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2106, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'FFFD26F3-DDBD-4DAF-A266-2E7F26002E74', N'9', CAST(0x903B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2107, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'9AE1C335-446A-4E16-A8C6-B0B114541B26', N'10', CAST(0xAE3B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2108, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'5825F091-D903-4C1D-A1B6-AF3D4D0FDA69', N'11', CAST(0xCD3B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2109, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'4EEE0946-9563-4C23-8A64-3DE7EE552C48', N'12', CAST(0xEC3B0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2110, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'8AC614BC-E962-45EF-9140-D7D4FE24E4F9', N'13', CAST(0x0A3C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2111, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'3458942B-2C05-40C1-95AC-66402A965177', N'14', CAST(0x293C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2112, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'C71718D3-D43F-483A-9C89-7579A8B4197E', N'15', CAST(0x473C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2113, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'0221A423-01D5-437C-AA65-9E2BCFB16727', N'16', CAST(0x663C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2114, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'A9C1C488-8ED5-4CC6-8050-D7049C61AA7E', N'17', CAST(0x833C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2115, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'718C854E-56E7-4D3C-8F2D-1555EC818A0C', N'18', CAST(0xA13C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2116, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'3F52D8DA-CEDD-4089-9B8D-62BB68EE7460', N'19', CAST(0xC03C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2117, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'2517C592-186D-4BF7-810A-2DF441C2A011', N'20', CAST(0xDE3C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2118, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'5B22C400-1E62-4D03-857C-A7C9AEC9B711', N'21', CAST(0xFD3C0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2119, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'14D37AFE-9BC9-454B-8FC3-C6D8F539F506', N'22', CAST(0x1B3D0B00 AS Date), 1200, 0, N'')
GO
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2120, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'C513482B-B704-4224-8D94-E0346E1684CA', N'23', CAST(0x3A3D0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2121, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'845CA240-C933-4CB3-BFD7-218B3B233544', N'24', CAST(0x593D0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2122, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'D3B0E763-0EA7-4AAE-BDF8-C8652E483BEC', N'25', CAST(0x773D0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2123, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'2BE2C397-B41F-48E0-9E9F-3B0757E58828', N'26', CAST(0x963D0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2124, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'E7FEB8F7-6B74-4E58-B58A-666147B8A62E', N'27', CAST(0xB43D0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2125, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'0DB87E07-7489-4A85-84D3-9A6EA2183791', N'28', CAST(0xD33D0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2126, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'751F4F8A-0AD2-4ED5-AB51-0797382A7680', N'29', CAST(0xF03D0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2127, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'F130462B-321B-482A-AF07-114C69045F8C', N'30', CAST(0x0E3E0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2128, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'64DA7FF1-BCA2-435E-9ECA-01C340E33E88', N'31', CAST(0x2D3E0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2129, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'DC79EBB9-DC7F-4726-A444-073993D8B1EC', N'32', CAST(0x4B3E0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2130, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'41E324EB-DBC8-4445-930D-7B237C690D69', N'33', CAST(0x6A3E0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2131, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'392AEFED-D71B-423E-B0FE-D122A5D1C7D8', N'34', CAST(0x883E0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2132, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'E09CD622-5A80-44D5-9C1E-80D4576D05D1', N'35', CAST(0xA73E0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2133, CAST(0x0000A54000E17DF5 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'E8997950-12C2-41A6-ADDC-6718870F7CBD', N'36', CAST(0xC63E0B00 AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2136, CAST(0x0000A540010173E3 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, NULL, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'DFE9AA6D-DB28-4CAE-A5FE-A8E007ED173A', N'Ara Senet', CAST(0x9E3A0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2137, CAST(0x0000A540010173E3 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, NULL, CAST(0x9B3A0B00 AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'D4B2BCA2-69F0-4445-9E15-FBAEFF370A2F', N'Ara Senet', CAST(0xC73E0B00 AS Date), 3000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3096, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'282F3841-467F-437B-8299-59E92AE3EC9A', N'1', CAST(0x013C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3097, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'D9B5349B-9D2F-4FA3-AE85-3DA660FC6CCA', N'2', CAST(0x203C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3098, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'1BC55F00-2C99-4A27-918B-A8C840F6186D', N'3', CAST(0x3E3C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3099, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'CF07F3EE-43BB-4C77-9253-C9F23C9DBCDA', N'4', CAST(0x5D3C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3100, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'B348360D-0CCA-4741-8DE2-D3D571E39C6A', N'5', CAST(0x7C3C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3101, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'7B707DD2-089C-4A32-8076-3D2FE1EA4374', N'6', CAST(0x983C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3102, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'DFB0F110-9ADF-424E-8244-91A70079AD51', N'7', CAST(0xB73C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3103, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'64E5DAEB-7403-4CC5-9166-182B5582E025', N'8', CAST(0xD53C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3104, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'5A26D1D9-FE35-4414-8031-26E3BBCBF1CF', N'9', CAST(0xF43C0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3105, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'F04498DA-644D-485B-815B-60DB80667BD1', N'10', CAST(0x123D0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3106, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'2305C5E5-6BFD-421A-951A-66B5F282CDA9', N'11', CAST(0x313D0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3107, CAST(0x0000A54B015B1D59 AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(0xA63A0B00 AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'313372B9-0E51-4464-9DCD-7ED6FAB5BC0D', N'15', CAST(0x503D0B00 AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3108, CAST(0x0000A54C00FE3263 AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(0xA73A0B00 AS Date), N'', N'', N'', N'8385F278-1430-48B0-81E2-3E73BE1D00BF', N'1', CAST(0x9C3A0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3109, CAST(0x0000A54C00FE3263 AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(0xA73A0B00 AS Date), N'', N'', N'', N'706F0514-7997-4037-B52D-2CE46A9837D8', N'2', CAST(0xBB3A0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3110, CAST(0x0000A54C00FE3263 AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(0xA73A0B00 AS Date), N'', N'', N'', N'456FA979-F5F1-4437-A2D4-44201BABFD43', N'3', CAST(0xD93A0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3111, CAST(0x0000A54C00FE3263 AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(0xA73A0B00 AS Date), N'', N'', N'', N'7900D7DE-09BC-4AF9-ADDD-A9B44CE270F3', N'4', CAST(0xF83A0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3112, CAST(0x0000A54C00FE3263 AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(0xA73A0B00 AS Date), N'', N'', N'', N'DC37598F-A545-46CF-8FCC-92E087AF0517', N'5', CAST(0x163B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3113, CAST(0x0000A54C00FE3263 AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(0xA73A0B00 AS Date), N'', N'', N'', N'81E069F5-3476-4E00-9B27-9632B49D4D47', N'6', CAST(0x343B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3114, CAST(0x0000A54C00FE3263 AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(0xA73A0B00 AS Date), N'', N'', N'', N'4DD6FFA5-3458-44DB-8932-5590180D68B5', N'7', CAST(0x533B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3115, CAST(0x0000A54C00FE3263 AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(0xA73A0B00 AS Date), N'', N'', N'', N'3DA4CE8F-BBF2-42A0-8A2A-DF72D8D32B9F', N'8', CAST(0x713B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3116, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'A1459524-AAC4-4DE6-8DE9-53801D5FD419', N'0', CAST(0xBB3A0B00 AS Date), 500, 500, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3117, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'E558EDDD-DE20-428D-B1A4-A0C6E74A8666', N'1', CAST(0xBB3A0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3118, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'C1E92FB5-75B3-4C32-9D5E-E1FFCE3DF783', N'2', CAST(0xD93A0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3119, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'BC10DE13-730F-440C-810A-7C879B21B613', N'3', CAST(0xF83A0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3120, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'3C9D028E-AC06-4C47-9FB4-AC8CD0DC4C0F', N'Ara Senet', CAST(0xF83A0B00 AS Date), 1500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3121, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'F256A202-A18D-4841-A3F3-07EB95BC0090', N'4', CAST(0x163B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3122, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'17B4FED1-8C06-4F5A-9EFC-C49AB6299F38', N'5', CAST(0x343B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3123, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'DF6E5268-CDA2-4279-B54D-DE4317F108B4', N'6', CAST(0x533B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3124, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'D2BAD442-79B9-4680-8E44-529D2DB86B52', N'7', CAST(0x713B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3125, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'6DA836FA-D32C-4FDC-AB99-6C4AC67448C2', N'8', CAST(0x903B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3126, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'14D88972-2824-4511-91C4-D0654016316F', N'9', CAST(0xAE3B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3127, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'CE6E6FEE-2349-45BB-A1D0-3A8D22B229B0', N'10', CAST(0xCD3B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3128, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'BAE419FC-40E1-40D3-AB3C-86493F4E4A3C', N'11', CAST(0xEC3B0B00 AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3129, CAST(0x0000A54D010157FB AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(0xA83A0B00 AS Date), N'', N'', N'', N'C048030B-DA41-4C9F-8010-32C7419B1C70', N'12', CAST(0x0A3C0B00 AS Date), 1000, 0, N'')
SET IDENTITY_INSERT [dbo].[SenetBloklari] OFF
SET IDENTITY_INSERT [dbo].[SenetProfil] ON 

INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (16, N'05d07e93-7205-495a-a0af-ffb5166a8d02')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (14, N'1c011d86-77b9-49c9-9701-4ba68b1c12e8')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (23, N'290f3d6c-ba5b-4633-9576-564aa63ca7a8')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (6, N'2c278c98-bbc6-465c-a4d2-ffe611df885a')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (5, N'36c931c9-e75f-4c85-b6f5-7680bcc66e71')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (20, N'37b2293c-f6cb-48bb-aced-eb46da55fcc2')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (5005, N'5683568c-2fb0-4740-a209-c36f5a4bc398')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (3011, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (2003, N'66b6de1c-7829-41d8-8506-ffec542910eb')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (25, N'7a604ac2-10b5-41f9-b6a7-c4be3e15756a')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (11, N'8546374d-41c0-4568-9e9c-905c5a103fba')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (7, N'8be63a09-92f8-442b-99f2-7cde5f545d5f')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (18, N'94J48G4JDS')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (19, N'a9a43d5c-e8ee-4a76-a37c-e287a80a5aff')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (3010, N'ac1efd39-c961-4371-bab1-63d6fb9f31a2')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (24, N'ad3de6c5-7396-4901-b083-09c5bcf2daee')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (22, N'ae0e789f-976a-469b-a043-387da5576811')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (10, N'de42be6a-dc6a-4dcc-8bb6-849bbdb3364d')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (4005, N'e144bd22-6879-4609-a370-27abc98cf0c7')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (9, N'e6f32f77-c537-4687-a677-edc931811f30')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (15, N'e77b55b8-59fb-48bd-ba53-db0c0c8b27cf')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (13, N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (3009, N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (4, N'J3TH8Y94M')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (1, N'J9G40J0GUD')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (12, N'JOEJVENFDV')
INSERT [dbo].[SenetProfil] ([id], [ContactUID]) VALUES (26, N'km23tsj0k2f')
SET IDENTITY_INSERT [dbo].[SenetProfil] OFF
SET IDENTITY_INSERT [dbo].[Tadilatlar] ON 

INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (1, N'f1b5af03-11e9-4184-8287-a6c094761c00', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (2, N'504fa294-a1a0-46fa-a746-247ab5258cf4', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (3, N'7e66de3a-d1c7-4281-9980-669dba3c6dae', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (4, N'c5982ce0-44b3-4f82-b036-07070caaeafa', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (5, N'1ff80cd0-6e15-480e-ab7a-498ed6b5f491', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (6, N'c88410a5-09bb-4a54-8a90-1fcb03d54932', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (7, N'387bf54b-f5f3-42f2-b547-9cd1f91db209', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (8, N'2132b287-508d-4110-82e8-d56e1091cb9d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (9, N'340c947b-96f2-4a6d-b79e-cb2d2c69cca0', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (10, N'0069a4b4-4b88-4b75-aa3c-52b0cb9e4273', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (11, N'3c7e0834-73df-4d6b-9aa5-888edeeb2057', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (12, N'c1d08421-8d25-4a26-8c20-4d8b6660e1e6', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (13, N'c260092d-68cd-4eef-b522-dbf5d1c0707a', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tadilatlar] OFF
SET IDENTITY_INSERT [dbo].[Vekaletler] ON 

INSERT [dbo].[Vekaletler] ([id], [VekaletUID], [AracUID], [VekaletBitisTarihi]) VALUES (1, N'6ac02858-69b3-4307-b77e-e66ec8648f7a', N'6625aba7-bf68-4262-a240-b9909477b5ce', N'12/06/2015')
INSERT [dbo].[Vekaletler] ([id], [VekaletUID], [AracUID], [VekaletBitisTarihi]) VALUES (2, N'f324927c-78fd-4929-88de-d8ca3662d9bc', N'4116db32-3c3f-46c6-84d8-d3689f109bc3', N'01/05/2015')
INSERT [dbo].[Vekaletler] ([id], [VekaletUID], [AracUID], [VekaletBitisTarihi]) VALUES (3, N'66fe2527-8a23-49bf-a3f4-19601fcb6178', N'a85f3b3d-dc75-44b1-b547-9bab730c8ad8', N'0')
SET IDENTITY_INSERT [dbo].[Vekaletler] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Araclar]    Script Date: 11.11.2015 15:52:43 ******/
ALTER TABLE [dbo].[Araclar] ADD  CONSTRAINT [IX_Araclar] UNIQUE NONCLUSTERED 
(
	[AracUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Giderler__60E504D716395583]    Script Date: 11.11.2015 15:52:43 ******/
ALTER TABLE [dbo].[Giderler] ADD  CONSTRAINT [UQ__Giderler__60E504D716395583] UNIQUE NONCLUSTERED 
(
	[GiderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Iletisim__5B18F5F26F30B5C7]    Script Date: 11.11.2015 15:52:43 ******/
ALTER TABLE [dbo].[Iletisim] ADD  CONSTRAINT [UQ__Iletisim__5B18F5F26F30B5C7] UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Unique_Kullanicilar]    Script Date: 11.11.2015 15:52:43 ******/
ALTER TABLE [dbo].[Kullanicilar] ADD  CONSTRAINT [Unique_Kullanicilar] UNIQUE NONCLUSTERED 
(
	[username] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__RiskLimi__867C578E2B2879C1]    Script Date: 11.11.2015 15:52:43 ******/
ALTER TABLE [dbo].[RiskLimitleri] ADD UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_SenetProfil]    Script Date: 11.11.2015 15:52:43 ******/
ALTER TABLE [dbo].[SenetProfil] ADD  CONSTRAINT [IX_SenetProfil] UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Vekaletl__A014CAB62CDFED5F]    Script Date: 11.11.2015 15:52:43 ******/
ALTER TABLE [dbo].[Vekaletler] ADD UNIQUE NONCLUSTERED 
(
	[VekaletUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Vekaletl__D4EF8D43A6D0B4F1]    Script Date: 11.11.2015 15:52:43 ******/
ALTER TABLE [dbo].[Vekaletler] ADD UNIQUE NONCLUSTERED 
(
	[AracUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Araclar] ADD  CONSTRAINT [DF_Araclar_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO
ALTER TABLE [dbo].[Araclar] ADD  CONSTRAINT [DF_Araclar_Opsiyon]  DEFAULT ((0)) FOR [Opsiyon]
GO
ALTER TABLE [dbo].[Cek] ADD  CONSTRAINT [DF__Cek__CekID__30C33EC3]  DEFAULT (newid()) FOR [CekID]
GO
ALTER TABLE [dbo].[Cek] ADD  CONSTRAINT [DF_Cek_SistemeKayitTarihi]  DEFAULT (getdate()) FOR [SistemeKayitTarihi]
GO
ALTER TABLE [dbo].[Maliyetler] ADD  DEFAULT ((0)) FOR [Hesap_Diger]
GO
ALTER TABLE [dbo].[SenetBloklari] ADD  CONSTRAINT [DF_SenetBloklari_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO
ALTER TABLE [dbo].[SenetBloklari] ADD  CONSTRAINT [DF__SenetBlok__Senet__36B12243]  DEFAULT (getdate()) FOR [SenetOlusturulmaTarihi]
GO
ALTER TABLE [dbo].[SenetBloklari] ADD  CONSTRAINT [DF_SenetBloklari_SenetID]  DEFAULT (newid()) FOR [SenetID]
GO
ALTER TABLE [dbo].[SenetBloklari] ADD  CONSTRAINT [DF_SenetBloklari_Odenen]  DEFAULT ((0)) FOR [Odenen]
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
         Configuration = "(H (1[52] 2[23] 3) )"
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
               Bottom = 419
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "borclu"
            Begin Extent = 
               Top = 6
               Left = 290
               Bottom = 136
               Right = 469
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "kefil"
            Begin Extent = 
               Top = 6
               Left = 507
               Bottom = 136
               Right = 677
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "imzalayan"
            Begin Extent = 
               Top = 6
               Left = 715
               Bottom = 136
               Right = 945
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
      Begin ColumnWidths = 28
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Width = 1500
         Width = 1500
      End
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
               Bottom = 327
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
