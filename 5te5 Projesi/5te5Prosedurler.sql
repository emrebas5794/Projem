------þahane pazar balon oyunu 
--nGU[8]6U--
--Ödemeniz alýndý.Ýstanbulkart baþvurunuz baþarýyla tamamlanmýþtýr.Baþvuru takibi yapabileceðiniz Referans Numaranýz: 1507141154, Tutar : 10 TL, Provizyon No: 998474--
 ALTER proc GuncelSoruGetir
@derece INT,
@GelenSayi INT
 as
DECLARE @ToplamSoruSayisi INT 
SELECT @ToplamSoruSayisi = ToplamSoruSayisi from ToplamSoruSayisi where Derece=@derece
IF @GelenSayi > @ToplamSoruSayisi BEGIN
select * from (
 select *,ROW_NUMBER() over(order by(id)) sira from sorular where derece= @derece
 )sorularr where sira= 1
END
ELSE BEGIN
select * from (
 select *,ROW_NUMBER() over(order by(id)) sira from sorular where derece= @derece
 )sorularr where sira= @GelenSayi
END


exec GuncelSoruGetir 1,65

create index loginolma on uyeler(kullaniciadi)
create index sorugetirme on sorular(id)
create index ticketsaydirma on ticketekle(id)
create index toplamticketsaydirma on toplamticket(toplamticket)
create index assa on Table_1(id)
create index sorularcekme on sorular(id)
create index tokencekme2 on token(tokenid)

select * from uyeler
select * from ticketekle where kullaniciid=117 and tarih>='2015-07-01'
select * from toplamticket ORDER BY kullaniciid desc

delete ticketekle where tarih<'2015-07-13'


create proc aylikpuansifila
as
update haftalikpuan set ticket=1 where kullaniciid=93

create proc haftalikpuansifila
as
update haftalikpuan set ticket=0 

create proc secilenaylikpuansifila

as
update aylikpuan set ticketsayisi=0 

  declare @syc int =0
 while(@syc<205)
 begin

exec ticketkaydet 25


 set @syc += 1
 end
update sorular set soru='Fernandao Hangi Sezon Bursaspor a Transfer Olmuþtur' where id=103

exec tokenguncelle 87

 alter proc tokenguncelle
 @kullaniciid int
 as
 update token set tokenid=NEWID() where kullaniciid=@kullaniciid
 select tokenid from token  where kullaniciid=@kullaniciid

 insert into  token(kullaniciid,tokenid) values(18,NEWID())

 alter proc tokenkontrol
  @kullaniciid int,
  @tokenid varchar(MAX)
 as
  select count(tokenid) kontrol from token  where kullaniciid=@kullaniciid and tokenid=@tokenid

exec tokenkontrol 18 ,'b397e236-cdce-4e7a-876e-4e33540622ae'


create proc toplamhaftaliksira
as
 select   ROW_NUMBER() over(order by  h.ticket desc ) [sirasi], ta.takim takimi, u.kullaniciadi,h.ticket ticketsayisi from haftalikpuan h join uyeler u on h.kullaniciid=u.id join takimlar ta on u.takimi=ta.id group by ta.takim,u.kullaniciadi, h.ticket  order by h.ticket desc

create proc toplamaylikksira
as
 select  ROW_NUMBER() over(order by  a.ticketsayisi desc ) [sirasi], ta.takim takimi, u.kullaniciadi,a.ticketsayisi  from aylikpuan a join uyeler u on a.kullaniciid=u.id join takimlar ta on u.takimi=ta.id group by ta.takim,u.kullaniciadi, a.ticketsayisi  order by a.ticketsayisi desc

alter proc puansirasi

@kullaniciadi nvarchar(50),
@tarih1 date,
@tarih2 date,
@sirasayisi1 int,
@sirasayisi2 int
as
   select * from(
   select   top(@sirasayisi2-1)  ROW_NUMBER() over(order by  count(t.ticket) desc ) [sirasi], ta.takim takimi, u.kullaniciadi,count(t.ticket)[ticketsayisi] from uyeler u
 join ticketekle t on u.id=t.kullaniciid join takimlar ta on u.takimi=ta.id  where   t.tarih between @tarih1 and @tarih2 group by u.takimi,u.kullaniciadi, t.kullaniciid,ta.takim order by ticketsayisi desc
 )tablo2  where sirasi between  @sirasayisi1 and @sirasayisi2 
  UNION
  select * from(
  select      ROW_NUMBER() over(order by  count(t.ticket) desc ) [sirasi],ta.takim takimi, u.kullaniciadi,count(t.ticket)[ticketsayisi] from uyeler u
 join ticketekle t on u.id=t.kullaniciid  join takimlar ta on u.takimi=ta.id where   t.tarih between '2015-06-15' and '2015-06-22' group by u.kullaniciadi, t.kullaniciid,ta.takim
 )tablo where kullaniciadi='emre' 

 select * from uyeler order by id
 select * from ticketekle where tarih between '2015-06-15' and '2015-06-22'  order by kullaniciid
   update aylikpuan set ticketsayisi=0 where kullaniciid='87'

 alter proc haftaninilkbesi
 @kullaniciadi nvarchar(20)
 as
  select * from(
 select  top(5) ROW_NUMBER() over(order by  h.ticket desc ) [sirasi], ta.takim takimi, u.kullaniciadi,h.ticket ticketsayisi from haftalikpuan h join uyeler u on h.kullaniciid=u.id join takimlar ta on u.takimi=ta.id group by ta.takim,u.kullaniciadi, h.ticket  order by h.ticket desc
 )ilkbes
