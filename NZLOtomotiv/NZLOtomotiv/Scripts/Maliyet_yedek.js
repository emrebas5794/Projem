
function MaliyetListesiAl() {
    jQuery.ajax({
        url: "../../Data/MaliyetleriGoruntule",
        type: "post",
        success: function (e) {
            var AlinanData = JSON.parse(e);

            jQuery("#maliyet-ana-tablo").attr({
                "Kesim_KaportaBoya": AlinanData.Kesim_KaportaBoya.toString(),
                "Kesim_Yikama": AlinanData.Kesim_Yikama.toString(),
                "Kesim_Mekanik": AlinanData.Kesim_Mekanik.toString()
            });

            console.log(AlinanData);
            var KaportaBos = false;
            var YikamaBos = false;
            var MekanikBos = false;
            jQuery("#maliyet-ana-tablo").dxDataGrid({
                dataSource: AlinanData.Veriler,
                columns: [
                    { dataField: "Plaka", caption: "Plaka" },
                    { dataField: "Arac_TamAd", caption: "Araç" },
                    {
                        dataField: "Maliyet_KaportaBoya", caption: "Kaporta-Boya (" + AlinanData.Kesim_KaportaBoya + ")", dataType: "int", cellTemplate: function (container, options) {
                            container.addClass("column_KaportaBoya");
                            var ManuelClass = options.data.Manuel_Veri == "True" ? "maliyet-manuel-veri" : "maliyet-auto-veri";
                            var KayitliClass = options.data.Hesap_KaportaBoya == "True" ? "maliyet-veri-kayitli" : ManuelClass;
                            jQuery("<label/>").addClass(KayitliClass).data("Veri", options.data).attr("tip", "Kaporta-Boya").data("not", options.data.Not_KaportaBoya).attr("Deger", options.displayValue).css("width", "85%").text(options.displayValue + " ₺").appendTo(container);
                            try {
                                var DurumClass = options.data.Not_KaportaBoya.length > 0 ? "maliyet-not-ok" : "";
                                jQuery("<i/>").addClass("glyphicon glyphicon-align-justify maliyet-tablo-not " + DurumClass).data("rowData", options).appendTo(container);
                            }
                            catch (ex)
                            { }
                        }
                    },
                    {
                        dataField: "Maliyet_Yikama", caption: "Yıkama (" + AlinanData.Kesim_Yikama + ")", dataType: "int", cellTemplate: function (container, options) {
                            container.addClass("column_Yikama");
                            var ManuelClass = options.data.Manuel_Veri == "True" ? "maliyet-manuel-veri" : "maliyet-auto-veri";
                            var KayitliClass = options.data.Hesap_Yikama == "True" ? "maliyet-veri-kayitli" : ManuelClass;
                            jQuery("<label/>").addClass(KayitliClass).data("Veri", options.data).attr("tip", "Yıkama").data("not", options.data.Not_Yikama).attr("Deger", options.displayValue).css("width", "85%").text(options.displayValue + " ₺").appendTo(container);
                            try {
                                var DurumClass = options.data.Not_Yikama.length > 0 ? "maliyet-not-ok" : "";
                                jQuery("<i/>").addClass("glyphicon glyphicon-align-justify maliyet-tablo-not " + DurumClass).data("rowData", options).appendTo(container);
                            }
                            catch (ex)
                            { }
                        }
                    },
                    {
                        dataField: "Maliyet_Mekanik", caption: "Mekanik (" + AlinanData.Kesim_Mekanik + ")", dataType: "int", cellTemplate: function (container, options) {
                            container.addClass("column_Mekanik");
                            var ManuelClass = options.data.Manuel_Veri == "True" ? "maliyet-manuel-veri" : "maliyet-auto-veri";
                            var KayitliClass = options.data.Hesap_Mekanik == "True" ? "maliyet-veri-kayitli" : ManuelClass;
                            jQuery("<label/>").addClass(KayitliClass).data("Veri", options.data).attr("tip", "Mekanik").data("not", options.data.Not_Mekanik).attr("Deger", options.displayValue).css("width", "85%").text(options.displayValue + " ₺").appendTo(container);
                            try {
                                var DurumClass = options.data.Not_Mekanik.length > 0 ? "maliyet-not-ok" : "";
                                jQuery("<i/>").addClass("glyphicon glyphicon-align-justify maliyet-tablo-not " + DurumClass).data("rowData", options).appendTo(container);
                            }
                            catch (ex)
                            { }
                        }
                    },
                    {
                        dataField: "Maliyet_Diger", caption: "Diğer", dataType: "int", cellTemplate: function (container, options) {
                            container.addClass("column_Diger");
                            var ManuelClass = options.data.Manuel_Veri == "True" ? "maliyet-manuel-veri" : "maliyet-auto-veri";
                            var KayitliClass = options.data.Hesap_Diger == "True" ? "maliyet-veri-kayitli" : ManuelClass;
                            jQuery("<label/>").addClass(KayitliClass).data("Veri", options.data).attr("tip", "Diğer").data("not", options.data.Not_Diger).attr("Deger", options.displayValue).css("width", "85%").text(options.displayValue + " ₺").appendTo(container);
                            try {
                                var DurumClass = options.data.Not_Diger.length > 0 ? "maliyet-not-ok" : "";
                                jQuery("<i/>").addClass("glyphicon glyphicon-align-justify maliyet-tablo-not " + DurumClass).data("rowData", options).appendTo(container);
                            }
                            catch (ex)
                            { }
                        }
                    },
                    {
                        caption: "Sil", alignment: "center", cellTemplate: function (container, options) {
                            jQuery('<button/>').addClass('dx-button').addClass("Maliyet_SilButton")
                                .text('Kayıdı Kaldır')
                                .on('dxclick', function () {
                                    //Do something with options.data;
                                })
                                .appendTo(container);
                        }
                    },
                    { dataField: "Kapi", caption: "Kapı", visible: false },
                    { dataField: "Motor_Gucu", caption: "Motor Gücü", visible: false },
                    { dataField: "Motor_Hacmi", caption: "Motor Hacmi", visible: false },

                ],
                noDataText: "Kayıt Bulunamadı",
                hoverStateEnabled: true,
                allowColumnReordering: true,
                columnChooser: {
                    enabled: true,
                    height: 220,
                    width: 450,
                    emptyPanelText: 'Gizlemek istediğiniz alanı buraya sürükleyin.'
                },
                wordWrapEnabled: true,
                showBorders: true,
                onRowUpdating: function (e) {
                    KaportaBos = false;
                    YikamaBos = false;
                    MekanikBos = false;
                    console.log("Güncellendi");
                    console.log(e);
                    Maliyet_Guncelle(e);
                },
                onRowInserting: function (e) {
                    if (e.data.Plaka.length < 3 || e.data.Arac_TamAd.length < 3) {
                        var DataSource = jQuery("#maliyet-ana-tablo").dxDataGrid('instance').option("dataSource");
                        var NewDataSource = [];
                        for (var i = 0; i < DataSource.length; i++) {
                            if (DataSource[i].Plaka.length > 3 && DataSource[i].Arac_TamAd.length > 3)
                                NewDataSource.push(DataSource[i]);
                        }
                        jQuery("#maliyet-ana-tablo").dxDataGrid('instance').option("dataSource", NewDataSource);
                    }
                    else {
                        Maliyet_ManuelAracKayit(e.data);
                    }
                },
                onRowInserted: function (e) {
                    jQuery("#maliyet-ana-tablo").dxDataGrid('instance').repaint();
                },
                onRowPrepared: function (e) {
                    jQuery(e.rowElement).find(".maliyet-veri-kayitli").parent().addClass("maliyet-kayitli");
                    //#region Null değer kontrol
                    if (!e.data.Plaka) {
                        e.data.Plaka = "";
                        e.data.Manuel_Veri = "true";
                    }
                    //#endregion

                    //#region Sil butonu düzenleme
                    if (jQuery.isNumeric(e.data.Maliyet_KaportaBoya) && jQuery.isNumeric(e.data.Maliyet_Mekanik) && jQuery.isNumeric(e.data.Maliyet_Yikama)) {
                        jQuery(e.rowElement[0].children).find(".Maliyet_SilButton").prop("disabled", false);
                    }
                    else {
                        jQuery(e.rowElement[0].children).find(".Maliyet_SilButton").prop("disabled", true);
                    }
                    //#endregion

                    //#region Manuel kayıdın işlemi
                    if (e.data.Manuel_Veri == "true") {
                        jQuery(e.rowElement[0].children).find(".Maliyet_SilButton").prop("disabled", false);

                        if (!e.data.Arac_TamAd)
                            e.data.Arac_TamAd = "";

                        if (!e.data.Maliyet_KaportaBoya) {
                            e.data.Maliyet_KaportaBoya = "";
                            e.data.Not_KaportaBoya = "";
                            e.data.Kesim_KaportaBoya = "";
                            e.data.Hesap_KaportaBoya = "False";
                        }
                        if (!e.data.Maliyet_Mekanik) {
                            e.data.Maliyet_Mekanik = "";
                            e.data.Not_Mekanik = "";
                            e.data.Kesim_Mekanik = "";
                            e.data.Hesap_Mekanik = "False";
                        }
                        if (!e.data.Maliyet_Yikama) {
                            e.data.Maliyet_Yikama = "";
                            e.data.Not_Yikama = "";
                            e.data.Kesim_Yikama = "";
                            e.data.Hesap_Yikama = "False";
                        }
                        if (!e.data.Maliyet_Diger) {
                            e.data.Maliyet_Diger = "";
                            e.data.Not_Diger = "";
                            e.data.Kesim_Diger = "";
                            e.data.Hesap_Diger = "False";
                        }
                    }
                    //#endregion

                    //#region Hesap butonları kontrolleri
                    if (!jQuery.isNumeric(e.data.Maliyet_KaportaBoya) && !KaportaBos)
                        KaportaBos = true;
                    if (!jQuery.isNumeric(e.data.Maliyet_Mekanik) && !MekanikBos)
                        MekanikBos = true;
                    if (!jQuery.isNumeric(e.data.Maliyet_Yikama) && !YikamaBos)
                        YikamaBos = true;

                    HesapKontrol(KaportaBos, MekanikBos, YikamaBos);
                    //#endregion

                },
                editing: {
                    editMode: 'cell',
                    editEnabled: true,
                    insertEnabled: true
                },
                summary: {
                    totalItems: [{
                        column: 'Maliyet_KaportaBoya',
                        summaryType: 'sum',
                        customizeText: function (e) {
                            return "Toplam : " + e.value + " ₺";
                        }
                    },
                    {
                        column: 'Maliyet_Yikama',
                        summaryType: 'sum',
                        customizeText: function (e) {
                            return "Toplam : " + e.value + " ₺";
                        }
                    },
                    {
                        column: 'Maliyet_Mekanik',
                        summaryType: 'sum',
                        customizeText: function (e) {
                            return "Toplam : " + e.value + " ₺";
                        }
                    },
                    {
                        column: 'Maliyet_Diger',
                        summaryType: 'sum',
                        customizeText: function (e) {
                            return "Toplam : " + e.value + " ₺";
                        }
                    }]
                }
            });
        }
    });
}

