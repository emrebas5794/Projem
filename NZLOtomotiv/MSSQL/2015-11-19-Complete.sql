USE [NazliOtomotiv]
GO
/****** Object:  UserDefinedFunction [dbo].[CekRiskiHesapla]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  UserDefinedFunction [dbo].[SenetRiskiHesapla]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  UserDefinedFunction [dbo].[ToplamRiskiHesapla]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[Araclar]    Script Date: 19.11.2015 17:34:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Araclar](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AddDate] [date] NOT NULL CONSTRAINT [DF_Araclar_AddDate]  DEFAULT (getdate()),
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
	[Opsiyon] [bit] NULL CONSTRAINT [DF_Araclar_Opsiyon]  DEFAULT ((0)),
	[OpsiyonTarihi] [datetime] NULL,
	[OpsiyonKoyan] [nvarchar](50) NULL,
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
	[ResmiAlınanKisi] [nvarchar](50) NULL,
	[ResmiAlınanTipi] [nvarchar](50) NULL,
	[NoterAlisTarihi] [date] NULL,
	[ResmiGirisBedeli] [int] NULL,
	[ResmiCikisTarihi] [datetime] NULL,
	[ResmiCikisBedeli] [int] NULL,
	[ResmiCikisKisi] [nvarchar](50) NULL,
	[YedekAnahtar] [nvarchar](50) NULL,
	[YedekAnahtarVerildimi] [nvarchar](50) NULL,
	[AracMuayeneBitisTarihi] [date] NULL,
 CONSTRAINT [PK_Araclar] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BOSTEST]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[Cek]    Script Date: 19.11.2015 17:34:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cek](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CekID] [nvarchar](36) NOT NULL CONSTRAINT [DF__Cek__CekID__30C33EC3]  DEFAULT (newid()),
	[CekNo] [varchar](12) NOT NULL,
	[Tarih] [date] NOT NULL,
	[Miktar] [int] NOT NULL,
	[CekAlinanKisi] [nvarchar](36) NOT NULL,
	[CekAsilSahibi] [nvarchar](50) NOT NULL,
	[Banka] [nvarchar](50) NOT NULL,
	[BankaSubesi] [nvarchar](50) NOT NULL,
	[TakastaOlduguHesap] [nvarchar](50) NULL,
	[CekNot] [text] NULL,
	[SistemeKayitTarihi] [datetime] NOT NULL CONSTRAINT [DF_Cek_SistemeKayitTarihi]  DEFAULT (getdate()),
 CONSTRAINT [PK_Cek] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CekArsiv]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[GenelRisk]    Script Date: 19.11.2015 17:34:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenelRisk](
	[Limit] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Giderler]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[Iletisim]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[KasaFoyu]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[KasaFoyuArsiv]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[Kullanicilar]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[Maliyetler]    Script Date: 19.11.2015 17:34:49 ******/
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
	[Hesap_Diger] [bit] NULL DEFAULT ((0)),
	[Manuel_Veri] [bit] NOT NULL,
	[Manuel_Plaka] [nvarchar](50) NULL,
	[Manuel_Arac] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaliyetlerArsiv]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[RiskLimitleri]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[SenetBloklari]    Script Date: 19.11.2015 17:34:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SenetBloklari](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_SenetBloklari_AddDate]  DEFAULT (getdate()),
	[Borclu] [nvarchar](50) NOT NULL,
	[SenetBlokID] [nvarchar](36) NOT NULL,
	[Kefil] [nvarchar](50) NULL,
	[SenetiImzalayan] [nvarchar](50) NULL,
	[AlacakTipi] [nvarchar](50) NOT NULL,
	[VadeOrani] [float] NOT NULL,
	[AnaPara] [int] NULL,
	[SenetOlusturulmaTarihi] [date] NOT NULL CONSTRAINT [DF__SenetBlok__Senet__36B12243]  DEFAULT (getdate()),
	[AracPlakasi] [nvarchar](50) NULL,
	[AracBasligi] [nvarchar](50) NULL,
	[SenetBlokNot] [text] NULL,
	[SenetID] [nvarchar](36) NOT NULL CONSTRAINT [DF_SenetBloklari_SenetID]  DEFAULT (newid()),
	[SenetBlokNo] [nvarchar](12) NOT NULL,
	[OdemeTarihi] [date] NOT NULL,
	[Miktar] [int] NOT NULL,
	[Odenen] [int] NOT NULL CONSTRAINT [DF_SenetBloklari_Odenen]  DEFAULT ((0)),
	[Kalan]  AS ([Miktar]-[Odenen]),
	[SenetNot] [text] NULL,
 CONSTRAINT [PK_SenetBloklari] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SenetProfil]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[TadilatBaslik]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[TadilatKesimler]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[Tadilatlar]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  Table [dbo].[Vekaletler]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  View [dbo].[RiskLimitleri_View]    Script Date: 19.11.2015 17:34:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RiskLimitleri_View]
AS
SELECT        ContactUID, Type, Ad, KimlikNo, VergiDairesi, VergiNo, SenetRiski, CekRiski, ToplamRisk, CASE WHEN RiskLimit IS NULL THEN
                             (SELECT        Limit
                               FROM            GenelRisk) ELSE RiskLimit END AS RiskLimit, RiskLimit - ToplamRisk AS RiskMargin
FROM            (SELECT        ContactUID, Type, Ad, KimlikNo, VergiDairesi, VergiNo, dbo.SenetRiskiHesapla(ContactUID) AS SenetRiski, dbo.CekRiskiHesapla(ContactUID) AS CekRiski, dbo.ToplamRiskiHesapla(ContactUID) 
                                                    AS ToplamRisk,
                                                        (SELECT        RiskLimit
                                                          FROM            dbo.RiskLimitleri
                                                          WHERE        (ContactUID = dbo.Iletisim.ContactUID)) AS RiskLimit
                          FROM            dbo.Iletisim) AS derivedtbl_1

GO
/****** Object:  View [dbo].[SenetProfil_View]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  View [dbo].[SenetBloklari_View]    Script Date: 19.11.2015 17:34:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SenetBloklari_View]
AS
SELECT        senetler.id, senetler.Borclu, senetler.Kefil, senetler.SenetiImzalayan, senetler.SenetBlokID, senetler.AlacakTipi, senetler.SenetID, senetler.SenetBlokNo, senetler.Miktar, senetler.Odenen, senetler.Kalan, 
                         senetler.OdemeTarihi, senetler.VadeOrani, senetler.SenetOlusturulmaTarihi, senetler.SenetBlokNot, senetler.SenetNot, senetler.AracPlakasi, senetler.AracBasligi, borclu.BorcluAdi, kefil.KefilAdi, 
                         imzalayan.SenetiImzalayanAdi, borclu.BorcluTelefon, kefil.KefilTelefon, imzalayan.SenetiImzalayanTelefon, borclu.BorcluTelefonlari, kefil.KefilTelefonlari, imzalayan.SenetiImzalayanTelefonlari, 
                         senetler.AnaPara, senetler.AddDate
FROM            dbo.SenetBloklari AS senetler LEFT OUTER JOIN
                             (SELECT        Ad AS BorcluAdi, BirincilTelefon AS BorcluTelefon, Telefonlar AS BorcluTelefonlari, ContactUID AS BorcluID
                               FROM            dbo.Iletisim) AS borclu ON borclu.BorcluID = senetler.Borclu LEFT OUTER JOIN
                             (SELECT        Ad AS KefilAdi, BirincilTelefon AS KefilTelefon, Telefonlar AS KefilTelefonlari, ContactUID AS KefilID
                               FROM            dbo.Iletisim AS Iletisim_2) AS kefil ON kefil.KefilID = senetler.Kefil LEFT OUTER JOIN
                             (SELECT        Ad AS SenetiImzalayanAdi, BirincilTelefon AS SenetiImzalayanTelefon, Telefonlar AS SenetiImzalayanTelefonlari, ContactUID AS SenetiImzalayanID
                               FROM            dbo.Iletisim AS Iletisim_1) AS imzalayan ON senetler.SenetiImzalayan = imzalayan.SenetiImzalayanID

GO
/****** Object:  View [dbo].[AlacakTipineGoreSenetBorclari_View]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  UserDefinedFunction [dbo].[RiskleriHesapla]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  View [dbo].[Araclar_View]    Script Date: 19.11.2015 17:34:49 ******/
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
                         sahit.SahitAdres, sahit.SahitTelefon, sahit.SahitVergiDairesi, sahit.SahitVergiNo, vekalet.VekaletBitisTarihi, dbo.Araclar.Opsiyon, dbo.Araclar.OpsiyonTarihi, dbo.Araclar.OpsiyonKoyan, 
                         dbo.Araclar.ResmiAlınanKisi, dbo.Araclar.ResmiAlınanTipi, dbo.Araclar.NoterAlisTarihi, dbo.Araclar.ResmiGirisBedeli, dbo.Araclar.ResmiCikisTarihi, dbo.Araclar.ResmiCikisBedeli, dbo.Araclar.ResmiCikisKisi, 
                         dbo.Araclar.YedekAnahtar, dbo.Araclar.YedekAnahtarVerildimi, dbo.Araclar.AracMuayeneBitisTarihi
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
/****** Object:  View [dbo].[CekArsiv_View]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  View [dbo].[CekListesi_View]    Script Date: 19.11.2015 17:34:49 ******/
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

INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (1, CAST(N'2015-10-10' AS Date), N'f1b5af03-11e9-4184-8287-a6c094761c00', N'34 KD 184', N'OPEL', N'ASTRA', N'1.6DTİ', N'BEYAZ', 2008, 412000, N'Benzin', N'Manuel', 5, N'ÖNDEN', 1600, 140, N'ERTG23452134', N'TRTG2353235235', CAST(N'2015-10-10' AS Date), 29000, N'NZL Oto Listesi', N'Belirsiz', 1, CAST(N'2015-11-19 17:13:40.617' AS DateTime), N'ozan', 35000, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'EMRE BAŞ', N'Kişi', CAST(N'2015-11-14' AS Date), 123545, CAST(N'2015-11-14 00:00:00.000' AS DateTime), 10000, N'HAYDAR', NULL, NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (2, CAST(N'2015-10-10' AS Date), N'504fa294-a1a0-46fa-a746-247ab5258cf4', N'34 KD 185', N'OPEL', N'ASTRA', N'1.6DTİ', N'BEYAZ', 2008, 412000, N'Benzin', N'Manuel', 5, N'ÖNDEN', 1600, 140, N'ERTG23452134', N'TRTG2353235235', CAST(N'2015-10-10' AS Date), 29000, N'NZL Oto Listesi', N'Belirsiz', 1, CAST(N'2015-11-13 17:32:44.983' AS DateTime), N'ozan', 35000, N'94J48G4JDS', N'94J48G4JDS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ASDASD', N'Kişi', CAST(N'2015-11-13' AS Date), 234234, CAST(N'2015-11-13 00:00:00.000' AS DateTime), 324, N'DASD', NULL, NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (3, CAST(N'2015-10-10' AS Date), N'7e66de3a-d1c7-4281-9980-669dba3c6dae', N'34 KD 186', N'OPEL', N'ASTRA', N'1.6DTİ', N'BEYAZ', 2008, 412000, N'Benzin', N'Manuel', 5, N'ÖNDEN', 1600, 140, N'ERTG23452134', N'TRTG2353235235', CAST(N'2015-02-10' AS Date), 29000, N'NZL Oto Listesi', N'Belirsiz', 1, CAST(N'2015-11-13 17:42:02.060' AS DateTime), N'ozan', 35000, N'94J48G4JDS', N'94J48G4JDS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'DASDAS', N'Kişi', CAST(N'2015-11-05' AS Date), 3243, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (15, CAST(N'2015-11-12' AS Date), N'37146a21-4c7a-4550-90a3-e8c6c90605a7', N'06 BU 920', N'FORD ', N'FİESTA ', N'1.4 COOL ', N'SİYAH', 2008, 66500, N'Benzin', N'Manuel', 5, N'ÖNDEN ÇEKİŞ', 1400, 100, N'55651556', N'5465465', CAST(N'2015-11-12' AS Date), 25000, N'NZL Oto Listesi', N'Belirsiz', 0, CAST(N'1900-01-01 00:00:00.000' AS DateTime), N'', 30000, N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'988c1e06-531c-45c3-81d0-5724b6db1cdc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (24, CAST(N'2015-11-12' AS Date), N'51a9936b-2dac-4c66-b2ef-856c92e19245', N'ERWERq', N'WERQWE', N'RQWERq', N'WERQWER', N'QEWQRw', 2222, 22222, N'Benzin ve LPG', N'Yarı Otomatik', 222, N'2222', 2222, 2222, N'222', N'2222', CAST(N'2011-11-11' AS Date), 1213123, N'NZL Oto Listesi', N'Belirsiz', 0, NULL, NULL, 123123, N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'a9a43d5c-e8ee-4a76-a37c-e287a80a5aff', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (72, CAST(N'2015-11-17' AS Date), N'274fb5db-3d36-46c3-aa40-5de7830c629d', N'SDFDSF', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (73, CAST(N'2015-11-17' AS Date), N'62ffbc50-7aaf-422e-b70b-635f719fa0f1', N'DSF', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (74, CAST(N'2015-11-17' AS Date), N'4740ad4f-3540-4450-9830-16bf6506e969', N'ASDAS', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (75, CAST(N'2015-11-17' AS Date), N'be15f9dd-f20b-4c6b-93aa-11e2d6d4f632', N'F', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (76, CAST(N'2015-11-17' AS Date), N'c16dbd82-c5c4-4e69-bf17-cf9cff48d106', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (77, CAST(N'2015-11-17' AS Date), N'07a42ee8-eba1-4f95-a87f-8a7ac5dbe999', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (78, CAST(N'2015-11-17' AS Date), N'c1bf2385-dd20-4a28-85a8-411a7b7daed2', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (79, CAST(N'2015-11-17' AS Date), N'07621df6-8463-47ef-9c95-444fe5a3f816', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (80, CAST(N'2015-11-17' AS Date), N'5045e931-4b9a-4a13-a3c7-cb09108bf128', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (81, CAST(N'2015-11-17' AS Date), N'0f4f8490-b979-4e16-82a0-7051d620fe0f', N'AS', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (82, CAST(N'2015-11-17' AS Date), N'2254afd6-9052-47d8-9c27-c993ca76f076', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (83, CAST(N'2015-11-17' AS Date), N'e8ef8edc-70e3-46ec-9ceb-9d5c416d213c', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (84, CAST(N'2015-11-17' AS Date), N'95f6289b-34a1-4fa9-825a-6b07fbc3b6b3', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (85, CAST(N'2015-11-17' AS Date), N'907523eb-d01f-4834-9692-caef5e846856', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (86, CAST(N'2015-11-17' AS Date), N'ac9b857a-cb82-43f5-9564-c6670834c640', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (87, CAST(N'2015-11-17' AS Date), N'b419b272-5a7c-47bd-b417-5b1ef77783c8', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (88, CAST(N'2015-11-17' AS Date), N'21f15bd6-2842-44cf-9e2f-d0f7dbc68ef7', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2013-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (89, CAST(N'2015-11-17' AS Date), N'6903a618-e2a0-47fe-b387-7e282871c416', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (90, CAST(N'2015-11-17' AS Date), N'4331921b-4bfa-41a2-b653-bb4041dec98d', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (91, CAST(N'2015-11-17' AS Date), N'e57933e4-ac54-488c-abe9-ef8403067181', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (92, CAST(N'2015-11-17' AS Date), N'6fc86426-ae74-4d52-946b-54be64abf94b', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (93, CAST(N'2015-11-17' AS Date), N'799afc19-62c7-42ef-b257-c8a7710eb786', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (94, CAST(N'2015-11-17' AS Date), N'612cea32-a3cc-4ff6-952d-103e36c8ef0d', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (95, CAST(N'2015-11-17' AS Date), N'7691c36a-71be-4b72-9560-ae5840689a8d', N'ZXC', N'ZXC', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Var', NULL, NULL)
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (96, CAST(N'2015-11-19' AS Date), N'5194455b-3d63-4074-9ccc-4ad36a5ce0a3', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2010-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, CAST(N'2012-12-12' AS Date))
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (98, CAST(N'2015-11-19' AS Date), N'b61ee2ee-a0e6-41d4-9476-a3ed57357c51', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, CAST(N'2012-12-12' AS Date))
INSERT [dbo].[Araclar] ([id], [AddDate], [AracUID], [Plaka], [Marka], [Seri], [Model], [Renk], [Yil], [KM], [YakitTipi], [VitesTipi], [Kapi], [Cekis], [MotorHacmi], [MotorGucu], [MotorNo], [SasiNo], [AlinisTarihi], [AlinisFiyati], [Liste], [Durum], [Opsiyon], [OpsiyonTarihi], [OpsiyonKoyan], [EtiketFiyati], [RuhsatSahibi], [Satici], [Alici], [Sahit], [Satis_Tarihi], [Satis_Fiyati], [Resmi_Satis_Fiyati], [Noter_Devir_Tarihi], [Cikis_Durumu], [ResmiAlınanKisi], [ResmiAlınanTipi], [NoterAlisTarihi], [ResmiGirisBedeli], [ResmiCikisTarihi], [ResmiCikisBedeli], [ResmiCikisKisi], [YedekAnahtar], [YedekAnahtarVerildimi], [AracMuayeneBitisTarihi]) VALUES (99, CAST(N'2015-11-19' AS Date), N'd7023668-cdf5-41ea-b14b-6e5b0d92bf42', N'', N'', N'', N'', N'', 0, 0, N'', N'', 0, N'', 0, 0, N'', N'', CAST(N'2012-12-12' AS Date), 0, N'', N'Belirsiz', 0, NULL, NULL, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, CAST(N'2015-12-12' AS Date))
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

INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (5, N'1F8019C2-B41A-4C5E-B473-E803CB63C447', N'68418965', CAST(N'2016-06-25' AS Date), 12000, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'Cemal Han', N'Akbank', N'Bakırköy', N'', N'', CAST(N'2015-08-01 09:48:49.260' AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (1005, N'774EC7F5-AD97-4919-ABA3-A9FAB379FB4B', N'21684136', CAST(N'2016-09-25' AS Date), 8000, N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'', N'Yapı Kredi', N'Çengelköy', N'', N'', CAST(N'2015-08-01 18:29:59.757' AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (2008, N'6A81B585-03F4-423A-9837-15A9C02820A3', N'984584176420', CAST(N'2015-12-30' AS Date), 8000, N'94J48G4JDS', N'', N'İş Bankası', N'Ümraniye', N'', N'', CAST(N'2015-08-11 11:59:07.500' AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (2017, N'8EB61727-E737-4B4E-9E07-8A7A7C0950DE', N'8215648', CAST(N'2017-01-01' AS Date), 24000, N'e144bd22-6879-4609-a370-27abc98cf0c7', N'', N'Akbank', N'Pendik', N'', N'', CAST(N'2015-09-02 09:50:28.727' AS DateTime))
INSERT [dbo].[Cek] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi]) VALUES (4017, N'E8F4E9D6-B750-4C25-8F51-E9CF1025C94A', N'8458941', CAST(N'2015-09-25' AS Date), 2600, N'e144bd22-6879-4609-a370-27abc98cf0c7', N'', N'YAPIKREDİ', N'ÜMRANİYE', N'AKBANK BAĞLARBAŞI', N'Deneme', CAST(N'2015-09-21 21:24:10.533' AS DateTime))
SET IDENTITY_INSERT [dbo].[Cek] OFF
SET IDENTITY_INSERT [dbo].[CekArsiv] ON 

INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (9, N'CD110B6C-E01D-452C-8A39-090083E8DCA9', N'846548951', CAST(N'2015-07-30' AS Date), 8000, N'94J48G4JDS', N'', N'Akbank', N'Bahçelievler', N'', N'', CAST(N'2015-08-11 12:01:14.990' AS DateTime), CAST(N'2015-08-28 18:09:53.360' AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (11, N'C33E58B3-3E45-4125-A4EB-DF1CB5196623', N'8124981213', CAST(N'2015-01-25' AS Date), 8000, N'8546374d-41c0-4568-9e9c-905c5a103fba', N'Hasan Gelir', N'Akbank', N'Topkapı', N'', N'', CAST(N'2015-08-29 10:35:01.683' AS DateTime), CAST(N'2015-08-29 10:35:08.930' AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (12, N'A3DEB659-E98F-4ECC-8124-C8FB05D995E0', N'2168465498', CAST(N'2015-05-12' AS Date), 1400, N'66b6de1c-7829-41d8-8506-ffec542910eb', N'Cemil Kaya', N'İşbankası', N'Avcılar', N'', N'', CAST(N'2015-08-29 10:36:41.270' AS DateTime), CAST(N'2015-08-29 10:36:44.553' AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (13, N'F889ED6C-8C5A-4331-846B-83FA7164D10A', N'849186', CAST(N'2017-12-30' AS Date), 14000, N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'', N'Yapı Kredi', N'Şişli', N'', N'', CAST(N'2015-08-01 12:21:11.850' AS DateTime), CAST(N'2015-08-29 12:59:00.403' AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (14, N'20122F8E-4BB6-4DAE-97CF-F3E17F6992D0', N'25948913', CAST(N'2015-08-30' AS Date), 2500, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kamuran Günay', N'Akbank', N'Tarabya', N'', N'10. ayda ödeyecek', CAST(N'2015-08-29 12:09:03.403' AS DateTime), CAST(N'2015-09-01 22:53:57.237' AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (15, N'0A3BB0A0-11CA-46B1-8D8C-1A2C3554DE42', N'25948913', CAST(N'2015-09-04' AS Date), 2500, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kamuran Günay', N'Akbank', N'Tarabya', N'', N'', CAST(N'2015-08-29 12:11:25.830' AS DateTime), CAST(N'2015-09-14 15:01:38.030' AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (16, N'59BA40E4-9E53-4175-92B6-1AB5F72E5AC4', N'25948913', CAST(N'2015-09-05' AS Date), 2500, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kamuran Günay', N'Akbank', N'Tarabya', N'', N'', CAST(N'2015-08-29 12:11:32.100' AS DateTime), CAST(N'2015-09-14 15:02:57.060' AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (17, N'FD6F63BD-0958-4EAA-89D6-F7AF39BA3B2B', N'25948913', CAST(N'2015-09-06' AS Date), 2500, N'ff74f510-56f8-4e6b-91f7-62ced0df8b45', N'Kamuran Günay', N'Akbank', N'Tarabya', N'', N'', CAST(N'2015-08-29 12:11:53.400' AS DateTime), CAST(N'2015-09-14 15:03:47.603' AS DateTime), N'ozan')
INSERT [dbo].[CekArsiv] ([id], [CekID], [CekNo], [Tarih], [Miktar], [CekAlinanKisi], [CekAsilSahibi], [Banka], [BankaSubesi], [TakastaOlduguHesap], [CekNot], [SistemeKayitTarihi], [ArsivlenmeTarihi], [ArsivleyenKisi]) VALUES (1015, N'924573BD-61C2-4970-B4F5-CFE957ABE0FD', N'48915164', CAST(N'2015-09-12' AS Date), 7800, N'km23tsj0k2f', N'TURAP ÜLKÜ', N'YAPI KREDİ', N'KARTAL', N'', N'', CAST(N'2015-09-14 15:06:27.257' AS DateTime), CAST(N'2015-09-21 21:24:58.647' AS DateTime), N'ozan')
SET IDENTITY_INSERT [dbo].[CekArsiv] OFF
INSERT [dbo].[GenelRisk] ([Limit]) VALUES (15000)
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
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (6036, N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'Kişi', N'EMRE BAŞ', N'17438762424', N'(544) 434 91 14', N'', N'KADIKÖY İSTANBUL', N'', N'', N'', NULL, N'asdasd')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (6037, N'c9586307-eec8-437a-8771-1fef668146b1', N'Kişi', N'ASD', N'21431235476', N'(324) 234 23 42', N'(234) 234 23 42', N'VCSSDV', N'', N'', N'', NULL, N'vsdvsv')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (6038, N'3e960d0e-77a8-4f26-86e8-cf3250fcc140', N'Kişi', N'CSVSD', N'54645', N'(324) 234 23 42', N'(432) 532 42 34', N'SDVSDV', N'2423423', N'', N'', NULL, N'dfsdfsfsdf')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (6039, N'ae0b26ce-125d-4322-af93-ea39a707ff4a', N'Kişi', N'ASDA', N'2223332223322', N'(234) 242 34 23', N'(234) 234 23 44', N'23423', N'423423423', N'', N'', NULL, N'')
INSERT [dbo].[Iletisim] ([id], [ContactUID], [Type], [Ad], [KimlikNo], [BirincilTelefon], [Telefonlar], [BirincilAdres], [Adresler], [VergiDairesi], [VergiNo], [SenetNot], [IletisimNot]) VALUES (6040, N'9c6b2391-00e0-4228-97f8-5696d542fdfe', N'Kişi', N'GFH', N'435345345', N'', N'', N'', N'', N'', N'', NULL, N'')
SET IDENTITY_INSERT [dbo].[Iletisim] OFF
SET IDENTITY_INSERT [dbo].[KasaFoyu] ON 

INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (15, N'Giriş', N'Kasa Açılışı', NULL, NULL, -2868, N'TR', N'Kasa Açılışı', CAST(N'2015-05-11' AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (18, N'Giriş', N'Giriş', N'Çek', NULL, 22, N'TR', N'asdasd', CAST(N'2015-05-11' AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (19, N'Çıkış', NULL, NULL, NULL, 22, N'TR', N'Test', CAST(N'2015-05-11' AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (1015, N'Giriş', N'Giriş', N'Senet', NULL, 5000, N'TR', N'NİYAZİ YILMAZ KİRA GELİRİ', CAST(N'2015-05-11' AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (1016, N'Giriş', N'Giriş', N'Senet', NULL, 50, N'TR', N'AHMET', CAST(N'2015-05-11' AS Date))
INSERT [dbo].[KasaFoyu] ([id], [Tip], [AltTip], [Alt2Tip], [BaglantiID], [Miktar], [ParaBirimi], [Aciklama], [BaslangicTarihi]) VALUES (2015, N'Giriş', N'Giriş', N'Senet', NULL, 1250, N'TR', N'muhittin akça', CAST(N'2015-05-11' AS Date))
SET IDENTITY_INSERT [dbo].[KasaFoyu] OFF
SET IDENTITY_INSERT [dbo].[KasaFoyuArsiv] ON 

INSERT [dbo].[KasaFoyuArsiv] ([id], [BaslangicTarihi], [BitisTarihi], [ArsivData]) VALUES (1, CAST(N'2015-05-11' AS Date), CAST(N'2015-05-11' AS Date), N'[
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
INSERT [dbo].[KasaFoyuArsiv] ([id], [BaslangicTarihi], [BitisTarihi], [ArsivData]) VALUES (2, CAST(N'2015-05-11' AS Date), CAST(N'2015-05-11' AS Date), N'[
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
INSERT [dbo].[KasaFoyuArsiv] ([id], [BaslangicTarihi], [BitisTarihi], [ArsivData]) VALUES (3, CAST(N'2015-05-11' AS Date), CAST(N'2015-05-11' AS Date), N'[
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

INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (1, N'Kaporta-Boya', CAST(N'2015-05-11' AS Date), N'[
  {
    "id": "7",
    "Maliyet_Tipi": "Kaporta-Boya",
    "Maliyet_Arac": "6625aba7-bf68-4262-a240-b9909477b5ce",
    "Maliyet_Miktar": "543",
    "Maliyet_Odeme": "False",
    "Maliyet_Kasaid": ""
  }
]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (2, N'Kaporta-Boya', CAST(N'2015-05-11' AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (3, N'Kaporta-Boya', CAST(N'2015-05-11' AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (4, N'Kaporta-Boya', CAST(N'2015-05-11' AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (5, N'Kaporta-Boya', CAST(N'2015-05-11' AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (6, N'Kaporta-Boya', CAST(N'2015-05-11' AS Date), N'[]')
INSERT [dbo].[MaliyetlerArsiv] ([id], [ArsivTipi], [KayitTarihi], [ArsivData]) VALUES (7, N'Yikama', CAST(N'2015-05-11' AS Date), N'[
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

INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (14, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'035C3569-E611-4A47-B12B-A05C4BB4F89F', N'1', CAST(N'2015-08-05' AS Date), 1850, 1850, N'30 Kasım''da gelecekti, gelemedi.  Yurtdışına çıkmış dönünce gelecek.')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (15, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'76A44758-F00B-4F27-BEE3-F9E4A44951C0', N'2', CAST(N'2015-09-05' AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (16, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'63A093B9-B60D-47CD-8763-FAE6260C9760', N'3', CAST(N'2015-10-05' AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (17, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'D2EBF99B-62EF-4C2E-AD59-4B5821D1D6AE', N'4', CAST(N'2015-11-05' AS Date), 2300, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (18, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'EF4B6984-C4EE-4CDD-A296-8765BC33C858', N'5', CAST(N'2015-12-05' AS Date), 2300, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (19, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'6939AC7C-6962-4BCC-B01C-247BE67C7627', N'6', CAST(N'2016-01-05' AS Date), 2300, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (20, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'72326733-D031-4DDC-8D6F-41460230CD8D', N'7', CAST(N'2016-02-05' AS Date), 6000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (21, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'8BF8BA5F-F978-4ED4-97AA-93C27C0C687E', N'8', CAST(N'2016-03-05' AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (22, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'6DD20181-C783-4276-90A5-975CB15038C5', N'9', CAST(N'2016-04-05' AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (23, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'74388F55-2D6F-41BD-ACCF-364BF546957F', N'10', CAST(N'2016-05-05' AS Date), 1850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (24, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'D41EFE0B-49FC-48F5-9130-482C1F27A318', N'11', CAST(N'2016-06-05' AS Date), 3500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (25, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'53D61EB5-BF15-48E9-A3E0-989D7AE63B3F', N'12', CAST(N'2016-07-05' AS Date), 2400, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (26, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'DA389619-1B1E-476F-93D3-27DE3806CBFC', N'13', CAST(N'2016-08-05' AS Date), 1500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (27, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'B2E62D4B-53D7-4CF1-A8C5-4C185EAE195B', N'14', CAST(N'2016-09-05' AS Date), 2850, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (28, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'0259A4BF-29DE-41B5-9D71-777B60E70667', N'15', CAST(N'2016-10-05' AS Date), 1750, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (29, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'50AD654A-FE3D-4859-85FB-DE497FC706BD', N'16', CAST(N'2016-11-05' AS Date), 1600, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (30, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'8A36FFF3-25ED-44F5-A537-1FE684E77BA3', N'17', CAST(N'2016-12-05' AS Date), 1500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (31, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, 10000, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'F10763A9-4634-4785-96C7-9539D1F187A6', N'18', CAST(N'2017-01-05' AS Date), 1500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (54, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'B4325A7C-6007-4DC8-BF6D-D98845DE6120', N'6', CAST(N'2015-06-01' AS Date), 4000, 4000, N'2.000 tl 05/06 wkeıhfo0wıehf weıufy9ıweuohfoıw ıuewyf9ıuwheofuıwhepıfhu weıugf97wıeugfoıwugef9uwgeıufgweıf')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (55, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'489E4C07-0E0B-4D57-9D2E-0DE0F7287A86', N'7', CAST(N'2015-07-01' AS Date), 4000, 4000, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (58, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'047FC35C-B522-42A1-A6EA-12D204D80D81', N'10', CAST(N'2015-10-01' AS Date), 4000, 4000, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (59, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'5F51C1B1-6C2A-40C5-AD15-323C6AA69F69', N'11', CAST(N'2015-11-01' AS Date), 4000, 4000, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (60, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'80E5E78D-2F2A-4554-B04C-3DF725D4D9AB', N'12', CAST(N'2015-12-01' AS Date), 4000, 3000, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (61, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'2FCEC01E-59B2-43B0-B73E-B07B0B463A54', N'13', CAST(N'2016-01-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (62, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'33AC19F3-AFB4-4637-8EBD-D3F11B0A0B7B', N'14', CAST(N'2016-02-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (63, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'DC6AB4BD-F840-423E-99FF-ED53DAA90874', N'15', CAST(N'2016-03-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (74, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'D3826B7F-9F4E-4F93-8647-B3E8DB27518B', N'26', CAST(N'2017-02-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (75, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'4FAAB570-5285-47A4-9EDD-DCAA7E3C66C2', N'27', CAST(N'2017-03-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (76, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'4244A443-0CE9-41DF-8F00-D7F17CBB365C', N'28', CAST(N'2017-04-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (77, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'3FDA68C7-AB47-4F7F-8D6B-AA65E995DDC7', N'29', CAST(N'2017-05-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (78, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'9A620B42-D495-4F40-A1BE-38D7BD250F70', N'30', CAST(N'2017-06-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (79, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'BA11EF50-AD1A-4146-8468-40396B5ECBA8', N'31', CAST(N'2017-07-01' AS Date), 4000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (85, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'7BC46DB1-0FA6-40FB-9F65-E0FFC1DC869D', N'A:25', CAST(N'2017-01-21' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (86, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'F5920AAE-A477-4266-AC1B-B046EE4F10F9', N'A:32', CAST(N'2017-08-11' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (87, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'', N'F60A9CC1-6A4C-49C0-A819-3E1F4B3F3760', N'1', CAST(N'2015-08-31' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (88, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'', N'68AA0277-5618-468E-BD8E-11578C82EA9D', N'2', CAST(N'2015-09-30' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (89, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'', N'B6DE527B-6489-4EDA-A70D-8BE632E18FE4', N'3', CAST(N'2015-10-31' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (90, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'', N'7DA96DCD-3580-43C7-8778-8344567744D2', N'4', CAST(N'2015-11-30' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (91, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'', N'6DFEFE75-9E7F-48C6-A6DD-8EA1B5E8CEB9', N'5', CAST(N'2015-12-31' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (92, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'', N'AC55D210-08B0-44A0-846B-AAF9ED9D6590', N'6', CAST(N'2016-01-31' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (93, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'', N'FE960E2C-FE53-4373-A142-E9A471F9A361', N'7', CAST(N'2016-02-29' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (94, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e2e6507e-b522-4cdd-8761-243ba03bf458', N'', N'', N'ŞİRKET', 3.5, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'', N'922A3ACC-514C-4DDD-A831-0A7F00F19ED5', N'8', CAST(N'2016-03-31' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1087, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, 10000, CAST(N'2015-08-31' AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'5D8B07BC-C76B-404B-BB11-26E3892D3E19', N'1', CAST(N'2015-08-31' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1088, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, 10000, CAST(N'2015-08-31' AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'B01FC384-2289-4981-970D-87AD84CC4F8C', N'2', CAST(N'2015-09-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1089, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, 10000, CAST(N'2015-08-31' AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'F1FE4DD9-0437-4CF8-BAD1-9FE87B9C295A', N'3', CAST(N'2015-10-31' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1090, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, 10000, CAST(N'2015-08-31' AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'EFEDE67F-9700-4CDC-A599-85D3C7675CFA', N'4', CAST(N'2015-11-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1091, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, 10000, CAST(N'2015-08-31' AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'4E39AA2D-1626-4499-8809-65AE3D200CA2', N'5', CAST(N'2015-12-31' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1092, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, 10000, CAST(N'2015-08-31' AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'62741510-7DF9-48B0-ADF2-8457147F8A51', N'6', CAST(N'2016-01-31' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1093, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, 10000, CAST(N'2015-08-31' AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'C1889089-A41B-49B8-91E8-77C754A6A605', N'7', CAST(N'2016-02-29' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1094, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'94J48G4JDS', N'351ecbdb-1451-4ac2-8190-946faac28c6b', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'94J48G4JDS', N'ŞİRKET', 2.4, 10000, CAST(N'2015-08-31' AS Date), N'34 AKS 52', N'2007 MAVİ OPEL ASTRA', N'', N'22272094-443A-4BD1-AF26-A4792AE7D078', N'8', CAST(N'2016-03-31' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1095, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'D1836947-087C-40CA-B8FE-BA4D701099E4', N'1', CAST(N'2015-10-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1096, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'9493E79A-BDE2-4FA1-8147-ADA0B7DC27C2', N'2', CAST(N'2015-11-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1097, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'2F8D5504-D852-49D4-B2EC-CC864402FC01', N'3', CAST(N'2015-12-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1098, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'D27E5588-5082-4636-B49F-FAED9B860A1C', N'4', CAST(N'2016-01-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1099, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'09023AE3-8F26-4FC5-9806-CB7428BE7E21', N'A:4', CAST(N'2016-02-15' AS Date), 5000, 0, N'Günü geldiğinde çek vericek')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1100, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'5A811349-236D-4FDB-8CC1-A5BB29F8B87D', N'5', CAST(N'2016-02-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1101, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'F0435216-0F17-44DD-AB47-FF8BC4A083DE', N'6', CAST(N'2016-03-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1102, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'7472B255-1008-4C8E-9E0A-95CAD760F1AD', N'7', CAST(N'2016-04-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1103, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'03DB896F-8C8C-4E9F-840C-3215F7D05F00', N'8', CAST(N'2016-05-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1104, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'E47F1ED8-C9BF-46F7-B814-B9637B4320E3', N'9', CAST(N'2016-06-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1105, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'F0077258-CA35-445B-B346-B98D7EB720D3', N'10', CAST(N'2016-07-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1106, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'413D18A4-3E7F-46A5-98F2-3C094B7BB3C7', N'11', CAST(N'2016-08-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1107, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'31D06F80-CB2A-45C5-8AC7-0A7B5F775B50', N'12', CAST(N'2016-09-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1108, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'E56CB1D9-9706-4A24-9E03-D00D4FD16447', N'13', CAST(N'2016-10-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1109, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'11BB5423-3452-467A-9751-92CD8745E698', N'14', CAST(N'2016-11-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1110, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'C501A63A-4BC4-4AA1-BF3A-68FEB2C6BF4C', N'15', CAST(N'2016-12-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1111, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'1E003674-42E0-4FAB-83D4-D1C1D547DB83', N'16', CAST(N'2017-01-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1112, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'0EA7B511-F012-4161-8C3A-11C31F830AFD', N'17', CAST(N'2017-02-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1113, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'BD9DC5B8-F49A-41E0-B153-5796F48742C5', N'18', CAST(N'2017-03-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1114, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'D6B291A3-4A43-436D-AB47-86A799BC33F1', N'19', CAST(N'2017-04-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1115, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'ADA43EA5-3B8B-4B9B-9D09-7FE27976B88B', N'20', CAST(N'2017-05-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1116, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'F229765F-9EA4-4B7C-9C16-4CBB458C6EE1', N'21', CAST(N'2017-06-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1117, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'CA8CD5BE-E2B7-49EA-AD3F-0026EAFB602B', N'22', CAST(N'2017-07-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1118, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'050F0E04-0135-4968-A319-6F6DA72402CB', N'23', CAST(N'2017-08-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (1119, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'4232a80e-16b3-41f4-945d-673ea88ec1dc', N'J9G40J0GUD', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2.75, 10000, CAST(N'2015-10-01' AS Date), N'34 KSD 98', N'MERCEDES', N'', N'5FEA4A00-003A-4078-99E0-B6ACAA066B53', N'24', CAST(N'2017-09-20' AS Date), 1250, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2095, CAST(N'2015-10-29 09:35:04.067' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5eebc7a1-7eab-4f55-96ef-2a1f6cda0f16', N'', N'', N'ŞİRKET', 4, 10000, CAST(N'2015-07-24' AS Date), N'', N'', N'Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not Deneme notu uzun bir not 







Deneme notu uzun bir not Deneme notu uzun bir not ', N'C12AEF25-BF18-497B-9402-B64020D25956', N'A:6', CAST(N'2015-02-06' AS Date), 12000, 5000, N'grer')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2097, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'2EBD51A7-E0F8-4D95-AA0E-D1F0BACCDD39', N'1', CAST(N'2015-10-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2098, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'FC16F8D1-52C8-436B-8549-2A92E69806F5', N'2', CAST(N'2015-11-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2099, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'E76E7945-2E93-4F89-B9E1-A9D8609A6DA7', N'3', CAST(N'2015-12-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2100, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'DB7695DF-864B-46A5-9765-B7BEC2E33031', N'4', CAST(N'2016-01-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2101, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'BBF50DAD-FBE9-42E4-9631-492472AC5409', N'5', CAST(N'2016-02-29' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2102, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'EC6C37B6-9BCD-433E-9AE3-FD1BDC25DE84', N'6', CAST(N'2016-03-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2103, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'F520C69B-3A3D-482D-8240-C96456FB271C', N'7', CAST(N'2016-04-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2104, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'04EB0496-A3B5-4469-9C80-8853DC4B637B', N'8', CAST(N'2016-05-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2105, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'0CC7CC88-02B2-4DE0-8F4D-1764D922604E', N'55', CAST(N'2016-05-30' AS Date), 800, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2106, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'FFFD26F3-DDBD-4DAF-A266-2E7F26002E74', N'9', CAST(N'2016-06-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2107, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'9AE1C335-446A-4E16-A8C6-B0B114541B26', N'10', CAST(N'2016-07-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2108, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'5825F091-D903-4C1D-A1B6-AF3D4D0FDA69', N'11', CAST(N'2016-08-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2109, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'4EEE0946-9563-4C23-8A64-3DE7EE552C48', N'12', CAST(N'2016-09-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2110, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'8AC614BC-E962-45EF-9140-D7D4FE24E4F9', N'13', CAST(N'2016-10-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2111, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'3458942B-2C05-40C1-95AC-66402A965177', N'14', CAST(N'2016-11-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2112, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'C71718D3-D43F-483A-9C89-7579A8B4197E', N'15', CAST(N'2016-12-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2113, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'0221A423-01D5-437C-AA65-9E2BCFB16727', N'16', CAST(N'2017-01-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2114, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'A9C1C488-8ED5-4CC6-8050-D7049C61AA7E', N'17', CAST(N'2017-02-28' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2115, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'718C854E-56E7-4D3C-8F2D-1555EC818A0C', N'18', CAST(N'2017-03-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2116, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'3F52D8DA-CEDD-4089-9B8D-62BB68EE7460', N'19', CAST(N'2017-04-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2117, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'2517C592-186D-4BF7-810A-2DF441C2A011', N'20', CAST(N'2017-05-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2118, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'5B22C400-1E62-4D03-857C-A7C9AEC9B711', N'21', CAST(N'2017-06-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2119, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'14D37AFE-9BC9-454B-8FC3-C6D8F539F506', N'22', CAST(N'2017-07-30' AS Date), 1200, 0, N'')
GO
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2120, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'C513482B-B704-4224-8D94-E0346E1684CA', N'23', CAST(N'2017-08-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2121, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'845CA240-C933-4CB3-BFD7-218B3B233544', N'24', CAST(N'2017-09-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2122, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'D3B0E763-0EA7-4AAE-BDF8-C8652E483BEC', N'25', CAST(N'2017-10-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2123, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'2BE2C397-B41F-48E0-9E9F-3B0757E58828', N'26', CAST(N'2017-11-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2124, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'E7FEB8F7-6B74-4E58-B58A-666147B8A62E', N'27', CAST(N'2017-12-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2125, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'0DB87E07-7489-4A85-84D3-9A6EA2183791', N'28', CAST(N'2018-01-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2126, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'751F4F8A-0AD2-4ED5-AB51-0797382A7680', N'29', CAST(N'2018-02-28' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2127, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'F130462B-321B-482A-AF07-114C69045F8C', N'30', CAST(N'2018-03-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2128, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'64DA7FF1-BCA2-435E-9ECA-01C340E33E88', N'31', CAST(N'2018-04-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2129, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'DC79EBB9-DC7F-4726-A444-073993D8B1EC', N'32', CAST(N'2018-05-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2130, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'41E324EB-DBC8-4445-930D-7B237C690D69', N'33', CAST(N'2018-06-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2131, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'392AEFED-D71B-423E-B0FE-D122A5D1C7D8', N'34', CAST(N'2018-07-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2132, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'E09CD622-5A80-44D5-9C1E-80D4576D05D1', N'35', CAST(N'2018-08-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2133, CAST(N'2015-10-29 13:40:59.483' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'E8997950-12C2-41A6-ADDC-6718870F7CBD', N'36', CAST(N'2018-09-30' AS Date), 1200, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2136, CAST(N'2015-10-29 15:37:21.397' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'DFE9AA6D-DB28-4CAE-A5FE-A8E007ED173A', N'Ara Senet', CAST(N'2015-11-01' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (2137, CAST(N'2015-10-29 15:37:21.397' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'86f99ff6-1535-4b25-98b8-bbd04a90d6f1', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'', N'ŞİRKET', 2.5, 40000, CAST(N'2015-10-29' AS Date), N'34 ASJ 98', N'RENAULT CLIO KIRMIZI', N'', N'D4B2BCA2-69F0-4445-9E15-FBAEFF370A2F', N'Ara Senet', CAST(N'2018-10-01' AS Date), 3000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3096, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'282F3841-467F-437B-8299-59E92AE3EC9A', N'1', CAST(N'2016-10-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3097, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'D9B5349B-9D2F-4FA3-AE85-3DA660FC6CCA', N'2', CAST(N'2016-11-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3098, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'1BC55F00-2C99-4A27-918B-A8C840F6186D', N'3', CAST(N'2016-12-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3099, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'CF07F3EE-43BB-4C77-9253-C9F23C9DBCDA', N'4', CAST(N'2017-01-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3100, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'B348360D-0CCA-4741-8DE2-D3D571E39C6A', N'5', CAST(N'2017-02-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3101, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'7B707DD2-089C-4A32-8076-3D2FE1EA4374', N'6', CAST(N'2017-03-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3102, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'DFB0F110-9ADF-424E-8244-91A70079AD51', N'7', CAST(N'2017-04-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3103, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'64E5DAEB-7403-4CC5-9166-182B5582E025', N'8', CAST(N'2017-05-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3104, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'5A26D1D9-FE35-4414-8031-26E3BBCBF1CF', N'9', CAST(N'2017-06-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3105, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'F04498DA-644D-485B-815B-60DB80667BD1', N'10', CAST(N'2017-07-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3106, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'2305C5E5-6BFD-421A-951A-66B5F282CDA9', N'11', CAST(N'2017-08-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3107, CAST(N'2015-11-09 21:03:48.350' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'8b67583c-abce-422b-b0ce-137f9c0e55ca', N'', N'', N'ŞİRKET', 2, 25000, CAST(N'2015-11-09' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'313372B9-0E51-4464-9DCD-7ED6FAB5BC0D', N'15', CAST(N'2017-09-21' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3108, CAST(N'2015-11-10 15:25:30.143' AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(N'2015-11-10' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'8385F278-1430-48B0-81E2-3E73BE1D00BF', N'1', CAST(N'2015-10-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3109, CAST(N'2015-11-10 15:25:30.143' AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(N'2015-11-10' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'706F0514-7997-4037-B52D-2CE46A9837D8', N'2', CAST(N'2015-11-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3110, CAST(N'2015-11-10 15:25:30.143' AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(N'2015-11-10' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'456FA979-F5F1-4437-A2D4-44201BABFD43', N'3', CAST(N'2015-12-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3111, CAST(N'2015-11-10 15:25:30.143' AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(N'2015-11-10' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'7900D7DE-09BC-4AF9-ADDD-A9B44CE270F3', N'4', CAST(N'2016-01-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3112, CAST(N'2015-11-10 15:25:30.143' AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(N'2015-11-10' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'DC37598F-A545-46CF-8FCC-92E087AF0517', N'5', CAST(N'2016-02-29' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3113, CAST(N'2015-11-10 15:25:30.143' AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(N'2015-11-10' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'81E069F5-3476-4E00-9B27-9632B49D4D47', N'6', CAST(N'2016-03-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3114, CAST(N'2015-11-10 15:25:30.143' AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(N'2015-11-10' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'4DD6FFA5-3458-44DB-8932-5590180D68B5', N'7', CAST(N'2016-04-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3115, CAST(N'2015-11-10 15:25:30.143' AS DateTime), N'J3TH8Y94M', N'2b044f89-0dd8-4b41-a8a3-57a9c7e4a10c', N'', N'', N'ŞİRKET', 1.5, 5000, CAST(N'2015-11-10' AS Date), N'34 SDF 12', N'OPEL CORSA', N'', N'3DA4CE8F-BBF2-42A0-8A2A-DF72D8D32B9F', N'8', CAST(N'2016-05-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3116, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'A1459524-AAC4-4DE6-8DE9-53801D5FD419', N'0', CAST(N'2015-11-30' AS Date), 500, 500, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3117, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'E558EDDD-DE20-428D-B1A4-A0C6E74A8666', N'1', CAST(N'2015-11-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3118, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'C1E92FB5-75B3-4C32-9D5E-E1FFCE3DF783', N'2', CAST(N'2015-12-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3119, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'BC10DE13-730F-440C-810A-7C879B21B613', N'3', CAST(N'2016-01-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3120, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'3C9D028E-AC06-4C47-9FB4-AC8CD0DC4C0F', N'Ara Senet', CAST(N'2016-01-30' AS Date), 1500, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3121, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'F256A202-A18D-4841-A3F3-07EB95BC0090', N'4', CAST(N'2016-02-29' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3122, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'17B4FED1-8C06-4F5A-9EFC-C49AB6299F38', N'5', CAST(N'2016-03-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3123, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'DF6E5268-CDA2-4279-B54D-DE4317F108B4', N'6', CAST(N'2016-04-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3124, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'D2BAD442-79B9-4680-8E44-529D2DB86B52', N'7', CAST(N'2016-05-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3125, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'6DA836FA-D32C-4FDC-AB99-6C4AC67448C2', N'8', CAST(N'2016-06-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3126, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'14D88972-2824-4511-91C4-D0654016316F', N'9', CAST(N'2016-07-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3127, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'CE6E6FEE-2349-45BB-A1D0-3A8D22B229B0', N'10', CAST(N'2016-08-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3128, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'BAE419FC-40E1-40D3-AB3C-86493F4E4A3C', N'11', CAST(N'2016-09-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3129, CAST(N'2015-11-11 15:36:57.583' AS DateTime), N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'26db8310-0cc6-4489-828a-367dc2ff6b34', N'J3TH8Y94M', N'', N'ŞİRKET', 5.5, 10000, CAST(N'2015-11-11' AS Date), N'', N'', N'', N'C048030B-DA41-4C9F-8010-32C7419B1C70', N'12', CAST(N'2016-10-30' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3130, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'F53BE86C-4292-40E6-AA4E-B549DB45D378', N'1', CAST(N'2015-12-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3131, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'B23EAED1-BE35-404A-963E-CD63494AC604', N'2', CAST(N'2016-01-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3132, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'60EA2A05-F8D7-4BBD-AE20-BCC3FD737D28', N'3', CAST(N'2016-02-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3133, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'08142642-F0EE-4BB3-98AB-B9D72DB212CF', N'4', CAST(N'2016-03-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3134, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'C3875AC6-1AE1-4B5D-A22E-00AC7C7B4CF9', N'5', CAST(N'2016-04-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3135, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'4BFD237E-C7BC-4822-A358-EF918CDD7454', N'6', CAST(N'2016-05-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3136, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'1D8F3480-1519-472C-99C3-283DC213682A', N'7', CAST(N'2016-06-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3137, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'F0A93336-53CD-4685-9AF9-8A34F06BB614', N'8', CAST(N'2016-07-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3138, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'7DEF51BB-5555-4213-8DB5-B978948EFBC7', N'9', CAST(N'2016-08-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3139, CAST(N'2015-11-14 10:23:33.460' AS DateTime), N'1c011d86-77b9-49c9-9701-4ba68b1c12e8', N'6c94d34d-10a3-4181-9dd1-fea7f3ac3bbb', N'd8ef2bc7-bb5a-43fa-b98f-1b55be54f804', N'JOEJVENFDV', N'ŞİRKET', 5, 10000, CAST(N'2015-11-14' AS Date), N'34 BU 920', N'DSASDASD', N'asdasdasdasd', N'9B30C2B8-6D9E-4E8E-AA5B-172968D645D3', N'10', CAST(N'2016-09-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3140, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'73352804-6BFC-4F98-943A-885C09FDD389', N'1', CAST(N'2015-12-12' AS Date), 1000, 0, N'DSFS')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3141, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'713A122E-CBAE-4389-A8D0-4709FC82ADBF', N'2', CAST(N'2016-01-12' AS Date), 1000, 0, N'SDFSD')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3142, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'6EF3893E-CD9F-42D3-98F6-C9152AF46AD6', N'3', CAST(N'2016-02-12' AS Date), 1000, 0, N'FSDF')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3143, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'97B3B953-D3AD-423D-951D-E13EB3831B03', N'4', CAST(N'2016-03-12' AS Date), 1000, 0, N'SDFS')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3144, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'EB03D002-E9DD-459A-B798-433C45218EB2', N'5', CAST(N'2016-04-12' AS Date), 1000, 0, N'DFSDF')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3145, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'FEEF7E50-4970-4E8E-B07E-8BAC7A215157', N'6', CAST(N'2016-05-12' AS Date), 1000, 0, N'SDFS')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3146, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'2D52D70F-B9C9-46A5-9E26-22ABA894D91E', N'7', CAST(N'2016-06-12' AS Date), 1000, 0, N'DFS')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3147, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'637C5DF1-2D8E-4174-BCE0-81BE46EC9488', N'8', CAST(N'2016-07-12' AS Date), 1000, 0, N'FSDFS')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3148, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'B3F42CB1-7D3F-4767-AB37-177E6D404EF4', N'9', CAST(N'2016-08-12' AS Date), 1000, 0, N'DFS')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3149, CAST(N'2015-11-17 17:09:24.203' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'9e0e7679-dfbb-4912-822c-240b6ecdf921', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 5, 36332, CAST(N'2015-11-17' AS Date), N'FGDFG', N'GFDDFG', N'TRYRTYRTY', N'B0B161FF-126F-443F-96F3-936BEBB445BC', N'10', CAST(N'2016-09-12' AS Date), 1000, 0, N'DFSDF')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3150, CAST(N'2015-11-17 17:46:02.193' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'F46451E0-C5F1-49DC-A4B1-44F543B9D102', N'Ara Senet', CAST(N'2015-12-12' AS Date), 5000, 2000, N'asdadas')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3151, CAST(N'2015-11-17 17:53:21.740' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'EC55FD20-6561-4412-8AE2-414F745DEDD8', N'Ara Senet', CAST(N'2015-09-12' AS Date), 1500, 1000, N'asdsd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3152, CAST(N'2015-11-17 17:55:59.503' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'1595B77F-EA55-4C35-B420-79C3989DBD95', N'Ara Senet', CAST(N'2015-08-12' AS Date), 1500, 0, N'sad')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3153, CAST(N'2015-11-17 18:01:58.853' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'0DFD617F-18C7-4C00-AE3D-7E4C4A080567', N'Ara Senet', CAST(N'2015-12-12' AS Date), 4335, 3343, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3154, CAST(N'2015-11-18 10:25:10.810' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'07782d04-b787-4e42-8d38-ec86a13bb9c3', N'66b6de1c-7829-41d8-8506-ffec542910eb', N'e6f32f77-c537-4687-a677-edc931811f30', N'TUĞRUL NAZLI', 3, NULL, CAST(N'2015-07-02' AS Date), N'34 VN 6268', N'BEYAZ POLO DİZEL OTOMATİK', N'İSMAİL KAÇAK İLE KONUŞALACAK', N'F86D6A06-3E8D-4331-920D-AD4D856E0465', N'Ara Senet', CAST(N'2015-12-12' AS Date), 2332, 0, N'ffvdfv')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3155, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'276CBBF5-5459-4296-AF32-341C8BD1FE35', N'1', CAST(N'2012-12-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3156, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'D5F42F09-7DC9-4547-B0A6-DA6896382A94', N'2', CAST(N'2013-01-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3157, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'59671B1A-5F7C-45EE-85A4-3ABB5B0E50AF', N'3', CAST(N'2013-02-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3158, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'835217CD-7F4D-4FBF-8AD9-9753E526D417', N'4', CAST(N'2013-03-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3159, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'7810B1D9-DF8A-4072-B897-0DE5D1CAD195', N'5', CAST(N'2013-04-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3160, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'788D0CCA-88BE-47DD-A68A-A4C6B71C51AC', N'6', CAST(N'2013-05-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3161, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'FBC49E35-D87A-4EF6-BB1C-3E10AB461E9D', N'7', CAST(N'2013-06-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3162, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'4DC0D513-9C18-42DD-9D59-742334E7DA79', N'8', CAST(N'2013-07-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3163, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'35479E81-0D1B-4E2E-A844-74ADFDA6E87A', N'9', CAST(N'2013-08-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3164, CAST(N'2015-11-18 12:56:39.563' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'36904fc5-ee73-40d7-b21f-3d798db0919b', N'c9586307-eec8-437a-8771-1fef668146b1', N'J3TH8Y94M', N'ELLE GİR', 5, 50000, CAST(N'2015-12-12' AS Date), N'SADSAD', N'ASDASD', N'asd', N'8B07CDF3-7E1C-4EFE-94F1-08C8A22ED6EC', N'10', CAST(N'2013-09-21' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3165, CAST(N'2015-11-18 13:04:16.860' AS DateTime), N'290f3d6c-ba5b-4633-9576-564aa63ca7a8', N'8424b162-a488-4898-a4ea-7385a0203d5f', N'c9586307-eec8-437a-8771-1fef668146b1', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'ELLE GİR', 2, 10000, CAST(N'2012-12-12' AS Date), N'ASD', N'ASD', N'asd', N'B97AE0D5-F90C-4E8E-8213-34A76356F00F', N'1', CAST(N'2012-12-12' AS Date), 5555, 0, N'asd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3166, CAST(N'2015-11-18 13:04:16.860' AS DateTime), N'290f3d6c-ba5b-4633-9576-564aa63ca7a8', N'8424b162-a488-4898-a4ea-7385a0203d5f', N'c9586307-eec8-437a-8771-1fef668146b1', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'ELLE GİR', 2, 10000, CAST(N'2012-12-12' AS Date), N'ASD', N'ASD', N'asd', N'C69FD555-9F1A-409F-8F34-42C1B118A6F0', N'2', CAST(N'2013-01-12' AS Date), 5555, 0, N'asd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3167, CAST(N'2015-11-18 13:04:16.860' AS DateTime), N'290f3d6c-ba5b-4633-9576-564aa63ca7a8', N'8424b162-a488-4898-a4ea-7385a0203d5f', N'c9586307-eec8-437a-8771-1fef668146b1', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'ELLE GİR', 2, 10000, CAST(N'2012-12-12' AS Date), N'ASD', N'ASD', N'asd', N'22F744E1-BB22-4DD3-9681-5E7A602367A0', N'3', CAST(N'2013-02-12' AS Date), 5555, 0, N'asd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3168, CAST(N'2015-11-18 13:04:16.860' AS DateTime), N'290f3d6c-ba5b-4633-9576-564aa63ca7a8', N'8424b162-a488-4898-a4ea-7385a0203d5f', N'c9586307-eec8-437a-8771-1fef668146b1', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'ELLE GİR', 2, 10000, CAST(N'2012-12-12' AS Date), N'ASD', N'ASD', N'asd', N'AD973832-08C9-42C6-98D7-0C40DF3D0B3E', N'4', CAST(N'2013-03-12' AS Date), 5555, 0, N'asd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3169, CAST(N'2015-11-18 13:04:16.860' AS DateTime), N'290f3d6c-ba5b-4633-9576-564aa63ca7a8', N'8424b162-a488-4898-a4ea-7385a0203d5f', N'c9586307-eec8-437a-8771-1fef668146b1', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'ELLE GİR', 2, 10000, CAST(N'2012-12-12' AS Date), N'ASD', N'ASD', N'asd', N'25879B45-353D-4BD7-9903-8F19CC975344', N'5', CAST(N'2013-04-12' AS Date), 5555, 0, N'asd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3170, CAST(N'2015-11-18 13:18:26.790' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'1f7467c7-5db1-496e-a583-3380c6ccf138', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ELLE GİR', 3, 1000, CAST(N'2012-12-12' AS Date), N'ASDA', N'ASD', N'adsa', N'9A06D9B6-3FA8-4749-8F89-384E882FE7F8', N'1', CAST(N'2012-12-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3171, CAST(N'2015-11-18 13:18:26.790' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'1f7467c7-5db1-496e-a583-3380c6ccf138', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ELLE GİR', 3, 1000, CAST(N'2012-12-12' AS Date), N'ASDA', N'ASD', N'adsa', N'3F50AD70-6947-465F-BABA-C1686C673727', N'2', CAST(N'2013-01-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3172, CAST(N'2015-11-18 13:18:26.790' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'1f7467c7-5db1-496e-a583-3380c6ccf138', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ELLE GİR', 3, 1000, CAST(N'2012-12-12' AS Date), N'ASDA', N'ASD', N'adsa', N'D42643A0-5805-4551-B023-19BAAF0F4960', N'3', CAST(N'2013-02-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3173, CAST(N'2015-11-18 13:18:26.790' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'1f7467c7-5db1-496e-a583-3380c6ccf138', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ELLE GİR', 3, 1000, CAST(N'2012-12-12' AS Date), N'ASDA', N'ASD', N'adsa', N'F72CFF93-23F1-4850-AA45-1019F7EB099F', N'4', CAST(N'2013-03-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3174, CAST(N'2015-11-18 13:18:26.790' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'1f7467c7-5db1-496e-a583-3380c6ccf138', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ELLE GİR', 3, 1000, CAST(N'2012-12-12' AS Date), N'ASDA', N'ASD', N'adsa', N'A72DD9DB-BBC8-4408-AC25-E040665E700C', N'5', CAST(N'2013-04-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3175, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'C69F814F-2F0F-448C-A87D-D8DF7C29A2CC', N'1', CAST(N'2012-12-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3176, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'A3BEF639-3C99-4A3C-99F0-2021ED915951', N'2', CAST(N'2013-01-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3177, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'4FB8EE44-29DD-477D-967F-2B75EB5C245B', N'3', CAST(N'2013-02-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3178, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'F730FD48-F0AA-4F11-8C66-9CACBD1382C9', N'4', CAST(N'2013-03-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3179, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'E717244D-0405-4219-96C1-18428BF15680', N'5', CAST(N'2013-04-12' AS Date), 10000, 0, N'')
GO
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3180, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'9F36D21C-A86A-430D-9D41-AA93F01B23C3', N'6', CAST(N'2013-05-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3181, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'4678D75A-4A6B-4D14-9A3D-85CF47EB05E8', N'7', CAST(N'2013-06-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3182, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'05F380A9-7096-45E6-A32F-B763903C2E10', N'8', CAST(N'2013-07-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3183, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'642B0072-867C-424D-846F-024F7C70060A', N'9', CAST(N'2013-08-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3184, CAST(N'2015-11-18 13:20:06.683' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'455f07d5-8440-4a3e-9e80-ebb01129d010', N'c9586307-eec8-437a-8771-1fef668146b1', N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'EMRE ŞİRKET', 5, 100000, CAST(N'2012-12-12' AS Date), N'DSASD', N'ASDAS', N'ASD', N'8FEDFB33-5DC9-44C6-944A-D9416AA490FE', N'10', CAST(N'2013-09-12' AS Date), 10000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3185, CAST(N'2015-11-18 15:58:35.680' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'14984087-d1cd-455b-980f-036715ca42ac', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'8C301CAD-2151-4408-9CAD-C47BD573DD88', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3186, CAST(N'2015-11-18 15:58:35.680' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'14984087-d1cd-455b-980f-036715ca42ac', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'B87E73B1-2436-4888-A2F2-937BE67E0148', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3187, CAST(N'2015-11-18 15:58:35.680' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'14984087-d1cd-455b-980f-036715ca42ac', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3689BCBD-F677-4E71-9B7A-5615FAC20560', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3188, CAST(N'2015-11-18 15:58:35.680' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'14984087-d1cd-455b-980f-036715ca42ac', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'33AF9783-BB7E-497B-8360-8ED02B7E0882', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3189, CAST(N'2015-11-18 15:58:35.680' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'14984087-d1cd-455b-980f-036715ca42ac', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'5DF3F2DC-D74E-42C1-818D-C27EEF573178', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3190, CAST(N'2015-11-18 15:58:38.883' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5c6a5ff8-b0f2-4664-b06c-701cfa21120a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'CDFDB9E0-25FB-4706-B7C9-36830F618BC3', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3191, CAST(N'2015-11-18 15:58:38.883' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5c6a5ff8-b0f2-4664-b06c-701cfa21120a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'83CDB1E2-B2D8-429D-A1D5-5BC6E13579FE', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3192, CAST(N'2015-11-18 15:58:38.883' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5c6a5ff8-b0f2-4664-b06c-701cfa21120a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'E641DBF3-A495-403B-8BE9-264F540196DD', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3193, CAST(N'2015-11-18 15:58:38.883' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5c6a5ff8-b0f2-4664-b06c-701cfa21120a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'B0DD2E24-66BA-456B-91E0-7CD16C8EEB0F', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3194, CAST(N'2015-11-18 15:58:38.883' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5c6a5ff8-b0f2-4664-b06c-701cfa21120a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3E9A28A4-8A95-4E84-A1C3-7D45587DB51D', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3195, CAST(N'2015-11-18 15:58:39.447' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1e1b5e2-ac2f-4390-a5a1-a9046d7b0cb8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'E24C700F-2B98-4236-A856-CD0118D4B6CA', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3196, CAST(N'2015-11-18 15:58:39.447' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1e1b5e2-ac2f-4390-a5a1-a9046d7b0cb8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'51D7C6A5-53E8-43B1-948A-3F001E0061E2', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3197, CAST(N'2015-11-18 15:58:39.447' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1e1b5e2-ac2f-4390-a5a1-a9046d7b0cb8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C0DEB2E7-7AAA-4F26-AA99-42AF67E9B0CA', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3198, CAST(N'2015-11-18 15:58:39.447' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1e1b5e2-ac2f-4390-a5a1-a9046d7b0cb8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'EB4451E8-043B-4065-9C62-E4150F8327AD', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3199, CAST(N'2015-11-18 15:58:39.447' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1e1b5e2-ac2f-4390-a5a1-a9046d7b0cb8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'B91C79BA-02AC-4024-8924-06BE79BFF5B9', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3200, CAST(N'2015-11-18 15:58:39.633' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'429eba6f-02ad-4e07-901f-f6164354f15b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'5F31986B-C28B-41D9-BC9D-8E3A6F2FA038', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3201, CAST(N'2015-11-18 15:58:39.633' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'429eba6f-02ad-4e07-901f-f6164354f15b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'0AE39DFF-884C-4278-9D67-55001A39DC60', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3202, CAST(N'2015-11-18 15:58:39.633' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'429eba6f-02ad-4e07-901f-f6164354f15b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'7A8F3BDE-14AC-4F81-A1E8-37CED56713DF', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3203, CAST(N'2015-11-18 15:58:39.633' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'429eba6f-02ad-4e07-901f-f6164354f15b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'537CF841-5628-4234-A573-7693CD12FBE4', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3204, CAST(N'2015-11-18 15:58:39.633' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'429eba6f-02ad-4e07-901f-f6164354f15b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'5C545500-D934-4455-AACB-ADF7B471F3E7', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3205, CAST(N'2015-11-18 15:58:39.843' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'454802d4-1d53-4967-96a9-58ae937e1faf', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'4EBBB15F-612E-46C5-A9E9-662D63CDC5D5', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3206, CAST(N'2015-11-18 15:58:39.843' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'454802d4-1d53-4967-96a9-58ae937e1faf', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'E690415F-D13D-48C0-93CB-B4CE1EB33700', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3207, CAST(N'2015-11-18 15:58:39.843' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'454802d4-1d53-4967-96a9-58ae937e1faf', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'403C40EF-FEAB-4AA6-A464-9E5688FBE1FE', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3208, CAST(N'2015-11-18 15:58:39.843' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'454802d4-1d53-4967-96a9-58ae937e1faf', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'692FDD67-AAE4-4F4E-BFDD-1A619684127F', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3209, CAST(N'2015-11-18 15:58:39.843' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'454802d4-1d53-4967-96a9-58ae937e1faf', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C5D093B3-C415-4397-A441-DB61A8C08CF7', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3210, CAST(N'2015-11-18 15:58:40.043' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5f4e2ae6-c232-4881-ba7b-b7e88284cc7a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'E4466D2B-6915-4B4A-A85C-14850F29418C', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3211, CAST(N'2015-11-18 15:58:40.043' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5f4e2ae6-c232-4881-ba7b-b7e88284cc7a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'18DDAC29-700F-4BE1-8BA0-266D5C49ED7A', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3212, CAST(N'2015-11-18 15:58:40.043' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5f4e2ae6-c232-4881-ba7b-b7e88284cc7a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'CDBD7C90-A556-464D-9D85-2CEAC0B6CBB1', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3213, CAST(N'2015-11-18 15:58:40.043' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5f4e2ae6-c232-4881-ba7b-b7e88284cc7a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'96CC69E1-5F41-4BAD-B75A-A315DA56F0EA', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3214, CAST(N'2015-11-18 15:58:40.043' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'5f4e2ae6-c232-4881-ba7b-b7e88284cc7a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3198DF5D-DA12-4034-9B3C-3369D685A76A', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3215, CAST(N'2015-11-18 15:58:40.267' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c3e58e53-8c41-49ec-b431-f401050cded9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'FECE834C-B8A8-491C-856F-F69A595C63CC', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3216, CAST(N'2015-11-18 15:58:40.267' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c3e58e53-8c41-49ec-b431-f401050cded9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'9B86F9D3-2954-49F8-BF28-54B423E906A0', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3217, CAST(N'2015-11-18 15:58:40.267' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c3e58e53-8c41-49ec-b431-f401050cded9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'2FEBBE57-3597-46DE-AB20-E7B5F8F46329', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3218, CAST(N'2015-11-18 15:58:40.267' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c3e58e53-8c41-49ec-b431-f401050cded9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'FA9EEA78-09DF-4F3E-A721-6629BC67FBA2', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3219, CAST(N'2015-11-18 15:58:40.267' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c3e58e53-8c41-49ec-b431-f401050cded9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3487B790-657F-4EB7-9180-5E67B9BD4AEE', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3220, CAST(N'2015-11-18 15:58:40.470' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'034cd16a-94cf-4035-9afc-2c1764b7f832', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'60F4D1BA-C830-40CE-8226-8432E2FBB40D', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3221, CAST(N'2015-11-18 15:58:40.470' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'034cd16a-94cf-4035-9afc-2c1764b7f832', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'07E8DBA9-84AF-402E-A304-18223E8E7B62', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3222, CAST(N'2015-11-18 15:58:40.470' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'034cd16a-94cf-4035-9afc-2c1764b7f832', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C451D829-6FC3-4630-92A2-8792D50CD72D', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3223, CAST(N'2015-11-18 15:58:40.470' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'034cd16a-94cf-4035-9afc-2c1764b7f832', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'923E6B9C-385E-49DB-AD0A-FAF411495AAE', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3224, CAST(N'2015-11-18 15:58:40.470' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'034cd16a-94cf-4035-9afc-2c1764b7f832', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C8A862C0-78D9-4F1B-969F-4287C950BC49', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3225, CAST(N'2015-11-18 15:58:42.220' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'6959e5e3-60f4-4569-a202-7f9867b187f0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'8A550F78-0EAF-4A56-B690-337EC89DC751', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3226, CAST(N'2015-11-18 15:58:42.220' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'6959e5e3-60f4-4569-a202-7f9867b187f0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C1F35BE6-9A72-4235-B087-43F3248C88FB', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3227, CAST(N'2015-11-18 15:58:42.220' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'6959e5e3-60f4-4569-a202-7f9867b187f0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'100B2EA4-5933-44DA-9F10-E0174A868891', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3228, CAST(N'2015-11-18 15:58:42.220' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'6959e5e3-60f4-4569-a202-7f9867b187f0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'91B032AF-7AFC-4F17-808D-B1E96BC770C6', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3229, CAST(N'2015-11-18 15:58:42.220' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'6959e5e3-60f4-4569-a202-7f9867b187f0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3BEA30D5-BD47-4656-81D2-3B1329AF1296', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3230, CAST(N'2015-11-18 15:58:42.403' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b41f5fba-6aa3-4fe1-bba4-5f7dd967d880', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'EFC2FEC5-2C1D-4D32-B49C-4067B319FE98', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3231, CAST(N'2015-11-18 15:58:42.403' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b41f5fba-6aa3-4fe1-bba4-5f7dd967d880', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'D1E5910E-DC33-48FC-8840-F1587021558C', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3232, CAST(N'2015-11-18 15:58:42.403' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b41f5fba-6aa3-4fe1-bba4-5f7dd967d880', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'9068A131-F300-4FD3-B099-2D813C0A0775', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3233, CAST(N'2015-11-18 15:58:42.403' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b41f5fba-6aa3-4fe1-bba4-5f7dd967d880', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'13496C67-DE92-4030-9B1F-685C9772B184', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3234, CAST(N'2015-11-18 15:58:42.403' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b41f5fba-6aa3-4fe1-bba4-5f7dd967d880', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C2D50837-4B1E-4110-A24D-49441F0A44A4', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3235, CAST(N'2015-11-18 15:58:42.590' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'273b711a-887d-46fd-aba5-070fe0926afe', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'EF111DF0-CF94-4DDF-9547-62F97074C280', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3236, CAST(N'2015-11-18 15:58:42.590' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'273b711a-887d-46fd-aba5-070fe0926afe', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'9025A4A1-06B9-402B-94AA-B1C630AE0EAF', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3237, CAST(N'2015-11-18 15:58:42.590' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'273b711a-887d-46fd-aba5-070fe0926afe', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'AA7ABA57-7882-49F9-B078-452B8D2BA0E2', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3238, CAST(N'2015-11-18 15:58:42.590' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'273b711a-887d-46fd-aba5-070fe0926afe', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'7F7A50D6-25F6-4621-8F44-56AB7601FBEC', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3239, CAST(N'2015-11-18 15:58:42.590' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'273b711a-887d-46fd-aba5-070fe0926afe', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'2F16C8F3-1557-4EB1-A2D9-0F190332B029', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3240, CAST(N'2015-11-18 15:58:42.787' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b370fa1f-2836-4e51-8df8-da89a2a4b53f', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'59FFCB7B-D900-4624-A0E3-FC697127372D', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3241, CAST(N'2015-11-18 15:58:42.787' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b370fa1f-2836-4e51-8df8-da89a2a4b53f', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C7380127-90B2-446B-B511-B77757BA885C', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3242, CAST(N'2015-11-18 15:58:42.787' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b370fa1f-2836-4e51-8df8-da89a2a4b53f', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'62E096B0-5FE8-40F0-8B61-6785CFA97A41', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3243, CAST(N'2015-11-18 15:58:42.787' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b370fa1f-2836-4e51-8df8-da89a2a4b53f', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'F8E9F4E5-194C-4E47-AF21-F98F77300718', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3244, CAST(N'2015-11-18 15:58:42.787' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b370fa1f-2836-4e51-8df8-da89a2a4b53f', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3AA6285A-DB12-4BF9-AC87-2D6E153FAA75', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3245, CAST(N'2015-11-18 15:58:42.977' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b0a58ee2-2599-4684-855c-d65fa7b077d2', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'B3F96DE4-8653-41AD-AC4B-1969569A6236', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3246, CAST(N'2015-11-18 15:58:42.977' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b0a58ee2-2599-4684-855c-d65fa7b077d2', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'B8FADDB5-E863-47A5-A86B-CCDE951C6F6C', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3247, CAST(N'2015-11-18 15:58:42.977' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b0a58ee2-2599-4684-855c-d65fa7b077d2', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C5377722-DD28-49FF-BC61-D5CBB08D815F', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3248, CAST(N'2015-11-18 15:58:42.977' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b0a58ee2-2599-4684-855c-d65fa7b077d2', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'06937E70-1721-4896-A11C-1C8838169941', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3249, CAST(N'2015-11-18 15:58:42.977' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b0a58ee2-2599-4684-855c-d65fa7b077d2', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'12577676-FA1E-4E55-AE47-D0B75D70A418', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3250, CAST(N'2015-11-18 15:58:43.170' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0671b6c4-0c87-4962-8a71-8739278e0de7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'38BEAA66-E69C-40F2-A4F8-C9966EFE35A4', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3251, CAST(N'2015-11-18 15:58:43.170' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0671b6c4-0c87-4962-8a71-8739278e0de7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'AA558CA8-0883-4705-969B-6F3A5512CB07', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3252, CAST(N'2015-11-18 15:58:43.170' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0671b6c4-0c87-4962-8a71-8739278e0de7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'ABB7690D-EA8D-467C-A436-88F5EA4F5D73', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3253, CAST(N'2015-11-18 15:58:43.170' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0671b6c4-0c87-4962-8a71-8739278e0de7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'45A6CC1E-64B2-4582-B950-04533CEFE362', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3254, CAST(N'2015-11-18 15:58:43.170' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0671b6c4-0c87-4962-8a71-8739278e0de7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'800665C0-61A0-42BA-9876-BF334177FB03', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3255, CAST(N'2015-11-18 15:58:43.380' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c75faec0-cd1d-4c78-8906-a8b1f62659b3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'413DB984-6B81-4089-A09C-08F91E97B717', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3256, CAST(N'2015-11-18 15:58:43.380' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c75faec0-cd1d-4c78-8906-a8b1f62659b3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'BACF7777-1F5B-4420-9C45-5D5DAF617616', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3257, CAST(N'2015-11-18 15:58:43.380' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c75faec0-cd1d-4c78-8906-a8b1f62659b3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'AB537A16-3A58-4F8B-81E5-83A3ADE8A8C2', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3258, CAST(N'2015-11-18 15:58:43.380' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c75faec0-cd1d-4c78-8906-a8b1f62659b3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'2B9E56F1-6099-4AA4-B5D7-979878741CB0', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3259, CAST(N'2015-11-18 15:58:43.380' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c75faec0-cd1d-4c78-8906-a8b1f62659b3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'22C48C61-479E-46F5-8ACD-0C6D2F61D7B8', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3260, CAST(N'2015-11-18 15:58:43.557' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'59041203-4531-42ce-9486-3873841bf542', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'5F5544F9-EBC5-482D-BFC2-7B3A04467D4F', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3261, CAST(N'2015-11-18 15:58:43.557' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'59041203-4531-42ce-9486-3873841bf542', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'EF7CF8F1-59CD-44F8-98AE-206ED111A046', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3262, CAST(N'2015-11-18 15:58:43.557' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'59041203-4531-42ce-9486-3873841bf542', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'55F53C45-782A-45C5-9DDB-08A45648A274', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3263, CAST(N'2015-11-18 15:58:43.557' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'59041203-4531-42ce-9486-3873841bf542', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C4E6AB48-9DBD-402F-933A-15508843D2DB', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3264, CAST(N'2015-11-18 15:58:43.557' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'59041203-4531-42ce-9486-3873841bf542', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'9BFA8600-F2D0-4D1D-9EB3-701E817BCB9D', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3265, CAST(N'2015-11-18 15:58:53.570' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'014e79a3-4d42-4283-827a-9ce191fdd67b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'64BA7500-F61C-4463-89BF-AC1EC209384D', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3266, CAST(N'2015-11-18 15:58:53.570' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'014e79a3-4d42-4283-827a-9ce191fdd67b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'9B9A88FE-D5C3-4DF1-A1C3-7F292FD816AE', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3267, CAST(N'2015-11-18 15:58:53.570' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'014e79a3-4d42-4283-827a-9ce191fdd67b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3D8D2849-60EA-4438-9238-508855836662', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3268, CAST(N'2015-11-18 15:58:53.570' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'014e79a3-4d42-4283-827a-9ce191fdd67b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'F81C8958-B4A7-484E-98AF-C122E23530B7', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3269, CAST(N'2015-11-18 15:58:53.570' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'014e79a3-4d42-4283-827a-9ce191fdd67b', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'A8C7725B-60B7-4BD7-8B9B-830190E7D9F8', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3270, CAST(N'2015-11-18 15:59:19.253' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1175375e-dbfb-4456-8cb8-88d710e7003a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'6C645755-0998-4659-80E7-77DD4C317AD7', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3271, CAST(N'2015-11-18 15:59:19.253' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1175375e-dbfb-4456-8cb8-88d710e7003a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'CA192105-1D8E-40D5-AC8D-6F1ADD5D5BD2', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3272, CAST(N'2015-11-18 15:59:19.253' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1175375e-dbfb-4456-8cb8-88d710e7003a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'FE06ADB1-47F7-4883-AF29-7B4F8A0C70A7', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3273, CAST(N'2015-11-18 15:59:19.253' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1175375e-dbfb-4456-8cb8-88d710e7003a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'A86FC6F3-666F-423B-BA62-831DCAE88FA4', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3274, CAST(N'2015-11-18 15:59:19.253' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1175375e-dbfb-4456-8cb8-88d710e7003a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'8433071C-A4BB-41CD-ACB8-E8B79E740F0C', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3275, CAST(N'2015-11-18 15:59:19.613' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd13ee5c2-00c6-46a5-87c8-e69528021573', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'1CD43A63-EF3C-4241-8088-0647844F8FFE', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3276, CAST(N'2015-11-18 15:59:19.613' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd13ee5c2-00c6-46a5-87c8-e69528021573', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'195768D0-1195-477F-9F25-4DC7DEC82DF0', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3277, CAST(N'2015-11-18 15:59:19.613' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd13ee5c2-00c6-46a5-87c8-e69528021573', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'127BA724-772E-4AE4-84EF-52EE3223ACD2', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3278, CAST(N'2015-11-18 15:59:19.613' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd13ee5c2-00c6-46a5-87c8-e69528021573', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'135E46FE-FE54-445E-BFA0-0BD70962CFBF', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3279, CAST(N'2015-11-18 15:59:19.613' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd13ee5c2-00c6-46a5-87c8-e69528021573', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3F987CD8-D9EE-4EBB-A1E8-7BD91B40F799', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
GO
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3280, CAST(N'2015-11-18 15:59:19.800' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd7325a4c-1241-498a-bcb7-7e98fc132fb3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'6003D114-104D-444D-95AC-1F0E8EBF929E', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3281, CAST(N'2015-11-18 15:59:19.800' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd7325a4c-1241-498a-bcb7-7e98fc132fb3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'98CA7843-DC00-44CB-923F-0927F1B9E43C', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3282, CAST(N'2015-11-18 15:59:19.800' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd7325a4c-1241-498a-bcb7-7e98fc132fb3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'690C9A74-7F73-40F2-882B-8FEE3BD49C31', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3283, CAST(N'2015-11-18 15:59:19.800' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd7325a4c-1241-498a-bcb7-7e98fc132fb3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'E907C935-2C84-4FFD-A2D2-31AB1A2A1DAC', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3284, CAST(N'2015-11-18 15:59:19.800' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'd7325a4c-1241-498a-bcb7-7e98fc132fb3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'F21BC3CA-7C36-4CC2-8272-99676F7773DC', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3285, CAST(N'2015-11-18 15:59:20.013' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c965cf13-da54-47ff-81ae-6a075bf6e3e0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'66CA1636-6554-407D-9D14-F99BD6AE5B3F', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3286, CAST(N'2015-11-18 15:59:20.013' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c965cf13-da54-47ff-81ae-6a075bf6e3e0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'372C9E5F-3995-411C-B3A0-ADE2805EAA29', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3287, CAST(N'2015-11-18 15:59:20.013' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c965cf13-da54-47ff-81ae-6a075bf6e3e0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'85E78A9A-EC27-4F2E-A4B2-297106DBC7C3', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3288, CAST(N'2015-11-18 15:59:20.013' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c965cf13-da54-47ff-81ae-6a075bf6e3e0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'9C75E316-4DEE-4DCC-99B5-606FF30ABEF2', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3289, CAST(N'2015-11-18 15:59:20.013' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'c965cf13-da54-47ff-81ae-6a075bf6e3e0', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'F928448D-8546-41C9-A4C2-8ED712259DE2', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3290, CAST(N'2015-11-18 15:59:20.230' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'f09b3ce7-105a-4c0f-836a-cdc2bf9187d9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'8783BB6B-6585-4EE2-AD3F-8D5AEB6A7A74', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3291, CAST(N'2015-11-18 15:59:20.230' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'f09b3ce7-105a-4c0f-836a-cdc2bf9187d9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'A1306156-33F7-4052-A503-BB7BEEE5F13E', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3292, CAST(N'2015-11-18 15:59:20.230' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'f09b3ce7-105a-4c0f-836a-cdc2bf9187d9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'6C29D170-9B2B-4BAC-A104-78FD5A520F00', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3293, CAST(N'2015-11-18 15:59:20.230' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'f09b3ce7-105a-4c0f-836a-cdc2bf9187d9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'911FAB16-8C5F-4CB1-B5C3-96455C03A385', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3294, CAST(N'2015-11-18 15:59:20.230' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'f09b3ce7-105a-4c0f-836a-cdc2bf9187d9', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'ADF669E7-479D-4DA7-98A7-3E003E8F29C4', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3295, CAST(N'2015-11-18 15:59:58.840' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1b6d8b36-a69b-4773-ad93-cfc603143cd8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'F2A04945-2029-4900-AA51-A90266D7A5D9', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3296, CAST(N'2015-11-18 15:59:58.840' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1b6d8b36-a69b-4773-ad93-cfc603143cd8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'EEADA05D-9446-436C-A722-94DC25FA49D7', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3297, CAST(N'2015-11-18 15:59:58.840' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1b6d8b36-a69b-4773-ad93-cfc603143cd8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'0E20263D-58D5-401E-9728-3E3823FAC841', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3298, CAST(N'2015-11-18 15:59:58.840' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1b6d8b36-a69b-4773-ad93-cfc603143cd8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'EA0F5750-B68F-480A-9E69-3B055FDEB487', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3299, CAST(N'2015-11-18 15:59:58.840' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'1b6d8b36-a69b-4773-ad93-cfc603143cd8', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'4398DC4E-DE3A-414A-AAA1-C37EDECC59C0', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3300, CAST(N'2015-11-18 15:59:59.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'64d06028-6135-44b5-9893-3e16bf53976e', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'152E4573-6323-48E8-B648-B429E653F007', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3301, CAST(N'2015-11-18 15:59:59.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'64d06028-6135-44b5-9893-3e16bf53976e', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'27D4CE7E-45C2-4BC9-B7D5-70D05D1722C3', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3302, CAST(N'2015-11-18 15:59:59.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'64d06028-6135-44b5-9893-3e16bf53976e', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'3B0B2B0A-D388-4F8C-94FC-D9CFB6FCF372', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3303, CAST(N'2015-11-18 15:59:59.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'64d06028-6135-44b5-9893-3e16bf53976e', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'BE9FC758-80DF-4F28-92E0-30C994A215F9', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3304, CAST(N'2015-11-18 15:59:59.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'64d06028-6135-44b5-9893-3e16bf53976e', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'0E46A646-DF6F-4E48-969E-DCC2DD34FC1E', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3305, CAST(N'2015-11-18 15:59:59.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'be834ec6-58fb-4dcf-a7d9-ffce7c63c1e6', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'B510D82B-E7B8-42FB-A6C6-F20528535A13', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3306, CAST(N'2015-11-18 15:59:59.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'be834ec6-58fb-4dcf-a7d9-ffce7c63c1e6', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'0CA85352-5B37-4D1A-B05E-A0AA76BEDD69', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3307, CAST(N'2015-11-18 15:59:59.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'be834ec6-58fb-4dcf-a7d9-ffce7c63c1e6', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'F206406A-5FB5-4C50-B3B7-9D0D0FA64EE9', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3308, CAST(N'2015-11-18 15:59:59.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'be834ec6-58fb-4dcf-a7d9-ffce7c63c1e6', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'0495D7AE-0A43-4C1D-9836-F8CBB8C4FF23', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3309, CAST(N'2015-11-18 15:59:59.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'be834ec6-58fb-4dcf-a7d9-ffce7c63c1e6', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'E82559C8-5369-4978-A07D-8C68EDBD96AB', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3310, CAST(N'2015-11-18 16:00:00.207' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'2830b201-7da9-4b34-8036-87bab0d69baa', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'790C280F-766E-419B-854A-7BCEAD3D5148', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3311, CAST(N'2015-11-18 16:00:00.207' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'2830b201-7da9-4b34-8036-87bab0d69baa', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'37AED942-765A-4DA0-A5F4-0866172EAB72', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3312, CAST(N'2015-11-18 16:00:00.207' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'2830b201-7da9-4b34-8036-87bab0d69baa', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'9BFC652D-7039-4B03-BB18-96E38FE25744', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3313, CAST(N'2015-11-18 16:00:00.207' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'2830b201-7da9-4b34-8036-87bab0d69baa', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'C9C00161-FB4B-4773-95FA-CA920A0E5CE8', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3314, CAST(N'2015-11-18 16:00:00.207' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'2830b201-7da9-4b34-8036-87bab0d69baa', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'47DEC881-D9B2-4D6D-90D5-D31A869F8652', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3315, CAST(N'2015-11-18 16:00:00.407' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0edd4b24-8ed0-401f-946d-9011e75137e3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'771ED072-80C3-4F7D-B372-A4C4CE16238D', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3316, CAST(N'2015-11-18 16:00:00.407' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0edd4b24-8ed0-401f-946d-9011e75137e3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'BE2ABF71-C0E9-41C7-9D69-7352120FB45A', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3317, CAST(N'2015-11-18 16:00:00.407' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0edd4b24-8ed0-401f-946d-9011e75137e3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'FCAB01FC-25EA-4EE9-B8D2-5E2B38B62900', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3318, CAST(N'2015-11-18 16:00:00.407' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0edd4b24-8ed0-401f-946d-9011e75137e3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'DA840568-6E77-444B-9FE5-277B1954A72F', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3319, CAST(N'2015-11-18 16:00:00.407' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'0edd4b24-8ed0-401f-946d-9011e75137e3', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'56EE64BF-4327-46A5-9306-56EBB1F5193A', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3320, CAST(N'2015-11-18 16:00:00.567' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'eb14b96e-ce07-47ba-b040-561a82f4d813', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'07352DC5-717D-4CB6-BEDA-DE1D1B51E1C6', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3321, CAST(N'2015-11-18 16:00:00.567' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'eb14b96e-ce07-47ba-b040-561a82f4d813', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'CB1A8F90-13BF-473B-A13D-9C2DFC483AC2', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3322, CAST(N'2015-11-18 16:00:00.567' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'eb14b96e-ce07-47ba-b040-561a82f4d813', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'EA90863B-9D2B-41D3-AF36-80E3B6B95E53', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3323, CAST(N'2015-11-18 16:00:00.567' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'eb14b96e-ce07-47ba-b040-561a82f4d813', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'58CD5BEA-F401-48C5-9C56-951A7E5BF9FA', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3324, CAST(N'2015-11-18 16:00:00.567' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'eb14b96e-ce07-47ba-b040-561a82f4d813', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'A4F399DE-DA59-4F6F-BC3F-8C2E6AA323AB', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3325, CAST(N'2015-11-18 16:00:00.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1565877-9ba2-4186-8484-2cd56e44085c', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'5976FE49-B9CC-4963-A767-5F3DAD512F8F', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3326, CAST(N'2015-11-18 16:00:00.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1565877-9ba2-4186-8484-2cd56e44085c', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'A9F7D5A4-F35B-4977-8AD5-376801B04834', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3327, CAST(N'2015-11-18 16:00:00.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1565877-9ba2-4186-8484-2cd56e44085c', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'54FA8CEB-5332-4A2C-BD2B-164800292290', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3328, CAST(N'2015-11-18 16:00:00.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1565877-9ba2-4186-8484-2cd56e44085c', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'94EACB93-2FD6-4E60-BB03-1C5E2FDC8664', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3329, CAST(N'2015-11-18 16:00:00.770' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'e1565877-9ba2-4186-8484-2cd56e44085c', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'2A1DF424-AC7A-453C-B7F1-009D3C11525E', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3330, CAST(N'2015-11-18 16:00:01.340' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b13d6bce-508e-4103-90e0-f34410356b45', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'DE2D79A9-10E6-413A-B234-FEECC63BAC28', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3331, CAST(N'2015-11-18 16:00:01.340' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b13d6bce-508e-4103-90e0-f34410356b45', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'67ED3593-45E8-4D1C-AA6A-406C8CC8A727', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3332, CAST(N'2015-11-18 16:00:01.340' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b13d6bce-508e-4103-90e0-f34410356b45', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'5305C53E-FBCE-4763-9306-BEE532FF0B39', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3333, CAST(N'2015-11-18 16:00:01.340' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b13d6bce-508e-4103-90e0-f34410356b45', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'D04B182D-00AD-4C34-9399-81BE1BA97185', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3334, CAST(N'2015-11-18 16:00:01.340' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'b13d6bce-508e-4103-90e0-f34410356b45', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'E080E709-30BC-4096-9510-6A443D73C911', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3335, CAST(N'2015-11-18 16:00:01.533' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'56297dda-02d7-4c23-b324-1323db1ef0f7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'09AD978B-DB13-45F6-B463-3F1B6FE0A610', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3336, CAST(N'2015-11-18 16:00:01.533' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'56297dda-02d7-4c23-b324-1323db1ef0f7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'F51EA276-3F00-4CAD-8AE5-AD002E8AEBA4', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3337, CAST(N'2015-11-18 16:00:01.533' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'56297dda-02d7-4c23-b324-1323db1ef0f7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'FF0A5431-2E04-4AAC-AA0F-B0CB421301A4', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3338, CAST(N'2015-11-18 16:00:01.533' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'56297dda-02d7-4c23-b324-1323db1ef0f7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'2181AA5B-57BA-450A-B9F5-D6BFFAA13131', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3339, CAST(N'2015-11-18 16:00:01.533' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'56297dda-02d7-4c23-b324-1323db1ef0f7', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'CE8D3A70-9C0F-40A9-88E0-9E6177C2551A', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3340, CAST(N'2015-11-18 16:00:03.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'3162a0ec-f13b-4c92-bd88-740889254b9a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'19BDA950-FBD5-4D71-871A-F4D23431DBC4', N'1', CAST(N'2015-12-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3341, CAST(N'2015-11-18 16:00:03.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'3162a0ec-f13b-4c92-bd88-740889254b9a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'91AF8170-8E0D-4DAE-8621-8695B1C8F37D', N'2', CAST(N'2016-01-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3342, CAST(N'2015-11-18 16:00:03.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'3162a0ec-f13b-4c92-bd88-740889254b9a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'E8B7A3DD-945F-47A9-942E-A7B1C7963455', N'3', CAST(N'2016-02-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3343, CAST(N'2015-11-18 16:00:03.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'3162a0ec-f13b-4c92-bd88-740889254b9a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'FBB1C090-ED74-4FA3-A4D0-E13B4BE8DFA5', N'4', CAST(N'2016-03-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3344, CAST(N'2015-11-18 16:00:03.960' AS DateTime), N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'3162a0ec-f13b-4c92-bd88-740889254b9a', N'J3TH8Y94M', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'ŞİRKET', 5, 10000, CAST(N'2015-12-12' AS Date), N'DDSA', N'SDSD', N'sdsd', N'6E1EF36A-536F-416F-B459-D71E53E82B4D', N'5', CAST(N'2016-04-12' AS Date), 5, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3345, CAST(N'2015-11-18 16:29:04.893' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'2f0c8768-e0ef-4f9f-bf6b-b6524a4f6924', N'J3TH8Y94M', N'afdb6668-a17d-432f-8c9e-3c42c080f200', N'ŞİRKET', 12, 15000, CAST(N'2015-12-12' AS Date), N'DSA', N'ADS', N'asd', N'1C2BF989-A5CA-4072-AA71-1CCC96D1002B', N'1', CAST(N'2015-12-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3346, CAST(N'2015-11-18 16:29:04.893' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'2f0c8768-e0ef-4f9f-bf6b-b6524a4f6924', N'J3TH8Y94M', N'afdb6668-a17d-432f-8c9e-3c42c080f200', N'ŞİRKET', 12, 15000, CAST(N'2015-12-12' AS Date), N'DSA', N'ADS', N'asd', N'41856C0E-C67A-4BDE-990F-6C3E4768FE52', N'2', CAST(N'2016-01-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3347, CAST(N'2015-11-18 16:29:04.893' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'2f0c8768-e0ef-4f9f-bf6b-b6524a4f6924', N'J3TH8Y94M', N'afdb6668-a17d-432f-8c9e-3c42c080f200', N'ŞİRKET', 12, 15000, CAST(N'2015-12-12' AS Date), N'DSA', N'ADS', N'asd', N'F64C0D90-9AA0-4020-A2A0-77357301CADA', N'3', CAST(N'2016-02-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3348, CAST(N'2015-11-18 16:29:04.893' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'2f0c8768-e0ef-4f9f-bf6b-b6524a4f6924', N'J3TH8Y94M', N'afdb6668-a17d-432f-8c9e-3c42c080f200', N'ŞİRKET', 12, 15000, CAST(N'2015-12-12' AS Date), N'DSA', N'ADS', N'asd', N'8584A36E-1CC8-4EF0-90DA-110F76B06427', N'4', CAST(N'2016-03-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3349, CAST(N'2015-11-18 16:29:04.893' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'2f0c8768-e0ef-4f9f-bf6b-b6524a4f6924', N'J3TH8Y94M', N'afdb6668-a17d-432f-8c9e-3c42c080f200', N'ŞİRKET', 12, 15000, CAST(N'2015-12-12' AS Date), N'DSA', N'ADS', N'asd', N'78F4D7DA-DFF5-4E4F-9BDC-BEA22D91CDF4', N'5', CAST(N'2016-04-12' AS Date), 1000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3350, CAST(N'2015-11-18 16:34:02.867' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'5805f7a2-1592-49c0-9edd-95cc490ad2fa', N'J3TH8Y94M', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'ŞİRKET', 2, 1000, CAST(N'2015-12-12' AS Date), N'S', N'SD', N'dsd', N'52475665-CFA9-4F5A-AD38-3CDA86FB608F', N'1', CAST(N'2015-12-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3351, CAST(N'2015-11-18 16:34:02.867' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'5805f7a2-1592-49c0-9edd-95cc490ad2fa', N'J3TH8Y94M', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'ŞİRKET', 2, 1000, CAST(N'2015-12-12' AS Date), N'S', N'SD', N'dsd', N'12FF887B-C157-4C5E-B69E-6081FAE18CE3', N'2', CAST(N'2016-01-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3352, CAST(N'2015-11-18 16:34:02.867' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'5805f7a2-1592-49c0-9edd-95cc490ad2fa', N'J3TH8Y94M', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'ŞİRKET', 2, 1000, CAST(N'2015-12-12' AS Date), N'S', N'SD', N'dsd', N'F021CCE6-39AA-46A3-9E7A-210BAEC53116', N'3', CAST(N'2016-02-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3353, CAST(N'2015-11-18 16:34:02.867' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'5805f7a2-1592-49c0-9edd-95cc490ad2fa', N'J3TH8Y94M', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'ŞİRKET', 2, 1000, CAST(N'2015-12-12' AS Date), N'S', N'SD', N'dsd', N'41B6508F-5843-41BA-98F6-B2287F76E67F', N'4', CAST(N'2016-03-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3354, CAST(N'2015-11-18 16:34:02.867' AS DateTime), N'ecb2cab6-c555-4e26-afc4-4ea251f1ad8e', N'5805f7a2-1592-49c0-9edd-95cc490ad2fa', N'J3TH8Y94M', N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'ŞİRKET', 2, 1000, CAST(N'2015-12-12' AS Date), N'S', N'SD', N'dsd', N'CA4E30E9-FE64-4E33-963D-E1D2A918D3D7', N'5', CAST(N'2016-04-12' AS Date), 5000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3355, CAST(N'2015-11-18 17:22:36.667' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'f71480fd-64aa-433d-b99f-1fbd9f448367', N'J3TH8Y94M', N'c9586307-eec8-437a-8771-1fef668146b1', N'ŞİRKET', 1, 2015, CAST(N'2015-12-12' AS Date), N'SS', N'DDD', N'sd', N'736EC32D-5EBC-48C5-86A5-E681F03EB128', N'1', CAST(N'2015-12-12' AS Date), 21212, 0, N'sd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3356, CAST(N'2015-11-18 17:22:36.667' AS DateTime), N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'f71480fd-64aa-433d-b99f-1fbd9f448367', N'J3TH8Y94M', N'c9586307-eec8-437a-8771-1fef668146b1', N'ŞİRKET', 1, 2015, CAST(N'2015-12-12' AS Date), N'SS', N'DDD', N'sd', N'2A55FB1D-FB1E-4249-A9FE-532BDE9328BF', N'2', CAST(N'2016-01-12' AS Date), 21212, 0, N'sd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3357, CAST(N'2015-11-18 17:23:29.503' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'69125dec-4780-4873-b7b2-29230c59b807', N'J3TH8Y94M', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2, 22222, CAST(N'2015-12-12' AS Date), N'22CDS', N'SASA', N'sd', N'809D7D95-055E-406D-94A4-F7BEC637D461', N'1', CAST(N'2015-12-12' AS Date), 222, 0, N'dsd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3358, CAST(N'2015-11-18 17:23:29.503' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'69125dec-4780-4873-b7b2-29230c59b807', N'J3TH8Y94M', N'36c931c9-e75f-4c85-b6f5-7680bcc66e71', N'ŞİRKET', 2, 22222, CAST(N'2015-12-12' AS Date), N'22CDS', N'SASA', N'sd', N'F8CE313C-5CD8-469E-84D6-DACC86438F52', N'2', CAST(N'2016-01-12' AS Date), 222, 0, N'sd')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3359, CAST(N'2015-11-18 17:39:38.323' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'a2a18268-a3d7-4e3b-8900-ee6ef1777103', N'c9586307-eec8-437a-8771-1fef668146b1', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 2, 2222, CAST(N'2012-12-12' AS Date), N'DFSD', N'SDF', N'sdf', N'C79A9C11-C634-4240-ABA4-85072C5AC64D', N'1', CAST(N'2012-12-12' AS Date), 2222, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3360, CAST(N'2015-11-18 17:39:38.323' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'a2a18268-a3d7-4e3b-8900-ee6ef1777103', N'c9586307-eec8-437a-8771-1fef668146b1', N'6013ef27-d07f-4cab-9eb1-cda4cd7deb77', N'ŞİRKET', 2, 2222, CAST(N'2012-12-12' AS Date), N'DFSD', N'SDF', N'sdf', N'7348751F-C9C0-46E7-8672-A12AF876CD40', N'2', CAST(N'2013-01-12' AS Date), 2222, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3361, CAST(N'2015-11-18 17:46:55.833' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'414a7ebc-24ca-49e6-84be-2f40b819e386', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'c9586307-eec8-437a-8771-1fef668146b1', N'ŞİRKET', 2, 11111, CAST(N'2015-12-12' AS Date), N'111DD', N'DDD', N'd', N'1E2716D9-2BE5-4C94-8569-B205A1AE6C7A', N'1', CAST(N'2015-12-12' AS Date), 2222, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3362, CAST(N'2015-11-18 17:46:55.833' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'414a7ebc-24ca-49e6-84be-2f40b819e386', N'ac1efd39-c961-4371-bab1-63d6fb9f31a2', N'c9586307-eec8-437a-8771-1fef668146b1', N'ŞİRKET', 2, 11111, CAST(N'2015-12-12' AS Date), N'111DD', N'DDD', N'd', N'A6F2488F-EAAC-4784-AC46-6F0421AAB3BA', N'2', CAST(N'2016-01-12' AS Date), 2222, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3363, CAST(N'2015-11-18 17:50:04.927' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'3c3715f6-b8e2-4d02-8762-39eb21ba4455', N'', N'', N'ŞİRKET', 12, 1212, CAST(N'2015-12-12' AS Date), N'2X', N'X', N'x', N'1B82A3D0-E4E0-4DA0-BFF8-C15500799153', N'1', CAST(N'2015-12-12' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3364, CAST(N'2015-11-18 17:50:04.927' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'3c3715f6-b8e2-4d02-8762-39eb21ba4455', N'', N'', N'ŞİRKET', 12, 1212, CAST(N'2015-12-12' AS Date), N'2X', N'X', N'x', N'9EF720B5-A2A5-4E96-A70E-6FC2E4EA3965', N'2', CAST(N'2016-01-12' AS Date), 100, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3365, CAST(N'2015-11-18 17:55:51.143' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'0b37b9ed-5200-4960-8244-80174a2ffc50', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'', N'ŞİRKET', 11, 12122, CAST(N'2015-12-12' AS Date), N'1DD', N'DSD', N'asd', N'707BFFC8-48FE-4229-AE79-CDA25C08EDB7', N'1', CAST(N'2015-12-12' AS Date), 2, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3366, CAST(N'2015-11-18 17:55:51.143' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'0b37b9ed-5200-4960-8244-80174a2ffc50', N'fecb582c-bca6-4404-8eb4-bb3864fbb3d3', N'', N'ŞİRKET', 11, 12122, CAST(N'2015-12-12' AS Date), N'1DD', N'DSD', N'asd', N'36C918CA-FE55-44DF-A682-3ACA2689C4EC', N'2', CAST(N'2016-01-12' AS Date), 2, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3367, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'13AC329E-7677-4CD7-921F-17D4EC7492E9', N'1', CAST(N'2015-12-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3368, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'B719D471-2555-402E-9058-37F55FC74E9B', N'2', CAST(N'2016-01-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3369, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'96B21FB5-DCB7-4BB6-B4C9-0D658E599894', N'3', CAST(N'2016-02-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3370, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'CE0DFA54-D0D3-473C-93D9-88CAEC9F2C7B', N'4', CAST(N'2016-03-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3371, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'A175E235-4424-497E-B86B-338DD22337EF', N'5', CAST(N'2016-04-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3372, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'C05EF3EE-0D4F-4B7C-889A-D80918AA6FD6', N'6', CAST(N'2016-05-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3373, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'E119E44A-3699-4AD7-8F9A-0523DB1E320B', N'7', CAST(N'2016-06-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3374, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'D85E68DD-B855-4BBF-8A61-8C8E031FBD38', N'8', CAST(N'2016-07-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3375, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'6AFE7B7E-EB11-47F3-A866-E9D1831E0FE8', N'9', CAST(N'2016-08-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3376, CAST(N'2015-11-18 17:57:07.343' AS DateTime), N'8be63a09-92f8-442b-99f2-7cde5f545d5f', N'e5fa25b0-738f-434f-803c-32800a6e2bab', N'', N'', N'ŞİRKET', 5, 2255, CAST(N'2015-12-12' AS Date), N'DDS', N'DS', N'sd', N'875775CE-6571-4BFD-9577-C71B8881B274', N'10', CAST(N'2016-09-12' AS Date), 110000, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3377, CAST(N'2015-11-18 18:04:46.980' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'1077b8a0-0047-4794-ae07-d76938e90972', N'', N'', N'ŞİRKET', 5, 4444, CAST(N'2015-12-12' AS Date), N'JHG', N'GDFG', N'dfg', N'79672D6B-AFC6-4FE4-8856-3200E8F51943', N'1', CAST(N'2015-12-12' AS Date), 2222, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3378, CAST(N'2015-11-18 18:04:46.980' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'1077b8a0-0047-4794-ae07-d76938e90972', N'', N'', N'ŞİRKET', 5, 4444, CAST(N'2015-12-12' AS Date), N'JHG', N'GDFG', N'dfg', N'D50D7101-CBDD-4BD2-9110-7274D7270FC6', N'2', CAST(N'2016-01-12' AS Date), 22222, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3379, CAST(N'2015-11-18 18:05:46.673' AS DateTime), N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'de81628d-09ef-4056-9829-28a68bd88d66', N'', N'', N'ŞİRKET', 1, 1111, CAST(N'2012-12-12' AS Date), N'2DFGd', N'FGD', N'dfg', N'4F42CE04-D2BD-4EA4-B4AE-CDBA2F8D948E', N'1', CAST(N'2015-12-12' AS Date), 21, 0, N'')
GO
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3380, CAST(N'2015-11-18 18:05:46.673' AS DateTime), N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'de81628d-09ef-4056-9829-28a68bd88d66', N'', N'', N'ŞİRKET', 1, 1111, CAST(N'2012-12-12' AS Date), N'2DFGd', N'FGD', N'dfg', N'088CB08F-1CC5-468A-A656-8443B4090B50', N'2', CAST(N'2016-01-12' AS Date), 21, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3381, CAST(N'2015-11-18 18:15:38.967' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'7f7265ab-30b9-4aaa-b1a9-d4ca8d2e4537', N'', N'', N'ŞİRKET', 22, 222, CAST(N'2012-12-12' AS Date), N'222', N'222', N'22', N'4F34A2D9-5C2E-411F-9D19-6CC38A598773', N'1', CAST(N'2012-12-22' AS Date), 22, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3382, CAST(N'2015-11-18 18:15:38.967' AS DateTime), N'ae0e789f-976a-469b-a043-387da5576811', N'7f7265ab-30b9-4aaa-b1a9-d4ca8d2e4537', N'', N'', N'ŞİRKET', 22, 222, CAST(N'2012-12-12' AS Date), N'222', N'222', N'22', N'CC0ADCE4-CE2A-4F72-A044-B2438C7C3A86', N'2', CAST(N'2013-01-22' AS Date), 22, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3383, CAST(N'2015-11-18 18:31:03.710' AS DateTime), N'8546374d-41c0-4568-9e9c-905c5a103fba', N'1077b8a0-0047-4794-ae07-d76938e90972', N'', N'', N'ŞİRKET', 5, NULL, CAST(N'2015-12-12' AS Date), N'JHG', N'GDFG', N'dfg', N'71C85C3A-1985-45E6-9D00-22C0DEED6051', N'Ara Senet', CAST(N'2012-12-12' AS Date), 22222, 0, N'gh')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3384, CAST(N'2015-11-18 18:32:00.463' AS DateTime), N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'5cf6b85a-41b1-48dd-a7a8-d9789e286dcb', N'', N'', N'ŞİRKET', 3, 523, CAST(N'2015-12-12' AS Date), N'DSF', N'SDF', N'sdf', N'98503E4E-4675-4975-AB93-A28D6EDF0AA5', N'1', CAST(N'2015-12-12' AS Date), 2, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3385, CAST(N'2015-11-18 18:32:00.463' AS DateTime), N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'5cf6b85a-41b1-48dd-a7a8-d9789e286dcb', N'', N'', N'ŞİRKET', 3, 523, CAST(N'2015-12-12' AS Date), N'DSF', N'SDF', N'sdf', N'C7468674-53F1-4C1E-B8B1-71CEE7E96BC2', N'2', CAST(N'2016-01-12' AS Date), 2, 0, N'')
INSERT [dbo].[SenetBloklari] ([id], [AddDate], [Borclu], [SenetBlokID], [Kefil], [SenetiImzalayan], [AlacakTipi], [VadeOrani], [AnaPara], [SenetOlusturulmaTarihi], [AracPlakasi], [AracBasligi], [SenetBlokNot], [SenetID], [SenetBlokNo], [OdemeTarihi], [Miktar], [Odenen], [SenetNot]) VALUES (3386, CAST(N'2015-11-18 18:32:19.553' AS DateTime), N'2c278c98-bbc6-465c-a4d2-ffe611df885a', N'5cf6b85a-41b1-48dd-a7a8-d9789e286dcb', N'', N'', N'ŞİRKET', 3, NULL, CAST(N'2015-12-12' AS Date), N'DSF', N'SDF', N'sdf', N'41BCACAF-6D7B-4F11-ACB3-DB59CBCADDA0', N'Ara Senet', CAST(N'2016-12-12' AS Date), 3, 0, N'sad')
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
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (15, N'37146a21-4c7a-4550-90a3-e8c6c90605a7', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (23, N'51a9936b-2dac-4c66-b2ef-856c92e19245', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (30, N'8394c017-2e34-411e-af47-d2f1343a86f7', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (31, N'3e0b617a-ec8f-4276-961b-b7206c42ac33', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (32, N'4e6b0af0-2e03-485d-81ce-3b6cd51eba2d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (33, N'726b2c32-bcf8-4464-99e1-2fdf8760457e', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (34, N'7b001f80-bf17-4fd6-8260-1b263154cce3', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (35, N'e03cff83-e063-4830-9626-6a63c888f2b0', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (36, N'8479afb5-21a1-4dfb-ac23-e189b1a13029', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (37, N'81c85cd1-9292-4c08-ae9e-a759fc4a22e5', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (38, N'1f69f9cc-6aed-4db8-b4ba-290261042317', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (39, N'3b251e2b-9029-4c95-8a65-e686b00ded18', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (40, N'e7e3a9b2-f1af-4797-8d4e-e77774bb76ee', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (41, N'f49d64a3-b562-41b7-a747-c5b7399842b9', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (42, N'64b7ec51-9924-453b-a44a-58113b39a81a', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (43, N'fe25e1fd-898c-49c4-a502-a5aefcafcdd2', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (44, N'd6866974-bc54-4b35-b498-e9192da3fa26', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (45, N'411f306e-ef0f-49bd-ba91-35ff27728df7', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (46, N'54af0552-cb99-4276-b136-2cb187a57bed', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (47, N'cb28854c-0e0e-4890-b9df-d6c865943c2d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (48, N'4a1f7705-050a-440f-8726-885817ba22c7', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (49, N'08c597c2-8bb1-43c7-9a23-d4dd1b71c653', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (50, N'7e63339f-d890-471e-8641-bf122117cbf4', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (51, N'330aae59-a2fc-4f94-b711-9b74bb3da575', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (52, N'6a3fe7e5-48b4-4bc7-b3c9-43971fe39a89', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (53, N'54c68687-66a6-4733-b5bb-38b2177b3b93', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (54, N'081d6154-11aa-42f7-a994-184e2bcec4f7', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (55, N'52b23e2c-1587-47af-959e-f8588462fe2c', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (56, N'25a083b0-a209-4a1f-bd05-7a29d9500c0e', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (57, N'4944a351-3007-45d8-a0bc-9f0f777920f8', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (58, N'30d46ef3-7a1e-4884-a57f-8a8606cda134', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (59, N'6c495dd6-ccce-48c6-bb99-ad7054035ad1', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (60, N'677c9a7f-fa0e-4a97-bbe2-65fb629468ef', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (61, N'c51518ad-83d9-449f-87c5-a16e911f2a42', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (62, N'f50815d9-4894-4a8a-b9be-92e000c25928', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (63, N'683e688e-3990-415b-a31d-e9792a79098d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (64, N'2e6fed29-a9bc-4385-a257-feed3b8ac57d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (65, N'27dd41e1-5d8e-45c9-9720-6b7fcd6c5c23', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (66, N'6cfea9a2-e6d7-42ab-9e18-2fc1b03c2304', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (67, N'd7b448f8-5d33-4105-a2d9-77fad71005dc', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (68, N'f66a8b09-8293-478f-ae0d-867b89fa4843', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (69, N'c665b983-c374-49d5-84fe-16b447eecc70', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (70, N'33bc5010-dce4-4aea-a310-359e526570e2', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (71, N'274fb5db-3d36-46c3-aa40-5de7830c629d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (72, N'62ffbc50-7aaf-422e-b70b-635f719fa0f1', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (73, N'4740ad4f-3540-4450-9830-16bf6506e969', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (74, N'be15f9dd-f20b-4c6b-93aa-11e2d6d4f632', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (75, N'c16dbd82-c5c4-4e69-bf17-cf9cff48d106', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (76, N'07a42ee8-eba1-4f95-a87f-8a7ac5dbe999', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (77, N'c1bf2385-dd20-4a28-85a8-411a7b7daed2', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (78, N'07621df6-8463-47ef-9c95-444fe5a3f816', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (79, N'5045e931-4b9a-4a13-a3c7-cb09108bf128', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (80, N'0f4f8490-b979-4e16-82a0-7051d620fe0f', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (81, N'2254afd6-9052-47d8-9c27-c993ca76f076', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (82, N'e8ef8edc-70e3-46ec-9ceb-9d5c416d213c', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (83, N'95f6289b-34a1-4fa9-825a-6b07fbc3b6b3', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (84, N'907523eb-d01f-4834-9692-caef5e846856', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (85, N'ac9b857a-cb82-43f5-9564-c6670834c640', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (86, N'b419b272-5a7c-47bd-b417-5b1ef77783c8', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (87, N'21f15bd6-2842-44cf-9e2f-d0f7dbc68ef7', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (88, N'6903a618-e2a0-47fe-b387-7e282871c416', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (89, N'4331921b-4bfa-41a2-b653-bb4041dec98d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (90, N'e57933e4-ac54-488c-abe9-ef8403067181', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (91, N'6fc86426-ae74-4d52-946b-54be64abf94b', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (92, N'799afc19-62c7-42ef-b257-c8a7710eb786', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (93, N'612cea32-a3cc-4ff6-952d-103e36c8ef0d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (94, N'7691c36a-71be-4b72-9560-ae5840689a8d', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (95, N'5194455b-3d63-4074-9ccc-4ad36a5ce0a3', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (96, N'f988c452-3a11-4933-abb3-40898972533f', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (97, N'b61ee2ee-a0e6-41d4-9476-a3ed57357c51', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (98, N'd7023668-cdf5-41ea-b14b-6e5b0d92bf42', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tadilatlar] ([id], [Arac_ID], [Manuel_Veri], [Manuel_AracPlaka], [Manuel_AracAdi], [Manuel_AracRenk], [Manuel_AracYil], [Tamamlanmis], [Maliyet_Kaporta_Boya_KEMAL_USTA], [Not_Kaporta_Boya_KEMAL_USTA], [Hesap_Kaporta_Boya_KEMAL_USTA], [Kayit_Kaporta_Boya_KEMAL_USTA], [Kesim_Kaporta_Boya_KEMAL_USTA]) VALUES (100, N'4a2be832-3607-44ee-a3dd-d71ebfeb6ea3', 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tadilatlar] OFF
SET IDENTITY_INSERT [dbo].[Vekaletler] ON 

INSERT [dbo].[Vekaletler] ([id], [VekaletUID], [AracUID], [VekaletBitisTarihi]) VALUES (1, N'6ac02858-69b3-4307-b77e-e66ec8648f7a', N'6625aba7-bf68-4262-a240-b9909477b5ce', N'12/06/2015')
INSERT [dbo].[Vekaletler] ([id], [VekaletUID], [AracUID], [VekaletBitisTarihi]) VALUES (2, N'f324927c-78fd-4929-88de-d8ca3662d9bc', N'4116db32-3c3f-46c6-84d8-d3689f109bc3', N'01/05/2015')
INSERT [dbo].[Vekaletler] ([id], [VekaletUID], [AracUID], [VekaletBitisTarihi]) VALUES (3, N'66fe2527-8a23-49bf-a3f4-19601fcb6178', N'a85f3b3d-dc75-44b1-b547-9bab730c8ad8', N'0')
INSERT [dbo].[Vekaletler] ([id], [VekaletUID], [AracUID], [VekaletBitisTarihi]) VALUES (4, N'73B69237-75D9-4A98-A62A-95DF4B473F97', N'411f306e-ef0f-49bd-ba91-35ff27728df7', N'11.11.2015')
INSERT [dbo].[Vekaletler] ([id], [VekaletUID], [AracUID], [VekaletBitisTarihi]) VALUES (5, N'E26FEFFE-A9D4-4A77-B571-366D967F06B8', N'4a2be832-3607-44ee-a3dd-d71ebfeb6ea3', N'12.12.2017')
SET IDENTITY_INSERT [dbo].[Vekaletler] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Araclar]    Script Date: 19.11.2015 17:34:49 ******/
ALTER TABLE [dbo].[Araclar] ADD  CONSTRAINT [IX_Araclar] UNIQUE NONCLUSTERED 
(
	[AracUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Giderler__60E504D716395583]    Script Date: 19.11.2015 17:34:49 ******/
ALTER TABLE [dbo].[Giderler] ADD  CONSTRAINT [UQ__Giderler__60E504D716395583] UNIQUE NONCLUSTERED 
(
	[GiderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Iletisim__5B18F5F26F30B5C7]    Script Date: 19.11.2015 17:34:49 ******/
ALTER TABLE [dbo].[Iletisim] ADD  CONSTRAINT [UQ__Iletisim__5B18F5F26F30B5C7] UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Unique_Kullanicilar]    Script Date: 19.11.2015 17:34:49 ******/
ALTER TABLE [dbo].[Kullanicilar] ADD  CONSTRAINT [Unique_Kullanicilar] UNIQUE NONCLUSTERED 
(
	[username] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__RiskLimi__867C578E4E5DFD56]    Script Date: 19.11.2015 17:34:49 ******/
ALTER TABLE [dbo].[RiskLimitleri] ADD UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_SenetProfil]    Script Date: 19.11.2015 17:34:49 ******/
ALTER TABLE [dbo].[SenetProfil] ADD  CONSTRAINT [IX_SenetProfil] UNIQUE NONCLUSTERED 
(
	[ContactUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Vekaletl__0D09956A9D3D5C50]    Script Date: 19.11.2015 17:34:49 ******/
ALTER TABLE [dbo].[Vekaletler] ADD UNIQUE NONCLUSTERED 
(
	[AracUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Vekaletl__307D1B40060CFBB5]    Script Date: 19.11.2015 17:34:49 ******/
ALTER TABLE [dbo].[Vekaletler] ADD UNIQUE NONCLUSTERED 
(
	[VekaletUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SenetProfil]  WITH CHECK ADD  CONSTRAINT [FK_SenetProfil_Iletisim] FOREIGN KEY([ContactUID])
REFERENCES [dbo].[Iletisim] ([ContactUID])
GO
ALTER TABLE [dbo].[SenetProfil] CHECK CONSTRAINT [FK_SenetProfil_Iletisim]
GO
/****** Object:  StoredProcedure [dbo].[Create_Tables]    Script Date: 19.11.2015 17:34:49 ******/
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
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 19.11.2015 17:34:49 ******/
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
         Configuration = "(H (1[50] 4[5] 2[31] 3) )"
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
         Top = -96
         Left = 0
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
            TopColumn = 30
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
         Configuration = "(H (1[12] 4[5] 2[62] 3) )"
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
         Top = -96
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Width = 1500
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