UNION
select * from(
 select ROW_NUMBER() over(order by  h.ticket desc  ) [sirasi], ta.takim takimi, u.kullaniciadi,h.ticket ticketsayisi from haftalikpuan h join uyeler u on h.kullaniciid=u.id join takimlar ta on u.takimi=ta.id  group by ta.takim,u.kullaniciadi, h.ticket  
 )kendisirasi where kullaniciadi=@kullaniciadi



 create  proc haftasiralamalari
 as

 select   ROW_NUMBER() over(order by  h.ticket desc ) [sirasi], ta.takim takimi, u.kullaniciadi,h.ticket ticketsayisi from haftalikpuan h join uyeler u on h.kullaniciid=u.id join takimlar ta on u.takimi=ta.id group by ta.takim,u.kullaniciadi, h.ticket  order by h.ticket desc



 create proc ayinilkbesi
 @kullaniciadi nvarchar(20)
 as
  select * from(
 select  top(5) ROW_NUMBER() over(order by  a.ticketsayisi desc ) [sirasi], ta.takim takimi, u.kullaniciadi,a.ticketsayisi  from aylikpuan a join uyeler u on a.kullaniciid=u.id join takimlar ta on u.takimi=ta.id group by ta.takim,u.kullaniciadi, a.ticketsayisi  order by a.ticketsayisi desc
 )ilkbes
UNION
select * from(
 select ROW_NUMBER() over(order by  a.ticketsayisi desc  ) [sirasi], ta.takim takimi, u.kullaniciadi,a.ticketsayisi from aylikpuan a join uyeler u on a.kullaniciid=u.id join takimlar ta on u.takimi=ta.id  group by ta.takim,u.kullaniciadi, a.ticketsayisi  
 )kendisirasi where kullaniciadi=@kullaniciadi

 select  ROW_NUMBER() over(order by  ticket desc  ),kullaniciid,ticket  from haftalikpuan  order by  ticket  desc

  declare @syc int =55 
 while(@syc<76)
 begin
 insert into haftalikpuan(kullaniciid,ticket) values(@syc,'0')
 set @syc += 1
 end
 select * from toplamticket ORDER BY kullaniciid 

 alter proc kullanicisoruekle
 @soru nvarchar(max),
 @kullaniciid int
 as 
 insert into kullanicisoru(kullanicisorusu,kullaniciid) values(@soru,@kullaniciid)
 select 'true' deger

 exec kullanicisoruekle 'select * from sorular',1
 select * from kullanicisoru

 delete from kullanicisoru
 SELECT LEN(kullaniciadi) FROM uyeler;
 exec puansirasi 'emre','2015-03-24','2015-04-30',1,11
 SELECT * FROM uyeler 
 update uyeler set takimi='FENERBAHCE' where id=5


 select u.id,u.eposta,ta.takim,u.ad,u.soyad,u.kullaniciadi,u.sifre,u.androidid from uyeler u join takimlar ta on u.takimi=ta.id 
 select * from uyeler

 delete from uyeler
 delete from ticketekle
 delete from toplamticket



 create proc MailBilgiGetir
 @eposta varchar(100)
 as
 select eposta,ad,soyad,kullaniciadi,sifre from uyeler where eposta=@eposta



 exec MailBilgiGetir 'emrewebmaster@hotmail.com'

 select count(id) from Table_1

 declare @syc int =0
 while(@syc<5000000)
 begin
 insert into Table_1(asd) values('sahte')
 set @syc += 1
 end

 exec uyekaydet 'deneme@hotmail.com','2','Semih','Kaya','semihk','1234','234234234234'
  insert into uyeler(eposta,takimi,ad,soyad,kullaniciadi,sifre,androidid) values('sksgl@hotmail.com','FENERBAHCE','Selda','Köseoðlu','selda','1234','234234234234')


  create proc uyeguncelle
  @uyeid int,
  @ad varchar(50),
  @soyad varchar(50),
  @kullaniciadi varchar(50),
  @sifre varchar(50),
  @email varchar(100)
  as
  update uyeler set eposta=@email, ad=@ad,soyad=@soyad,kullaniciadi=@kullaniciadi,sifre=@sifre where id=@uyeid

  delete sorular where id in (13,14,15,16)
  update sorular set cevapb='Kýrmýzý-Beyaz' where id>131 and id<138
  select * from sorular

 delete uyeler where id >5
 select * from toplamticket
 insert into toplamticket(kullaniciid,toplamticket) values(84515,0) 
 

 alter proc login
 @kullaniciadi varchar(50),
 @sifre varchar(50)
 as 
 select u.id,u.eposta,ta.takim takimi ,u.ad,u.soyad,u.kullaniciadi,u.sifre,u.androidid from uyeler u join takimlar ta on u.takimi=ta.id  where (kullaniciadi=@kullaniciadi) and (sifre=@sifre)

 select * from takimlar ta join uyeler u on ta.id=u.takimi
 
 create proc takimlistesi
 as
