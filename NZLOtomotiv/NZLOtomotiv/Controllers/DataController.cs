using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NZLOtomotiv.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NZLOtomotiv.Controllers
{
    public class DataController : Controller
    {
        [HttpPost]
        public string PersonelSil(string id)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return PersonelIslemleri.PersonelSil(id);
        }
        [HttpPost]
        public string PersonelKaydet(string KullaniciAdi, string Sifre, string Email, string Telefon)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return PersonelIslemleri.PersonelKaydet(KullaniciAdi, Sifre, Email, Telefon);
        }
        [HttpPost]
        public string PersonelDuzenle(string KullaniciAdi, string Sifre, string Email, string Telefon, string id)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return PersonelIslemleri.PersonelDuzenle(KullaniciAdi, Sifre, Email, Telefon,id);
        }

        [HttpPost]
        public string PersonelAl()
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return PersonelIslemleri.PersonelAl();
        }



        [HttpPost]
        public string YazdirBilgi(string AracData)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return AracData;
        }
        [HttpPost]
        public string AracAra(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return AracIslemleri.AracAra(Data);
        }
   

        [HttpPost]
        public string AracKaydet(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return AracIslemleri.AracKaydet(Data);
        }
        [HttpPost]
        public string AracMaliyetEkle(string AracUID,string Maliyet,string KasaFoyuId)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return AracIslemleri.AracMaliyetEkle(AracUID, Maliyet, KasaFoyuId);
        }
        [HttpPost]
        public string AracDuzenle(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return AracIslemleri.AracDuzenle(Data);
        }
        [HttpPost]
        public string AracSil(string AracUID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.AracSil(AracUID);
            if (Directory.Exists(Server.MapPath("~/Data/AracResimleri/" + AracUID)))
            {
                Directory.Delete(Server.MapPath("~/Data/AracResimleri/" + AracUID), true);
            }
            
            return "OK";
        }
        [HttpPost]
        public string AracAra2(string AracUID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return AracIslemleri.AracAra2(AracUID);
        }

        [HttpPost]
        public string AracResimEkle(string AracID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";

            System.IO.DirectoryInfo dirinfo = new System.IO.DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + "/Data/AracResimleri/" + AracID);
            if (!dirinfo.Exists)
                dirinfo.Create();
            JArray response = new JArray();
            foreach (string key in Request.Files)
            {
                string tarihsaat = DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString()+DateTime.Now.Millisecond.ToString();

                HttpPostedFileBase file = Request.Files[key];
                string name = tarihsaat + System.IO.Path.GetExtension(file.FileName);
                file.SaveAs(dirinfo.FullName + "/" + name);
                response.Add(name);
            }
            return JsonConvert.SerializeObject(response);
        }

        [HttpPost]
        public string AracResimSil(string AracUID, string ResimAdi)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";

            System.IO.File.Delete(Server.MapPath("~/Data/AracResimleri/" + AracUID + "/" + ResimAdi));
            return "Ok";
        }

        public string AracSatisYap(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.AracSatisYap(Data);
            return "OK";
        }

        [HttpPost]
        public string IletisimBilgisiAl(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return IletisimIslemleri.IletisimBilgisiAl(Data);
        }

        [HttpPost]
        public string IletisimBilgisiKaydet(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return IletisimIslemleri.IletisimBilgisiKaydet(Data);
        }

        public string IletisimBilgisiDuzenle(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return IletisimIslemleri.IletisimBilgisiDuzenle(Data);
        }

        [HttpPost]
        public string GiderKaydet(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            GiderIslemleri.GiderKaydet(Data);
            return "OK";
        }

        [HttpPost]
        public string GiderAl(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return GiderIslemleri.GiderAl(Data);
        }

        [HttpGet]
        public string KasaFoyuAl()
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return KasaFoyuIslemleri.KasaFoyuAl();
        }

        [HttpPost]
        public string KasaFoyuGir(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            KasaFoyuIslemleri.KasaFoyuGir(Data);
            return "OK";
        }

        [HttpPost]
        public string KasaFoyuUpdate(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            KasaFoyuIslemleri.KasaFoyuUpdate(Data);
            return "OK";
        }

        [HttpPost]
        public string KasaFoyuMaliyetGirdisi(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            KasaFoyuIslemleri.KasaFoyuMaliyetGirdisi(Data);
            return "OK";
        }

        [HttpPost]
        public string KasaFoyuSifirla(string BaslangicTarihi, string Miktar)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            KasaFoyuIslemleri.KasaFoyuSifirla(BaslangicTarihi, Miktar);
            return "OK";
        }

        [HttpPost]
        public string KasaFoyuSil(string KasaFoyID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            KasaFoyuIslemleri.KasaFoyuSil(KasaFoyID);
            return "OK";
        }

        [HttpPost]
        public string MaliyetleriGoruntule()
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";

            return AracIslemleri.MaliyetleriGoruntule().ToString();
        }

        [HttpPost]
        public string MaliyetEkle(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.MaliyetEkle(Data);
            return "OK";
        }

        [HttpPost]
        public string MaliyetSil(string MaliyetID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.MaliyetSil(MaliyetID);
            return "OK";
        }

        [HttpPost]
        public string MaliyetManuelAracKayit(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.MaliyetManuelAracKayit(Data);
            return "OK";
        }

        [HttpPost]
        public string MaliyetNotKaydet(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.MaliyetNotKaydet(Data);
            return "OK";
        }

        [HttpPost]
        public string MaliyetGuncelle(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.MaliyetGuncelle(Data);
            return "OK";
        }

        [HttpPost]
        public string OpsiyonGuncelle(string Opsiyon,string AracUID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";

           string kullaniciadi=Session["Username"].ToString();
         DateTime tarih=  DateTime.Now;

      string sonuc=  AracIslemleri.OpsiyonGuncelle(Opsiyon, AracUID, tarih, kullaniciadi);
      return sonuc;
        }

        [HttpPost]
        public string MaliyetSifirla(string Tip)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.MaliyetTemizle(Tip);
            return "OK";
        }

        [HttpPost]
        public string MaliyetKaydet(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            AracIslemleri.MaliyetKaydet(Data);
            return "OK";
        }

        /// <summary>
        /// Tadilat Controller
        /// </summary>

        [HttpPost]
        public string TadilatListesiAl()
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return new TadilatIslemleri().TadilatListesiAl().ToString();
        }

        [HttpPost]
        public string TadilatSutunOlustur(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            new TadilatIslemleri().TadilatSutunOlustur(Data);
            return "OK";
        }

        [HttpPost]
        public string TadilatNotKaydet(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            new TadilatIslemleri().TadilatNotKaydet(Data);
            return "OK";
        }

        [HttpPost]
        public string TadilatManuelAracEkle(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            new TadilatIslemleri().TadilatManuelAracEkle(Data);
            return "OK";
        }

        [HttpPost]
        public string TadilatSutunSil(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            new TadilatIslemleri().TadilatSutunSil(Data);
            return "OK";
        }

        [HttpPost]
        public string TadilatKaydiGuncelle(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            new TadilatIslemleri().TadilatKaydiGuncelle(Data);
            return "OK";
        }
        [HttpPost]
        public string TadilatKayitAracGonder(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            new TadilatIslemleri().TadilatKayitAracGonder(Data);
            return "OK";
        }

        [HttpPost]
        public string TadilatHesapKes(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            new TadilatIslemleri().TadilatHesapKes(Data);
            return "OK";
        }

        [HttpPost]
        public string TadilatKayitKalidr(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            new TadilatIslemleri().TadilatKayitKalidr(Data);
            return "OK";
        }

        [HttpGet]
        public string SenetProfilAl()
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return SenetIslemleri.SenetProfilAl();
        }

         [HttpPost]
        public string SecilenSenetProfilAl(string ContactUID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return SenetIslemleri.SecilenSenetProfilAl(ContactUID);
        }

        [HttpPost]
        public string YeniSenetBlok(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            SenetIslemleri.YeniSenetBlok(Data);
            return "OK";
        }

        [HttpPost]
        public string SenetBlokAl(string Borclu)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return SenetIslemleri.SenetBlokAl(Borclu);
        }

        [HttpPost]
        public string SenetProfilEkle(string ContactID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return SenetIslemleri.SenetProfilEkle(ContactID);
        }

        [HttpPost]
        public string SenetProfilKaldir(string ContactUID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            SenetIslemleri.SenetProfilKaldir(ContactUID);
            return "OK";
        }

        [HttpPost]
        public string SenetProfilNotKaydet(string ContactID, string Not)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            SenetIslemleri.SenetProfilNotKaydet(ContactID, Not);
            return "OK";
        }

        [HttpPost]
        public string SenetDuzenle(string DuzenlenenSenetler, string EklenenSenetler, string SilinenSenetler, string BlokBilgileri, string SenetBlokID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return SenetIslemleri.SenetDuzenle(DuzenlenenSenetler, EklenenSenetler, SilinenSenetler, BlokBilgileri, SenetBlokID);
        }

        [HttpPost]
        public string SenetBlokSil(string SenetBlokID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            SenetIslemleri.SenetBlokSil(SenetBlokID);
            return "OK";
        }

        [HttpPost]
        public string SenetRiskiAl(string ContactUID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return SenetIslemleri.SenetRiskiAl(ContactUID);
        }

        [HttpPost]
        public string SenetBlokNotKaydet(string SenetBlokID, string Not)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            SenetIslemleri.SenetBlokNotKaydet(SenetBlokID, Not);
            return "OK";
        }

        public string SenetFiltre(string type)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            switch (type)
            {
                default:
                    break;
                case "TarihiGecmis":
                    return SenetIslemleri.Filtre.TarihiGecmis();
                case "TarihAraligi":
                    {
                        string BasTarih = HttpContext.Request["BasTarih"];
                        string SonTarih = HttpContext.Request["SonTarih"];
                        return SenetIslemleri.Filtre.TarihAraligi(BasTarih, SonTarih);
                    }
                case "AlacakTipi":
                    string AlacakTipi = HttpContext.Request["AlacakTipi"];
                    return SenetIslemleri.Filtre.AlacakTipi(AlacakTipi);
                case "AlacakTipiOzet":
                    return SenetIslemleri.Filtre.AlacakTipiOzet();
            }
            return "Geçersiz Filtre Operasyonu";
        }

        [HttpGet]
        public string CekListesiAl()
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return CekIslemleri.CekListesiAl();
        }

        [HttpGet]
        public string CekArsivAl()
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return CekIslemleri.CekArsivAl();
        }

        [HttpPost]
        public string CekEkle(string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            CekIslemleri.CekEkle(Data);
            return "OK";
        }

        [HttpPost]
        public string CekRiskiAl(string ContactUID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return CekIslemleri.CekRiskiAl(ContactUID);
        }

        [HttpPost]
        public string CekAl(string CekAlinanKisi)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            return CekIslemleri.CekAl(CekAlinanKisi);
        }

        [HttpPost]
        public string CekSilArsivle(string CekID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            CekIslemleri.CekSilArsivle(CekID);
            return "OK";
        }

        [HttpPost]
        public string CekDuzenle(string CekID, string Data)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            CekIslemleri.CekDuzenle(CekID, Data);
            return "OK";
        }

        [HttpPost]
        public string CekSil(string CekID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            CekIslemleri.CekSil(CekID);
            return "OK";
        }

        public string CekArsivSil(string CekID)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            CekIslemleri.CekArsivSil(CekID);
            return "OK";
        }

        [HttpPost]
        public string RisklerVeLimitAl(string ContactUID = null)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";

            if (Request["ContactUID"] != null)
                return RiskLimitIslemleri.RisklerVeLimitAl(Request["ContactUID"]);

            return RiskLimitIslemleri.RisklerVeLimitAl();
        }

        [HttpPost]
        public string GenelRisk()
        {
            if (!Globals.ManageSession())
            {
                return "Lütfen giriş yapın.";
            }
           return RiskLimitIslemleri.GenelRisk();
        }

        [HttpPost]
        public string GenelRiskGuncelle(string Limit)
        {
            if (!Globals.ManageSession())
            {
                return "Lütfen giriş yapın.";
            }
            return RiskLimitIslemleri.GenelRiskGuncelle(Limit);
        }
        [HttpPost]
        public string ResmiGirisYap(string AracUID, string ResmiAlınanTipi, string ResmiAlınanKisi, string NoterAlisTarihi, string ResmiGirisBedeli, string ResmiGirisTcVergiNo, string ResmiGirisFatura)
        {
            if (!Globals.ManageSession())
            {
                return "Lütfen giriş yapın.";
            }
            return AracIslemleri.ResmiGirisYap(AracUID, ResmiAlınanTipi, ResmiAlınanKisi, NoterAlisTarihi, ResmiGirisBedeli, ResmiGirisTcVergiNo, ResmiGirisFatura);
        }

        public string ResmiCikisYap(string AracUID, string ResmiCikisKisi, string ResmiCikisBedeli, string ResmiCikisTarihi, string ResmiCikisTcVergiNo)
        {
            if (!Globals.ManageSession())
            {
                return "Lütfen giriş yapın.";
            }
            return AracIslemleri.ResmiCikisYap(AracUID, ResmiCikisKisi, ResmiCikisBedeli, ResmiCikisTarihi, ResmiCikisTcVergiNo);
        }

        [HttpPost]
        public string RiskLimitDuzenle(string ContactUID, int RiskLimit = 0)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            RiskLimitIslemleri.RiskLimitDuzenle(ContactUID, RiskLimit);
            return "OK";
        }

        public string RiskFiltre(string type)
        {
            if (!Globals.ManageSession())
                return "Lütfen giriş yapın.";
            switch (type)
            {
                default:
                    break;
                case "LimitAsan":
                    return RiskLimitIslemleri.Filtre.LimitAsan();
                case "RiskAralik":
                    {
                        int Min = string.IsNullOrWhiteSpace(HttpContext.Request["Min"]) ? 0 : int.Parse(HttpContext.Request["Min"]);
                        int Max = string.IsNullOrWhiteSpace(HttpContext.Request["Max"]) ? 0 : int.Parse(HttpContext.Request["Max"]);
                        return RiskLimitIslemleri.Filtre.RiskAralik(Min, Max);
                    }
            }
            return "Geçersiz Filtre Operasyonu";
        }

        public void PanicButton()
        {
            //TODO : Bunu güvenli hala getir
            Globals.LoggedInUsers.Clear();
        }
    }
}

//TODO: Bütün date tipi dataları yyyy/MM/dd olarak döndürüp arayüzde gösterirken düzenle. (Solution'da DateTime.TryParse aratarak hepsine ulaş)