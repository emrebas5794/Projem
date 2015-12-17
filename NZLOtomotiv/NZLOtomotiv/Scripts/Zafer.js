/// <reference path="General.js" />
/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/bootstrap.js" />
/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/$-2.1.3.js" />
/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/$-ui.js" />
/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/$.noty.packaged.js" />
/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/$.maskedinput.js" />
/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/dx.all.debug.js" />

//#region Kasa Föyü


// Giriş tablosundaki "Giriş Ekle" butonu.
$(document).on("click", ".kasa-foyu .kasa-gelir-ekle", function () {
       
    if (!$(".kasa-foyu").hasClass("Giris")) {
        var kasafoyu = $(".templates .kasa-foyu-template").clone().removeClass("kasa-foyu-template").addClass("kasa-foyu");
        $(".content-container").empty();
        kasafoyu.appendTo(".content-container");
       
        KasaFoyu_TabloOlustur(kasa_data);
          
            kasafoyu.removeClass("Cikis");
            kasafoyu.addClass("Giris");

            kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append("<tr>");
            kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Fiyat").addClass("form-control sayi")));
            kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Açıklama").addClass("form-control aciklama")));
            kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append("</tr>");
            $(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .sayi").focus();
       
    }
   

});
// Çıkış tablosundaki "Çıkış Ekle" butonu.
$(document).on("click", ".kasa-foyu .kasa-gider-ekle", function () {
   
    if (!$(".kasa-foyu").hasClass("Cikis")) {
        var kasafoyu = $(".templates .kasa-foyu-template").clone().removeClass("kasa-foyu-template").addClass("kasa-foyu");
        $(".content-container").empty();
        kasafoyu.appendTo(".content-container");
       
        KasaFoyu_TabloOlustur(kasa_data);
           
            kasafoyu.removeClass("Giris");
            kasafoyu.addClass("Cikis");
            kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append("<tr>");
            kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Fiyat").addClass("form-control sayi")));
            kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Açıklama").addClass("form-control aciklama")));
            kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append("</tr>");
            $(".kasa-foyu .kasa-gider .kasa-foyu-tablo .sayi").focus();
        
      
    }
    
});

// Kasa sıfırlama butonu.
$(document).on("click", "#kasa-foyu-kasaSifirla", function () {
    var atanmisgirdisayisi = $(".kasa-foyu .kasa-foyu-tablo .atanmis-girdi").length;
    var tumgirdisayisi = $(".kasa-foyu .kasa-foyu-tablo .TR").length;

    var sonuc = tumgirdisayisi - atanmisgirdisayisi;
    console.log(sonuc);
    if (sonuc==0) {
    swal({
        title: "Emin misiniz?",
        text: "Kasayı sıfırlamak istediğinize emin misiniz?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Evet",
        cancelButtonText: "Hayır",
        closeOnConfirm: false,
        closeOnCancel: false
    }, function (isConfirm) {
        if (isConfirm) {
           
                $.ajax({
                    url: "../../Data/KasaFoyuSifirla",
                    type: "post",
                    data: {
                        BaslangicTarihi: $(".kasa-foyu .kasa-foyu-baslangic span").text(),
                        Miktar: $(".kasa-foyu-toplam .TR").html()
                    },
                    beforeSend:
                        function () { FullPagePreload(); },
                    success:
                        function (data) {
                            if (data == "OK") {
                                noty({
                                    layout: "topRight",
                                    theme: 'relax',
                                    type: "information",
                                    text: "Kasa Föyü başarıyla sıfırlandı.",
                                    dismissQueue: true,
                                    animation: {
                                        open: 'animated bounceInRight',
                                        close: 'animated bounceOutRight'
                                    },
                                    maxVisible: 10,
                                    timeout: 5000
                                });

                                kasafoyugetir().done(function (datas) {                                  
                                        KasaFoyu_TabloOlustur(datas);                                    
                                    return;
                                });
                                swal.close();
                                return;
                            }
                            else if (data == "Lütfen giriş yapın.") {
                                alert(data);
                                window.location = "/";
                                return;
                            }
                        },
                    error:
                        function (jqxhr) {
                            console.log(jqxhr);
                            noty({
                                layout: "center",
                                theme: 'relax',
                                type: "error",
                                text: "İşlem Başarısız! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                                dismissQueue: true,
                                animation: {
                                    open: 'animated fadeIn'
                                },
                                timeout: false,
                                killer: true,
                                modal: true,
                                closeWith: ['click', 'backdrop']
                            });
                        },
                    complete:
                        function () { Remove_FullPagePreload(); }
                });
                swal.close();
           
          
        } else {
            swal.close();
        }
    });
    }
    else {

        DevExpress.ui.dialog.alert("Kasa Foylarında Atanmamıs Girdi Var Sıfırlanamıyor.");
    }
});

// Kasa föyüne giriş veya çıkış yapmak için.
function KasaFoyu_EklemeYap(EklemeTuru) {
    $(".kasa-foyu-ekle").modal("show");

    $(".kasa-foyu-ekle .modal-title").text("Kasa Föyü '" + EklemeTuru + "' Girdisi Ekle.");

    $("#kasa-ekle-kayitTipi").val(EklemeTuru);
}

function AracSec(Element) {
    var $this = $(this),
       modal = $(".arac-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        var span = $this.siblings("span"),
            dxLI = modal.find(".arac-sec-lookup").dxLookup("instance");
        console.log(dxLI.option("value") + Element.attr("fiyati"));
        $.ajax({
            url: "../../Data/AracMaliyetEkle",
            type: "post",
            data: { 
                AracUID: dxLI.option("value"),
                Maliyet: Element.attr("fiyati"),
                KasaFoyuId: Element.attr("kasa-foyu-id"),
    },
            beforeSend:
                function () { FullPagePreload(); },
            success:
                function (data) {
                    if (data == "Ok") {
                        noty({
                            layout: "topRight",
                            theme: 'relax',
                            type: "information",
                            text: "Araç maliyeti başarıyla kaydedildi.",
                            dismissQueue: true,
                            animation: {
                                open: 'animated bounceInRight',
                                close: 'animated bounceOutRight'
                            },
                            maxVisible: 10,
                            timeout: 5000
                        });
                        kasafoyugetir().done(function (datas) {
                            KasaFoyu_TabloOlustur(datas);
                        });
                        return;
                    }
                    else if (data=="Var") {
                        noty({
                            layout: "topRight",
                            theme: 'relax',
                            type: "information",
                            text: "Bu Araca Maliyet Zaten Kaydedilmiş",
                            dismissQueue: true,
                            animation: {
                                open: 'animated bounceInRight',
                                close: 'animated bounceOutRight'
                            },
                            maxVisible: 10,
                            timeout: 5000
                        });
                        return;
                    }
                    else if (data == "Lütfen giriş yapın.") {
                        alert(data);
                        window.location = "/";
                        return;
                    }
                },
            error:
                function (jqxhr) {
                    modal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                    console.log(jqxhr);
                    modal.modal("handleUpdate");
                },
            complete:
                function () { Remove_FullPagePreload(); }
        });

        modal.modal("hide");
    });
}