select * from takimlar



 exec login emre,1234

 alter proc sorugetir
 @soruid int
 as
 select * from (
 select *,count(id) over() toplamsoru,ROW_NUMBER() over(order by(id)) sira from sorular where derece= @soruid
 )sorular where sira= CONVERT(INT, RAND()* toplamsoru+1)
 
 exec sorugetir 1

 select CONVERT(INT, RAND()* 10000)

 alter proc sorukaydet
 @derece int,
@soru nvarchar(max),
@cevapa nvarchar(250),
@cevapb nvarchar(250),
@cevapc nvarchar(250),
@cevapd nvarchar(250),
@dogrucevap nvarchar(250)

 as
 Insert Into sorular(derece,soru,cevapa,cevapb,cevapc,cevapd,dogrucevap) Values (@derece,@soru,@cevapa,@cevapb,@cevapc,@cevapd,@dogrucevap)

 exec sorukaydet 1,'Semih Þentürk Hangi Takýmda Oynuyor','Fenerbahçe','Baþakþehir','Mersin ÝdmanYurdu','Bursaspor','Baþakþehir'

 select * from sorular
 
 select CONVERT(INT, RAND()* 5+1)

 exec facebookpaylas 9

 alter proc ticketkaydet
 @kulid int
 as
 insert into ticketekle(kullaniciid,ticket,tarih) values(@kulid,1,getdate()) 
 update toplamticket set toplamticket=toplamticket+1  where kullaniciid=@kulid
 
 create proc jokerekle
 @kullaniciid int
 as
update toplamticket set jokersayisi=jokersayisi+1  where kullaniciid=@kullaniciid

 alter proc jokersil
 @kullaniciid int,
 @jokersayisi int
 as
update toplamticket set jokersayisi=@jokersayisi  where kullaniciid=@kullaniciid
 select * from uyeler
 select * from toplamticket
  create proc jokersayisi
   @kullaniciid int
  as
  select jokersayisi from toplamticket where kullaniciid=@kullaniciid

  exec jokersil 58,50

  exec ticketkaydet 52
  select * from uyeler
  select * from toplamticket

  exec kullaniciadiepostakontrol 'emre','emre@hotmadil.com'


  
  
  
  declare @i int =0
   
  while(@i<5)
  begin
   declare @j int =0
  while(@j<4)
   begin
   insert into ticketekle(kullaniciid,ticket,tarih) values(81860+@i,1,getdate())
 set @j+=1
   end
    set @i+=1
  end

  select * from ticketekle where id=46555
  alter proc kullaniciadiepostakontrol
  as
  select kullaniciadi,eposta,id from  uyeler 

  exec kullaniciadiepostakontrol
 

   insert into ticketekle(kullaniciid,ticket,tarih) values(1,1,'2015-03-18')

   select * from ticketekle where tarih between '2015-03-01' and '2015-03-07' and kullaniciid=1

 select * from uyeler

   

INSERT toplamticket 

select kullaniciid,count(t.ticket) toplamticket  from ticketekle t join uyeler u on t.kullaniciid=u.id group by kullaniciid

alter proc toplamticketsayisi
@kullaniciid int 
as
select toplamticket from toplamticket where kullaniciid=@kullaniciid
exec toplamticketsayisi 7

select * from toplamticket
select * from ticketekle
12qw3ey
select * from uyeler 
select count(kullaniciadi) sayi  from  uyeler  where  LEN('emreemreemre')>11
 exec uyekontrol 'emreemreemre','emrewebaster@hotmail.com','asdadasd'
