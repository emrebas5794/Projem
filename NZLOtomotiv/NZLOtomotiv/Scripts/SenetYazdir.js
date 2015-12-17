console.log(SenetData);
Globalize.culture("tr-TR");

var div = $(".senet-table-yazdir");
for (var i = 0; i < SenetData.length; i++) {
    SenetDataObject = SenetData[i];
    var tarihcevir = SenetDataObject.DuzenlenmeTarihi.split(".");
    var DuzenlenmeTarihiCevir = SenetDataObject.OdemeGunu.split(".");
    var OdemeGunuDate = Globalize.format(new Date(tarihcevir[1]+"."+tarihcevir[0]+"."+tarihcevir[2]), "E");
   
    table = $("<div>").css({ "width": "21cm", "height": "10cm", position:"relative" }),
    SenetVadeDiv = $("<div>").text(SenetDataObject.SenetVade).css({ "left": "6.4cm", "top": "1cm", "position": "absolute" }),
    OdemeGunuDiv = $("<div>").text(SenetDataObject.OdemeGunu).css({ "left": "9.5cm", "top": "1cm", "position": "absolute" }),
    TurkLirasiDiv = $("<div>").text(SenetDataObject.TurkLirasi + "₺").css({ "left": "13.7cm", "top": "1.1cm", "position": "absolute" }),
    KurusDiv = $("<div>").text(SenetDataObject.Kurus + "kr").css({ "left": "17cm", "top": "1.1cm", "position": "absolute" }),
    NoDiv = $("<div>").text(SenetDataObject.SenetNo).css({ "left": "20cm", "top": "1.1cm", "position": "absolute" }),
    SayinDiv = $("<div>").text(SenetDataObject.Sayin).css({ "left": "7cm", "top": "2.8cm", "position": "absolute" }),
    YaziOdemeGunuDiv = $("<div>").text(OdemeGunuDate).css({ "left": "13cm", "top": "2.3cm", "position": "absolute" }),
    YaziTurkLirasiDiv = $("<div>").text(SenetDataObject.YaziPara).css({ "left": "10cm", "top": "3.4cm", "position": "absolute" }),
    YaziKurusDiv = $("<div>").text(SenetDataObject.YaziKurus).css({ "left": "5.7cm", "top": "3.9cm", "position": "absolute", "font-size": "12px" }),
    VukuuDiv = $("<div>").text(SenetDataObject.SenetVukuu).css({ "left": "17.2cm", "top": "4.8cm", "position": "absolute", "font-size": "12px" }),
    OdeyecekIsimDiv = $("<div>").text(SenetDataObject.OdeyecekIsim).css({ "left": "8cm", "top": "6.4cm", "position": "absolute" }),
    OdeyecekAdresDiv = $("<div>").text(SenetDataObject.OdeyecekAdres).css({ "left": "6.5cm", "top": "7.5cm", "position": "absolute" }),
    OdeyecekTcVerginoDiv = $("<div>").text(SenetDataObject.OdeyecekTcVergino).css({ "left": "10cm", "top": "8.1cm", "position": "absolute" }),
    KefilIsimDiv = $("<div>").text(SenetDataObject.KefilIsim).css({ "left": "8cm", "top": "8.6cm", "position": "absolute" }),
    KefilTcVerginoDiv = $("<div>").text(SenetDataObject.KefilTcVergino).css({ "left": "10cm", "top": "9.2cm", "position": "absolute" }),
    DuzenlenmeTarihiGunDiv = $("<div>").text(DuzenlenmeTarihiCevir[0]).css({ "left": "18.5cm", "top": "6.6cm", "position": "absolute", "font-size": "12px" }),
    DuzenlenmeTarihiAyDiv = $("<div>").text(DuzenlenmeTarihiCevir[1]).css({ "left": "19.4cm", "top": "6.6cm", "position": "absolute", "font-size": "12px" }),
    DuzenlenmeTarihiYilDiv = $("<div>").text(DuzenlenmeTarihiCevir[2].substring(2)).css({ "left": "20.4cm", "top": "6.6cm", "position": "absolute", "font-size": "12px" }),
    DuzenlenmeYeriDiv = $("<div>").text(SenetDataObject.DuzenlenmeYeri).css({ "left": "18.5cm", "top": "7cm", "position": "absolute" });

    if (SenetDataObject.SenetYapilan=="kisi") {
        SenedimDiv = $("<div>").text("in").css({ "left": "9.7cm", "top": "2.5cm", "position": "absolute","font-size":"11px"});
        OdeyecegiDiv = $("<div>").text("m").css({ "left": "13cm", "top": "4cm", "position": "absolute", "font-size": "11px" });
        EyleriDiv = $("<div>").text("m").css({ "left": "13.4cm", "top": "5.3cm", "position": "absolute", "font-size": "11px" });
        BedeliDiv = $("<div>").text("Nakden").css({ "left": "14.5cm", "top": "3.9cm", "position": "absolute", "font-size": "11px" });
    }
    else {
        SenedimDiv = $("<div>").text("izin").css({ "left": "9.5cm","top": "2.5cm", "position": "absolute" });
        OdeyecegiDiv = $("<div>").text("iz").css({ "left": "13cm", "top": "4cm", "position": "absolute" });
        EyleriDiv = $("<div>").text("iz").css({ "left": "13.4cm",  "top": "5.3cm", "position": "absolute" });
        BedeliDiv = $("<div>").text("Malen").css({ "left":"14.5cm","top": "3.9cm", "position": "absolute" });
    }
    
    

    div.append(table.append(SenetVadeDiv).append(OdemeGunuDiv).append(TurkLirasiDiv).append(KurusDiv).append(NoDiv).append(SayinDiv).append(YaziOdemeGunuDiv).append(YaziTurkLirasiDiv).append(YaziKurusDiv).append(VukuuDiv).append(OdeyecekIsimDiv).append(OdeyecekAdresDiv).append(OdeyecekTcVerginoDiv).append(KefilIsimDiv).append(KefilTcVerginoDiv).append(DuzenlenmeTarihiGunDiv).append(DuzenlenmeTarihiAyDiv).append(DuzenlenmeTarihiYilDiv).append(DuzenlenmeYeriDiv).append(SenedimDiv).append(OdeyecegiDiv).append(EyleriDiv).append(BedeliDiv));
      
}
   