// Giriş veya Çıktı eklemek için açılan modaldaki "Kaydet" butonu.
$(document).on("click", ".kasa-foyu-ekle.modal .btn.btn-primary.kaydet", function () {
    var modal = $(this).closest(".modal");

    var emptyreq = modal.find(".required").filter(function (i, el) { return $(this).val().length < 1 });
    if (emptyreq.length) {
        emptyreq.eq(0).focus();
        var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css({ "display": "none", "color": "red" }).insertAfter(emptyreq.eq(0)).show(200);
        setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
        return;
    }

    $.ajax({
        url: "../../Data/KasaFoyuGir",
        type: "post",
        data: {
            Data: JSON.stringify({
                Tip: modal.find("#kasa-ekle-kayitTipi").val(),
                Miktar: modal.find("#kasa-ekle-kayitMiktar").val(),
                ParaBirimi: "TR",
                Aciklama: modal.find("#kasa-ekle-kayitAciklama").val(),
                BaslangicTarihi: $(".content-container > .kasa-foyu .kasa-foyu-baslangic > span").text()
            })
        },
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {
                if (data == "OK") {
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Kasa föyü girdisi başarıyla kaydedildi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    modal.modal("hide");
                    $(".left-menu-container li.kasafoyu").trigger("click");
                    return;
                }
                else if (data == "Lütfen giriş yapın.") {
                    alert(data);
                    window.location = "/";
                    return;
                }
            },
        error:
            function (jqxhr) {
                modal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                console.log(jqxhr);
                modal.modal("handleUpdate");
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
});

// Alınan tablo verilerini işlemek için.
function KasaFoyu_TabloOlustur(Data) {
    if (Data.length < 1)
        return alert("Kasa föyü içinde hiç kayıt bulunamadı.");

    var kasafoyu = $(".kasa-foyu").data("KasaFoyuData", Data);

    kasafoyu.find(".kasa-foyu-baslangic span").text(Data[0].BaslangicTarihi);

    var ToplamTL = 0,
        ToplamUSD = 0,
        ToplamEUR = 0;

    // Temizle
    kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").empty().append('<tr>  <th style="width:100px;">Fiyat</th> <th>Açıklama</th>  </tr>');
    kasafoyu.find(".kasa-gider .kasa-foyu-tablo").empty().append('<tr>  <th style="width:100px;">Fiyat</th> <th>Açıklama</th>  </tr>');
    kasafoyu.find(".kasa-foyu-toplam table td:nth-child(2)").empty();

    for (var i = 0; i < Data.length; i++) {
        var tr = $("<tr>");
        if (Data[i].AltTip=="") {
            var span = "";
        } else {
            var span = "<span  style='position:absolute;right:10px;top:10px' class='glyphicon glyphicon-info-sign alttip' aria-hidden='true' data-toggle='tooltip' data-placement='left' title='" + Data[i].AltTip + "'></span>";
        }
       
        tr.addClass(Data[i].ParaBirimi + (Data[i].AltTip ? " atanmis-girdi" : "")).attr({ "data-index": i, "kasa-foyu-id": Data[i].id });
        tr
            .append("<td>" + parseInt(Data[i].Miktar.replace(/[^0-9.-]/g, "")) + "</td>").attr("fiyati", parseInt(Data[i].Miktar.replace(/[^0-9.-]/g, "")))
            .append("<td style='position:relative'>" + Data[i].Aciklama +span+ "</td>");
            

     
        if (Data[i].Tip == "Giriş") {
            $(".kasa-gelir .kasa-foyu-tablo").append(tr);
          
            if (Data[i].ParaBirimi == "TR")
                ToplamTL += parseInt(Data[i].Miktar.replace(/[^0-9.-]/g, ""));
            else if (Data[i].ParaBirimi == "USD")
                ToplamUSD += parseInt(Data[i].Miktar.replace(/[^0-9.-]/g, ""));
            else if (Data[i].ParaBirimi == "EUR")
                ToplamEUR += parseInt(Data[i].Miktar.replace(/[^0-9.-]/g, ""));

        }
        else if (Data[i].Tip == "Çıkış") {
            $(".kasa-gider .kasa-foyu-tablo").append(tr);

            if (Data[i].ParaBirimi == "TR")
                ToplamTL -= parseInt(Data[i].Miktar.replace(/[^0-9.-]/g, ""));
            else if (Data[i].ParaBirimi == "USD")
                ToplamUSD -= parseInt(Data[i].Miktar.replace(/[^0-9.-]/g, ""));
            else if (Data[i].ParaBirimi == "EUR")
                ToplamEUR -= parseInt(Data[i].Miktar.replace(/[^0-9.-]/g, ""));
        }
        
    }
   
    if (ToplamTL != 0) {
        kasafoyu.find(".kasa-foyu-toplam table td:nth-child(2)").append($("<span>").addClass("TR").text(ToplamTL));
    }
    if (ToplamUSD != 0) {
        kasafoyu.find(".kasa-foyu-toplam table td:nth-child(2)").append($("<span>").addClass("USD").text(ToplamUSD));
    }
    if (ToplamEUR != 0) {
        kasafoyu.find(".kasa-foyu-toplam table td:nth-child(2)").append($("<span>").addClass("EUR").text(ToplamEUR));
    }
    $('[data-toggle="tooltip"]').tooltip();
    
   
}

function KasaFoyu_Gonder(Element, AltTip, Alt2Tip, BaglantiID) {
    console.log(Element);
    $.ajax({
        url: "../../Data/KasaFoyuUpdate",
        type: "post",
        data: {
            Data: JSON.stringify({
                id: Element.attr("kasa-foyu-id"),
                AltTip: AltTip,
                Alt2Tip: Alt2Tip,
                BaglantiID: BaglantiID
            })
        },
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {
                if (data == "OK") {
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Kasa föyü girdisi " + AltTip + (Alt2Tip ? " " + Alt2Tip : "") + " olarak atandı.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    kasafoyugetir().done(function (datas) {
                        KasaFoyu_TabloOlustur(datas);
                    });
                    return;
                }
                else if (data == "Lütfen giriş yapın.") {

                    window.location = "/";
                    return;
                }
            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
                noty({
                    layout: "center",
                    theme: 'relax',
                    type: "error",
                    text: "İşlem Başarısız! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                    dismissQueue: true,
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: false,
                    killer: true,
                    modal: true,
                    closeWith: ['click', 'backdrop']
                });
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
}

function KasaFoyu_AracMaliyetGonder(Element, Tip) {
    console.log($(Element).children("td:eq(0)").html() + " - " + $(Element).children("td:eq(1)").html());

    $.ajax({
        url: "../../Data/KasaFoyuMaliyetGirdisi",
        type: "post",
        data: {
            Data: JSON.stringify({
                Tip: Tip,
                Fiyat: $(Element).children("td:eq(0)").html(),
                Aciklama: $(Element).children("td:eq(1)").html(),
                KasaFoyID: $(Element).attr("kasa-foyu-id")
            })
        },
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {
                if (data == "OK") {
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Araç maliyeti çıkışı başarıyla kaydedildi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    Element.addClass("atanmis-girdi");
                    return;
                }
                else if (data == "Lütfen giriş yapın.") {
                    alert(data);
                    window.location = "/";
                    return;
                }
            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });

}
var kasa_data;
function KasaFoyu_Sil(Element) {

    $.ajax({
        url: "../../Data/KasaFoyuSil",
        type: "post",
        data: { KasaFoyID: Element.attr("kasa-foyu-id") },
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {
                if (data == "OK") {
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Araç maliyeti başarıyla Silindi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    $(".left-menu-container li.kasafoyu").trigger("click");
                    $(".kasa-foyu").removeClass("Cikis");
                    $(".kasa-foyu").removeClass("Giris");
                    $.ajax({
                        url: "../../Data/KasaFoyuAl",
                        type: "get",
                        beforeSend:
                            function () { FullPagePreload(); },
                        success:
                            function (data) {
                                try {
                                    kasa_data = JSON.parse(data);
                                } catch (e) {
                                    console.log(data);
                                    if (data == "Lütfen giriş yapın.") {
                                      
                                        window.location = "/";
                                    }
                                    return;
                                }
                                KasaFoyu_TabloOlustur(kasa_data);
                            },
                        error:
                            function (jqxhr) {
                                console.log(jqxhr);
                                noty({
                                    layout: "center",
                                    theme: 'relax',
                                    type: "error",
                                    text: "Kasa Föyü Alınamadı! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                                    dismissQueue: true,
                                    animation: {
                                        open: 'animated fadeIn'
                                    },
                                    timeout: false,
                                    killer: true,
                                    modal: true,
                                    closeWith: ['click', 'backdrop']
                                });
                            },
                        complete:
                            function () { Remove_FullPagePreload(); }
                    });
                    return;
                }
                else if (data == "Lütfen giriş yapın.") {
                    alert(data);
                    window.location = "/";
                    return;
                }
            },
        error:
            function (jqxhr) {
                modal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                console.log(jqxhr);
                modal.modal("handleUpdate");
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
}

//#endregion

//#region Maliyetler ( TADİLAT )
function tadilatlistesiCagir() {
    var maliyetler = $(".templates .maliyetler-template").clone().removeClass("maliyetler-template").addClass("maliyetler-ana-govde");
    $(".content-container").empty();
    maliyetler.appendTo(".content-container");
    TadilatListesiAl();
}
$(document).on("click", ".left-menu-container li.maliyetler", function () {
    tadilatlistesiCagir();
});

function TadilatListesiAl() {
    $.ajax({
     
        url: "../../Data/TadilatListesiAl",
        type: "post",
        success: function (e) {
            var AlinanData = JSON.parse(e);
          

            var SummaryArray = [];
            for (var i = 0; i < AlinanData.Ozet.length; i++) {
                //#region Summary Array Push
                SummaryArray.push({
                    column: "Maliyet_" + AlinanData.Ozet[i],
                    summaryType: 'sum',
                    customizeText: function (e) {
                        return "Toplam : " + e.value + " ₺";
                    }
                });
                //#endregion
            }

            $("#maliyet-column-silinecek").empty();
            $("#TadilatListesi_HesapButtonlar").empty();
            var Columns = [];
           


                Columns.push({
                    dataField: "Arac_TamAd",
                    caption: "Araçlar",
                    allowEditing:true,
                    cellTemplate: function (container, options) {
                        console.log(options.data);
                        $("<label>").text(options.data.Arac_TamAd).appendTo(container);
                        
                       
                    }

                })
           
            for (var i = 0; i < AlinanData.Baslik.length; i++) {
                
                //#region Öncelik 1
                if (AlinanData.Baslik[i].Oncelik == "True") {
                    Columns.push({
                        dataField: "Maliyet_" + AlinanData.Baslik[i].dataField,
                        caption: AlinanData.Baslik[i].caption,
                        tip: AlinanData.Baslik[i].Tip,
                        validationRules: [{
                            type: 'pattern',
                            message: 'Sayı girdiğinizden emin olun!',
                            pattern: /^[0-9]*$/
                        }],
                        cellTemplate: function (container, options) {
                            container.addClass(options.column.dataField);
                            var ManuelClass = options.data.Manuel_Veri == "True" ? "maliyet-manuel-veri" : "maliyet-auto-veri";
                            var KayitliClass = options.data.Hesap_Diger == "True" ? "maliyet-veri-kayitli" : ManuelClass;
                            var Deger = options.displayValue == undefined ? "" : options.displayValue == "" ? "" : options.displayValue + " ₺";

                            $("<label/>").addClass(KayitliClass).data("Veri", options.data).attr("columntype", options.column.dataField).attr("tip", options.column.tip).data("not", options.data["Not_" + options.column.dataField.replace("Maliyet_", "")]).attr("Deger", options.displayValue).css("width", "85%").text(Deger).appendTo(container);
                            try {
                                var DurumClass = options.data["Not_" + options.column.dataField.replace("Maliyet_", "")].length > 0 ? "maliyet-not-ok" : "";
                                $("<i/>").addClass("glyphicon flaticon-email5 maliyet-tablo-not " + DurumClass).data("not", options.data["Not_" + options.column.dataField.replace("Maliyet_", "")]).data("rowData", options).appendTo(container);
                            }
                            catch (ex)
                            { }
                        }
                    });

                    $("#maliyet-column-silinecek").append("<option value='" + AlinanData.Baslik[i].dataField + "'>" + AlinanData.Baslik[i].caption + "</option>");
                    $("#TadilatListesi_HesapButtonlar").append('<button hesap="' + AlinanData.Baslik[i].dataField + '" class="btn btn-primary tadilat-hesap-kes" disabled>' + AlinanData.Baslik[i].caption + ' Hesabını Kes</button>');
                }
                    //#endregion
                //#region Öncelik 2
                else {
                    Columns.push({
                        dataField: AlinanData.Baslik[i].dataField,
                        caption: AlinanData.Baslik[i].caption,
                        validationRules: [{ type: 'required' }]
                    });
                }
                //#endregion
            }
            Columns.push({
                caption: "Sil", alignment: "center", width: 150, cellTemplate: function (container, options) {
                    $('<button/>').addClass('dx-button').addClass("Maliyet_SilButton")
                        .text('Kayıt Kaldır')
                        .on('dxclick', function () {
                            Tadilat_KayitKaldir(options, SummaryArray);

                        })
                        .appendTo(container);
                }
            });

            $("#maliyet-ana-tablo").dxDataGrid({
                dataSource: AlinanData.Liste,
                columns: Columns,
                noDataText: "Kayıt Bulunamadı",
                hoverStateEnabled: true,
                allowColumnReordering: true,
                wordWrapEnabled: false,
                showBorders: true,
                onRowUpdating: function (e) {
                    Tadilat_KayitGuncelle(e);
                },
                onRowInserting: function (e) {
                    console.log(e);
                   
                },
                onCellPrepared: function (e) {
                    //console.log(e);
                    try {
                    
                        if (e.data[e.column.dataField.replace("Maliyet_", "Kayit_")] == "True") {
                            $(e.cellElement[0]).css("background", "rgb(204, 255, 199)").children(".maliyet-auto-veri").text("Gönderildi (" + e.value + " ₺)").removeClass("maliyet-auto-veri");
                            $(e.cellElement[0]).css("background", "rgb(204, 255, 199)").children(".maliyet-manuel-veri").text("Gönderildi (" + e.value + " ₺)").removeClass("maliyet-manuel-veri");
                        }
                        if (e.data[e.column.dataField.replace("Maliyet_", "Hesap_")] == "True") {
                            $(e.cellElement[0]).css("background", "rgb(255, 165, 165)").children("label").text("Hesap Kesildi").removeClass("maliyet-auto-veri");
                        }
                    }
                    catch (ex) {
                        //console.log(ex);
                    }
                },
                onEditingStart: function (e) {
                 
                    if (e.column.caption == "Araçlar" && e.data.Manuel_Veri == "False") {                       
                        e.cancel = true;                       
                    }
                  
                 
                        if (e.data[e.column.dataField.replace("Maliyet_", "Kayit_")] == "True") {
                            e.cancel = true;
                        }
                   
                },
                onRowInserted: function (e) {
                  
                    Tadilat_ManuelAracEkle(e);
                },
                onRowPrepared: function (e) {
                    //#region Hesabı kes butonları kontrolü
                    if (e.rowType == "header" || e.rowType == "totalFooter") return;
                    for (var i = 0; i < SummaryArray.length; i++) {
                        if (e.data[SummaryArray[i].column.replace("Maliyet_", "Kayit_")] == "True" && e.data[SummaryArray[i].column.replace("Maliyet_", "Hesap_")] != "True") {
                            $("#TadilatListesi_HesapButtonlar [hesap=" + SummaryArray[i].column.replace("Maliyet_", "") + "]").prop("disabled", false);
                        }
                    }
                    //#endregion
                },
                editing: {
                    editMode: 'batch',
                    editEnabled: true,
                    insertEnabled: true
                   
                },
                summary: {
                    totalItems: SummaryArray
                },
                width: '100%'
            });
            $("<div/>").dxButton({
                text: 'Sütun Sil',
                onClick: function () {
                    $(".maliyet-column-sil").modal("toggle");
                }
            }).appendTo(".dx-datagrid-header-panel");

            $("<div/>").dxButton({
                text: 'Sütun Ekle',
                onClick: function () {
                    $(".maliyet-column-ekle").modal("toggle");
                }
            }).appendTo(".dx-datagrid-header-panel");
        },
        error: function(a) {
            console.log(a);
        }
    });
}

$(document).on("click", ".maliyet-tablo-not", function (e) {
    e.stopPropagation();
    var RowData = $(this).data("rowData");
    console.log(RowData);
    $(".maliyet-not-goruntule .modal-title").text(RowData.data.Plaka + " - " + RowData.data.Arac_TamAd + " " + RowData.column.caption + " Maliyeti");

    var NotValue = $(this).data("not");

    $(".maliyet-not-goruntule #maliyetNot_TextArea").val(NotValue);
    $(".maliyet-not-goruntule").modal("show");

    $("#maliyetNot_Kaydet").unbind("click").bind("click", function () {
        $.ajax({
            url: "../../Data/TadilatNotKaydet",
            type: "post",
            data: {
                Data: JSON.stringify({
                    ID: RowData.data.id,
                    Column: RowData.column.dataField.replace("Maliyet_", ""),
                    NotValue: $(".maliyet-not-goruntule #maliyetNot_TextArea").val()
                })
            },
            success: function (e) {
                console.log(e);
                if (e == "OK") {
                    $(".maliyet-not-goruntule").modal("hide");
                    tadilatlistesiCagir();
                   
                }
                else if (data == "Lütfen giriş yapın.") {
                    alert(data);
                    window.location = "/";
                    return;
                }

            }
        });
    });
});

$(document).on("click", "#maliyetColumn_Kaydet", function () {
    $.ajax({
        async: false,
        url: "../../Data/TadilatSutunOlustur",
        type: "post",
        data: {
            Data: JSON.stringify({
                Sutun_Adi: $("#maliyet-column-ad").val(),
                Sutun_Tipi: $("#maliyet-column-tip").val()
            })
        },
        success: function (e) {
            if (e == "OK") {
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Sütun kayıdı başarıyla oluşturuldu.",
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: 5000
                });
                $(".maliyet-column-ekle").modal("hide");
                tadilatlistesiCagir();
               
            }
            else if ("Lütfen giriş yapın.") {
                alert(e);
                window.location = "/";
            }
        },
        error: function (a)
        {
            console.log(a);
        }

    });
});

$(document).on("click", "#maliyetColumn_Sil", function () {
    $.ajax({
        async: false,
        url: "../../Data/TadilatSutunSil",
        type: "post",
        data: {
            Data: JSON.stringify({
                Sutun_Adi: $("#maliyet-column-silinecek").val()
            })
        },     
        success: function (e) {
            if (e == "OK") {
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Seçilen sütun başarıyla silindi.",
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: 5000
                });
                
                tadilatlistesiCagir();
               
            }
            else if ("Lütfen giriş yapın.") {
                alert(e);
                window.location = "/";
            }
        },
        error: function (a) {
            console.log(a);
        }
    });
});

$(document).on("click", ".tadilat-hesap-kes", function () {
    console.log($(this).attr("hesap"));
    var Hesap = $(this).attr("hesap");
    swal({
        title: "Seçilen hesabı kesmek istediğinize emin misiniz?",
        text: "Gönderilmiş " + $(this).attr("hesap") + " kayıtların hesabı kesilecek. Emin misiniz?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Hesabı kes",
        cancelButtonText: "İptal et",
        closeOnConfirm: false,
        closeOnCancel: false,
    }, function (isConfirm) {
        if (isConfirm) {
            $.ajax({
                async: false,
                url: "../../Data/TadilatHesapKes",
                type: "post",
                data: {
                    Data: JSON.stringify({
                        Sutun_Adi: Hesap
                    })
                },
                success: function (e) {
                    if (e == "OK") {
                        noty({
                            layout: "topRight",
                            theme: 'relax',
                            type: "information",
                            text: "Tadilat hesabı başarıyla kesildi.",
                            animation: {
                                open: 'animated fadeIn'
                            },
                            timeout: 5000
                        });
                        $(".maliyet-column-ekle").modal("hide");
                        var maliyetler = $(".templates .maliyetler-template").clone().removeClass("maliyetler-template").addClass("maliyetler-ana-govde");
                        $(".content-container").empty();
                        maliyetler.appendTo(".content-container");
                        TadilatListesiAl();
                    }
                    else if ("Lütfen giriş yapın.") {
                      
                        window.location = "/";
                    }
                }
            });
            swal.close();
        }
        else {
            swal.close();
        }
    });
});

function Tadilat_ManuelAracEkle(Data) {
    
    $.ajax({
        url: "../../Data/TadilatManuelAracEkle",
        type: "post",
        data: {
            Data: JSON.stringify({
                Manuel_Veri: 1,
                Manuel_Data:Data.data
                //Manuel_AracPlaka: Data.data.Plaka,
                //Manuel_AracAdi: Data.data.Arac_TamAd,
                //Manuel_AracYil: Data.data.Arac_Yil,
                //Manuel_AracRenk: Data.data.Arac_Renk
            })
        },
        success: function (e) {
          
            if (e == "OK") {
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Manuel araç kaydı başarıyla oluşturuldu.",
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: 5000
                });
                tadilatlistesiCagir();
            }
        }
    });
}

function Tadilat_KayitGuncelle(Data) {
    console.log(Data.newData);
    switch (Object.keys(Data.newData)[0]) {
        case "Plaka":
        case "Arac_Yil":
        case "Arac_Renk":
            return;
        default:
            {
                $.ajax({
                    url: "../../Data/TadilatKaydiGuncelle",
                    type: "post",
                    data: {
                        Data: JSON.stringify({
                            Kayit_ID: Data.key.id,
                            Kayit_Sutun: Data.newData,
                            
                        })
                    },
                    success: function (e) {
                     
                        if (e == "OK") {
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: Object.keys(Data.newData) + " kaydı başarıyla değiştirildi.",
                                animation: {
                                    open: 'animated fadeIn'
                                },
                                timeout: 5000
                            });
                            tadilatlistesiCagir();
                            
                        }
                        else if (e == "Lütfen giriş yapın.") {
                            
                            window.location = "/";
                            return;
                        }

                    }
                });
            }
    }
}

function Tadilat_KayitKaydet(Element) {
       

        $.ajax({
            url: "../../Data/TadilatKayitAracGonder",
            type: "post",
            data: {
                Data: JSON.stringify({
                    VeriID: Element.data("Veri").id,
                    AracID: Element.data("Veri").Arac_ID,
                    SutunAdi: Element.attr("columntype").replace("Maliyet_", ""),
                    KayitTipi: Element.attr("tip"),
                    VeriMiktar: Element.attr("deger"),
                    VeriNot: Element.data("not")
                })
            },
            success: function (e) {
                console.log(e);
                if (e == "OK") {
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Tadilat kayıdı seçili araca başarıyla işlendi.",
                        animation: {
                            open: 'animated fadeIn'
                        },
                        timeout: 5000
                    });
                    tadilatlistesiCagir();
                }
                else if (data == "Lütfen giriş yapın.") {
                    alert(data);
                    window.location = "/";
                    return;
                }

            },
            error: function (a) {
                console.log(a);
            }
        });

    
    
}