jQuery(document).on("click", ".maliyet-tablo-not", function (e) {
    e.stopPropagation();
    var RowData = jQuery(this).data("rowData");
    console.log(RowData);
    jQuery(".maliyet-not-goruntule .modal-title").text(RowData.data.Plaka + " - " + RowData.data.Arac_TamAd + " " + RowData.column.caption + " Maliyeti");

    var NotValue = "";
    if (RowData.column.dataField == "Maliyet_KaportaBoya")
        NotValue = RowData.data.Not_KaportaBoya;
    else if (RowData.column.dataField == "Maliyet_Yikama")
        NotValue = RowData.data.Not_Yikama;
    else if (RowData.column.dataField == "Maliyet_Mekanik")
        NotValue = RowData.data.Not_Mekanik;
    else if (RowData.column.dataField == "Maliyet_Diger")
        NotValue = RowData.data.Not_Diger;

    jQuery(".maliyet-not-goruntule #maliyetNot_TextArea").val(NotValue);
    jQuery(".maliyet-not-goruntule").modal("show");

    jQuery("#maliyetNot_Kaydet").unbind("click").bind("click", function () {
        jQuery.ajax({
            url: "../../Data/MaliyetNotKaydet",
            type: "post",
            data: {
                Data: JSON.stringify({
                    ID: RowData.data.id,
                    Column: RowData.column.dataField,
                    NotValue: jQuery(".maliyet-not-goruntule #maliyetNot_TextArea").val()
                })
            },
            success: function (e) {
                console.log(e);
                if (e == "OK") {
                    jQuery(".maliyet-not-goruntule").modal("hide");
                    MaliyetListesiAl();
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

function Maliyet_Guncelle(Data) {
    jQuery.ajax({
        url: "../../Data/MaliyetGuncelle",
        type: "post",
        data: {
            Data: JSON.stringify({
                KeyID: Data.key.id,
                KeyTip: Object.keys(Data.newData).toString(),
                KeyValue: Data.newData[Object.keys(Data.newData).toString()]
            })
        },
        success: function (e) {
            console.log(e);
            if (e == "OK") {
                MaliyetListesiAl();
            }
            else if (data == "Lütfen giriş yapın.") {
                alert(data);
                window.location = "/";
                return;
            }

        }
    });
}

function HesapKontrol(KaportaBos, MekanikBos, YikamaBos) {
    if (KaportaBos)
        jQuery("#maliyetKes_KaportaBoya").prop("disabled", true);
    else
        jQuery("#maliyetKes_KaportaBoya").prop("disabled", false);

    if (MekanikBos)
        jQuery("#maliyetKes_Mekanik").prop("disabled", true);
    else
        jQuery("#maliyetKes_Mekanik").prop("disabled", false);

    if (YikamaBos)
        jQuery("#maliyetKes_Yikama").prop("disabled", true);
    else
        jQuery("#maliyetKes_Yikama").prop("disabled", false);
}

function Maliyet_ManuelAracKayit(Data) {
    jQuery.ajax({
        url: "../../Data/MaliyetManuelAracKayit",
        type: "post",
        data: {
            Data: JSON.stringify({
                Manuel_Veri: Data.Manuel_Veri,
                Manuel_Plaka: Data.Plaka,
                Manuel_Arac: Data.Arac_TamAd,
                Maliyet_KaportaBoya: Data.KaportaBoya,
                Maliyet_Yikama: Data.Maliyet_Yikama,
                Maliyet_Mekanik: Data.Maliyet_Mekanik
            })
        },
        success: function (e) {
            console.log(e);
            if (e == "OK") {
                MaliyetListesiAl();
            }
            else if (data == "Lütfen giriş yapın.") {
                alert(data);
                window.location = "/";
                return;
            }

        }
    });
}

function Maliyet_HesapKes(Tip) {
    if (Tip == 0) {
        // Kaporta-Boya



    }
    else if (Tip == 1)
    { }
    else if (Tip == 2)
    { }
}

jQuery(document).on("click", ".maliyetler-ana-govde .maliyet-govde .maliyet-girdi-ekle", function () {
    jQuery(".arac-maliyet-ekle").modal("show");
    jQuery("#arac-maliyet-tipi").val(jQuery(this).attr("maliyet-tip"));
});

jQuery(document).on("click", ".maliyetler-bottom li", function () {
    switch (parseInt(jQuery(this).children("a").attr("aria-controls"))) {
        case 0: {
            jQuery(".maliyetler-ana-govde .maliyet-baslik-yazi").text("Kaporta-Boya Maliyetleri");
            jQuery(".maliyetler-ana-govde .maliyet-govde .table").attr("tablo-tip", "Kaporta-Boya");
            jQuery(".maliyet-ana-odemeler .table").attr("tablo-tip", "Kaporta-Boya");
            jQuery("#maliyet-sifirla").attr("maliyet-tip", "Kaporta-Boya");
            jQuery(".maliyetler-ana-govde .maliyet-govde .maliyet-girdi-ekle").attr("maliyet-tip", "Kaporta-Boya");
            MaliyetTipiDegisimi("Kaporta-Boya");
            break;
        }
        case 1: {
            jQuery(".maliyetler-ana-govde .maliyet-baslik-yazi").text("Mekanik Maliyetleri");
            jQuery(".maliyetler-ana-govde .maliyet-govde .table").attr("tablo-tip", "Mekanik");
            jQuery(".maliyet-ana-odemeler .table").attr("tablo-tip", "Mekanik");
            jQuery("#maliyet-sifirla").attr("maliyet-tip", "Mekanik");
            jQuery(".maliyetler-ana-govde .maliyet-govde .maliyet-girdi-ekle").attr("maliyet-tip", "Mekanik");
            MaliyetTipiDegisimi("Mekanik");
            break;
        }
        case 2: {
            jQuery(".maliyetler-ana-govde .maliyet-baslik-yazi").text("Yıkama Maliyetleri");
            jQuery(".maliyetler-ana-govde .maliyet-govde .table").attr("tablo-tip", "Yikama");
            jQuery(".maliyet-ana-odemeler .table").attr("tablo-tip", "Yikama");
            jQuery("#maliyet-sifirla").attr("maliyet-tip", "Yikama");
            jQuery(".maliyetler-ana-govde .maliyet-govde .maliyet-girdi-ekle").attr("maliyet-tip", "Yikama");
            MaliyetTipiDegisimi("Yikama");
            break;
        }
    }
});

jQuery(document).on("click", "#maliyet-sifirla", function () {
    var Tip = jQuery(this).attr("maliyet-tip");
    swal({
        title: "Emin misiniz?",
        text: Tip + " maliyetini sıfırlamak istediğinize emin misiniz?",
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
                url: "../../Data/MaliyetSifirla",
                type: "post",
                data: {
                    Tip: Tip
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
                                text: Tip + " maliyeti başarıyla sıfırlandı.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });
                            MaliyetTipiDegisimi(Tip);
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
});

function MaliyetTipiDegisimi(ElementIndex) {

    jQuery.ajax({
        url: "../../Data/MaliyetleriGoruntule",
        type: "post",
        data: { MaliyetTipi: ElementIndex },
        success: function (e) {
            try {
                var AlinanData = JSON.parse(e);
                console.log(AlinanData);

                // Tabloyu temizle.
                jQuery(".maliyetler-ana-govde .maliyet-govde .table").empty();
                jQuery(".maliyet-ana-odemeler .table").empty();

                // Table header ekle.
                jQuery(".maliyetler-ana-govde .maliyet-govde .maliyet-ana-tablo").append('<tr>' +
                                                                                '<th style="width:100px;">Plaka</th>' +
                                                                                '<th>Araç</th>' +
                                                                                '<th>Miktar</th>' +
                                                                             '</tr>');
                jQuery(".maliyet-ana-odemeler .table").append('<tr>' +
                                                                '<th style="width:100px;">Fiyat</th>' +
                                                                '<th>Açıklama</th>' +
                                                              '</tr>');

                var ToplamTutar = 0;
                // Tabloya alınan datayı yaz.
                for (var i = 0; i < AlinanData.length; i++) {
                    if (AlinanData[i].Maliyet_Odeme == "False") {
                        jQuery(".maliyetler-ana-govde .maliyet-govde .maliyet-ana-tablo").append('<tr maliyet-tipi="' + ElementIndex + '" maliyet-table-index="' + i + '" maliyet-data-id="' + AlinanData[i].id + '">' +
                                                                                        '<td>' + AlinanData[i].Plaka + '</td>' +
                                                                                        '<td>' + AlinanData[i].Marka + ' ' + AlinanData[i].Seri + ' ' + AlinanData[i].Model + '</td>' +
                                                                                        '<td>' + AlinanData[i].Miktar + ' ₺' + '</td>' +
                                                                                    '</tr>');
                        ToplamTutar += parseInt(AlinanData[i].Miktar);
                    }
                    else {
                        jQuery(".maliyet-ana-odemeler .table").append('<tr>' +
                                                                        '<td>' + AlinanData[i].Miktar + ' ₺' + '</td>' +
                                                                        '<td>' + AlinanData[i].Maliyet_Value + '</td>' +
                                                                      '</tr>');
                        ToplamTutar -= parseInt(AlinanData[i].Miktar);
                    }
                }

                // Toplam tutarı güncelle.
                jQuery(".maliyetler-ana-govde .maliyet-baslik-toplam span").text(ToplamTutar.toString() + " ₺");
            } catch (er) {
                console.log(er);
                if (e == "Lütfen giriş yapın.") {
                    alert(e);
                    window.location = "/";
                }
                return;
            }
        }
    });
}

jQuery(document).on("click", "#arac-maliyet-kaydet", function () {
    var modal = jQuery(this).closest(".modal");

    var emptyreq = modal.find(".required").filter(function (i, el) { return jQuery(this).val().length < 1 });
    if (emptyreq.length) {
        emptyreq.eq(0).focus();
        var warn = jQuery("<div>").text("Bu alanın doldurulması zorunludur.").css({ "display": "none", "color": "red" }).insertAfter(emptyreq.eq(0)).show(200);
        setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
        return;
    }

    jQuery.ajax({
        url: "../../Data/MaliyetEkle",
        type: "post",
        data: {
            Data: JSON.stringify({
                Tip: modal.find("#arac-maliyet-tipi").val(),
                Arac: modal.find("#arac-maliyet-plaka").val(),
                Miktar: modal.find("#arac-maliyet-Miktar").val()
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
                        text: "Araç maliyeti başarıyla kaydedildi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    modal.modal("hide");
                    MaliyetTipiDegisimi(modal.find("#arac-maliyet-tipi").val());
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

function Maliyet_Sil(Element) {

    jQuery.ajax({
        url: "../../Data/MaliyetSil",
        type: "post",
        data: { MaliyetID: Element.attr("maliyet-data-id") },
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {
                if (data == "OK") {
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
                    MaliyetTipiDegisimi(Element.attr("maliyet-tipi"));
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

function Maliyet_Kaydet(Element) {
    console.log(Element.data("Veri"));

    jQuery.ajax({
        url: "../../Data/MaliyetKaydet",
        type: "post",
        data: {
            Data: JSON.stringify({
                VeriID: Element.data("Veri").id,
                AracID: Element.data("Veri").Arac_ID,
                KayitTipi: Element.attr("tip"),
                VeriMiktar: Element.attr("deger"),
                VeriNot: Element.data("not")
            })
        },
        success: function (e) {
            console.log(e);
            if (e == "OK") {
                MaliyetListesiAl();
            }
            else if (data == "Lütfen giriş yapın.") {
                alert(data);
                window.location = "/";
                return;
            }

        }
    });

}