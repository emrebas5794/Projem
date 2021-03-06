USE [master]
GO
/****** Object:  Database [AldomTR]    Script Date: 8.11.2015 15:11:25 ******/
CREATE DATABASE [AldomTR]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AldomTR', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\AldomTR.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AldomTR_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\AldomTR_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AldomTR] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AldomTR].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AldomTR] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AldomTR] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AldomTR] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AldomTR] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AldomTR] SET ARITHABORT OFF 
GO
ALTER DATABASE [AldomTR] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AldomTR] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AldomTR] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AldomTR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AldomTR] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AldomTR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AldomTR] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AldomTR] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AldomTR] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AldomTR] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AldomTR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AldomTR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AldomTR] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AldomTR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AldomTR] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AldomTR] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AldomTR] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AldomTR] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AldomTR] SET  MULTI_USER 
GO
ALTER DATABASE [AldomTR] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AldomTR] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AldomTR] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AldomTR] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [AldomTR] SET DELAYED_DURABILITY = DISABLED 
GO
USE [AldomTR]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 8.11.2015 15:11:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Related] [nvarchar](50) NOT NULL,
	[RelatedKey] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KategoriYazi]    Script Date: 8.11.2015 15:11:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KategoriYazi](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Controller] [nvarchar](50) NULL,
	[Action] [nvarchar](50) NULL,
	[SubID] [nvarchar](50) NULL,
	[PageTitle] [nvarchar](50) NULL,
	[PageText] [text] NULL,
 CONSTRAINT [PK_KategoriYazi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pages]    Script Date: 8.11.2015 15:11:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Controller] [nvarchar](50) NOT NULL,
	[Action] [nvarchar](50) NOT NULL,
	[SubID] [nvarchar](50) NOT NULL,
	[PageTitle] [nvarchar](50) NOT NULL,
	[PageText] [text] NOT NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Referans]    Script Date: 8.11.2015 15:11:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Referans](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Parent] [nvarchar](25) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[NameConverted] [nvarchar](50) NOT NULL,
	[Text] [text] NOT NULL,
 CONSTRAINT [PK_Referans] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Urunler]    Script Date: 8.11.2015 15:11:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Urunler](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Parent] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[NameConverted] [nvarchar](50) NULL,
	[Text] [text] NULL,
 CONSTRAINT [PK_Urunler] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 8.11.2015 15:11:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](25) NOT NULL,
	[Password] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Images] ON 

INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (2003, N'Distributor', N'Optimal_Aluminyum', N'Optimal.jpg', N'Optimal Alüminyum')
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (2004, N'Distributor', N'Simin_Yapi', N'simin.jpg', N'Simin Yapı')
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (2013, N'Cepheler', N'Mirror_Mirror_Plus_EV', N'Mirror Plus SG_1.png', NULL)
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (3012, N'Surme_Sistemleri', N'PA_110', N'PA110.93_1.png', NULL)
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (3015, N'Cepheler', N'Mirror_Mirror_Plus_CC', N'Mirror Plus CC_1.png', NULL)
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (3016, N'Cepheler', N'Mirror_Mirror_Plus_SG', N'Mirror Plus SG_2.png', NULL)
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (3017, N'Surme_Sistemleri', N'TB_65', N'TB65-SURME_1.png', NULL)
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (3018, N'Kapi_ve_Pencere_Sistemleri', N'TOP_65_TB', N'TB65_2.png', NULL)
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (3019, N'Kapi_ve_Pencere_Sistemleri', N'TOP_65_TB', N'TB65-PENCERE_7.png', NULL)
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (3020, N'Kapi_ve_Pencere_Sistemleri', N'PG_52_WD', N'PG52-KAPI_2.png', NULL)
INSERT [dbo].[Images] ([id], [Related], [RelatedKey], [Name], [Title]) VALUES (3021, N'Kapi_ve_Pencere_Sistemleri', N'PG_52_WD', N'PG52-PENCERE_2.png', NULL)
SET IDENTITY_INSERT [dbo].[Images] OFF
SET IDENTITY_INSERT [dbo].[KategoriYazi] ON 