function Tadilat_KayitKaldir(Data, summary) {
    console.log(Data.data);
    
    var varmi=0;
  
    for (var i = 0; i < summary.length; i++) {
        if (Data.data[summary[i].column.replace("Maliyet_", "Hesap_")] != "True") {
            varmi = i;
            
            swal({
                title: "Seçilen satırda Hesabı Kesilmeyenler Var Yinede Kaldırılsın mı?",
                text: "Seçilmiş olan satır güncel tadilat listesinden, arşive taşınsın mı?",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Taşı",
                cancelButtonText: "İptal et",
                closeOnConfirm: false,
                closeOnCancel: false,
            }, function (isConfirm) {
                if (isConfirm) {
                    $.ajax({
                        async: false,
                        url: "../../Data/TadilatKayitKalidr",
                        type: "post",
                        data: {
                            Data: JSON.stringify({
                                Satir_ID: Data.data.id
                            })
                        },
                        success: function (e) {
                            if (e == "OK") {
                                noty({
                                    layout: "topRight",
                                    theme: 'relax',
                                    type: "information",
                                    text: "Seçilen satır başarıla arşive taşındı.",
                                    animation: {
                                        open: 'animated fadeIn'
                                    },
                                    timeout: 5000
                                });
                                $(".maliyet-column-ekle").modal("hide");
                                tadilatlistesiCagir();
                            }
                            else if ("Lütfen giriş yapın.") {
                                alert(e);
                                window.location = "/";
                            }
                        }
                    });
                    swal.close();
                }
                else {
                    swal.close();
                }
            });
            
        }
        else {
           
          
        }
    }

    if (varmi ==0) {
        swal({
            title: "Seçilen satır kaldırılsın mı?",
            text: "Seçilmiş olan satır güncel tadilat listesinden, arşive taşınsın mı?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Taşı",
            cancelButtonText: "İptal et",
            closeOnConfirm: false,
            closeOnCancel: false,
        }, function (isConfirm) {
            if (isConfirm) {
                $.ajax({
                    async: false,
                    url: "../../Data/TadilatKayitKalidr",
                    type: "post",
                    data: {
                        Data: JSON.stringify({
                            Satir_ID: Data.data.id
                        })
                    },
                    success: function (e) {
                        if (e == "OK") {
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: "Seçilen satır başarıla arşive taşındı.",
                                animation: {
                                    open: 'animated fadeIn'
                                },
                                timeout: 5000
                            });
                            $(".maliyet-column-ekle").modal("hide");
                            tadilatlistesiCagir();
                        }
                        else if ("Lütfen giriş yapın.") {
                            alert(e);
                            window.location = "/";
                        }
                    }
                });
                swal.close();
            }
            else {
                swal.close();
            }
        });
    }
}

//#endregion

//#region Modal Shown Events
$(document).on("shown.bs.modal", ".kasa-foyu-ekle", function () {
    $("input").val("");
    $("select > option[value='TR']").attr("selected", true);
});

$(document).on("show.bs.modal", ".arac-maliyet-ekle", function () {
    $("input").val("");
    var modal = $(this),
        arac_list;

    if (modal.data("AracList")) {
        arac_list = modal.data("AracList");
    } else {
        $.ajax({
            url: "../../Data/AracAra",
            type: "post",
            async: false,
            data: {
                Data: JSON.stringify({ Durum: "Eldeki Araç", OrderBy: "Plaka" })
            },
            beforeSend:
                function () { FullPagePreload(); },
            success:
                function (data) {
                    try {
                        arac_list = JSON.parse(data);
                    } catch (e) {
                        console.log(data);
                        if (data == "Lütfen giriş yapın.") {
                            alert(data);
                            window.location = "/";
                        }
                        return;
                    }
                },
            error:
                function (jqxhr) {
                    console.log(jqxhr);
                    noty({
                        layout: "center",
                        theme: 'relax',
                        type: "error",
                        text: "Araç listesi alınamadı! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                        animation: {
                            open: 'animated fadeIn'
                        },
                        timeout: false,
                        killer: true,
                        modal: true,
                        closeWith: ['click', 'backdrop']
                    });
                },
            complete:
                function () { Remove_FullPagePreload(); }
        });
    }

    var aracselect = modal.find("#arac-maliyet-plaka");
    arac_list.forEach(function (val, i, arr) {
        aracselect.append($("<option>").val(val.ID).text(val.Plaka + " - " + val.Marka + " " + val.Seri + " " + val.Model));
    });
});