INSERT [dbo].[KategoriYazi] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (1, N'Urunler', N'Cepheler', N'', N'Cepheler', N'Aldom Mirror / Mirror Plus sistemi gelistirilmis yalıtım performansı ile yapılar için mükemmel bir üründür. Yüksek termal performansı ileısıtma ve sogutma giderlerini büyük ölçüde azaltılarak kullanıcıya her mevsim konforlu bir yasam alanı sunulur.

Aldom Mirror/Mirror Plus ile yapılarınızda güvenlik ve konfor üstün kalitede bir cephe sistemi ile saglanmaktadır. Sistem sahip oldugu yüksek termal, akustik ve hava geçirimsizlik performans basarısını Avrupa standartlarında yapılan testler ile ortaya koymustur.

Aldom Miror/Mirror Plus cephe sistemleri farklı proje tipleri için zengin çözümler sunmaktadır: kapaklı, mekanik tutuculu silikon ve kasetli cephe alternatifleri içersinde projeniz için aradıgınız açılım tipini rahatlıkla bulabileceksiniz. Proje gereksiniminiz ne olursa olsun sadece 52 mm görünür genislige sahip Aldom Mirror/Mirror Plus cephe sistemi ile mekanlarınız daha fazla ısıgı içeri alacak ve manzaranızın kesintisiz olarak görülebilmesi saglanacaktır. Sistem içerisinde yer alan açılır kanat opsiyonları ile mekanların temiz hava alması dogal olarak saglanabilmektedir. Diger Aldom pencere, kapı ve sürme sistemler ile de bir araya getirilebilen sistem sayesinde projelerin tüm gereksinimlerinin kolaylıkla karsılanabilmektedir.')
INSERT [dbo].[KategoriYazi] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (7, N'Urunler', N'Kapi_ve_Pencere_Sistemleri', N'', N'Kapı ve Pencere Sistemleri', N'Aldom Mirror / Mirror Plus sistemi gelistirilmis yalıtım performansı ile yapılar için mükemmel bir üründür. Yüksek termal performansı ileısıtma ve sogutma giderlerini büyük ölçüde azaltılarak kullanıcıya her mevsim konforlu bir yasam alanı sunulur. 

Aldom Mirror/Mirror Plus ile yapılarınızda güvenlik ve konfor üstün kalitede bir cephe sistemi ile saglanmaktadır. Sistem sahip oldugu yüksek termal, akustik ve hava geçirimsizlik performans basarısını Avrupa standartlarında yapılan testler ile ortaya koymustur.

Aldom Miror/Mirror Plus cephe sistemleri farklı proje tipleri için zengin çözümler sunmaktadır: kapaklı, mekanik tutuculu silikon ve kasetli cephe alternatifleri içersinde projeniz için aradıgınız açılım tipini rahatlıkla bulabileceksiniz. Proje gereksiniminiz ne olursa olsun sadece 52 mm görünür genislige sahip Aldom Mirror/Mirror Plus cephe sistemi ile mekanlarınız daha fazla ısıgı içeri alacak ve manzaranızın kesintisiz olarak görülebilmesi saglanacaktır. Sistem içerisinde yer alan açılır kanat opsiyonları ile mekanların temiz hava alması dogal olarak saglanabilmektedir. Diger Aldom pencere, kapı ve sürme sistemler ile de bir araya getirilebilen sistem sayesinde projelerin tüm gereksinimlerinin kolaylıkla karsılanabilmektedir.')
INSERT [dbo].[KategoriYazi] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (9, N'Urunler', N'Surme_Sistemleri', N'', N'Kaldır – Sür / Sürme Sistemler', N'Aldom sürme serileri iç ve dış ortam arasında şeffaf bir yüzey oluşturabilmek için tasarlanmış yüksek kaliteli alüminyum sistemlerdir. Özellikleri her mevsim iç mekanda ideal konfor ortamının sağlanmasını hedefleyen ve yoğuşmayı azaltan sistem performans değerleri ile öne çıkmaktadır. Isı yalıtımı testlerinde elde edilen performansının üstünlüğü ile farklı iklim yapısına sahip bölgelerdeki tüm yapılarda enerjinin korunumu için kullanılabilecek ideal bir sistemlerdir.

Aldom sürme sisdtemleri yapılarınızda güvenlik ve konforu en üst düzeyde sunar.

Sistem içerisinde yer alan fitiller ve aksesuarlar gibi diğer bileşenler sürmenin eşsiz bir akustik performans elde etmesinde oldukça etkilidir.

İç ve dış profillerin farklı renkte boyanabilmesine olanak sağlayan bi-color opsiyonu ve su tahliye kapaklarının da profiller ile aynı renkte boyanabilmesi, sistemden mükemmel bir estetik görüntüsü almanızı sağlayan özelliklerden birkaçıdır.

Basit sürme ve kaldır&sür mekanizmalı versiyonlarda düşük eşik kasa uygulaması ile iç ve dış mekan arasında minimum kot farkı yaratılarak, kullanıcıların rahat bir şekilde geçişi sağlanabilmektedir.

Aldom sistemleri en iyi kalite alüminyumdan imal edilen uzun ömürlü çözümler sunmaktadır. Minimum bakım gerektiren Aldom sistemlerini yapılarınızın estetik görüntüsü bozulmadan ve mekanik özelliklerini yitirmeden uzun yıllar kullanabilirsiniz.')
INSERT [dbo].[KategoriYazi] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (10, N'Urunler', N'Katlanir_Kapi_Sistemleri', N'~/Urunler/Katlanir_Kapi_Sistemleri/TB_75_Garden', N'', N'')
SET IDENTITY_INSERT [dbo].[KategoriYazi] OFF
SET IDENTITY_INSERT [dbo].[Pages] ON 

INSERT [dbo].[Pages] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (1, N'Home                ', N'Distributor         ', N'Optimal_Aluminyum   ', N'Optimal Alüminyum   ', N'Optimal Aluminyum San ve Tic Ltd Sti

Adres: Deri Organize Sanayi Bolgesi Kadife Cd R8 Parsel No:7 Tuzla Istanbul

Tel : +90 216 361 9973

Faks : +90 216 442 9076')
INSERT [dbo].[Pages] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (2, N'Home                ', N'Distributor         ', N'Simin_Yapi          ', N'Simin Yapı          ', N'Simin Yapı Sistemleri A.Ş.

Hürriyet Mah. Dr. Cemil Bengü Caddesi No:22 K.1 Çağlayan Kağıthane - İstanbul

Tel: +90 212 225 75 75 

Faks: +90 212 225 70 80')
INSERT [dbo].[Pages] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (6, N'Home', N'Distributor', N'asdasd', N'asdasd', N'asdads')
INSERT [dbo].[Pages] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (1003, N'Home', N'Yesil_Aluminyum', N'Aluminyum_Yasam_Dongusu', N'Alüminyum Yaşam Döngüsü', N'Alüminyumun dairesel bir döngüde ömrü sonsuzdur. Boksit minaralinden elde edilen alüminyum kütükler ekstrüde edilerek alüminyum profiller elde edilir. Aluminyum profiller daha sonra eritilerek tekrar kütüklere dönüştürülebilir ve daire tamamlanır.')
INSERT [dbo].[Pages] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (1004, N'Home', N'Yesil_Aluminyum', N'Ekstruzyon', N'Ekstrüzyon', N'Ekstürüzyon sıcak alüminyum kütüğün bir kalıp içerisine itilmesi ile ürün elde edilmesi işlemine verilen addır.

Bu işlemden önce alümünyum kütük ekstrüde etmek için gerekli basıncı azaltmak ve ihtiyaç duyulan mekanik özellikleri elde etmek için 400 ile 500 C arası bir sıcaklıkta ısıtılır.

Ekstrüzyondan sonra, elde edilen profil soğutma işlemi ile yaşlandırma sürecine tabi tutulur. 160 ile 210 arasındaki bir sıcaklıkta mekanik özelliklere ulaşılır ve stabilize olur.

Kalıptan çekilmiş profil çok yönlü kullanılabilir ve kullanım alanlarından biriside mimari alüminyum sistemleridir.')
INSERT [dbo].[Pages] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (1005, N'Home', N'Yesil_Aluminyum', N'Surdurulebilirlik', N'Sürdürülebilirlik', N'Alüminyum malzeme olarak gücü ve hafifliği birleştiren, modaya uygun dayanıklı bir malzemedir. Esnek olması onu istenilen formlara sokulabilmesini ve tüm ihtiyaçlara adapte edilebilmesini sağlar.

Alüminyum sürdürülebilir bir malzemedir. Geri dönüşümü %100 olan alüminyum gelecek nesiller için gerçek bir kaynaktır. 

Yenilikçi yapıların yanı sıra yenileme için mükemmel bir malzemedir, Konforu, sürdürlebiliriliği ve enerji tasarufunu aynı zamanda sağlar. Binaların tarihsel değerleri korunarak entegre edilebilir.

Doğal rengi ile kullanılabiliceği gibi binlerce rengede boyanabilien alüminyum, maliyetleri düşürürken geleceğe kalıcı çözümler bırakmaktadır. 

Verimliliği, çok yönlü kullanımı ile alüminyum şehirlerimizin kalitesine ve hayatımıza katkıda bulunmaktadır.')
INSERT [dbo].[Pages] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (1006, N'Home', N'Aldom', N'Sapa_Group', N'Sapa Group', N'Aluminyum çözümleri, dizaynları ve mimari sistemler konusunda lider olan SAPA bu ürünleri üretimini, dağıtımını Dünya''nın birçok ülkesinde gerçekleştirmektedir. SAPA Group Aldom markası ile de küresel market için geliştirmeler yapmakta, cephe, pencere, kapılar, sürme sistemler gibi bir çok segmente ürünler sunmaktadır. Aldom, 1 Eylül 2013 tarihinde SAPA Group bünyesine katılmıştır.

Aldom''un 2013 yıllından itibaren katıldığı SAPA Group 23.500 çalışanı ile 40''tan daha fazla ülkede yer almakta ve merkez ofisi Oslo, Norveçte bulunmaktadır.')
INSERT [dbo].[Pages] ([id], [Controller], [Action], [SubID], [PageTitle], [PageText]) VALUES (1007, N'Home', N'Aldom', N'Aldom_Markasi', N'Aldom Markası', N'Aldom markası 1 Eylül 2013 tarihinde SAPA Group bünyesine katıldı. (Orkla ASA ve Hydro ASA tarafından 50/50 ortak girişimle markalar SAPA AS altından toplanmıştır)

Aldom uzun bir geleneğe sahiptir ve İtalyan pazarında en ünlü alüminyum yapı sistemleri markasıdır.

Aldom markası 1973 yılında Milano''da kurulmuş ve kurulduğu günden itibaren en zorlu projeler için bir referans noktası olmuştur.

1988 yılında Aldom markası uluslararası bir marka olan eski Hydro Group''un bir parçası haline geldi.')
SET IDENTITY_INSERT [dbo].[Pages] OFF
SET IDENTITY_INSERT [dbo].[Referans] ON 

INSERT [dbo].[Referans] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (1005, N'Kamu_Binalari', N'Kilise  - Foligno, İtalya', N'Kilise-Foligno,Italya', N'Church in Foligno, Italy
Designed by Massimiliano e Doriana Fuksas Studio 
Products: Domal Break PA 70S')
INSERT [dbo].[Referans] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (1006, N'Kamu_Binalari', N'fgdfg', N'fgdfg', N'gfdgdfgdfg')
SET IDENTITY_INSERT [dbo].[Referans] OFF
SET IDENTITY_INSERT [dbo].[Urunler] ON 

INSERT [dbo].[Urunler] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (3, N'Cepheler', N'Mirror / Mirror Plus CC', N'Mirror_Mirror_Plus_CC', N'Aldom Mirror/Mirror Plus CC kapaklı cephe sistemi, farklı dizayn hatlara sahip yatay ve düşey kapak profillerinin bir araya getirilmesi ile yapılara farklı görsellikler kazandırabilen yenilikçi bir cephe sistemidir.  Yüksek performans ve ısı yalıtım değerlerine sahip sistem ile mimari projelerin gereklilikleri kolayca sağlanabilmektedir. Dıştaki kapak profilleri ile içeride yer alan ana taşıyıcı profillerin farklı renkte boyabilmesi veya eloksallenebilmesi mimariye kazandırdığı özelliklerdendir.   Dışarıdan 50 mm görünür genişliğe sahip kapaklı sistem, sahip olduğu yüksek alalet değerleri ile şimdiye kadar tüm dünyada yüzlerce özel uygulama ile kendini ispatlamıştır.  Versiyon Özellikleri  Ana taşıyıcı profiller 52 mm görünür genişlikte  Kapak profilleri görünür genişiliği	50 mm  Profil et kalınlığı	1,6 mm ile 2,0 mm arasında  Dikme profil derinlikleri	90 mm ile 217 mm arasında  Yatay profil derinlikleri	63 mm ile 162 mm arasında  Cam kalınlığı	8-40 mm arasında  Teknik Özellikler  Hava geçirimsizlik: Class 4 / 600 Pa  Su geçirimsizlik: E1050 / 1050 Pa  Rüzgar yükü dayanımı: 2.000 Pa')
INSERT [dbo].[Urunler] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (4, N'Cepheler', N'Mirror / Mirror Plus SG', N'Mirror_Mirror_Plus_SG', N'Aldom Mirror/Mirror Plus SG cephe sistemi camların kaset profillerine monte edilmesi ile açılır kanatlar ve sabit cephe bölümlerinin aynı homojenlikte göründüğü bir cephe sistemidir.  Sistem içerisinde dışta kapak profilleri kullanılmaması ile şeffaf bir görünüm kazanmaktadır. Farklı atalet değerlerine sahip yatay ve düşey taşıyıcı profiller sayesinde büyük açıklıklar rahatlıkla geçilebilmektedir.   Diğer Aldom pencere&kapı sistemler ile de bir araya gelebilen sistem ile projelerin ihtiyaç duyduğu tüm çözümleri bünyesinde barındırmaktadır.  Versiyon Özellikleri  Ana taşıyıcı profiller 52 mm görünür genişlikte  Kapak profilleri görünür genişiliği	50 mm  Profil et kalınlığı	1,6 mm ile 2,0 mm arasında  Dikme profil derinlikleri	90 mm ile 217 mm arasında  Yatay profil derinlikleri	63 mm ile 162 mm arasında  Cam kalınlığı	8-32 mm arasında  Teknik Özellikler  Hava geçirimsizlik: Class 4 / 600 Pa  Su geçirimsizlik: R6 / 450 Pa  Rüzgar yükü dayanımı: 2.000 Pa')
INSERT [dbo].[Urunler] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (5, N'Cepheler', N'Mirror / Mirror Plus EV', N'Mirror_Mirror_Plus_EV', N'Aldom Mirror/Mirror Plus EV (Ecovec) sistemi, dışarıdan sadece cam-cama görünen ve arasında derz detayının yer aldığı estetik bir cephe çözümüdür.

  Sistemin montajında yer alarak çift cam arasında kullanılan özel mekanik tutucular ile camların ana konstrüksiyona taşıtılması ve ısıl geçişlerin engellenmesi bu sistem ile yüksek performans değerleri ile sağlanmakatdır.

  Standart kasetli cephelere göre daha az profil kullanımı ile sistem hem ekonomik hem de daha az profil görüntüsü vererek minimal bir yapı sergilemektedir.

 Versiyon Özellikleri 

 Ana taşıyıcı profiller 52 mm görünür genişlikte 

 Profil et kalınlığı	1,6 mm ile 2,0 mm arasında  

 Dikme profil derinlikleri	90 mm ile 217 mm arasında

 Yatay profil derinlikleri	63 mm ile 162 mm arasında 

 Cam kalınlığı	32-42 mm arasında')
INSERT [dbo].[Urunler] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (13, N'Surme_Sistemleri', N'PA 110', N'PA_110', N'Konfor ve Güvenlik  Aldom Slide PA 110 sürme serisi iç ve dış ortam arasında şeffaf bir yüzey oluşturabilmek için tasarlanmış yüksek kaliteli bir alüminyum sistemdir. Özellikleri ile her mevsim iç mekanda ideal konfor ortamının sağlanmasını hedefleyen ve yoğuşmayı azaltan sistem performans değerleri ile öne çıkmaktadır. Isı yalıtımı testlerinde elde edilen performansının üstünlüğü ile farklı iklim yapısına sahip bölgelerdeki tüm yapılarda enerjinin korunumu için kullanılabilecek ideal bir sistemdir.   Aldom Slide PA 110 sürme sistemi yapılarınızda güvenlik ve konforu en üst düzeyde sunar.  Konutlarda yüksek güvenlik sağlanabilmesi için   6 noktaya kadar kilitleme opsiyonu bulunan sistem, içerisinde kullanılan malzemelerin kalitesi ile yüksek dayanımı da beraberinde sunmaktadır. Sistem içerisinde yer alan fitiller ve aksesuarlar gibi diğer bileşenler sürmenin eşsiz bir akustik performans elde etmesinde oldukça etkilidir.  Tasarım ve Çok Yönlülük  Aldom Slide PA 110, tasarımcıya farklı uygulama olanakları sunan bir sürme sistemdir: iki raylı kasa ile 2,3 ve 4 kanatlı uygulama yapılabilmektedir.  Aldom Slide PA 110 sisteminde küçük bir konuttan büyük bir otele kadar farklı ölçeklerdeki projeler için çözümler yer almaktadır. Sistem ile 6,50 metre genişliğe ve 2,5 metre yüksekliğe kadar uygulama yapılabilmektedir.  İç ve dış profillerin farklı renkte boyanabilmesine olanak sağlayan bi-color opsiyonu ve su tahliye kapaklarının da profiller ile aynı renkte boyanabilmesi, sistemden mükemmel bir estetik görüntüsü almanızı sağlayan birkaç özelliğidir.  Büyük Ebatlar  Sürme serileri ile 3 metre yükseklikte kanatlar yapılması kolay değildir. Aldom serilerinden PA 110’nun ister kaldır&sür mekanizmalı ister standart sürme versiyonlarında bu ebatlara sahip büyük açıklıklar rahat bir şekilde geçilebilmektedir. Bu sayede kullanıcılara daha şeffaf bir çözüm sağlanarak manzaranın kesintisiz görünebilmesi sağlanmış olur.  Hemzemin Geçiş İmkanı  Basit sürme ve kaldır&sür mekanizmalı versiyonlarda düşük eşik kasa uygulaması ile iç ve dış mekan arasında minimum kot farkı yaratılarak, kullanıcıların rahat bir şekilde geçişi sağlanabilmektedir.  Teknik Özellikleri  Termal Performans:  Uw: 3,041 W/m²K   (2100 mm x 2100 mm ebatlarında 20 mm (4+12+4) ısıcam ile)  Performans*:  Hava geçirimsizlik: Class 4 / 600 Pa  Su geçirimsizlik: E750 / 750 Pa  Rüzgar yükü dayanımı: C5 / 2000 Pa  Kanat başına maksimum ağırlık:  200 kg  * 2000 mm x 2330 mm (h) ebatlarında 2 rayda 2 kanatlı tip için')
INSERT [dbo].[Urunler] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (14, N'Surme_Sistemleri', N'TB 65', N'TB_65', N'Konfor ve Güvenlik  Aldom Slide TB 65 iç ve dış ortam arasında şeffaf bir yüzey oluşturabilmek için tasarlanmış yüksek kaliteli bir alüminyum sistemdir. Özellikleri ile her mevsim iç mekanda ideal konfor ortamının sağlanmasını hedefleyen ve yoğuşmayı azaltan sistem performans değerleri ile öne çıkmaktadır. Isı yalıtımı testlerinde elde edilen performansının üstünlüğü ile farklı iklim yapısına sahip bölgelerdeki tüm yapılarda enerjinin korunumu için kullanılabilecek ideal bir sistemdir. Aldom Slide TB 65 sürme sistemi yapılarınızda güvenlik ve konforu en üst düzeyde sunar.  Konutlarda yüksek güvenlik sağlanabilmesi için 4 noktadan kilitleme opsiyonu bulunan sistem, içerisinde kullanılan malzemelerin kalitesi ile yüksek dayanımı da beraberinde sunmaktadır. Sistem içerisinde yer alan fitiller ve aksesuarlar gibi diğer bileşenler sürmenin eşsiz bir akustik performans elde etmesinde oldukça etkilidir.  Tasarım ve Çok Yönlülük  Aldom Slide TB 65, tasarımcıya farklı uygulama olanakları sunan bir sürme sistemdir: iki raylı versiyonda dört kanada ve üç raylı versiyonda ise altı kanada kadar uygulama imkanı verir.   Kanatların duvar içine sürülebilmesi ile yer kaybı yaşamadan uygulama olanağı veren özel çözümü, tek raylı ve iki raylı versiyonlarında yer almaktadır.   İç ve dış profillerin farklı renkte boyanabilmesine olanak sağlayan bi-color opsiyonu ve su tahliye kapaklarının da profiller ile aynı renkte boyanabilmesi, sistemden mükemmel bir estetik görüntüsü almanızı sağlayan birkaç özelliğidir.  Büyük Ebatlar  Aldom Slide TB 65 sisteminde küçük bir konuttan büyük bir otele kadar farklı ölçeklerdeki projeler için çözümler yer almaktadır. Sistem ile 6,50 metre genişliğe ve 2,5 metre yüksekliğe kadar uygulama yapılabilmektedir.  Maksimum Açıklıklar  Sürme sistemlerin kullanılacağı alanlarda maksimum açıklığa ulaşmak kolay değildir. Aldom sürme serilerindeki duvar içine sürülebilen kanatlar ile oturma odasından mutfağa, ofisten dükkana gibi çok farklı kullanım alanlarında bile size daha şeffaf ve geçirgen yüzeyler sağlanmaktadır.   Kanatların duvar içerisinde gizlenmesi ile yenilikçi ve rasyonel tasarımlar hayata geçebilmekte ve sistem kullanıldığı mekanlara artı bir değer katmaktadır. Bu çözüm ile enerjiden ödün vermeden alanı en iyi şekilde değerlendirmeniz ve daha fazla açılım yapmanız sağlanmaktadır.  Üç Ray Uygulama Olanağı  Üç raylı çözüm ile yaratıcılığınızı özgürleştirin: 220 kg''a kadar kanat taşınmasına olanak veren rulmanlar ile üç raylı versiyonda altı kanada kadar uygulama yapılabilmektedir.  Teknik Özellikleri  Termal Performans:  Uw: 1,5 W/m²K  (Ug: 1,0 W/m²K cam ile 2000 mm x 2180 mm)  Performans*:  Hava geçirimsizlik: Class 4  Su geçirimsizlik: Class 7  Rüzgar yükü dayanımı: Class A5/B4/C3  Akustik Performans**:  Rw (C;Ctr) = 40 (-1;-4) dB [Rw = 46 dB cam ile]  Kanat başına maksimum ağırlık: 220 kg')
INSERT [dbo].[Urunler] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (15, N'Katlanir_Kapi_Sistemleri', N'TB 75 Garden', N'TB_75_Garden', N'TB 75 Garden 
 Konfor ve Enerji tasarrufu  Aldom Garden TB 75 katlanır sistemi güvenlik ve konfordan ödün vermeden, mekanlara şekil vererek veranda ve kış bahçeleri gibi eklentiler ile dışarı doğru genişlemelerine olanak sağlayan çözümler sunar.  

Konutların veranda, balkon ve kış bahçesi gibi alanlarında yapılan uygulamalarda sistemin sahip olduğu ısı ve ses yalıtım performansı ile mekanlar dış hava koşullarının olumsuz etkenlerinden korunmuş olur. Bu sayede yapının tamamında tüm yıl boyunca istenilen ideal konfor sağlanarak ısıtma ve soğutma giderlerinde önemli tasarruf sağlanır: yazın daha serin, kışın ise daha sıcak.  Çok yönlü ve işlevsel  Aldom Garden TB 75, her türlü şekil ve tasarımdaki her alana adapte edilebilir:


 Konfigürasyon olanağı sonsuzdur.   Gerek yapıya bağlı balkon ve teraslarda gerek ise bahçe içerisinde bağımsız bir bölümünde tek bir sistem ile hayal edilen çok yönlü kullanım sağlanır: tasarlanan mekana düşük eşik detayı ile kolayca giriş çıkış yapılır ve sistemin bir noktada toplanması ile içerinin ve dışarının tek bir mekan olarak kullanımına izin verilir.  Özellikle sıcak mevsimlerde sistemi en az düzeyde yer kaplayacak şekilde tek bir noktada toplayarak  dış mekana açılım sağlanır. Maksimum açıklığın sağlanması ile mekanda istenilen doğal havalandırma da sağlanmış olunur.

  Büyük Boyutlar  Kanat başına 150 kg''a kadar taşıma kapasitesine sahip rulmanlar ile büyük cam yüzeyli kanatlar güvenle yapılabilmektedir. Bu sayede az sayıda kanat ile daha büyük katlanır şeffaf yüzeyler Aldom Garden TB 75 sistemi ile kurulabilmektedir.  Engelsiz  Düşük eşik olanağı ile iç mekandan dış mekana geçişlerde tüm mimari engeller ortadan kaldırılabilmekte, kullanıcıya maksimum hareket özgürlüğü sağlanmaktadır. Kanatların katlanması için sistem minimum park alanına ihtiyaç duyar. Kanatlar katlı iken sistem sadece ince bir çerçeve görüntüsü verir.  Maksimum Performans  Aldom Garden TB 75 üç sıralı fitil yapısı ile kullanıcıları her türlü kötü hava koşullarına karşı korunabilmekte ve yüksek akustik performansı ile ideal konfor ortamı sağlamaktadır.  Teknik Özellikler  Termal Performans:  Uw: 1,6 W/m²K  (Ug: 0,6 W/m²K cam ile 3260 mm x 2465 mm)  Performans*:  Hava geçirimsizlik: Class 3  Su geçirimsizlik: Class 5A  Rüzgar yükü dayanımı: Class C2  * 3260 mm x 2465mm ebatlarında 6 kanatlı tip için')
INSERT [dbo].[Urunler] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (1012, N'Kapi_ve_Pencere_Sistemleri', N'TOP 65 TB', N'TOP_65_TB', N'Konfor ve Güvenlik

Aldom Top 65 TB sistemi geliştirilmiş yalıtım performansı ile yapılar için mükemmel bir üründür. Yüksek termal performansı ile ısıtma ve soğutma giderlerini büyük ölçüde azaltılarak kullanıcıya her mevsim konforlu bir yaşam alanı sunulur. Mevcut yapıların renovasyonununda da kullanılabilen Top 65 TB sistemi ile enerjinin korunumu sağlanmaktadır.

Aldom Top 65 TB ile yapılarınızda güvenlik ve konfor üstün kalitede bir pencere ve kapı sistemi ile sağlanmaktadır. Sistem sahip olduğu yüksek termal, akustik ve hava geçirimsizlik performans başarısını Avrupa standartlarında yapılan testler ile ortaya koymuştur.


Tasarım ve Çok Yönlülük

Aldom TB 65 sistemi farklı proje tipleri için farklı çözümler sunmaktadır: tek eksen veya çift eksen açılır pencereler, pivot açılımlı pencereler, paralel sürülebilir pencere ve kapılar, eşikli-eşiksiz kapılar, hem yüz kapılar, çarpma kapılar veya acil çıkış kapıları gibi. 

Kanat tipleri yapının tipine bağlı olarak değişkenlik gösterir: geleneksel veya rüstik tarzda inşa edilmiş yapılar için daha yuvarlak ve dairesel hatlar veya çağdaş yapılar için minimalist dizaynda doğrusal hatlı modern çizgiler.

Proje gereksiniminiz ne olursa olsun sadece 89 mm görünür genişliğe sahip Aldom TB 65 sistemi ile mekanlarınız daha fazla ışığı içeri alacak ve manzaranızın kesintisiz olarak görülebilmesi sağlanacaktır. Aldom sistemleri içerisinde yer alan TB 65 sürme sistemi ile entegre olarak kullanılabilmektedir. 

Engelliler İçin Erişilebilirlik

Sistem düşük eşik seçenekli kapı çözümleri ile tüm kullanıcı gruplarının daha rahat geçiş yapabilmelerine olanak sağlar.

Çift renk seçeneği

Alüminyum''un içeriden ve dışarıdan farklı renklerde gözükmesini istemeniz halinde, mimari gerekliliklere veya kişisel zevkinize uygun iki farklı renk seçmenize olanak veren çift-renk seçeneği Aldom ürünlerinde sunulur. 

Aldom Top TB 65 Pencere Teknik Özellikleri 

Termal Performans:

Uw: 1,0 W/m²K

(Ug: 0,6 W/m²K cam ile 1230 mm x 1480 mm  

ebatlarında bir pencerede)

Performans*:

Hava geçirimsizlik: Class 4 

Su geçirimsizlik: E1500

Rüzgar yükü dayanımı: C5

Akustik Performans**

Rw (C;Ctr) = 46 (-2;-7) dB

[Rw = 47 dB cam ile]

* 1440 mm x 1486 mm ebatlarında 2 kanatlı pencere için

** 1265 mm x 1515 mm ebatlarında 1 kanatlı pencere için ')
INSERT [dbo].[Urunler] ([id], [Parent], [Name], [NameConverted], [Text]) VALUES (1013, N'Kapi_ve_Pencere_Sistemleri', N'PG 52 WD', N'PG_52_WD', N'Konfor ve güvenlik

Aldom PG 52 WD yalıtımsız pencere ve kapı sistemi, ekonomik olarak mimari ve teknik ihtiyaçları karşılamayı amaçlayan bir tasarım ürünüdür. İç mekan kullanımı için de uygun olarak tasarlanmıştır. Mevcut yapıların renovasyonunda da alternatiflere sahip mimari özellikleri ile kullanılabilir. PG 52 WD projelerinizin önemli tamamlayıcı sistemidir.

Aldom Stopper PG 52 ile yapılarınızda güvenlik ve konfor üstün kalitede bir pencere ve kapı sistemi ile sağlanmaktadır. Sistem sahip olduğu yüksek akustik ve hava geçirimsizlik performans başarısını Avrupa standartlarında yapılan testler ile ortaya koymuştur.

Tasarım ve çok yönlülük 

Aldom Stopper PG 52 sistemi farklı proje tipleri için farklı çözümler sunmaktadır: tek eksen veya çift eksen açılır pencereler, pivot açılımlı pencereler, paralel sürülebilir pencere ve kapılar, eşikli-eşiksiz kapılar, hem yüz kapılar, çarpma kapılar veya acil çıkış kapıları gibi.  

Kanat tipleri yapının tipine bağlı olarak değişkenlik gösterir: geleneksel veya rüstik tarzda inşa edilmiş yapılar için daha yuvarlak ve dairesel hatlar veya çağdaş yapılar için minimalist dizaynda doğrusal hatlı modern çizgiler.

Proje gereksiniminize uygun olarak sadece 91 mm görünür genişliğe kadar düşebilen Aldom Stopper PG 52 sistemi ile mekanlarınız daha fazla ışığı içeri alacak ve manzaranızın kesintisiz olarak görülebilmesi sağlanacaktır. Aldom sistemleri içerisinde yer alan diğer sürme sistemi ile entegre olarak kullanılabilmektedir. 

Engelliler için erişilebilirlik

Sistem düşük eşik seçenekli kapı çözümleri ile tüm kullanıcı gruplarının daha rahat geçiş yapabilmelerine olanak sağlar.

Aldom Top TB 65 Hemyüz Kapı Teknik Özellikleri

Termal Performans:

UNI EN ISO 12567-1:2002

UNI EN ISO 8990:1999

Performans*:

Hava geçirimsizlik: Class 4 / 600 Pa

Su geçirimsizlik: 9A / 600 Pa 

Rüzgar yükü dayanımı: C5 / 2000 Pa

Dayanım Yorulma**:

EN 107 - 10.000 Tekrar

* 1240 mm x 1320 mm ebatlarında 2 kanatlı pencere için 

** 1240 mm x 1320 mm ebatlarında 1 kanatlı pencere için')
SET IDENTITY_INSERT [dbo].[Urunler] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [Username], [Password]) VALUES (1, N'emre', N'123456')
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Images]    Script Date: 8.11.2015 15:11:25 ******/
ALTER TABLE [dbo].[Images] ADD  CONSTRAINT [IX_Images] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [AldomTR] SET  READ_WRITE 
GO