$(document).on("keyup blur", "input.sayi-gir", function () {
    if ($(this).data("LastValue") == null)
        $(this).data("LastValue", "");

    if (!$(this).val().match(/^[0-9]*$/)) {
        $(this).val($(this).data("LastValue"));
    }
    else {
        $(this).data("LastValue", $(this).val());
    }
});
//#endregion

//#region Context Menus
$(document).ready(function () {

    //#region Kasa Föyü Giriş Tablosu Context menu
    $.contextMenu({
        selector: ".kasa-gelir .kasa-foyu-tablo tr:not(:first):not(:nth-child(2))",
        items: {
            Gonder: {
                name: "Gönder",
                items: {
                    Cek: {
                        name: "Çek",
                        callback:
                            function () { KasaFoyu_Gonder($(this), "Giriş", "Çek", null); }
                    },
                    Senet: {
                        name: "Senet",
                        callback:
                            function () { KasaFoyu_Gonder($(this), "Giriş", "Senet", null); }
                    },
                    FaliyetDisi: {
                        name: "Faliyet Dışı",
                        callback:
                            function () { KasaFoyu_Gonder($(this), "Giriş", "Faliyet Dışı", null); }
                    },
                    DigerGider: {
                        name: "Diğer",
                        callback:
                        function () { KasaFoyu_Gonder($(this), "Diğer Gider", null); }
                    }
                }
            },
            Sil: {
                name: "Sil",
                callback:
                    function () { KasaFoyu_Sil($(this)); }
            }
        }
    });
    //#endregion
   

    //#region Kasa Föyü Çıkış Tablosu Context Menu
    $.contextMenu({
        selector: ".kasa-gider .kasa-foyu-tablo tr:not(:first)",
        items: {
            Gonder: {
                name: "Gönder",
                items: {
                    AracMaliyeti: {
                        name: "Araç Maliyeti",
                        callback: function () { AracSec($(this)); }
                           
                    },
                    DukkanGiderleri: {
                        name: "Dükkan Gideri",
                        callback:
                            function () { KasaFoyu_Gonder($(this), "Dükkan Giderleri", null); }
                    },
                    FaaliyetDisiGider: {
                        name: "Faaliyet Dışı Gider",
                        callback:
                            function () { KasaFoyu_Gonder($(this), "Faaliyet Dışı Gider", null); }
                    },
                    DigerGider: {
                     name: "Diğer",
                     callback:
                     function () { KasaFoyu_Gonder($(this), "Diğer Gider", null); }
                      }
                }
            },
            Sil: {
                name: "Sil",
                callback:
                    function () { KasaFoyu_Sil($(this)); }
            }
        }
    });
    //#endregion

    //#region Maliyetler Context Menu
    $.contextMenu({
        selector: ".maliyet-auto-veri",
        items: {
            Gonder: {
                name: "Gönder/Kaydet",
                callback:
                    function () {
                        if ($("#maliyet-ana-tablo").children(".dx-datagrid.dx-datagrid-borders").children(".dx-datagrid-header-panel").children(".dx-edit-button.dx-datagrid-save-button.dx-widget.dx-button-has-icon.dx-button.dx-button-normal").hasClass("dx-state-disabled")) {
                            Tadilat_KayitKaydet($(this));

                        } else {
                            DevExpress.ui.dialog.alert("Lütfen Yazdığınız Değeri Kaydetiniz");

                        }
                       
                        
                        
                    }
            }
        }
    });

    $.contextMenu({
        selector: ".maliyet-manuel-veri",
        items: {
            FaaliyetDisi: {
                name: "Faaliyet dışı gider",
                callback:
                    function () {
                        if ($("#maliyet-ana-tablo").children(".dx-datagrid.dx-datagrid-borders").children(".dx-datagrid-header-panel").children(".dx-edit-button.dx-datagrid-save-button.dx-widget.dx-button-has-icon.dx-button.dx-button-normal").hasClass("dx-state-disabled")) {
                            Tadilat_KayitKaydet($(this));

                        } else {
                            DevExpress.ui.dialog.alert("Lütfen Yazdığınız Değeri Kaydetiniz");
                        }
                    }
            }
        }
    });
    //#endregion
});
//#endregion