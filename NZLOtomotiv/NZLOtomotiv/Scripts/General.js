/// <reference path="..\Components/bootstrap.js" />
/// <reference path="..\Components/jquery-2.1.3.js" />
/// <reference path="..\Components/jquery-ui.js" />
/// <reference path="..\Components/jquery.noty.packaged.js" />
/// <reference path="..\Components/jquery.maskedinput.js" />
/// <reference path="..\Components/moment.js" />
/// <reference path="..\Components/dx.all.js" />
/// <reference path="..\Components/globalize.min.js" />
/// <reference path="..\Components/oUploader.js" />

//TODO : Templateleri partial viewlere böl
//$(".content-container").load("../../NzlOto/Templates", { id: "borclu-filtre" }, function (data) { console.log(arguments); console.log(arguments.length); console.log(data); });

Globalize.culture("tr-TR");
var kasa_data;
function kasafoyugetir() {
    var def = $.Deferred();

    $.ajax({
        url: "../../Data/KasaFoyuAl",
        type: "get",
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {

                if (data == "Lütfen giriş yapın.") {
                    window.location = "/";
                }
                else {
                    kasa_data = JSON.parse(data);
                    def.resolve(JSON.parse(data));

                }

            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
                noty({
                    layout: "center",
                    theme: 'relax',
                    type: "error",
                    text: "Kasa Föyü Alınamadı! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "" : jqxhr.responseText),
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

    return def.done();
}
//#region General
(function ($) {
    $.fn.CursorPosition = function () {
        var input = this.get(0);
        if (!input) return; // No (input) element found

        if (arguments[0] == "get") {
            if ('selectionStart' in input) {
                // Standard-compliant browsers
                return input.selectionStart;
            } else if (document.selection) {
                // IE
                input.focus();
                var sel = document.selection.createRange();
                var selLen = document.selection.createRange().text.length;
                sel.moveStart('character', -input.value.length);
                return sel.text.length - selLen;
            }
        }
        else if (arguments[0] == "set" && typeof arguments[1] == "number") {
            var pos = arguments[1];
            if ('selectionStart' in input) {
                input.focus();
                input.setSelectionRange(pos, pos);
            }
            else if ('createTextRange' in input) {
                input.createTextRange().move('character', pos).select();
            }
            else {
                input.focus();
            }
        }
        return this;
    }
})(jQuery);

function Alert(type, message, classes) {
    /// <summary>Returns a bootstrap alert object</summary>
    /// <param name="type" type="String">Type of alert. Could be : success, info, danger, warning</param>
    /// <param name="message" type="String">A string message that will be placed into the body of the alert.</param>
    /// <param name="classes" type="String">Space seperated classes to add into the alert object.</param>
    /// <returns type="jQueryObject" />
    return $("<div>").addClass("alert alert-" + type + (classes ? " " + classes : "")).append('<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>').append(message);
}

var tableToExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,',
        template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>',
        base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) },
        format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
    return function (table, name) {
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
        window.location.href = uri + base64(format(template, ctx))
    }
})();

var POPtimeouts = new Array();
function InfoPop(options) {
    /*OPTIONS
    * message <string>
    * (Optional) referrer <jQuery element>
    * (Optional) position <javasript object> 
        * position.top <string>
        * position.left <string>
        * position.right <string>
        * position.bottom <string>
    * (Optional) size <js object>
        * width <string>
        * height <string>
    * (Optional) padding <string>
    * (Optional) foregroundColor <string>
    * (Optional) backgroundColor <string>
    * (Optional) boxShadow <string>
    * (Optional) maxWidth <string>
    * (Optional) timeout <int>
    */
    if (!options.message) //Return if a message for the POP was not provided
        return false;
    var pop = jQuery('<div>').addClass('sdc_infoPop');

    //Options
    var referrer = options.referrer || null,
        foregroundColor = options.foregroundColor || '#fff',
        backgroundColor = options.backgroundColor || 'rgba(30,30,70,.9)',
        boxShadow = options.boxShadow || '2px 2px 5px 1px #000',
        timeout = options.timeout || 2000,
        maxWidth = options.maxWidth || '',
        padding = options.padding || '';
    if (!!options.position) {
        var positionTop = options.position.top || '',
            positionLeft = options.position.left || '',
            positionBottom = options.position.bottom || '',
            positionRight = options.position.right || '';
    } else { var positionTop = positionLeft = positionBottom = positionRight = '' }
    if (!!options.size) {
        var width = options.size.width || '',
            height = options.size.height || '';
    } else { var width = height = '' }

    pop.css({
        color: foregroundColor,
        backgroundColor: backgroundColor,
        boxShadow: boxShadow,
        maxWidth: maxWidth,
        padding: padding,
        width: width,
        height: height,
        top: positionTop,
        left: positionLeft,
        bottom: positionBottom,
        right: positionRight
    });
    pop.append(jQuery('<span>').html(options.message));

    if (!!referrer) {
        //If there is a referrer for the POP
        if (referrer.attr('sdc-infopop-referrer')) {
            //If there is already a POP belonging to this referrer
            var ref_id = referrer.attr('sdc-infopop-referrer');
            jQuery('#' + ref_id).remove();

            clearTimeout(POPtimeouts[ref_id]);
            POPtimeouts[ref_id] = setTimeout(function () {
                referrer.removeAttr('sdc-infopop-referrer');
                pop.remove();
            }, timeout);
        }
        else {
            //If there is no POP belonging to this referrer
            var ref_id = randomString(8);
            referrer.attr('sdc-infopop-referrer', ref_id);

            POPtimeouts[ref_id] = setTimeout(function () {
                referrer.removeAttr('sdc-infopop-referrer');
                pop.remove();
            }, timeout);
        }
        pop.attr('id', ref_id);
    } else {
        //If there is no referrer for the POP
        setTimeout(function () { pop.remove() }, timeout);
    }
    console.log(pop);
    pop.appendTo('body'); // Append the POP now that its all set up
}

function randomString(Length) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
    var result = "";
    for (var i = 0; i < Length; i++)
        result += chars.charAt(Math.floor(Math.random() * chars.length));
    return result;
}

function FullPagePreload() {
    if ($("#full-page-preload").length)
        return;
    var loader = $("<div>").attr("id", "full-page-preload");
    loader.append($("<div>").addClass("loader-inner"));
    loader.append($("<div>").addClass("text").text("Yükleniyor..."));
    $("body").prepend(loader);
}
function Remove_FullPagePreload() {
    $("#full-page-preload").remove();
}

//#region General Masks
$(document).on("focus", "input.telefon:not(.manuel)", function () {
    $(this).mask("(999) 999 99 99");
});
$(document).ready(function () {
    $.contextMenu({
        selector: "input.telefon",
        items: {
            manuel: {
                name: "Manuel Gir",
                callback:
                    function () {
                        $(this).unmask().addClass("manuel");
                        $(this).focus();
                    },
                disabled:
                    function () {
                        return $(this).hasClass("manuel");
                    }
            },
            masked: {
                name: "Formatlanmış Olarak Gir",
                callback:
                    function () {
                        $(this).removeClass("manuel");
                        $(this).focus();
                    },
                disabled:
                    function () {
                        return !$(this).hasClass("manuel");
                    }
            }
        }
    });
});

$(document).on("focus", "input.tarih", function () {
    $(this).mask("99.99.9999");
});
$(document).on("focus", "input.yil", function () {
    $(this).mask("9999");
});
$(document).on("focus keyup blur", "input.sayi", function (e) {
    if (e.which == 16 || e.which == 17 || (e.which >= 37 && e.which <= 40)) { // Ctrl || Shift  || Ok tuşları
        return;
    }
    var _this = $(this),
        _val = _this.val();

    if (_this.data("LastValid") == null)
        _this.data("LastValid", "");

    if (!_val.match(/^[0-9]*$/)) {
        _this.val(_this.data("LastValid"));
    } else {
        _this.data("LastValid", _val);
    }

    _this.trigger("change");
});
$(document).on("focus keyup blur", "input.float-sayi", function (e) {
    if (e.which == 16 || e.which == 17 || (e.which >= 37 && e.which <= 40)) { // Ctrl || Shift  || Ok tuşları
        return;
    }

    if ($(this).data("LastValid") == null)
        $(this).data("LastValid", "");
    $(this).val($(this).val().replace(/,/g, "."));
    if ($(this).val().match(/^[0-9.]*$/) && !$(this).val().match(/\.{2,}/) && ($(this).val().match(/^[^\.]*$/) || $(this).val().match(/^[^.]+\.\d*$/))) {
        $(this).data("LastValid", $(this).val());
    } else {
        $(this).val($(this).data("LastValid"));
    }

    $(this).trigger("change");
});
$(document).on("keyup", "input.uppercase", function (e) {
    if (e.which == 16 || e.which == 17 || (e.which >= 37 && e.which <= 40)) { // Ctrl || Shift  || Ok tuşları
        return;
    }
    var _this = $(this),
        pos = _this.CursorPosition("get");
    _this.val(_this.val().toTRUpperCase());
    _this.CursorPosition("set", pos);
    _this.trigger("change");
});
//#endregion

Number.prototype.getDate = function () {
    var d = new Date(this),
        DD = (d.getDate() < 10) ? "0" + d.getDate() : d.getDate(),
        MM = (d.getMonth() + 1 < 10) ? "0" + (d.getMonth() + 1) : (d.getMonth() + 1),
        YYYY = d.getFullYear(),
        hh = d.getHours() < 10 ? "0" + d.getHours() : d.getHours(),
        mm = d.getMinutes() < 10 ? "0" + d.getMinutes() : d.getMinutes(),
        ss = d.getSeconds() < 10 ? "0" + d.getSeconds() : d.getSeconds();
    return DD + "." + MM + "." + YYYY + " " + hh + ":" + mm + ":" + ss;
}
Number.prototype.getShortDate = function () {
    var d = new Date(this),
        DD = (d.getDate() < 10) ? "0" + d.getDate() : d.getDate(),
        MM = (d.getMonth() + 1 < 10) ? "0" + (d.getMonth() + 1) : (d.getMonth() + 1),
        YYYY = d.getFullYear();
    return DD + "." + MM + "." + YYYY;
}
Number.prototype.getMonth = function () {
    var d = new Date(this);
    return (d.getMonth() + 1 < 10) ? "0" + (d.getMonth() + 1) : (d.getMonth() + 1)
}

Number.prototype.BasamakGrupla = function () {
    return this.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");
}
String.prototype.BasamakGrupla = function () {
    return this.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");
}

String.prototype.ReplaceNewlineTobr = function () {
    return this.replace(/\r\n|\r|\n/g, "<br/>");
}

String.prototype.toTRUpperCase = function () {
    function getTRUpperCase(char) {
        switch (char) {
            case "ç":
                return "Ç";
            case "ğ":
                return "Ğ";
            case "ı":
                return "I";
            case "i":
                return "İ";
            case "ö":
                return "Ö";
            case "ş":
                return "Ş";
            case "ü":
                return "Ü";
            default:
                return char.toUpperCase();
        }
    }
    return this.replace(/[çğıiöşü]/g, function (char) { return getTRUpperCase(char); }).toUpperCase();
}

String.prototype.format = function () {
    var str = this;
    for (var i = 0; i < arguments.length; i++) {
        str = str.replace("{" + i + "}", arguments[i]);
    }
    return str;
}
//Sayfayı terketmeden önce sor
$(window).on("beforeunload", function () { return "Şu anda görüntüledğiniz sayfayı kapatmak istediğinize emin misiniz?"; });

//#region General ajax Handler
var promptingForPass = false,
    ajaxToResend = [],
    promptPopup = {};
$(document).ajaxSuccess(function (ev, jqxhr, options, data) {
    if (data == "Lütfen giriş yapın.") {
        if (!promptingForPass) {
            PromptPasswordRelogin();
        }
        ajaxToResend.push(options);
    }
});
function PromptPasswordRelogin(text, type) {
    promptingForPass = true;

    var sendAuth = function (username, password) {
        if (!promptPopup.usernameTextbox.dxValidator("instance").validate().isValid)
            return promptPopup.usernameTextbox.dxTextBox("instance").focus();
        if (!promptPopup.passwordTextbox.dxValidator("instance").validate().isValid)
            return promptPopup.passwordTextbox.dxTextBox("instance").focus();

        $.ajax({
            url: "../../NZLOto/Login",
            type: "post",
            data: {
                username: promptPopup.usernameTextbox.dxTextBox("instance").option("value"),
                password: promptPopup.passwordTextbox.dxTextBox("instance").option("value")
            },
            beforeSend: FullPagePreload,
            success:
                function (data) {
                    if (data == "OK") {
                        //Giriş başarılı
                        promptingForPass = false;

                        //Başarısız olmuş ajaxları tekrar gönder
                        $.each(ajaxToResend, function (i, oldAjaxOptions) {
                            $.ajax(oldAjaxOptions).done(function () { var ind = ajaxToResend.lastIndexOf(oldAjaxOptions); ajaxToResend.splice(ind, 1); });
                        });

                        promptPopup.popup.dxPopup("instance").hide();
                        promptPopup = {};
                    }
                    else if (data == "Şifre Hatalı")
                        PromptPasswordRelogin("Şifre Hatalı! Lütfen bilgilerinizi doğru girdiğinizden emin olunuz.");
                    else
                        PromptPasswordRelogin("Giriş Başarısız oldu!Lütfen bilgilerinizi doğru girdiğinizden emin olunuz.");
                },
            error:
                function (jqxhr) {
                    console.log(jqxhr);
                    PromptPasswordRelogin("Server Error! Bir hata ile kaşılaşıldı. <br/>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText));
                },
            complete: function () {
                Remove_FullPagePreload();
            }
        });
    };

    if (!promptPopup.popup)
        promptPopup.popup = $("<div>").appendTo("body");
    promptPopup.popup.dxPopup({
        buttons: [
            {
                toolbar: "top", location: "center", text: "Kullanıcı Bilgilerinizi Doğrulayınız!"
            },
            {
                toolbar: "bottom",
                location: "after",
                widget: "button",
                options: {
                    onClick: function (e) {
                        sendAuth();
                    },
                    text: "Tamam",
                    type: "success"
                }
            },
        ],
        closeOnOutsideClick: true,
        contentTemplate: function (content) {
            promptPopup.popupContent = content;
            promptPopup.usernameTextbox = $("<div>").dxTextBox({
                placeholder: "Kullanıcı Adı",
                valueChangeEvent: "change keyup",
                onEnterKey: sendAuth
            }).dxValidator({
                validationRules: [{ type: "required" }]
            }).appendTo(content).css("margin-bottom", "10px");
            promptPopup.passwordTextbox = $("<div>").dxTextBox({
                mode: "password",
                placeholder: "Şifre",
                valueChangeEvent: "change keyup",
                onEnterKey: sendAuth
            }).dxValidator({
                validationRules: [{ type: "required" }]
            }).appendTo(content);
        },
        height: 300,
        visible: true,
        onHidden: function () {
            if (!!promptPopup.popup) {
                promptPopup.popup.remove();
                promptPopup = {};
            }
        }
    });


    if (!!text) {
        //$("<div>").appendTo("body").dxToast({
        //    contentTemplate: function (el) {
        //        el.append(text);
        //    },
        //    type: type,
        //    visible: true
        //});
    }
}
//#endregion

//#region Text Görüntüleme Modal
$(document).on("hidden.bs.modal", ".modal.text-goruntule", function () {
    $(this).find(".modal-body, .modal-title").text("");
});
function Modal_TextGoruntule(Text, HeaderText) {
    var modal = $(".modal.text-goruntule").modal("show");
    modal.find(".modal-body").text(Text);
    modal.find(".modal-title").text(HeaderText || "");
}
//#endregion

//General modal handlers
$(document).on("hidden.bs.modal", function () {
    $(this).find(".modal-feedback").empty();
});

//Datagrid Context Menu
function DataGridContextMenu(dgContainer, cmItems, cmItemClick, additionalCMOptions) {
    /// <param name="dgContainer">dxDataGrid Container. jQuery Object, DOM Element veya CSS Selector olabilir</param>
    /// <param name="cmItems" type="Array">Context Menu items Array.</param>
    /// <param name="cmItemClick" type="Function">1.Parameter : Context Menu Options || 2.Parameter : Data Grid Row Options</param>
    /// <param name="additionalCMOptions" type="Object">dxContextMenu'ye eklenmesini istediğiniz herhangi seçenekler</param>
    cmoptions = {
        onPositioning: function (args) { args.component.option('items', cmItems); },
        width: 200
    }
    additionalCMOptions = additionalCMOptions || {};
    $.extend(cmoptions, additionalCMOptions);
    $(dgContainer).dxDataGrid("instance").option({
        rowPrepared:
            function ($r, rowOptions) {
                var rcmopt = $.extend({}, cmoptions, { itemClickAction: function (options) { cmItemClick(options, rowOptions); } });
                $r.on("dxcontextmenu", function (e) {
                    if (e.ctrlKey) return;
                    cm.option(rcmopt);
                    e.preventDefault();
                });
            }
    });
    var cm = $("<div>").dxContextMenu({
        target: $(dgContainer).dxDataGrid("instance").element().find(".dx-datagrid-rowsview")
    }).appendTo("body").dxContextMenu("instance");
}

//Datagrid Column customizeText function
var customizeText_Number = function (cellData) {
    return cellData.value.BasamakGrupla();
};
var customizeText_TL = function (cellData) {
    return (cellData.value === "" || isNaN(cellData.value)) ? "" : cellData.value.BasamakGrupla() + " ₺";
}

//Error alert kapandığında modal'ı yeniden çiz
$(document).on("close.bs.alert", ".modal", function (e) {
    var modal = $(this);
    setTimeout(function () { modal.modal("handleUpdate") }, 100);
});
//#endregion
var SenetProfiller;
//#region Sol Menü / Footbar
var LM = {
    "ana-sayfa": {
        func: function () {
            var anaekran = $(".templates .ana-giris-template").clone().removeClass("ana-giris-template").addClass("ana-giris");
            $(".content-container").empty();
            anaekran.appendTo(".content-container");
        },
        footbarItems: []
    },
    "yeni-arac": {
        func: function () {
            var yeniarac = $(".templates .yeni-arac-template").clone().removeClass("yeni-arac-template").addClass("yeni-arac");
            $(".content-container").empty();
            yeniarac.appendTo(".content-container");
        },
        footbarItems: []
    },
    "arac-ara": {
        func: function () {
            var aracara = $(".templates .arac-arama-template").clone().removeClass("arac-arama-template").addClass("arac-arama");
            $(".content-container").empty();
            aracara.appendTo(".content-container");

            aracara.find("[nzl-field-type=date]").dxDateBox({
                value: "",
                width: "100%"
            });
        },
        footbarItems: []
    },
    "nzl-oto-liste": {
        func: function () {
            AracAra2([{ field: "Liste", operator: "=", value: "NZL Oto Listesi" }]);
        },
        footbarItems: []
    },
    "misafir-arac-liste": {
        func: function () {
            AracAra2([{ field: "Liste", operator: "=", value: "Misafir Araç Listesi" }]);
        },
        footbarItems: []
    },
    "tadilat-liste": {
        func: function () {
            var tadilat = jQuery(".templates .maliyetler-template").clone().removeClass("maliyetler-template").addClass("maliyetler-ana-govde");
            jQuery(".content-container").empty();
            tadilat.appendTo(".content-container");
            TadilatListesiAl();
        },
        footbarItems: []
    },
    "senet-defteri": {
        func: function () {

            //#region senet Profilleri
            $.ajax({
                url: "../../Data/SenetProfilAl",
                type: "get",
                async: false,

                success: function (data) {
                    SenetProfiller = data;

                    var data = JSON.parse(data);

                    var senetdefteri = $(".templates .senet-defteri-template").clone().removeClass("senet-defteri-template").addClass("senet-defteri");
                    $(".content-container").empty();
                    senetdefteri.appendTo(".content-container");


                    var i = 0;
                    $.each(data, function (i, v) {

                        v.SenetRiski = parseInt(v.SenetRiski);
                        v.CekRiski = parseInt(v.CekRiski);
                        v.ToplamRisk = parseInt(v.ToplamRisk);
                    });

                    SenetProfil_DS = new DevExpress.data.DataSource({
                        store: data,
                        searchOperation: "contains",
                        searchExpr: ["Ad", "KimlikNo", "VergiNo"],
                        paginate: true,
                        pageSize: 20

                    });

                    senetdefteri.find(".senet-profil-list").removeClass("risk-shown").dxList({
                        dataSource: SenetProfil_DS,
                        hoverStateEnabled: true,
                        itemTemplate: function (itemData) {
                            var limit = parseInt(itemData["RiskLimit"]) | 0,
                                item = $("<div>").data("profilData", itemData).addClass("profil-item " + ((limit > 0 && limit < parseInt(itemData["ToplamRisk"])) ? "limiti-asmis" : ""))
                                            .append("<span class='isim'>" + itemData["Ad"] + "</span>")
                                            .append("<span class='no'>" + (itemData["KimlikNo"] || itemData["VergiNo"]) + "</span>"),
                                riskdiv = $("<div>").appendTo(item);
                            riskdiv.css("float", "right").addClass("riskler");
                            riskdiv.append($("<span>").text("Senet Riski").addClass("senet")).append($("<span>").text(itemData["SenetRiski"].BasamakGrupla()));
                            riskdiv.append($("<br/>"));
                            riskdiv.append($("<span>").text("Çek Riski").addClass("cek")).append($("<span>").text(itemData["CekRiski"].BasamakGrupla()));
                            riskdiv.append($("<br/>"));
                            riskdiv.append($("<span>").text("Toplam Risk").addClass("toplam")).append($("<span>").text(itemData["ToplamRisk"].BasamakGrupla()));
                            riskdiv.append($("<br/>"));
                            riskdiv.append($("<span>").text("Risk Limiti").addClass("limit")).append($("<span>").text(!itemData["RiskLimit"] ? "Tanımsız" : itemData["RiskLimit"].BasamakGrupla()));
                            return item;
                        },
                        onContentReady: function () {

                            var maxw = 0;
                            $(".senet-profil .senet-profil-list .profil-item .isim").each(function (i, el) {
                                var w = parseInt($(el).css("width"));
                                maxw = w > maxw ? w : maxw;
                            });
                            $(".senet-profil .senet-profil-list .profil-item .isim").css("width", maxw + "px");
                            if ($(".senet-profil .senet-profil-list").hasClass("risk-shown")) {
                                var maxw = 0;
                                $(".senet-profil .senet-profil-list .riskler").each(function (i, el) {
                                    var w = parseInt($(el).css("width"));
                                    maxw = w > maxw ? w : maxw;
                                });
                                $(".riskler").css("width", maxw + "px");
                            }
                        },
                        selectionMode: "single",
                        noDataText: "Senet Profili bulunamadı.",
                        pageLoadingText: "Yükleniyor...",
                        refreshingText: "Yenileniyor...",
                        pageLoadMode: "scrollBottom",

                        //autoPagingEnabled: true,
                        height: 800,
                        onItemClick:
                            function (args) {
                                $(".senet-defteri .senet-profil").hide();


                                Senet_ProfilDetaylariGoruntule(args.itemIndex);
                            },
                        allowItemDeleting: true,
                        itemDeleteMode: "context",
                        onItemDeleting: function (e) {
                            var def = $.Deferred();
                            DevExpress.ui.dialog.confirm("Borçluyu listeden kaldırmak istediğinize emin misiniz?", "Borçlu Kaldır").done(function (sil) {
                                if (sil) {
                                    $.ajax({
                                        url: "../../Data/SenetProfilKaldir",
                                        type: "post",
                                        data: {
                                            ContactUID: e.itemData.ContactUID
                                        },
                                        beforeSend: FullPagePreload,
                                        success: function () {
                                            def.resolve(true);

                                            noty({
                                                layout: "topRight",
                                                theme: 'relax',
                                                type: "information",
                                                text: e.itemData.Ad + " senet borçluları listesinden kaldırıldı.",
                                                dismissQueue: true,
                                                animation: {
                                                    open: 'animated bounceInRight',
                                                    close: 'animated bounceOutRight'
                                                },
                                                maxVisible: 10,
                                                timeout: 5000
                                            });
                                        },
                                        error: function (jqxhr) {
                                            console.log(jqxhr);
                                            def.resolve(false);
                                            noty({
                                                layout: "center",
                                                theme: 'relax',
                                                type: "error",
                                                text: "Borçlu Silinemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
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
                                        complete: Remove_FullPagePreload
                                    });
                                }
                                else
                                    def.resolve(false);
                            });
                            return def;
                        }
                    });


                    $(".senet-defteri .senet-profil-ara").dxTextBox({
                        valueChangeEvent: "keyup",
                        placeholder: "Ara... (Ad, TC Kimlik No, Vergi No)",
                        mode: "search",
                        onValueChanged: function (e) {
                            SenetProfil_DS.searchValue(e.value);
                            SenetProfil_DS.load();
                        }
                    });

                },
                error: function (jqxhr) {
                    console.log(jqxhr);
                    noty({
                        layout: "center",
                        theme: 'relax',
                        type: "error",
                        text: "Profil  Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                        animation: {
                            open: 'animated fadeIn'
                        },
                        timeout: false,
                        killer: true,
                        modal: true,
                        closeWith: ['click', 'backdrop']
                    });
                },
                complete: function () { Remove_FullPagePreload(); }
            });
            //#endregion

        
        },
        footbarItems: []
    },
    "cek-defteri": {
        func: function () {
            var cekdefteri = $(".templates .cek-defteri-template").clone().removeClass("cek-defteri-template").addClass("cek-defteri");
            $(".content-container").empty();
            cekdefteri.appendTo(".content-container");

            CekListesiAlDoldur();
            OdenmisCekleriAlDoldur();
        },
        footbarItems: [
                {
                    text: "Çek Listesi",
                    onClick: function () {
                        if ($("#s-cek-listesi").is(":visible")) return;
                        $("#s-cek-odenmis").addClass('animated zoomOut').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                            $("#s-cek-odenmis").hide().removeClass('animated zoomOut');
                            $("#s-cek-listesi").show().addClass('animated zoomIn').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                                $("#s-cek-listesi").removeClass('animated zoomIn');
                            });
                        });
                    }
                },
                {
                    text: "Ödenmiş Çekler",
                    onClick: function () {
                        if ($("#s-cek-odenmis").is(":visible")) return;
                        $("#s-cek-listesi").addClass('animated zoomOut').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                            $("#s-cek-listesi").hide().removeClass('animated zoomOut');
                            $("#s-cek-odenmis").show().addClass('animated zoomIn').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                                $("#s-cek-listesi").removeClass('animated zoomIn');
                            });
                        });
                    }
                }
        ]
    },
    "risk-limit": {
        func: function () {
            FullPagePreload();

            var riskl = $(".templates .risk-limitleri-template").clone().removeClass("risk-limitleri-template").addClass("risk-limitleri");
            $(".content-container").empty();
            riskl.appendTo(".content-container");
            var content = $(".risk-tanimla", riskl);

            //genel Risk Al
            $.ajax({
                url: "../../Data/GenelRisk",
                type: "post",
                success: function (data) {

                    var risk2 = $(".templates .genelrisk-limitleri-template").clone().removeClass("genelrisk-limitleri-template").addClass("genelrisk-limitleri");
                    risk2.appendTo(".content-container");
                    var content2 = $(".genelrisk-tanimla", risk2);



                    riskbilg2 = content2.find(".genelrisk-bilgileri");
                    content2.find(".genelrisk-bilgileri .guncelle").prop("disabled", true);
                    var limitinp2 = $("<input>").addClass("form-control genelsayi"),
                                                    limit2 = data;
                    riskbilg2.find(".genellimit td:last-child").empty().append(limitinp2);
                    limitinp2.val(limit2);

                    //Güncelle butonu active/deactive et
                    limitinp2.on("focus keyup blur change", function (e) {
                        if (e.target.value == data)
                            content2.find(".genelrisk-bilgileri .guncelle").prop("disabled", true);
                        else
                            content2.find(".genelrisk-bilgileri .guncelle").prop("disabled", false);
                    });


                },
                error: function (jqxhr) { console.log(jqxhr); },

            });
            //end




            //Değerleri temizle ve TL sembollerini kaldır
            content.find(".risk-bilgileri tbody td:last-child").empty();
            content.find(".symbol-TL").addClass("symbol-removed");
            content.find(".risk-bilgileri .kaydet").prop("disabled", true);

            $.ajax({
                url: "../../Data/RisklerVeLimitAl",
                type: "post",
                success: function (data) {
                    try {
                        var response = JSON.parse(data);
                    } catch (e) {
                        console.log(e);
                        console.log(data);
                        return;
                    }

                    $.each(response, function (i, v) { v.RiskLimit = parseInt(v.RiskLimit); });
                    content.find("#risk-lookup").dxLookup({
                        dataSource: new DevExpress.data.DataSource({
                            store: response,
                            key: "ContactUID",
                           
                            paginate: true,
                            pageSize: 25,
                            sort: [{ getter: "RiskLimit", desc: true }, "Ad"]
                        }),
                        displayExpr: function (itemData) { return !!itemData ? itemData.Ad + " - " + (itemData["KimlikNo"] || itemData["VergiNo"]) : ""; },
                        itemTemplate: function (itemData) {
                            var t = $("<div>");
                            if (!!itemData["RiskLimit"] && (parseInt(itemData["ToplamRisk"]) > parseInt(itemData["RiskLimit"])))
                                t.addClass("limiti-asmis");
                            t.append($("<div>").text(!!itemData ? itemData.Ad + " - " + (itemData["KimlikNo"] || itemData["VergiNo"]) : ""));
                            t.append($("<div>").text("( Toplam Risk : {0} ₺ ) ( Risk Limiti : {1} )".format(itemData["ToplamRisk"].BasamakGrupla(), !!itemData["BireyselRiskLimit"] ? itemData["RiskLimit"].BasamakGrupla() + " ₺" : itemData["GenelRiskLimit"].BasamakGrupla())));
                            return t;
                        },
                       
                        onValueChanged:
                            function (e) {
                                if (!e.value) return;
                                FullPagePreload();

                                content.find(".risk-bilgileri .kaydet").prop("disabled", true);

                                $.ajax({
                                    url: "../../Data/RisklerVeLimitAl",
                                    type: "post",
                                    data: { ContactUID: e.value },
                                    success: function (data) {
                                        try {
                                            var response = JSON.parse(data);
                                        } catch (e) {
                                            console.log(e);
                                            console.log(data);
                                            return;
                                        }
                                        riskbilg = content.find(".risk-bilgileri");
                                        riskbilg.find(".senet td:last-child").text(response.SenetRiski.BasamakGrupla());
                                        riskbilg.find(".cek td:last-child").text(response.CekRiski.BasamakGrupla());
                                        riskbilg.find(".toplam td:last-child").text(response.ToplamRisk.BasamakGrupla());
                                        if (!!response.RiskLimit && parseInt(response.RiskLimit) == 0) response.RiskLimit = undefined;
                                        var limitinp = $("<input>").addClass("form-control sayi"),
                                            limit = !response.RiskLimit ? "Tanımsız" : response.BireyselRiskLimit;
                                        riskbilg.find(".limit td:last-child").empty().append(limitinp);
                                        limitinp.val(limit);

                                        //Kaydet butonu active/deactive et
                                        limitinp.on("focus keyup blur change", function (e) {
                                            if (e.target.value == response.RiskLimit || (!parseInt(e.target.value) && !response.RiskLimit))
                                                content.find(".risk-bilgileri .kaydet").prop("disabled", true);
                                            else
                                                content.find(".risk-bilgileri .kaydet").prop("disabled", false);
                                        });

                                        //TL sembollerini göster
                                        content.find(".symbol-removed").removeClass("symbol-removed");
                                    },
                                    error: function (jqxhr) { console.log(jqxhr); },
                                    complete: function () { Remove_FullPagePreload(); }
                                });
                            },
                        searchExpr: ["Ad", "KimlikNo", "VergiNo"],
                        searchPlaceholder: "Ara (Ad, Kimlik No, Vergi No)",
                        showClearButton: true,
                        showPopupTitle: false,
                        value: null,
                        valueExpr: "ContactUID",
                        pageLoadMode: "scrollBottom"
                    });
                },
                error: function (jqxhr) { console.log(jqxhr); },
                complete: function () {
                    content.show();
                    Remove_FullPagePreload();
                }
            });
        },
        footbarItems: []
    },
    "borclu-filtre": {
        func: function () {
            var bfiltre = $(".templates .borclu-filtre-template").clone().removeClass("borclu-filtre-template").addClass("borclu-filtre");
            $(".content-container").empty();
            bfiltre.appendTo(".content-container");
        },
        footbarItems: []
    },

    "kasa-foyu": {
        func: function () {
            kasafoyugetir();
            var kasafoyu = $(".templates .kasa-foyu-template").clone().removeClass("kasa-foyu-template").addClass("kasa-foyu");
            $(".content-container").empty();
            kasafoyu.appendTo(".content-container");

            kasafoyugetir().done(function(datas) {
                KasaFoyu_TabloOlustur(datas);
            });



        },
        footbarItems: []
    },
    "aylik-hesap": {
        func: function () { },
        footbarItems: []
    },
    "iletisim-islemleri": {
        func: function () {
            var iletisim = $(".templates .iletisim-islemleri-template").clone().removeClass("iletisim-islemleri-template").addClass("iletisim-islemleri");
            $(".content-container").empty();
            iletisim.appendTo(".content-container");

            $.ajax({
                url: "../../Data/IletisimBilgisiAl",
                type: "post",
                beforeSend: FullPagePreload,
                success: function (data) {
                    try {
                        var iletisim_list = JSON.parse(data);
                    } catch (e) {
                        console.error(e);
                        console.log(data);
                        return;
                    }

                    $(".content-container .iletisim-islemleri .iletisim-lookup .lookup").dxLookup({
                        dataSource: new DevExpress.data.DataSource({
                            store: iletisim_list,
                            key: "ContactUID",
                            sort: "Ad",
                            paginate: true,
                            pageSize: 25
                        }),
                        displayExpr: function (itemData) { return !!itemData ? itemData.Ad + " - " + (itemData["KimlikNo"] || itemData["VergiNo"]) : ""; },

                        onValueChanged: function (e) {
                            var bilg = $(".content-container .iletisim-islemleri .bilgiler");
                            bilg.find("[nzl-field]").empty();

                            if (!e.itemData) return;

                            $.each(e.itemData, function (key, val) {

                                var field = bilg.find("[nzl-field={0}]".format(key));
                                if (field.length) {
                                    if (Object.prototype.toString.call(val) == "[object String]") {
                                        if (field.attr("nzl-field-type") == "text")
                                            val == "" ? "" : field.html(val.replace(/\r?\n/g, "<br/>"));
                                        else
                                            field.text(val);
                                    }
                                    else if (Object.prototype.toString.call(val) == "[object Array]") {
                                        $.each(val, function (i, v) {
                                            if (i > 0)
                                                field.append("<br>");
                                            field.append($("<span>").text(v));
                                        });
                                    }
                                    else
                                        field.text(val.toString());
                                }
                            });

                            $(".content-container .iletisim-islemleri .actions .duzenle").prop("disabled", false);
                        },
                        searchExpr: ["Ad", "KimlikNo", "VergiNo", "BirincilTelefon", "Telefonlar", "BirincilAdres", "Adresler"],
                        searchPlaceholder: "Ara (Ad, Kimlik No, Vergi No, Telefon, Adres)",
                        showClearButton: true,
                        showPopupTitle: false,
                        pageLoadingText: "Yükleniyor...",
                        refreshingText: "Yenileniyor...",
                        pageLoadMode: "scrollBottom",
                        value: null,
                        valueExpr: "ContactUID"
                    });
                },
                error: function (jqxhr) {
                    console.log(jqxhr);
                    noty({
                        layout: "center",
                        theme: 'relax',
                        type: "error",
                        text: "İletişim Listesi alınamadı! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
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
                complete: Remove_FullPagePreload
            })
        }
    },
     "ayarlar": {
         func: function () {
             var ayrlar = $(".templates .program-ayarlar-template").clone().removeClass("program-ayarlar-template").addClass("program-ayarlar");
             $(".content-container").empty();
             ayrlar.appendTo(".content-container");

         },
        footbarItems: []
    },
}




$(document).on("click", ".left-menu-container li[o-target]", function () {
    var targetN = $(this).attr("o-target"),
        target = LM[targetN];

    target.func();
    footbarFill(target.footbarItems);
});

function footbarFill(footbarItems) {
    var fi = footbarItems || [],
        fb = $(".foot-bar-container .page-items");
    fb.empty();
    $.each(fi, function (i, data) {
        $("<div>").addClass("foot-bar-item").text(data.text).click(data.onClick).appendTo(fb);
    });
}
//#endregion




//#region Personel
function PersoneldxLookup() {
    $.ajax({
        url: "../../Data/PersonelAl",
        type: "post",
        beforeSend:
            function () { FullPagePreload(); },
        error:
            function (jqxhr) {

            },
        success:
            function (data) {
                try {
                    var personel_list = JSON.parse(data);
                } catch (e) {
                    console.log(data);
                    return;
                }
                var personelbilgi = $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler")
                personelbilgi.find(".personel-lookup").dxLookup({
                    cancelButtonText: "İptal",
                    clearButtonText: "Temizle",
                    dataSource: new DevExpress.data.DataSource({
                        store: personel_list,
                        key: "id",
                        sort: "username",
                        paginate: true,
                        pageSize: 20

                    }),
                    displayExpr: function (itemData) { return !!itemData ? itemData.username + " - " + itemData.email : "" },

                    noDataText: "No Data",
                    onValueChanged: function (e) {
                        var bilg = $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .bilgiler");
                        bilg.find("[nzl-field]").empty();


                        if (!e.itemData) return;

                        $.each(e.itemData, function (key, val) {

                            var field = bilg.find("[nzl-field={0}]".format(key));
                            if (field.length) {
                                field.text(val.toString());
                            }
                            if (key == "username") {
                                $("#personel-bilgi-kullaniciadi").val(val.toString());
                            }
                            if (key == "email") {
                                $("#personel-bilgi-email").val(val.toString());
                            }
                            if (key == "phone") {
                                $("#personel-bilgi-telefon").val(val.toString());
                            }



                        });
                        $(".content-container .Personel-Bilgiler .actions .duzenle").prop("disabled", false);
                        $(".content-container .Personel-Bilgiler .actions .sil").prop("disabled", false);
                    },
                    pageLoadingText: "Yükleniyor...",
                    placeholder: "Seç",
                    searchExpr: ["username", "email"],
                    searchPlaceholder: "Ara (Kullanıcı Adı, Email)",
                    showClearButton: true,
                    pageLoadingText: "Yükleniyor...",
                    refreshingText: "Yenileniyor...",
                    pageLoadMode: "scrollBottom",
                    showPopupTitle: false,
                    value: null,
                    valueExpr: "id"
                });
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
}
//#region Personel Sayfası
$(document).on("click", ".content-container .program-ayarlar .ayarlar-list-menu #a-li-personeller", function () {

    $(".content-container .program-ayarlar .ayarlar-content .Personel-Kayit").attr("Style", "display:block");
    $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler").attr("Style", "display:block");
    PersoneldxLookup();



});
//#endregion
//#region Personel Düzenle
$(document).on("click", ".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .btn.duzenle", function () {

    $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .personel-bilgileri").attr("Style", "display:none");
    $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .personel-bilgi-duzenle").attr("Style", "display:block");
   
    $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .btn.duzenle").text("Kaydet").removeClass("duzenle").addClass("guncelkaydet");
    $(".content-container .Personel-Bilgiler .actions .sil").attr("Style", "display:none");
});
//#endregion
//#region Personel Güncel Kaydet
$(document).on("click", ".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .btn.guncelkaydet", function () {
   
    var emptyreq = $(".content-container .Personel-Bilgiler .required").filter(function (i, el) { return $(this).val().length < 1 });
    if (emptyreq.length) {
        emptyreq.eq(0).focus();

        return;
    }
    var dxLI = $(".content-container .Personel-Bilgiler .personel-lookup").dxLookup("instance");
    var id;
    dxLI.option("dataSource").load().done(function () {
        id = dxLI.option("value");
    });

    $.ajax({
        url: "../../Data/PersonelDuzenle",
        data: {
            KullaniciAdi: $("#personel-bilgi-kullaniciadi").val(),
            Sifre: $("#personel-bilgi-sifre").val(),
            Email: $("#personel-bilgi-email").val(),
            Telefon: $("#personel-bilgi-telefon").val(),
            id: id
        },
        type: "post",
        success: function (data) {
            if (data == "KullaniciAdiEmail") {
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Bu Kullanıcı Adı ve E-mail Zaten Kayıtlı.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
            }
            else if (data == "KullaniciAdi") {
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Bu Kullanıcı Adı Zaten Kayıtlı.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
            }
            else if (data == "Email") {
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Bu E-mail  Zaten Kayıtlı.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
            }
            else {
                var gelen = JSON.parse(data);
                $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .personel-bilgileri").attr("Style", "display:block");
                $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .personel-bilgi-duzenle").attr("Style", "display:none");
               
                info = dxLI.option("selectedItem");
                $(".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .btn.guncelkaydet").text("Düzenle").removeClass("guncelkaydet").addClass("duzenle");
                dxLI.option("dataSource").store().remove(info).done(function () {
                    dxLI.option("dataSource").store().insert(gelen).done(function () {
                        dxLI.option("dataSource").load().done(function () {
                            dxLI.reset();
                            dxLI.option("value", gelen["id"]);
                        });
                    });
                });
                $(".content-container .Personel-Bilgiler .actions .sil").css("display", "");
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "iletişim bilgileri Güncellendi.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
            }
         
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            noty({
                layout: "center",
                theme: 'relax',
                type: "error",
                text: "Profil  Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                animation: {
                    open: 'animated fadeIn'
                },
                timeout: false,
                killer: true,
                modal: true,
                closeWith: ['click', 'backdrop']
            });
        },
        complete: function () { Remove_FullPagePreload(); }
    });
});
//#endregion
//#region Personel  Kaydet
$(document).on("click", ".content-container .program-ayarlar .ayarlar-content .Personel-Kayit .btn.kaydet", function () {
    var emptyreq = $(".content-container .Personel-Kayit .required").filter(function (i, el) { return $(this).val().length < 1 });
    if (emptyreq.length) {
        emptyreq.eq(0).focus();
       
        return;
    }
    $.ajax({
        url: "../../Data/PersonelKaydet",
        data: {
            KullaniciAdi: $("#personel-kayit-kullaniciadi").val(),
            Sifre: $("#personel-kayit-sifre").val(),
            Email: $("#personel-kayit-email").val(),
            Telefon: $("#personel-kayit-telefon").val(),

        },
        type: "post",
        success: function (data) {
            if (data == "Ok") {
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Personel Başarı İLe Eklendi.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
                $(".content-container .program-ayarlar .ayarlar-content .Personel-Kayit input").val("");
                PersoneldxLookup();
            }
            if (data == "KullaniciAdi") {
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Bu Kullanıcı Adı Zaten Kayıtlı.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
            }
            if (data == "Email") {
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Bu E-mail  Zaten Kayıtlı.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
            }
            if (data == "KullaniciAdiEmail") {
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Bu Kullanıcı Adı ve E-mail Zaten Kayıtlı.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
            }

          
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            noty({
                layout: "center",
                theme: 'relax',
                type: "error",
                text: "Profil  Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                animation: {
                    open: 'animated fadeIn'
                },
                timeout: false,
                killer: true,
                modal: true,
                closeWith: ['click', 'backdrop']
            });
        },
        complete: function () { Remove_FullPagePreload(); }
    });


});
//#endregion
//#region Personel  Sil
$(document).on("click", ".content-container .program-ayarlar .ayarlar-content .Personel-Bilgiler .btn.sil", function () {
    var dxLI = $(".content-container .Personel-Bilgiler .personel-lookup").dxLookup("instance");
    var id;
    dxLI.option("dataSource").load().done(function () {
        id = dxLI.option("value");
    });
    $.ajax({
        url: "../../Data/PersonelSil",
        data: { id: id},
        type: "post",
        success: function (data) {
            if (data == "Ok") {
                //#region noty
                noty({
                    layout: "topRight",
                    theme: 'relax',
                    type: "information",
                    text: "Personel Başarı İLe Silindi.",
                    dismissQueue: true,
                    animation: {
                        open: 'animated bounceInRight',
                        close: 'animated bounceOutRight'
                    },
                    maxVisible: 10,
                    timeout: 5000
                });
                //#endregion
                $(".content-container .Personel-Bilgiler .actions .duzenle").prop("disabled", true);
                $(".content-container .Personel-Bilgiler .actions .sil").prop("disabled", true);
                PersoneldxLookup();
            }
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            noty({
                layout: "center",
                theme: 'relax',
                type: "error",
                text: "Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                animation: {
                    open: 'animated fadeIn'
                },
                timeout: false,
                killer: true,
                modal: true,
                closeWith: ['click', 'backdrop']
            });
        },
        complete: function () { Remove_FullPagePreload(); }
    });
  
});
//#endregion
//#endregion

//#region Araç Arama ve Listeleme
$(document).on("click", ".content-container .arac-arama .actions .temizle", function () {
    $(".content-container .arac-arama .col-panel .form-row").each(function (i, el) {
        $(this).find("td:nth-child(2) select option:first").prop("selected", true);
        $(this).find("[nzl-field]").each(function (i2, el2) {
            switch ($(this).attr("nzl-field-type")) {
                default:
                    break;
                case "text":
                case "number":
                    {
                        $(this).val("");
                    }
                    break;
                case "enum":
                    {
                        $(this).prepend($("<option>").addClass("null")).children(".null").prop("selected", true);
                    }
                    break;
                case "id":
                    {
                        $(this).text("").attr("nzl-field-value", "");
                    }
                    break;
                case "date":
                    {
                        $(this).dxDateBox("instance").option("value", "");
                    }
                    break;
            }
        });
    });

});
$(document).on("click", ".content-container .arac-arama .actions .ara", function () {
    var parameters = [];
    $(".content-container .arac-arama .col-panel [nzl-field]").each(function (i, el) {
        var operator = $(this).closest(".form-row").find("td:nth-child(2) select").val(),
            val = "";

        switch ($(this).attr("nzl-field-type")) {
            default:
                break;
            case "text":
            case "number":
            case "enum":
                {
                    val = $(this).val();
                }
                break;
            case "id":
                {
                    val = $(this).attr("nzl-field-value");
                }
                break;
            case "date":
                {
                    val = $(this).dxDateBox("instance").option("value");

                    if (val != "" && val != null) {
                        val = moment(val).format("YYYY.MM.DD");

                    }



                }
        }

        if (val != "" && val != null)
            parameters.push({
                field: $(this).attr("nzl-field"),
                operator: operator,
                value: val
            });
    });

    AracAra2(parameters);
});
$(document).on("click", ".content-container .arac-arama .col-panel .form-row .kisi-kurum-sec", function () {
    var $this = $(this),
        modal = $(".kisi-kurum-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        var span = $this.siblings("span"),
            dxLI = modal.find(".kisi-kurum-lookup").dxLookup("instance");
        span.attr("nzl-field-value", dxLI.option("value"));
        span.text(dxLI.option("text"));

        modal.modal("hide");
    });
});

function AracAra2(parameters) {
    $.ajax({
        url: "../../Data/AracAra",
        type: "post",
        data: {
            Data: JSON.stringify(parameters)
        },
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {
                try {
                    var arac_list = JSON.parse(data);
                    console.log(arac_list);
                } catch (e) {
                    console.log(data);
                    return;
                }
                if (arac_list.length < 1)
                    return DevExpress.ui.dialog.alert("Araç Bulunamadı.");

                AracListele2(arac_list);
                /*if (DetayliGosterIndex != null)
                    AracGoster(DetayliGosterIndex);*/
            },
        error:
            function (jqxhr) {
                noty({
                    layout: "center",
                    theme: 'relax',
                    type: "error",
                    text: "Araç Arama İşlemi Başırısız! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                    dismissQueue: true,
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: false,
                    killer: true,
                    modal: true,
                    closeWith: ['click', 'backdrop']
                });
                console.log(jqxhr);
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
}
function AracListele2(AracData, Columns, Options) {
    /// <param name="Columns" type="Object">columns => Array & override => Boolean</param>
    /// <param name="Optiıns" type="Object">options => Object & override => Boolean</param>
    var liste = $(".templates .arac-listesi-template").clone().removeClass("arac-listesi-template").addClass("arac-listesi"),
        datagrid = liste.find(".datagrid"),
        columns = [
            {
                dataField: "id",
                dataType: "number",
                visible: false
            },
            {
                dataField: "Plaka",
                fixed: true
            },
            "Marka",
            "Seri",
            "Model",
            {
                dataField: "Yil",
                caption: "Yıl",
                dataType: "date",
                customizeText: function (data) {

                    return moment(data.value).format("DD.MM.YYYY");
                },
                format: "year"
            },
            {
                dataField: "KM",
                dataType: "number",
                customizeText: customizeText_Number
            },
            "Renk",
            "VitesTipi",
            "YakitTipi",
            {
                dataField: "MotorHacmi",
                dataType: "number",
                customizeText: customizeText_Number
            },
            "Durum",
            {
                dataField: "AlinisTarihi",
                caption: "Alınış Tarihi",
                dataType: "date",
                customizeText: function (data) {

                    return moment(data.value).format("DD.MM.YYYY");
                }
            },
            "Liste",
            {
                dataField: "AddDate",
                caption: "Sisteme Giriş Tarihi",
                dataType: "date",
                customizeText: function (data) {

                    return moment(data.value).format("DD.MM.YYYY");
                }
            },
            {
                dataField: "Cekis",
                caption: "Çekiş",
                visible: false
            },
            {
                dataField: "Kapi",
                caption: "Kapı",
                visible: false
            },
            {
                dataField: "MotorGucu",
                caption: "Motor Gücü",
                visible: false
            },
            {
                dataField: "MotorNo",
                visible: false
            },
            {
                dataField: "SasiNo",
                caption: "Şasi No",
                visible: false
            },
            {
                dataField: "EtiketFiyati",
                caption: "Etiket Fiyatı",
                dataType: "number",
                customizeText: customizeText_TL,
                visible: false
            },
            {
                dataField: "VekaletBitisTarihi",
                caption: "Vekalet Bitiş Tarihi",
                dataType: "date",
                customizeText: function (data) {

                    return moment(data.value).format("DD.MM.YYYY");
                },
                visible: false
            }
        ],
        options = {
            allowColumnResizing: true,
            columnAutoWidth: true,
            columnChooser: {
                enabled: true
            },
            dataSource: new DevExpress.data.DataSource({
                store: new DevExpress.data.ArrayStore({
                    data: AracData,
                    key: "AracUID"
                })
            }),
            "export": {
                enabled: true,
                fileName: moment().format("DD.MM.YYYY") + " - Araç Listesi"
            },
            filterRow: {
                visible: true
            },
            groupPanel: {
                visible: true
            },
            headerFilter: {
                visible: true
            },
            paging: {
                enabled: false
            },
            searchPanel: {
                visible: true
            },
            selection: {
                mode: "single"
            },
            showBorders: true,
            onRowClick: function (e) {
                if (!!e.rowElement.data("LastClick") && e.rowElement.data("LastClick") > (Date.now() - 500))
                    AracGoster2(e.key);//Detaylı göster

                e.rowElement.data("LastClick", Date.now());


            },
            onRowPrepared: function (e) {
                if (e.rowType == "data") {
                    e.rowElement.attr({ id: e.data.AracUID, "row-index": e.rowIndex });
                }
            }
        };

    $(".content-container").empty().append(liste);

    //Column verildiyse ekle
    if (!!Columns) {
        if (Columns.override)
            columns = Columns.columns;
        else {
            if (!!Columns.columns && Object.prototype.toString.call(Columns.columns) == "[object Array]" && Columns.columns.length)
                $.merge(columns, Columns.columns);
        }
    }

    //Options verildiyse ekle
    if (!!Options) {
        if (Options.override)
            options = Options.options;
        else {
            if (!!Options.options && Object.prototype.toString.call(Options.options) == "[object Object]")
                $.extend(true, options, Options.options);
        }
    }

    //Columns ekle
    options.columns = columns;

    datagrid.dxDataGrid(options);
}
function AracGoster2(AracUID) {

    var datagrid = $(".content-container .arac-listesi .datagrid");
    datagrid.dxDataGrid("instance").option("dataSource").store().byKey(AracUID).done(function (aracdata) {

        var detay = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid", aracdata.AracUID);
        console.log(aracdata);
        $("[nzl-field]").empty();
        $.each(aracdata, function (key, val) {
            var field = $("[nzl-field=" + key + "]", detay);
            if (!field.length)
                return;
            switch (field.attr("nzl-field-type")) {
                default:
                    field.text(val);
                    break;
                case "FaturaGoster":
                    if (val == "") {
                        $(".content-container .arac-listesi .detayli-gorunum .FaturaGoster").hide();
                    }
                    else {
                        field.text(val);
                    }

                    break;
                case "number":
                    field.text(val.BasamakGrupla());
                    break;
                case "tl":
                    if (val == "") {
                        field.text("");
                    } else {
                        field.text(val.BasamakGrupla() + " ₺");
                    }

                    break;
                case "date":
                    if (val == "") {
                        field.text("");
                    } else {
                        field.text(moment(val, "YYYY/MM/DD").format("DD.MM.YYYY"));
                    }

                    break;
                case "array":
                    field.html(val.toString().replace(",", "<br/>"));
                    break;
                case "image":
                    if (val.length == 0) {
                        field.text("Resim Bulunamadı.");
                    } else {
                        for (var j = 0; j < val.length; j++) {
                            field.append("<img class='ResimResim' adres='" + val[j] + "' src='../../Data/AracResimleri/{0}/{1}' image-index='{2}' />".format(aracdata.AracUID, val[j], j));


                        }
                    }
                    break;
                case "bool":
                case "boolean":
                    if (!!val && (val == true || val == "True" || val == "true" || val == 1)) {
                        field.text("Var");
                        if (key == "Opsiyon") {
                            $(".content-container [nzl-field=OpsiyonTarihi], .content-container [nzl-field=OpsiyonKoyan]").parent().show();
                            $(".content-container .arac-listesi .actions .opsiyon-koy").text("Opsiyon Kaldır");
                        }
                    }

                    else {
                        field.text("Yok");
                        if (key == "Opsiyon") {
                            $(".content-container [nzl-field=OpsiyonTarihi], .content-container [nzl-field=OpsiyonKoyan]").parent().hide();
                            $(".content-container .arac-listesi .actions .opsiyon-koy").text("Opsiyon Koy");
                        }
                    }

                    break;
            }
        });
        detay.find("h3").text("{0} - {1} {2} {3}".format(aracdata.Plaka, aracdata.Marka, aracdata.Seri, aracdata.Model));
        detay.show();
        datagrid.hide();
    });

    $(".content-container .arac-listesi .actions .resim-ekle").off("click").on("click", function () {

        var upload = $("<input>").attr({ type: "file", accept: "image/png,image/gif,image/jpg,image/jpeg", multiple: true }),
       detayligorunum = $(this).closest(".detayli-gorunum"),
       aracid = detayligorunum.attr("arac-uid");
        upload.trigger("click");
        upload.on("change", function (e) {
            var data = new FormData();
            $.each(e.target.files, function (key, val) {
                data.append("Resim" + key, val);
            });
            data.append("AracID", aracid);
            $.ajax({
                url: "../../Data/AracResimEkle",
                type: "post",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                beforeSend: function () { FullPagePreload(); },
                success:
                    function (data) {
                        try {
                            var response = JSON.parse(data);
                        } catch (e) {
                            console.log(data);
                            console.log(e);
                            return;
                        }
                        //Resimleri dataya ekle
                        $(".content-container .arac-listesi .datagrid").dxDataGrid("instance").option("dataSource").store().byKey(aracid).done(function (aracdata) {
                            $.each(response, function (i, v) { aracdata.Resimler.push(v); });
                        });
                        //Yeniden çiz
                        AracGoster2(AracUID);
                    },
                error:
                    function (jqxhr) {
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
                        console.log(jqxhr);
                    },
                complete:
                    function () {
                        Remove_FullPagePreload();
                        upload.remove();
                    }
            });
        });
    });
    $(".ResimResim").off("contextmenu").on("contextmenu", function (e) {
        e.preventDefault();
        var Adres = $(this).attr("Adres");
        var silinecekresim = $(this);

        var AracUID = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid");
        var def = $.Deferred();
        DevExpress.ui.dialog.confirm("Bu resimin silinmesine emin misiniz?", "Resim Sil").done(function (sil) {
            if (sil) {

                $.ajax({

                    url: "../../Data/AracResimSil",
                    type: "post",
                    data: {
                        AracUID: AracUID,
                        ResimAdi: Adres
                    },
                    beforeSend: FullPagePreload,
                    success: function (data) {
                        def.resolve(true);

                        noty({
                            layout: "topRight",
                            theme: 'relax',
                            type: "information",
                            text: "Resim Listeden Silindi.",
                            dismissQueue: true,
                            animation: {
                                open: 'animated bounceInRight',
                                close: 'animated bounceOutRight'
                            },
                            maxVisible: 10,
                            timeout: 5000
                        });

                        var datagrid = $(".content-container .arac-listesi .datagrid");
                        datagrid.dxDataGrid("instance").option("dataSource").store().byKey(AracUID).done(function (aracdata) {
                            console.log(silinecekresim.attr("image-index"));
                            aracdata.Resimler.splice(silinecekresim.attr("image-index"), 1);


                        });
                        AracGoster2(AracUID);
                    },
                    error: function (jqxhr) {
                        console.log(jqxhr);
                        def.resolve(false);
                        noty({
                            layout: "center",
                            theme: 'relax',
                            type: "error",
                            text: "Resim Silinemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
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
                    complete: Remove_FullPagePreload
                });
            }
            else
                def.resolve(false);
        });
        return def;

    });
}

var AracGridNavigation = {
    goback: function () {
        $(".content-container .arac-listesi .detayli-gorunum").hide().siblings(".datagrid").show();
    },
    back: function () {
        var aracid = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid"),
            currentRow = $(".content-container .arac-listesi .datagrid #{0}".format(aracid)),
            gotoRow;
        if ((gotoRow = currentRow.prevAll("tr.dx-data-row:first")).length)
            gotoRow.trigger("click").trigger("click");
        else
            gotoRow = currentRow.siblings("tr.dx-data-row:last").trigger("click").trigger("click");
    },
    forward: function () {
        var aracid = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid"),
            currentRow = $(".content-container .arac-listesi .datagrid #{0}".format(aracid)),
            gotoRow;
        if ((gotoRow = currentRow.nextAll("tr.dx-data-row:first")).length)
            gotoRow.trigger("click").trigger("click");
        else
            gotoRow = currentRow.siblings("tr.dx-data-row:first").trigger("click").trigger("click");
    }
}


$(document).on("click", ".content-container .arac-listesi .actions .opsiyon-koy", function () {
    if ($(".content-container [nzl-field=Opsiyon]").text() == "Var") {
        var def = $.Deferred();
        var AracUID = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid");


        DevExpress.ui.dialog.confirm("Bu aracın Opsiyonunu Kaldırmak istediğinizden emin misiniz?", "Opsiyon Kaldır.").done(function (opsiyonkaldir) {
            if (opsiyonkaldir) {
                $.ajax({
                    url: "../../Data/OpsiyonGuncelle",
                    type: "post",
                    data: {
                        Opsiyon: "False",
                        AracUID: AracUID
                    },
                    beforeSend: FullPagePreload,
                    success: function (data) {
                        if (data != "Var") {

                            def.resolve(true);
                            var opsiyonlist = JSON.parse(data);
                            $("[nzl-field=Opsiyon]").text("Var");
                            $("[nzl-field=OpsiyonKoyan]").text(opsiyonlist[1]);
                            $("[nzl-field=OpsiyonTarihi]").text(opsiyonlist[0]);
                            $(".content-container [nzl-field=OpsiyonTarihi], .content-container [nzl-field=OpsiyonKoyan]").parent().hide();
                            $(".content-container .arac-listesi .actions .opsiyon-koy").text("Opsiyon Kaldır");
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: "Araca Opsiyon Koyuldu.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });



                        }
                        else {

                            $("[nzl-field=Opsiyon]").text("Yok");
                            $("[nzl-field=OpsiyonKoyan]").text("");
                            $("[nzl-field=OpsiyonTarihi]").text("");
                            $(".content-container [nzl-field=OpsiyonTarihi], .content-container [nzl-field=OpsiyonKoyan]").parent().hide();
                            $(".content-container .arac-listesi .actions .opsiyon-koy").text("Opsiyon Koy");
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: "Aracın Opsiyonu Kaldırıldı.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });

                        }


                    },
                    error: function (jqxhr) {
                        console.log(jqxhr);
                        def.resolve(false);
                        noty({
                            layout: "center",
                            theme: 'relax',
                            type: "error",
                            text: "Opsiyon Bir Hatadan Dolayı Değiştirilemedi. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
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
                    complete: Remove_FullPagePreload
                });
            }
            else
                def.resolve(false);
        });

        return def;
    } else {

        var def = $.Deferred();
        var AracUID = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid");


        DevExpress.ui.dialog.confirm("Bu araca Opsiyon koymak istediğinizden emin misiniz?", "Opsiyon Koy.").done(function (opsiyon) {
            if (opsiyon) {
                $.ajax({
                    url: "../../Data/OpsiyonGuncelle",
                    type: "post",
                    data: {
                        Opsiyon: "True",
                        AracUID: AracUID
                    },
                    beforeSend: FullPagePreload,
                    success: function (data) {

                        var opsiyonlist = JSON.parse(data);

                        if (data != "Var") {

                            def.resolve(true);
                            var opsiyonlist = JSON.parse(data);
                            $("[nzl-field=Opsiyon]").text("Var");
                            $("[nzl-field=OpsiyonKoyan]").text(opsiyonlist[1]);
                            $("[nzl-field=OpsiyonTarihi]").text(opsiyonlist[0]);
                            $(".content-container [nzl-field=OpsiyonTarihi], .content-container [nzl-field=OpsiyonKoyan]").parent().show();
                            $(".content-container .arac-listesi .actions .opsiyon-koy").text("Opsiyon Kaldır");
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: "Araca Opsiyon Konuldu.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });



                        }
                        else {

                            $("[nzl-field=Opsiyon]").text("Yok");
                            $("[nzl-field=OpsiyonKoyan]").text("");
                            $("[nzl-field=OpsiyonTarihi]").text("");
                            $(".content-container [nzl-field=OpsiyonTarihi], .content-container [nzl-field=OpsiyonKoyan]").parent().hide();
                            $(".content-container .arac-listesi .actions .opsiyon-koy").text("Opsiyon Koy");
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: "Aracın Opsiyonu Kaldırıldı.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });

                        }


                    },
                    error: function (jqxhr) {
                        console.log(jqxhr);
                        def.resolve(false);
                        noty({
                            layout: "center",
                            theme: 'relax',
                            type: "error",
                            text: "Opsiyon Bir Hatadan Dolayı Değiştirilemedi. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
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
                    complete: Remove_FullPagePreload
                });
            }
            else
                def.resolve(false);
        });

        return def;
    }
});

$(document).on("change", ".resmi-giris-ekle.modal #resmi-giris-ekle-tip", function () {
    var modal = $(this).closest(".modal");
    if ($(this).val() == "Kişi") {
        modal.find(".faturaverildimi").removeClass("visible");
    }
    else if ($(this).val() == "Kurum") {
        modal.find(".faturaverildimi").addClass("visible");

    }
});

$(document).on("click", ".content-container .arac-listesi .actions .resmi-giris-yap", function () {
    var AracUID = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid");

    var resmigirismodal = $(this).closest(".modal"),
      resmigirismodal = $(".resmi-giris-ekle.modal").modal("show");

    resmigirismodal.find(".btn.kaydet").off("click").on("click", function () {
        resmigirismodal.find(".modal-feedback").empty();
        var fatura;
        if (resmigirismodal.find("#resmi-giris-ekle-tip").val() == "Kurum") {
            fatura = resmigirismodal.find("#resmi-giris-ekle-faturaverildimi").val();
        } else {
            fatura = "";
        }

        $.ajax({
            url: "../../Data/ResmiGirisYap",
            type: "post",
            data: {

                AracUID: AracUID,
                ResmiAlınanTipi: resmigirismodal.find("#resmi-giris-ekle-tip").val(),
                ResmiAlınanKisi: resmigirismodal.find("#resmi-giris-ekle-ad").val(),
                NoterAlisTarihi: resmigirismodal.find("#resmi-giris-ekle-alistarihi").val(),
                ResmiGirisBedeli: resmigirismodal.find("#resmi-giris-ekle-girisbedeli").val(),
                ResmiGirisTcVergiNo: resmigirismodal.find("#resmi-giris-ekle-resmigiristcvergino").val(),
                ResmiGirisFatura: fatura

            },
            beforeSend:
                function () { FullPagePreload(); },
            error:
                function (jqxhr) {
                    if (jqxhr.responseText.length)
                        emodal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                    else
                        emodal.find(".modal-feedback").append(Alert("danger", "Kayıt Başarısız! Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü."));
                },
            success:
                function (data) {

                    var resmigirislist = JSON.parse(data);
                    //#region noty
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Resmi Giriş Başarı İle Yapıldı.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    //#endregion
                    $("[nzl-field=NoterAlisTarihi]").text(resmigirislist[1] == "" ? "" : moment(resmigirislist[1], "YYYY/MM/DD").format("DD.MM.YYYY"));
                    $("[nzl-field=ResmiGirisBedeli]").text(resmigirislist[3].BasamakGrupla() + " ₺");
                    $("[nzl-field=ResmiAlınanKisi]").text(resmigirislist[0]);
                    $("[nzl-field=ResmiGirisTcVergiNo]").text(resmigirislist[4]);
                    if (resmigirislist[2] == "Kişi") {
                        $(".FaturaGoster").hide();
                    } else {
                        $(".FaturaGoster").show();
                        $("[nzl-field=ResmiGirisFatura]").text(resmigirislist[5]);
                    }

                    resmigirismodal.modal("hide");

                },
            complete:
                function () { Remove_FullPagePreload(); }
        });
    });


});

$(document).on("click", ".content-container .arac-listesi .actions .resmi-cikis-yap", function () {
    var AracUID = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid");

    var resmicikismodal = $(this).closest(".modal"),
      resmicikismodal = $(".resmi-cikis-ekle.modal").modal("show");

    resmicikismodal.find(".btn.kaydet").off("click").on("click", function () {
        resmicikismodal.find(".modal-feedback").empty();


        $.ajax({
            url: "../../Data/ResmiCikisYap",
            type: "post",
            data: {

                AracUID: AracUID,
                ResmiCikisKisi: resmicikismodal.find("#resmi-cikis-ekle-ad").val(),
                ResmiCikisBedeli: resmicikismodal.find("#resmi-cikis-ekle-cikisbedeli").val(),
                ResmiCikisTarihi: resmicikismodal.find("#resmi-cikis-ekle-cikistarihi").val(),
                ResmiCikisTcVergiNo: resmicikismodal.find("#resmi-cikis-ekle-resmicikistcvergino").val(),


            },
            beforeSend:
                function () { FullPagePreload(); },
            error:
                function (jqxhr) {
                    if (jqxhr.responseText.length)
                        emodal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                    else
                        emodal.find(".modal-feedback").append(Alert("danger", "Kayıt Başarısız! Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü."));
                },
            success:
                function (data) {
                    var resmicikislist = JSON.parse(data);

                    //#region noty
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Resmi Çıkış Başarı İle Yapıldı.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    //#endregion

                    $("[nzl-field=ResmiCikisTarihi]").text(resmicikislist[2] == "" ? "" : moment(resmicikislist[2], "YYYY/MM/DD").format("DD.MM.YYYY"));
                    $("[nzl-field=ResmiCikisBedeli]").text(resmicikislist[1].BasamakGrupla() + " ₺");
                    $("[nzl-field=ResmiCikisKisi]").text(resmicikislist[0]);
                    $("[nzl-field=ResmiCikisTcVergiNo]").text(resmicikislist[3]);

                    resmicikismodal.modal("hide");
                },
            complete:
                function () { Remove_FullPagePreload(); }
        });
    });


});

$(document).on("click", ".satis-sozlesmesi.modal .btn.kisisec", function () {
    var smodal = $(this).closest(".modal");
    var $this = $(this),
        emodal = $(".kisi-kurum-sec.modal").modal("show");

    emodal.find(".btn.sec").off("click").on("click", function () {
        var span = $this.siblings("span"),
            dxLI = emodal.find(".kisi-kurum-lookup").dxLookup("instance");

        span.attr("ContactData", JSON.stringify(dxLI.option("selectedItem")));

        span.text(dxLI.option("text"));

        emodal.modal("hide");
    });
});

$(document).on("click", ".satis-sozlesmesi.modal .btn.sahitkisisec", function () {
    var smodal = $(this).closest(".modal");
    var $this = $(this),
        emodal = $(".kisi-kurum-sec.modal").modal("show");

    emodal.find(".btn.sec").off("click").on("click", function () {
        var span = $("#ya-sahit");
        dxLI = emodal.find(".kisi-kurum-lookup").dxLookup("instance");

        span.attr("ContactData", JSON.stringify(dxLI.option("selectedItem")));

        span.text(dxLI.option("text"));

        emodal.modal("hide");
    });
});


$(document).on("click", ".satis-sozlesmesi.modal .btn.senetolustur", function () {
    var smodal = $(this).closest(".modal");
    var $this = $(this),

        emodal = $(".senet-yazdir.modal").modal("show");


});

$(document).on("click", ".senet-yazdir.modal .btn.olustur", function () {
    var blok = $(this).closest(".senet-yazdir.modal");
    var emptyreq = blok.find(".clearfix .required").filter(function (i, el) { return $(this).val().length <= 0 });
    if (emptyreq.length) {
        emptyreq.eq(0).focus();
        var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(emptyreq.eq(0).parent(".input-group").length ? emptyreq.eq(0).parent() : emptyreq.eq(0)).show(200);
        setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
        return;
    }
    var senetsayisi = $("#senetsayisi").val();
    if (senetsayisi != "") {
        for (var i = 1; i <= senetsayisi; i++) {


            $(".senet-yapilan , .senetsayisi , .odeyecekisim , .odeyecekadres , .odeyecektcvergino , .kefilisim, .kefiltcvergino , .duzenlenmetarihi , .duzenlenmeyeri , .senet-olustur , .senetvukuu").hide();


            $(".senet-yazdir.modal .modal-dialog").css("width", "80%");
            var blog = $(".senetleryazdir"),

            formdiv = $("<div>").addClass("form-group").addClass("visible").addClass("SenetVade"),
            SenetVadelabel = $("<label>").addClass("control-label").addClass("col-xs-1").attr("for", "SenetVade").text("VADE"),
            SenetVadedivinput = $("<div>").addClass("col-xs-2"),
            SenetVadeinput = $("<input>").attr("id", "SenetVade" + i).attr("type", "text").addClass("form-control").addClass("required");
            blog.append(formdiv.append(SenetVadelabel).append(SenetVadedivinput.append(SenetVadeinput)));


            OdemeGunulabel = $("<label>").addClass("control-label").addClass("col-xs-2").attr("for", "OdemeGunu").text("Ödeme Günü"),
            OdemeGunudivinput = $("<div>").addClass("col-xs-2"),
            OdemeGunuinput = $("<input>").attr("id", "OdemeGunu" + i).attr("type", "text").addClass("form-control").addClass("tarih").addClass("required");
            blog.append(formdiv.append(OdemeGunulabel).append(OdemeGunudivinput.append(OdemeGunuinput)));


            TurkLirasilabel = $("<label>").addClass("control-label").addClass("col-xs-1").attr("for", "TurkLirasi").text("Türk Lirası"),
            TurkLirasidivinput = $("<div>").addClass("col-xs-2"),
            TurkLirasiinput = $("<input>").attr("id", "TurkLirasi" + i).attr("type", "text").addClass("form-control").addClass("sayi").addClass("required");
            blog.append(formdiv.append(TurkLirasilabel).append(TurkLirasidivinput.append(TurkLirasiinput)));



            Kuruslabel = $("<label>").addClass("control-label").addClass("col-xs-1").attr("for", "Kurus").text("Kuruş"),
            Kurusdivinput = $("<div>").addClass("col-xs-1"),
            Kurusinput = $("<input>").attr("id", "Kurus" + i).attr("type", "text").addClass("form-control").addClass("sayi").addClass("required");
            blog.append(formdiv.append(Kuruslabel).append(Kurusdivinput.append(Kurusinput)));





            formdivyazi = $("<div>").addClass("form-group").addClass("visible").addClass("Sayin"),
            Sayinlabel = $("<label>").addClass("control-label").addClass("col-xs-1").attr("for", "Sayin").text("Sayın"),
            Sayindivinput = $("<div>").addClass("col-xs-2"),
            Sayininput = $("<input>").attr("id", "Sayin" + i).attr("type", "text").addClass("form-control").addClass("required");
            blog.append(formdivyazi.append(Sayinlabel).append(Sayindivinput.append(Sayininput)));

            YaziParalabel = $("<label>").addClass("control-label").addClass("col-xs-2").attr("for", "YaziPara").text("Yazıyla Türk Lirası"),
            YaziParadivinput = $("<div>").addClass("col-xs-2"),
            YaziParainput = $("<input>").attr("id", "YaziPara" + i).attr("type", "text").addClass("form-control").addClass("required");
            blog.append(formdivyazi.append(YaziParalabel).append(YaziParadivinput.append(YaziParainput)));

            YaziKuruslabel = $("<label>").addClass("control-label").addClass("col-xs-1").attr("for", "YaziKurus").text("Yazı Kuruş"),
            YaziKurusdivinput = $("<div>").addClass("col-xs-2"),
            YaziKurusinput = $("<input>").attr("id", "YaziKurus" + i).attr("type", "text").addClass("form-control").addClass("required");
            blog.append(formdivyazi.append(YaziKuruslabel).append(YaziKurusdivinput.append(YaziKurusinput)));

            Nolabel = $("<label>").addClass("control-label").addClass("col-xs-1").attr("for", "No").text("No"),
            Nodivinput = $("<div>").addClass("col-xs-1"),
            Noinput = $("<input>").attr("id", "No" + i).attr("type", "text").addClass("form-control").addClass("sayi").addClass("required").val(i);
            blog.append(formdivyazi.append(Nolabel).append(Nodivinput.append(Noinput)));

            blog.append("<hr>")
        }

    }
    else {
        alert("sad");
    }




});

$(document).on("click", ".senet-yazdir.modal .btn.yazdir", function () {

    var senetarry = [];

    var senetsayisi = $("#senetsayisi").val();
    for (var i = 1; i <= senetsayisi; i++) {

        var SenetBilgisi = {
            SenetYapilan: $("#senet-yapilan").val(),
            OdeyecekIsim: $("#odeyecekisim").val(),
            OdeyecekAdres: $("#odeyecekadres").val(),
            OdeyecekTcVergino: $("#odeyecektcvergino").val(),
            KefilIsim: $("#kefilisim").val(),
            KefilTcVergino: $("#kefiltcvergino").val(),
            DuzenlenmeTarihi: $("#duzenlenmetarihi").val(),
            DuzenlenmeYeri: $("#duzenlenmeyeri").val(),
            SenetVukuu: $("#senetvukuu").val(),
            SenetNo: $("#No" + i).val(),
            SenetVade: $("#SenetVade" + i).val(),
            OdemeGunu: $("#OdemeGunu" + i).val(),
            TurkLirasi: $("#TurkLirasi" + i).val(),
            Kurus: $("#Kurus" + i).val(),
            Sayin: $("#Sayin" + i).val(),
            YaziPara: $("#YaziPara" + i).val(),
            YaziKurus: $("#YaziKurus" + i).val(),
        };
        senetarry.push(SenetBilgisi);
    }
    window.open("/NZLOto/SenetYazdir?SenetData=" + JSON.stringify(senetarry), "_blank");
    $(".senet-yazdir.modal").modal("hide");

});


$(document).on("click", ".content-container .arac-listesi .actions .satis-protokolu-yap", function (e) {
    var AracUID = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid");
    var modal2 = $(".satis-sozlesmesi.modal").modal("show");
    modal2.find("#ruhsatsahibi-ad").val($(".content-container [nzl-field=RuhsatSahibiAd]").text());
    modal2.find(".secili-iletisim-bilgileri table tr td:nth-child(2)").empty();

    $.ajax({
        url: "../../Data/AracAra2",
        type: "post",
        data: { AracUID: AracUID },
        success: function (data) {

            var aracbilgiler = JSON.parse(data);
            var table = modal2.find(".secili-iletisim-bilgileri table");
            table.find(".satis-sozlesmesi-marka  td:nth-child(2)").text(aracbilgiler[0].Marka);
            table.find(".satis-sozlesmesi-model  td:nth-child(2)").text(aracbilgiler[0].Model);
            table.find(".satis-sozlesmesi-plaka  td:nth-child(2)").text(aracbilgiler[0].Plaka);
            table.find(".satis-sozlesmesi-km  td:nth-child(2)").text(aracbilgiler[0].KM);
            table.find(".satis-sozlesmesi-motorno  td:nth-child(2)").text(aracbilgiler[0].MotorNo);
            table.find(".satis-sozlesmesi-saseno  td:nth-child(2)").text(aracbilgiler[0].SasiNo);
            table.find(".satis-sozlesmesi-yakit  td:nth-child(2)").text(aracbilgiler[0].YakitTipi);
            table.find(".satis-sozlesmesi-saticiad  td:nth-child(2)").text(aracbilgiler[0].SaticiAd);
            table.find(".satis-sozlesmesi-saticitel  td:nth-child(2)").text(aracbilgiler[0].SaticiTelefon);
            table.find(".satis-sozlesmesi-saticiadres  td:nth-child(2)").text(aracbilgiler[0].SaticiAdres);
            table.find(".satis-sozlesmesi-saticitc  td:nth-child(2)").text(aracbilgiler[0].SaticiKimlikNo);

            modal2.find(".btn.sec").off("click").on("click", function () {

                var ContactData = (JSON.parse($("#ya-alici").attr("ContactData")));
                var SahitContactData = (JSON.parse($("#ya-sahit").attr("ContactData")));
                console.log(ContactData);

                var AracData2;
                AracData2 = JSON.stringify({
                    Plaka: aracbilgiler[0].Plaka,
                    Marka: aracbilgiler[0].Marka,
                    Model: aracbilgiler[0].Model,
                    KM: aracbilgiler[0].KM,
                    Yakit: aracbilgiler[0].YakitTipi,
                    MotorNo: aracbilgiler[0].MotorNo,
                    SasiNo: aracbilgiler[0].SasiNo,
                    SaticiAd: aracbilgiler[0].SaticiAd,
                    SaticiTelefon: aracbilgiler[0].SaticiTelefon,
                    SaticiAdres: aracbilgiler[0].SaticiAdres,
                    SaticiKimlikNo: aracbilgiler[0].SaticiKimlikNo,
                    RuhsatSahibi: modal2.find("#ruhsatsahibi-ad").val(),
                    SatisBedeli: modal2.find("#satis-sozlesmesi-satisbedeli").val(),
                    AlinanPara: modal2.find("#satis-sozlesmesi-alinanpara").val(),
                    KalanVade: modal2.find("#satis-sozlesmesi-kalanvade").val(),
                    Not: modal2.find("#satis-sozlesmesi-not").val(),
                    AliciAd: ContactData.Ad,
                    AliciKimlikNo: ContactData.KimlikNo,
                    AliciTelefon: ContactData.BirincilTelefon,
                    AliciAdres: ContactData.BirincilAdres,
                    SahitAd: SahitContactData.Ad,
                    SahitKimlikNo: SahitContactData.KimlikNo,
                    SahitTelefon: SahitContactData.BirincilTelefon,
                    SahitAdres: SahitContactData.BirincilAdres

                });
                window.open("/NZLOto/Yazdir?AracData=" + AracData2, "_blank");
                modal2.modal("hide");
            });



        },
        error: function (jqxhr) {
            console.log(jqxhr);
            noty({
                layout: "center",
                theme: 'relax',
                type: "error",
                text: "Araç Getirilemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                animation: {
                    open: 'animated fadeIn'
                },
                timeout: false,
                killer: true,
                modal: true,
                closeWith: ['click', 'backdrop']
            });
        },
        complete: function () { Remove_FullPagePreload(); }
    });






});




$(document).on("click", ".content-container .arac-listesi .actions .bilgileri-goster", function () {
    if ($(this).attr("durum") == "1") {
        $(this).text("Bilgileri Göster").attr("durum", "0");
        $(".content-container .arac-listesi .gizli-bilgi").hide();
    }
    else {
        $(this).text("Bilgileri Gizle").attr("durum", "1");
        $(".content-container .arac-listesi .gizli-bilgi").show();
    }
});
$(document).on("click", ".content-container .arac-listesi .images img", function () {
    var c = $("<div>").addClass("overlay-image-container"),
        w = $("<div>").addClass("arac-resmi-wrapper"),
        arac = $(".content-container .arac-listesi .detayli-gorunum");
    $(".content-container .arac-listesi").addClass("locked");
    c.prependTo("body");
    c.append(w.append($(this).clone()));
    var next = function () {
        var i = parseInt(w.find("img").attr("image-index"));
        w.empty();
        if (arac.find(".images img[image-index=" + (i + 1) + "]").length) {
            w.append(arac.find(".images img[image-index=" + (i + 1) + "]").clone());
        }
        else
            w.append(arac.find(".images img:first-child").clone());
    };
    var prev = function () {
        var i = w.find("img").attr("image-index");
        w.empty();
        if (arac.find(".images img[image-index=" + (i - 1) + "]").length) {
            w.append(arac.find(".images img[image-index=" + (i - 1) + "]").clone());
        }
        else
            w.append(arac.find(".images img:last-child").clone());
    };
    var close = function () {
        c.remove();
        $(document).off("keydown.ImageOverlay");
        $(".content-container .arac-listesi").addClass("locked");
    };

    $(document).on("keydown.ImageOverlay", function (e) {
        if (e.which == 39) {
            //Sağ ok
            next();
        }
        else if (e.which == 37) {
            //Sol ok
            prev();
        }
        else if (e.which == 27) {
            //Esc
            close();
        }
    });
    c.on("click", function (e) {
        if ($(e.target).is("img")) {
            next();
        }
        else {
            close();
        }
    });
});
$(document).on("click", ".content-container .arac-listesi .header-bar .navigation .goback", function () {
    AracGridNavigation.goback();
});
$(document).on("click", ".content-container .arac-listesi .header-bar .navigation .back", function () {
    AracGridNavigation.back();
});
$(document).on("click", ".content-container .arac-listesi .header-bar .navigation .forward", function () {
    AracGridNavigation.forward();
});
$(document).on("keydown.Araclar", function (e) {
    var araclistesi = $(".content-container .arac-listesi:not(.locked)");
    if (!araclistesi.length) return;

    if (e.which == 39)
        AracGridNavigation.forward();
    else if (e.which == 37)
        AracGridNavigation.back();
    else if (e.which == 38)
        AracGridNavigation.goback();
});
//#endregion

//#region Araç Düzenle
$(document).on("change", ".duzenle-arac #ya-durum", function () {
    var vekalet = $(this).closest(".form-group").next(".form-group");
    if ($(this).val() === "Vekaleten (Vekaleti Alınmış)")
        vekalet.show(300);
    else
        vekalet.hide(300);
});
$(document).on("click", ".duzenle-arac .kisi-kurum-sec", function () {
    var $this = $(this),
        modal = $(".kisi-kurum-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        var span = $this.siblings("span"),
            dxLI = modal.find(".kisi-kurum-lookup").dxLookup("instance");
        span.attr("contact-uid", dxLI.option("value"));
        span.text(dxLI.option("text"));

        modal.modal("hide");
    });
});
$(document).on("click", ".content-container .arac-listesi .actions .bilgileri-düzenle", function () {
    var AracUID = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid");
    var aracduzenle = $(".templates .duzenle-arac-template").clone().removeClass("duzenle-arac-template").addClass("duzenle-arac");
    $(".content-container").empty();
    aracduzenle.appendTo(".content-container");

    $.ajax({
        url: "../../Data/AracAra2",
        type: "post",
        data: { AracUID: AracUID },
        success: function (data) {
            var aracbilgileri = JSON.parse(data);
            $(".duzenle-arac").attr("aracuid", AracUID);
            $(".duzenle-arac #ya-plaka").val(aracbilgileri[0].Plaka);
            $(".duzenle-arac #ya-marka").val(aracbilgileri[0].Marka);
            $(".duzenle-arac #ya-seri").val(aracbilgileri[0].Seri);
            $(".duzenle-arac #ya-model").val(aracbilgileri[0].Model);
            $(".duzenle-arac #ya-renk").val(aracbilgileri[0].Renk);
            $(".duzenle-arac #ya-yil").val(aracbilgileri[0].Yil);
            $(".duzenle-arac #ya-km").val(aracbilgileri[0].KM);
            $(".duzenle-arac #ya-yakit").val(aracbilgileri[0].YakitTipi);
            $(".duzenle-arac #ya-vites").val(aracbilgileri[0].VitesTipi);
            $(".duzenle-arac #ya-kapi").val(aracbilgileri[0].Kapi);
            $(".duzenle-arac #ya-cekis").val(aracbilgileri[0].Cekis),
            $(".duzenle-arac #ya-motor-hacim").val(aracbilgileri[0].MotorHacmi);
            $(".duzenle-arac #ya-motor-guc").val(aracbilgileri[0].MotorGucu);
            $(".duzenle-arac #ya-motor-no").val(aracbilgileri[0].MotorNo);
            $(".duzenle-arac #ya-sasi-no").val(aracbilgileri[0].SasiNo);

            if (aracbilgileri[0].AlinisTarihi == "") {
                $(".duzenle-arac #ya-alinis-tarih").val("");
            }
            else {
                $(".duzenle-arac #ya-alinis-tarih").val(moment(aracbilgileri[0].AlinisTarihi, "YYYY/MM/DD").format("DD.MM.YYYY"));
            }
            $(".duzenle-arac #ya-alinis-fiyat").val(aracbilgileri[0].AlinisFiyati);
            $(".duzenle-arac #ya-liste").val(aracbilgileri[0].Liste);
            $(".duzenle-arac #ya-durum").val(aracbilgileri[0].Durum);
            $(".duzenle-arac #ya-vekalet-bitis").val(aracbilgileri[0].VekaletBitis);
            $(".duzenle-arac #ya-etiket").val(aracbilgileri[0].EtiketFiyati);
            $(".duzenle-arac #ya-anahtar").val(aracbilgileri[0].YedekAnahtar);
            if (aracbilgileri[0].AracMuayeneBitisTarihi == "") {
                $(".duzenle-arac #ya-aracmuayene-tarih").val("");
            }
            else {
                $(".duzenle-arac #ya-aracmuayene-tarih").val(moment(aracbilgileri[0].AracMuayeneBitisTarihi, "YYYY/MM/DD").format("DD.MM.YYYY"));
            }

            if (aracbilgileri[0].AracSigortaBitisTarihi == "") {
                $(".duzenle-arac #ya-sigorta-tarih").val("");
            }
            else {
                $(".duzenle-arac #ya-sigorta-tarih").val(moment(aracbilgileri[0].AracSigortaBitisTarihi, "YYYY/MM/DD").format("DD.MM.YYYY"));
            }

            var span = $(".duzenle-arac #ya-ruhsat");
            span.attr("contact-uid", aracbilgileri[0].RuhsatSahibi);

            if (aracbilgileri[0].RuhsatSahibiType == "Kişi") {

                span.text(aracbilgileri[0].RuhsatSahibiAd + " - " + aracbilgileri[0].RuhsatSahibiKimlikNo);
            }
            else {
                span.text(aracbilgileri[0].RuhsatSahibiAd + " - " + aracbilgileri[0].RuhsatSahibiVergiNo);
            }
            var span = $(".duzenle-arac #ya-satici");
            span.attr("contact-uid", aracbilgileri[0].Satici);

            if (aracbilgileri[0].SaticiType == "Kişi") {

                span.text(aracbilgileri[0].SaticiAd + " - " + aracbilgileri[0].SaticiKimlikNo);
            }
            else {
                span.text(aracbilgileri[0].SaticiAd + " - " + aracbilgileri[0].SaticiVergiNo);
            }




            console.log(aracbilgileri);
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            noty({
                layout: "center",
                theme: 'relax',
                type: "error",
                text: "Araç Getirilemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                animation: {
                    open: 'animated fadeIn'
                },
                timeout: false,
                killer: true,
                modal: true,
                closeWith: ['click', 'backdrop']
            });
        },
        complete: function () { Remove_FullPagePreload(); }
    });

});
$(document).on("click", ".duzenle-arac .actions .kaydet", function () {
    FullPagePreload();


    $.ajax({
        url: "../../Data/AracDuzenle",
        type: "post",
        data: {
            Data: JSON.stringify({
                AracUID: $(".duzenle-arac").attr("aracuid"),
                Plaka: $(".duzenle-arac #ya-plaka").val(),
                Marka: $(".duzenle-arac #ya-marka").val(),
                Seri: $(".duzenle-arac #ya-seri").val(),
                Model: $(".duzenle-arac #ya-model").val(),
                Renk: $(".duzenle-arac #ya-renk").val(),
                Yil: $(".duzenle-arac #ya-yil").val(),
                KM: $(".duzenle-arac #ya-km").val(),
                Yakit: $(".duzenle-arac #ya-yakit").val(),
                Vites: $(".duzenle-arac #ya-vites").val(),
                Kapi: $(".duzenle-arac #ya-kapi").val(),
                Cekis: $(".duzenle-arac #ya-cekis").val(),
                MotorHacim: $(".duzenle-arac #ya-motor-hacim").val(),
                MotorGuc: $(".duzenle-arac #ya-motor-guc").val(),
                MotorNo: $(".duzenle-arac #ya-motor-no").val(),
                SasiNo: $(".duzenle-arac #ya-sasi-no").val(),
                AlinisTarih: $(".duzenle-arac #ya-alinis-tarih").val(),
                AlinisFiyat: $(".duzenle-arac #ya-alinis-fiyat").val(),
                Liste: $(".duzenle-arac #ya-liste").val(),
                Durum: $(".duzenle-arac #ya-durum").val(),
                VekaletBitis: $(".duzenle-arac #ya-vekalet-bitis").val(),
                Etiket: $(".duzenle-arac #ya-etiket").val(),
                Ruhsat: $(".duzenle-arac #ya-ruhsat").attr("contact-uid"),
                Satici: $(".duzenle-arac #ya-satici").attr("contact-uid"),
                YedekAnahtar: $(".duzenle-arac #ya-anahtar").val(),
                AracMuayeneBitisTarihi: $(".duzenle-arac #ya-aracmuayene-tarih").val(),
                AracSigortaBitisTarihi: $(".duzenle-arac #ya-sigorta-tarih").val(),

            })
        },
        success: function (data) {
            console.log(data);
            //#region noty


            AracGoster3(data);


            //#endregion
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            noty({
                layout: "center",
                theme: 'relax',
                type: "error",
                text: "Araç Düzenlenemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                animation: {
                    open: 'animated fadeIn'
                },
                timeout: false,
                killer: true,
                modal: true,
                closeWith: ['click', 'backdrop']
            });
        },
        complete: function () { Remove_FullPagePreload(); }
    });
});
$(document).on("click", ".duzenle-arac .actions .sil", function () {

    var def = $.Deferred();
    DevExpress.ui.dialog.confirm("Bu aracın silinmesine emin misiniz?", "Araç Sil").done(function (silincekmi) {
        if (silincekmi) {

            $.ajax({
                url: "../../Data/AracSil",
                type: "post",
                data: { AracUID: $(".duzenle-arac").attr("aracuid") },
                success: function (data) {
                    var parameters = [];
                    AracAra2(parameters);

                },
                error: function (jqxhr) {
                    console.log(jqxhr);
                    noty({
                        layout: "center",
                        theme: 'relax',
                        type: "error",
                        text: "Araç Silinemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                        animation: {
                            open: 'animated fadeIn'
                        },
                        timeout: false,
                        killer: true,
                        modal: true,
                        closeWith: ['click', 'backdrop']
                    });
                },
                complete: function () { Remove_FullPagePreload(); }
            });

        }
        else {
            def.resolve(false);
        }

    });
    return def;


});
//#endregion


//#region Araç Kayıt
$(document).on("click", ".yeni-arac .kisi-kurum-sec", function () {
    var $this = $(this),
        modal = $(".kisi-kurum-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        var span = $this.siblings("span"),
            dxLI = modal.find(".kisi-kurum-lookup").dxLookup("instance");
        span.attr("contact-uid", dxLI.option("value"));
        span.text(dxLI.option("text"));

        modal.modal("hide");
    });
});
$(document).on("change", ".yeni-arac select", function () {
    $(this).find(".null").remove();
});
$(document).on("change", ".yeni-arac #ya-durum", function () {
    var vekalet = $(this).closest(".form-group").next(".form-group");
    if ($(this).val() === "Vekaleten (Vekaleti Alınmış)")
        vekalet.show(300);
    else
        vekalet.hide(300);
});
$(document).on("click", ".yeni-arac .actions .kaydet", function () {
    FullPagePreload();


    $.ajax({
        url: "../../Data/AracKaydet",
        type: "post",
        data: {
            Data: JSON.stringify({
                Plaka: $(".yeni-arac #ya-plaka").val(),
                Marka: $(".yeni-arac #ya-marka").val(),
                Seri: $(".yeni-arac #ya-seri").val(),
                Model: $(".yeni-arac #ya-model").val(),
                Renk: $(".yeni-arac #ya-renk").val(),
                Yil: $(".yeni-arac #ya-yil").val(),
                KM: $(".yeni-arac #ya-km").val(),
                Yakit: $(".yeni-arac #ya-yakit").val(),
                Vites: $(".yeni-arac #ya-vites").val(),
                Kapi: $(".yeni-arac #ya-kapi").val(),
                Cekis: $(".yeni-arac #ya-cekis").val(),
                MotorHacim: $(".yeni-arac #ya-motor-hacim").val(),
                MotorGuc: $(".yeni-arac #ya-motor-guc").val(),
                MotorNo: $(".yeni-arac #ya-motor-no").val(),
                SasiNo: $(".yeni-arac #ya-sasi-no").val(),
                AlinisTarih: $(".yeni-arac #ya-alinis-tarih").val(),
                AlinisFiyat: $(".yeni-arac #ya-alinis-fiyat").val(),
                Liste: $(".yeni-arac #ya-liste").val(),
                Durum: $(".yeni-arac #ya-durum").val(),
                VekaletBitis: $(".yeni-arac #ya-vekalet-bitis").val(),
                Etiket: $(".yeni-arac #ya-etiket").val(),
                Ruhsat: $(".yeni-arac #ya-ruhsat").attr("contact-uid"),
                Satici: $(".yeni-arac #ya-satici").attr("contact-uid"),
                YedekAnahtar: $(".yeni-arac #ya-anahtar").val(),
                AracMuayeneBitisTarihi: $(".yeni-arac #ya-aracmuayene-tarih").val(),
                AracSigortaBitisTarihi: $(".yeni-arac #ya-sigorta-tarih").val(),

            })
        },
        success: function (data) {
            console.log(data);
            //#region noty


            AracGoster3(data);


            //#endregion
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            noty({
                layout: "center",
                theme: 'relax',
                type: "error",
                text: "Araç kayıt edilemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                animation: {
                    open: 'animated fadeIn'
                },
                timeout: false,
                killer: true,
                modal: true,
                closeWith: ['click', 'backdrop']
            });
        },
        complete: function () { Remove_FullPagePreload(); }
    });
});

function AracGoster3(aracdata) {

    $(".content-container").empty();
    $(".templates .arac-listesi-template").clone().removeClass("arac-listesi-template").addClass("arac-listesi").appendTo(".content-container");
    var RESULT = JSON.parse(aracdata);
    var detay = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid", RESULT[0].AracUID);
    console.log(RESULT[0]);
    $("[nzl-field]").empty();
    $.each(RESULT[0], function (key, val) {

        var field = $("[nzl-field=" + key + "]", detay);
        if (!field.length) {
            return;
        }
        switch (field.attr("nzl-field-type")) {
            default:
                field.text(val);
                break;
            case "FaturaGoster":
                if (val == "") {
                    $(".content-container .arac-listesi .detayli-gorunum .FaturaGoster").hide();
                }
                else {
                    field.text(val);
                }
            case "number":
                field.text(val.BasamakGrupla());
                break;
            case "tl":
                if (val == "") {
                    field.text("");
                } else {
                    field.text(val.BasamakGrupla() + " ₺");
                }
                break;
            case "date":
                if (val == "") {
                    field.text("");
                } else {
                    field.text(moment(val, "YYYY/MM/DD").format("DD.MM.YYYY"));
                }
                break;
            case "array":
                field.html(val.toString().replace(",", "<br/>"));
                break;
            case "image":
                if (val.length == 0) {
                    field.text("Resim Bulunamadı.");
                } else {
                    for (var j = 0; j < val.length; j++) {
                        field.append("<img class='ResimResim' adres='" + val[j] + "' src='../../Data/AracResimleri/{0}/{1}' image-index='{2}' />".format(RESULT[0].AracUID, val[j], j));
                    }
                }
                break;
            case "bool":
            case "boolean":
                if (!!val && (val == true || val == "True" || val == "true" || val == 1)) {
                    field.text("Var");
                    if (key == "Opsiyon") {
                        $(".content-container [nzl-field=OpsiyonTarihi], .content-container [nzl-field=OpsiyonKoyan]").parent().show();
                        $(".content-container .arac-listesi .actions .opsiyon-koy").text("Opsiyon Kaldır");
                    }
                }

                else {
                    field.text("Yok");
                    if (key == "Opsiyon") {
                        $(".content-container [nzl-field=OpsiyonTarihi], .content-container [nzl-field=OpsiyonKoyan]").parent().hide();
                        $(".content-container .arac-listesi .actions .opsiyon-koy").text("Opsiyon Koy");
                    }
                }

                break;
        }
    });
    detay.find("h3").text("{0} - {1} {2} {3}".format(RESULT[0].Plaka, RESULT[0].Marka, RESULT[0].Seri, RESULT[0].Model));

    detay.show();

    $(".content-container .arac-listesi .actions .resim-ekle").off("click").on("click", function () {
        var upload = $("<input>").attr({ type: "file", accept: "image/png,image/gif,image/jpg,image/jpeg", multiple: true }),
            aracid = RESULT[0].AracUID
        upload.trigger("click");
        upload.on("change", function (e) {
            var data = new FormData();
            $.each(e.target.files, function (key, val) {
                data.append("Resim" + key, val);
            });
            data.append("AracID", aracid);
            $.ajax({
                url: "../../Data/AracResimEkle",
                type: "post",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                beforeSend: function () { FullPagePreload(); },
                success:
                    function (data) {
                        try {
                            var response = JSON.parse(data);
                            console.log(response);
                        } catch (e) {
                            console.log(data);
                            console.log(e);
                            return;
                        }
                        //Resimleri dataya ekle


                        $.each(response, function (i, v) {

                            RESULT[0].Resimler.push(v);

                        });



                        AracGoster3(JSON.stringify(RESULT));
                    },
                error:
                    function (jqxhr) {
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
                        console.log(jqxhr);
                    },
                complete:
                    function () {
                        Remove_FullPagePreload();
                        upload.remove();
                    }
            });
        });
    });

    $(".ResimResim").off("contextmenu").on("contextmenu", function (e) {
        e.preventDefault();
        var Adres = $(this).attr("Adres");
        var silinecekresim = $(this);

        var AracUID = $(".content-container .arac-listesi .detayli-gorunum").attr("arac-uid");
        var def = $.Deferred();
        DevExpress.ui.dialog.confirm("Bu resimin silinmesine emin misiniz?", "Resim Sil").done(function (sil) {
            if (sil) {

                $.ajax({

                    url: "../../Data/AracResimSil",
                    type: "post",
                    data: {
                        AracUID: AracUID,
                        ResimAdi: Adres
                    },
                    beforeSend: FullPagePreload,
                    success: function (data) {
                        def.resolve(true);

                        noty({
                            layout: "topRight",
                            theme: 'relax',
                            type: "information",
                            text: "Resim Listeden Silindi.",
                            dismissQueue: true,
                            animation: {
                                open: 'animated bounceInRight',
                                close: 'animated bounceOutRight'
                            },
                            maxVisible: 10,
                            timeout: 5000
                        });
                        silinecekresim.remove();


                        RESULT[0].Resimler.splice(silinecekresim.attr("image-index"), 1);
                        AracGoster3(JSON.stringify(RESULT));



                    },
                    error: function (jqxhr) {
                        console.log(jqxhr);
                        def.resolve(false);
                        noty({
                            layout: "center",
                            theme: 'relax',
                            type: "error",
                            text: "Resim Silinemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
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
                    complete: Remove_FullPagePreload
                });
            }
            else
                def.resolve(false);
        });
        return def;

    });

}


//#endregion

//#region Kişi-Kurum Seç
$(document).on("show.bs.modal", ".kisi-kurum-sec.modal", function (e) {
    var modal = $(this);

    //Temizle - Default duruma getir
    modal.find(".secili-iletisim-bilgileri table tr td:nth-child(2)").empty();
    modal.find(".secili-iletisim-bilgileri table tr").filter(".vergi-dairesi, .kimlik-no, .vergi-no").removeClass("visible");

    //İletişim listesini al ve dxLookup oluştur
    $.ajax({
        url: "../../Data/IletisimBilgisiAl",
        type: "post",
        beforeSend:
            function () { FullPagePreload(); },
        error:
            function (jqxhr) {
                modal.find(".modal-feedback").append(Alert("danger", "İletişim Bilgileri Alınamadı! Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü."));
                console.log(jqxhr);
                modal.modal("handleUpdate");
            },
        success:
            function (data) {
                try {
                    var kisi_kurum_list = JSON.parse(data);
                } catch (e) {
                    console.log(data);
                    return;
                }
                modal.find(".kisi-kurum-lookup").dxLookup({
                    cancelButtonText: "İptal",
                    clearButtonText: "Temizle",
                    dataSource: new DevExpress.data.DataSource({
                        store: kisi_kurum_list,
                        key: "ContactUID",

                        sort: "Ad",
                        paginate: true,
                        pageSize: 20

                    }),
                    displayExpr: function (itemData) { return !!itemData ? itemData.Ad + " - " + (itemData["KimlikNo"] || itemData["VergiNo"]) : ""; },

                    noDataText: "No Data",
                    onValueChanged: function (e) {
                        //Temizle - Default duruma getir
                        modal.find(".secili-iletisim-bilgileri table tr td:nth-child(2)").empty();
                        modal.find(".secili-iletisim-bilgileri table tr").filter(".vergi-dairesi, .kimlik-no, .vergi-no").removeClass("visible");

                        if (!e.itemData || Object.keys(e.itemData).indexOf("items") > -1) return;

                        var table = modal.find(".secili-iletisim-bilgileri table");
                        table.find(".tip td:nth-child(2)").text(e.itemData["Type"]);
                        table.find(".ad td:nth-child(2)").text(e.itemData["Ad"]);
                        table.find(".birincil-adres td:nth-child(2)").text(e.itemData["BirincilAdres"]);
                        table.find(".birincil-telefon td:nth-child(2)").text(e.itemData["BirincilTelefon"]);
                        $.each(e.itemData["Adresler"], function (i, val) {
                            if (i > 0)
                                table.find(".adres td:nth-child(2)").append("<br />");
                            table.find(".adres td:nth-child(2)").append($("<span>").text(val));
                        });
                        $.each(e.itemData["Telefonlar"], function (i, val) {
                            if (i > 0)
                                table.find(".telefon td:nth-child(2)").append("<br />");
                            table.find(".telefon td:nth-child(2)").append($("<span>").text(val));
                        });
                        table.find(".iletisim-not td:nth-child(2)").html(e.itemData["IletisimNot"].replace(/\r?\n/g, "</br>"));

                        if (e.itemData["Type"] == "Kişi") {
                            table.find(".kimlik-no").addClass("visible").find("td:nth-child(2)").text(e.itemData["KimlikNo"]);
                        }
                        else if (e.itemData["Type"] == "Kurum") {
                            table.find(".vergi-dairesi").addClass("visible").find("td:nth-child(2)").text(e.itemData["VergiDairesi"]).addClass("visible");
                            table.find(".vergi-no").addClass("visible").find("td:nth-child(2)").text(e.itemData["VergiNo"]).addClass("visible");
                        }
                    },
                    pageLoadingText: "Yükleniyor...",
                    placeholder: "Seç",
                    searchExpr: ["Ad", "KimlikNo", "VergiNo"],
                    searchPlaceholder: "Ara (Ad, Kimlik No, Vergi No)",
                    showClearButton: true,
                    pageLoadingText: "Yükleniyor...",
                    refreshingText: "Yenileniyor...",
                    pageLoadMode: "scrollBottom",
                    showPopupTitle: false,
                    value: null,
                    valueExpr: "ContactUID"
                });
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
});

$(document).on("click", ".kisi-kurum-sec.modal .btn.ekle", function () {
    var smodal = $(this).closest(".modal"),
        emodal = $(".kisi-kurum-ekle.modal").modal("show");
    emodal.find(".btn.kaydet").off("click").on("click", function () {
        emodal.find(".modal-feedback").empty();
        var telefonlar = [];
        emodal.find(".telefonlar input.telefon").each(function (i, el) {
            if ($(this).val().length)
                telefonlar.push($(this).val());
        });
        var adresler = [];
        emodal.find(".adresler input.adres").each(function (i, el) {
            if ($(this).val().length)
                adresler.push($(this).val());
        });

        if (emodal.find("#kisi-kurum-ekle-ad").val() == "") {
            emodal.find("#kisi-kurum-ekle-ad").focus();
            var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(emodal.find("#kisi-kurum-ekle-ad").parent(".input-group").length ? emodal.find("#kisi-kurum-ekle-ad").parent() : emodal.find("#kisi-kurum-ekle-ad")).show(200);
            setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
            return;
            emodal.find(".modal-feedback").append(Alert("danger", "KimlikNo Boş Geçilemez"));
        }
        else if (emodal.find("#kisi-kurum-ekle-tip").val() == "Kişi" && emodal.find("#kisi-kurum-ekle-kimlik-no").val() == "") {

            emodal.find("#kisi-kurum-ekle-kimlik-no").focus();
            var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(emodal.find("#kisi-kurum-ekle-kimlik-no").parent(".input-group").length ? emodal.find("#kisi-kurum-ekle-kimlik-no").parent() : emodal.find("#kisi-kurum-ekle-kimlik-no")).show(200);
            setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
            return;
        }
        else {
            $.ajax({
                url: "../../Data/IletisimBilgisiKaydet",
                type: "post",
                data: {
                    Data: JSON.stringify({
                        Ad: emodal.find("#kisi-kurum-ekle-ad").val(),
                        Type: emodal.find("#kisi-kurum-ekle-tip").val(),
                        KimlikNo: emodal.find("#kisi-kurum-ekle-kimlik-no").val(),
                        VergiDairesi: emodal.find("#kisi-kurum-ekle-vergi-dairesi").val(),
                        VergiNo: emodal.find("#kisi-kurum-ekle-vergi-no").val(),
                        BirincilAdres: emodal.find("#kisi-kurum-ekle-birincil-adres").val(),
                        Adresler: adresler,
                        BirincilTelefon: emodal.find("#kisi-kurum-ekle-birincil-telefon").val(),
                        Telefonlar: telefonlar,
                        IletisimNot: emodal.find("#kisi-kurum-ekle-iletisim-not").val(),
                    })
                },
                beforeSend:
                    function () { FullPagePreload(); },
                error:
                    function (jqxhr) {
                        if (jqxhr.responseText.length)
                            emodal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                        else
                            emodal.find(".modal-feedback").append(Alert("danger", "Kayıt Başarısız! Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü."));
                    },
                success:
                    function (data) {

                        try {
                            var kisi_bilgisi = JSON.parse(data);
                            console.log(kisi_bilgisi);
                        } catch (e) {
                            console.error(e);
                            console.log(data);
                            return;
                        }
                        console.log(kisi_bilgisi.Kontrol);
                        if (kisi_bilgisi.Kontrol == "1") {
                            emodal.find(".modal-feedback").append(Alert("danger", "Bu Tc Kimlik Numarası Başkasına Kayıtlıdır."));
                        }
                        else if (kisi_bilgisi.Kontrol == "2") {
                            emodal.find(".modal-feedback").append(Alert("danger", "Bu Vergi Numarası Başkasına Kayıtlıdır."));
                        }
                        else {

                            emodal.modal("hide");

                            var dxLI = smodal.find(".kisi-kurum-lookup").dxLookup("instance");
                            dxLI.option("dataSource").store().insert(kisi_bilgisi);
                            dxLI.option("dataSource").load().done(function () {
                                dxLI.option("value", kisi_bilgisi["ContactUID"]);
                                smodal.find(".btn.sec").trigger("click");
                            });

                            //#region noty
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: kisi_bilgisi.Ad + " iletişim bilgileri eklendi.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });
                            //#endregion
                        }

                    },
                complete:
                    function () { Remove_FullPagePreload(); }
            });

        }

    });
});
$(document).on("click", ".kisi-kurum-sec.modal .btn.duzenle", function () {
    var smodal = $(this).closest(".modal"),
        lookup = smodal.find(".kisi-kurum-lookup").dxLookup("instance"),
        info = lookup.option("selectedItem");

    KisiKurumDuzenle(info).done(function (kisi_bilgileri) {
        lookup.option("dataSource").store().remove(info).done(function () {
            lookup.option("dataSource").store().insert(kisi_bilgileri).done(function () {
                lookup.option("dataSource").load().done(function () {
                    lookup.reset();
                    lookup.option("value", kisi_bilgileri["ContactUID"]);
                });
            });
        });
    });
});
//#endregion

//#region Kişi-Kurum Ekle / Düzenle
$(document).on("show.bs.modal", ".kisi-kurum-ekle.modal", function (e) {
    var modal = $(this);
    modal.find(".modal-feedback").empty();
    modal.find(".telefon-kaldir").closest(".input-group").remove();
    modal.find(".adres-kaldir").closest(".input-group").remove();
    modal.find("#kisi-kurum-ekle-tip").val("Kişi");
    modal.find(".vergi-dairesi, .vergi-no").removeClass("visible");
    modal.find("input").val("");
});

$(document).on("change", ".kisi-kurum-ekle.modal #kisi-kurum-ekle-tip", function () {
    var modal = $(this).closest(".modal");
    if ($(this).val() == "Kişi") {
        modal.find(".vergi-dairesi, .vergi-no").removeClass("visible").find("input").val("");
        modal.find(".kimlik-no").addClass("visible").find("input").val("");
    }
    else if ($(this).val() == "Kurum") {
        modal.find(".kimlik-no").removeClass("visible").find("input").val("");
        modal.find(".vergi-dairesi, .vergi-no").addClass("visible").find("input").val("");
    }
});

$(document).on("click", ".kisi-kurum-ekle.modal .telefon-kaldir", function () {
    $(this).closest(".input-group").remove();
});
$(document).on("click", ".kisi-kurum-ekle.modal .telefon-ekle", function () {
    var thisgroup = $(this).closest(".input-group"),
        newgroup = $("<div>").addClass("input-group");

    var emptyinput = thisgroup.siblings(".input-group").addBack().find("input").filter(function (i, el) { return $(this).val() == "" });
    if (emptyinput.length) {
        emptyinput.eq(0).focus();
        return;
    }
    newgroup.append($("<input>").addClass("form-control telefon").attr({ type: "text", id: "kisi-kurum-ekle-telefon" }));
    newgroup.append($("<span>").addClass("input-group-btn").append($("<button>").addClass("btn btn-default telefon-ekle").append($("<i>").addClass("glyphicon glyphicon-plus"))));
    newgroup.insertBefore(thisgroup);
    newgroup.find("input").focus();

    thisgroup.find("input").removeAttr("id");
    thisgroup.find("button").removeClass("telefon-ekle").addClass("telefon-kaldir").children("i").removeClass("glyphicon-plus").addClass("glyphicon-minus");
});

$(document).on("click", ".kisi-kurum-ekle.modal .adres-kaldir", function () {
    $(this).closest(".input-group").remove();
});
$(document).on("click", ".kisi-kurum-ekle.modal .adres-ekle", function () {
    var thisgroup = $(this).closest(".input-group"),
        newgroup = $("<div>").addClass("input-group");

    var emptyinput = thisgroup.siblings(".input-group").addBack().find("input").filter(function (i, el) { return $(this).val() == "" });
    if (emptyinput.length) {
        emptyinput.eq(0).focus();
        return;
    }

    newgroup.append($("<input>").addClass("form-control adres uppercase").attr({ type: "text", id: "kisi-kurum-ekle-adres" }));
    newgroup.append($("<span>").addClass("input-group-btn").append($("<button>").addClass("btn btn-default adres-ekle").append($("<i>").addClass("glyphicon glyphicon-plus"))));
    newgroup.insertBefore(thisgroup);
    newgroup.find("input").focus();

    thisgroup.find("input").removeAttr("id");
    thisgroup.find("button").removeClass("adres-ekle").addClass("adres-kaldir").children("i").removeClass("glyphicon-plus").addClass("glyphicon-minus");
});

function KisiKurumDuzenle_FromContactUID(ContactUID) {
    var def = $.Deferred();

    $.ajax({
        url: "../../Data/IletisimBilgisiAl",
        data: { Data: JSON.stringify({ ContactUid: ContactUID }) },
        type: "post",
        beforeSend:
            function () { FullPagePreload(); },
        error:
            function (jqxhr) {
                modal.find(".modal-feedback").append(Alert("danger", "İletişim Bilgileri Alınamadı! Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü."));
                console.log(jqxhr);
                modal.modal("handleUpdate");
            },
        success:
            function (data) {
                try {
                    var info = JSON.parse(data);
                    info = info[0];
                } catch (e) {
                    console.log(e);
                    console.log(data);
                    return;
                }
                KisiKurumDuzenle(info).done(function (r) { def.resolve(r) });
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });

    return def.promise();
}
function KisiKurumDuzenle(info) {
    if (!info)
        return;

    var def = $.Deferred();
    var modal = $(".kisi-kurum-ekle.modal").modal("show");
    modal.find("#kisi-kurum-ekle-tip").val(info.Type).trigger("change");
    modal.find("#kisi-kurum-ekle-ad").val(info.Ad);
    modal.find("#kisi-kurum-ekle-kimlik-no").val(info.KimlikNo);
    modal.find("#kisi-kurum-ekle-vergi-dairesi").val(info.VergiDairesi);
    modal.find("#kisi-kurum-ekle-vergi-no").val(info.VergiNo);
    modal.find("#kisi-kurum-ekle-birincil-telefon").val(info.BirincilTelefon);
    $.each(info.Telefonlar, function (i, tel) {
        if (i == 0) {
            modal.find(".telefonlar #kisi-kurum-ekle-telefon").val(tel);
        }
        else {
            var ig = $("<div>").addClass("input-group");
            ig.append($("<input>").addClass("form-control telefon").attr("type", "text").val(tel));
            ig.append($("<span>").addClass("input-group-btn").append($("<button>").addClass("btn btn-default telefon-kaldir").append($("<i>").addClass("glyphicon glyphicon-minus"))));
            modal.find(".telefonlar > div").append(ig);
        }
    });
    modal.find("#kisi-kurum-ekle-birincil-adres").val(info.BirincilAdres);
    $.each(info.Adresler, function (i, adres) {
        if (i == 0) {
            modal.find(".adresler #kisi-kurum-ekle-adres").val(adres);
        }
        else {
            var ig = $("<div>").addClass("input-group");
            ig.append($("<input>").addClass("form-control adres uppercase").attr("type", "text").val(adres));
            ig.append($("<span>").addClass("input-group-btn").append($("<button>").addClass("btn btn-default adres-kaldir").append($("<i>").addClass("glyphicon glyphicon-minus"))));
            modal.find(".adresler > div").append(ig);
        }
    });
    modal.find("#kisi-kurum-ekle-iletisim-not").val(info.IletisimNot);

    modal.find(".btn.kaydet").off("click").on("click", function () {
        modal.find(".modal-feedback").empty();
        var telefonlar = [];
        modal.find(".telefonlar input.telefon").each(function (i, el) {
            if ($(this).val().length)
                telefonlar.push($(this).val());
        });
        var adresler = [];
        modal.find(".adresler input.adres").each(function (i, el) {
            if ($(this).val().length)
                adresler.push($(this).val());
        });
        if (modal.find("#kisi-kurum-ekle-ad").val() == "") {
            modal.find("#kisi-kurum-ekle-ad").focus();
            var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(modal.find("#kisi-kurum-ekle-ad").parent(".input-group").length ? modal.find("#kisi-kurum-ekle-ad").parent() : modal.find("#kisi-kurum-ekle-ad")).show(200);
            setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
            return;
            modal.find(".modal-feedback").append(Alert("danger", "KimlikNo Boş Geçilemez"));
        }
        else if (modal.find("#kisi-kurum-ekle-tip").val() == "Kişi" && modal.find("#kisi-kurum-ekle-kimlik-no").val() == "") {

            modal.find("#kisi-kurum-ekle-kimlik-no").focus();
            var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(modal.find("#kisi-kurum-ekle-kimlik-no").parent(".input-group").length ? modal.find("#kisi-kurum-ekle-kimlik-no").parent() : modal.find("#kisi-kurum-ekle-kimlik-no")).show(200);
            setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
            return;
        }
        else {
            $.ajax({
                url: "../../Data/IletisimBilgisiDuzenle",
                type: "post",
                data: {
                    Data: JSON.stringify({
                        ContactUID: info.ContactUID,
                        Ad: modal.find("#kisi-kurum-ekle-ad").val(),
                        Type: modal.find("#kisi-kurum-ekle-tip").val(),
                        KimlikNo: modal.find("#kisi-kurum-ekle-kimlik-no").val(),
                        VergiDairesi: modal.find("#kisi-kurum-ekle-vergi-dairesi").val(),
                        VergiNo: modal.find("#kisi-kurum-ekle-vergi-no").val(),
                        BirincilAdres: modal.find("#kisi-kurum-ekle-birincil-adres").val(),
                        Adresler: adresler,
                        BirincilTelefon: modal.find("#kisi-kurum-ekle-birincil-telefon").val(),
                        Telefonlar: telefonlar,
                        IletisimNot: modal.find("#kisi-kurum-ekle-iletisim-not").val()
                    })
                },
                beforeSend: FullPagePreload,
                error:
                    function (jqxhr) {
                        if (jqxhr.responseText.length)
                            modal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                        else
                            modal.find(".modal-feedback").append(Alert("danger", "Kayıt Başarısız! Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü."));
                    },
                success:
                    function (data) {
                        try {
                            var kisi_bilgisi = JSON.parse(data);
                        } catch (e) {
                            console.error(e);
                            console.log(data);
                            def.resolve(data);
                            return;
                        }

                        console.log(kisi_bilgisi.Kontrol);
                        if (kisi_bilgisi.Kontrol == "1") {
                            modal.find(".modal-feedback").append(Alert("danger", "Bu Tc Kimlik Numarası Başkasına Kayıtlıdır."));
                        }
                        else if (kisi_bilgisi.Kontrol == "2") {
                            modal.find(".modal-feedback").append(Alert("danger", "Bu Vergi Numarası Başkasına Kayıtlıdır."));
                        }
                        else {
                            modal.modal("hide");
                            //#region noty
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: kisi_bilgisi.Ad + " iletişim bilgileri eklendi.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });
                            //#endregion
                        }
                        def.resolve(kisi_bilgisi);
                    },
                complete: Remove_FullPagePreload
            });
        }
    });

    return def.promise();
}

//Genereal iletisim duzenle button
$(document).on("click", ".iletisim-duzenle", function () {
    KisiKurumDuzenle_FromContactUID($(this).attr("iletisim-id"));
});
//#endregion

//#region Giriş Kısayolları
$(document).on("click", ".ana-giris .kisayol-box", function () {
    $(".left-menu-container li." + $(this).attr("o-target")).trigger("click");
});
//#endregion

$(document).on("click", ".left-menu-container li.anaekranadon", function () {
    var anaekran = $(".templates .ana-giris-template").clone().removeClass("ana-giris-template").addClass("ana-giris");
    $(".content-container").empty();
    anaekran.appendTo(".content-container");
});

//#region Giderler
$(document).on("click", ".left-menu-container li.gidergir", function () {
    var maliyetgirekran = $(".templates .gider-gir-template").clone().removeClass("gider-gir-template").addClass("gider-gir");
    $(".content-container").empty();
    maliyetgirekran.appendTo(".content-container");
});
$(document).on("change", ".gider-gir .gider-tipi", function () {
    var container = $(this).closest(".container-fluid");
    $(this).find(".null").remove();

    if ($(this).val() == "Araç Maliyeti") {
        //Arac Maliyeti Tipi Selecbox ekle
        $("<div>").addClass("input-group")
            .append($("<span>").addClass("input-group-addon").text("Maliyet Tipi"))
            .append(
                $("<select>").addClass("form-control arac-maliyeti-tipi required")
                    .append($("<option>").text("Diğer"))
                    .append($("<option>").text("Mekanik"))
                    .append($("<option>").text("Kaporta-Boya"))
                    .append($("<option>").text("Yıkama"))
            )
        .insertAfter($(this).closest(".input-group"));

        $("<div>").addClass("input-group")
            .append($("<span>").addClass("input-group-addon").text("Araç"))
            .append($("<select>").addClass("form-control arac-maliyeti-arac-id required"))
        .insertAfter(container.find(".arac-maliyeti-tipi").closest(".input-group"));

        $.ajax({
            url: "../../Data/AracAra",
            type: "post",
            data: {
                Data: JSON.stringify({ Durum: "Eldeki Araç", OrderBy: "Plaka" })
            },
            beforeSend:
                function () { FullPagePreload(); },
            success:
                function (data) {
                    try {
                        var arac_list = JSON.parse(data);
                    } catch (e) {
                        console.log(data);
                        return;
                    }
                    var aracselect = container.find(".arac-maliyeti-arac-id");
                    arac_list.forEach(function (val, i, arr) {
                        aracselect.append($("<option>").val(val.ID).text(val.Plaka + " - " + val.Marka + " " + val.Seri + " " + val.Model));
                    });
                },
            error:
                function (jqxhr) {
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
                    console.log(jqxhr);
                },
            complete:
                function () { Remove_FullPagePreload(); }
        });
    } else {
        //Arac Maliyeti Tipi Selecbox kaldır
        container.find(".arac-maliyeti-tipi").closest(".input-group").remove();
        container.find(".arac-maliyeti-arac-id").closest(".input-group").remove();
    }

    //Yoksa inputları ekle
    if (!container.find(".gider-aciklama").length) {
        $("<div>").addClass("input-group")
            .append($("<span>").addClass("input-group-addon").text("Açıklama"))
            .append($("<input>").addClass("form-control gider-aciklama").attr("type", "text"))
        .appendTo($(this).closest(".container-fluid"));
    }

    if (!container.find(".gider-gider").length) {
        $("<div>").addClass("input-group")
            .append($("<span>").addClass("input-group-addon").text("Gider"))
            .append($("<input>").addClass("form-control gider-gider required").attr("type", "text"))
            .append($("<span>").addClass("input-group-addon").append("<i class='fa fa-turkish-lira'></i>"))
        .appendTo($(this).closest(".container-fluid"));
    }

    if (!container.find(".gider-tarih").length) {
        $("<div>").addClass("input-group")
            .append($("<span>").addClass("input-group-addon").text("Tarih"))
            .append($("<input>").addClass("form-control gider-tarih tarih required").attr("type", "text").mask("99/99/9999").val(Date.now().getShortDate()))
        .appendTo($(this).closest(".container-fluid"));
    }

    //Yoksa butonu ekle
    if (!container.find("button.kaydet").length) {
        $("<button>").text("Kaydet").addClass("btn btn-primary kaydet pull-right").appendTo($(this).closest(".container-fluid"));
    }
});
$(document).on("click", ".gider-gir button.kaydet", function () {
    var emptyreq = $(".gider-gir .required").filter(function (i, el) { return $(this).val().length < 1 });
    if (emptyreq.length) {
        emptyreq.eq(0).focus();
        var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(emptyreq.eq(0).closest(".input-group")).show(200);
        setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
        return;
    }

    $.ajax({
        url: "../../Data/GiderKaydet",
        type: "post",
        data: {
            Data: JSON.stringify({
                GiderTipi: $(".gider-gir .gider-tipi").val(),
                AracMaliyetTipi: $(".gider-gir .arac-maliyeti-tipi").val(),
                AracID: $(".gider-gir .arac-maliyeti-arac-id").val(),
                Aciklama: $(".gider-gir .gider-aciklama").val(),
                Gider: $(".gider-gir .gider-gider").val(),
                Tarih: $(".gider-gir .gider-tarih").val()
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
                        text: "Gider başarıyla kaydedildi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                } else {
                    console.log(data);
                }
            },
        error:
            function (jqxhr) {
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
                console.log(jqxhr);
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
});

$(document).on("click", ".left-menu-container li.aylikgider", function () {
    var aylikgider = $(".templates .aylik-gider-tablosu-template").clone().removeClass("aylik-gider-tablosu-template").addClass("aylik-gider-tablosu");
    $(".content-container").empty();
    aylikgider.appendTo(".content-container");
    aylikgider.find(".ay-yil .ay option[value=" + Date.now().getMonth() + "]").prop("selected", true);
    aylikgider.find(".ay-yil .yil").val(new Date().getFullYear());

    $.ajax({
        url: "../../Data/GiderAl",
        type: "post",
        data: {
            Data: JSON.stringify({
                Tarih_min: "01." + aylikgider.find(".ay-yil .ay").val() + "." + aylikgider.find(".ay-yil .yil").val(),
                Tarih_max: new Date(aylikgider.find(".ay-yil .yil").val(), parseInt(aylikgider.find(".ay-yil .ay").val()), 0).getTime().getShortDate()
            })
        },
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {
                var giderler = JSON.parse(data);
                $(".aylik-gider-tablosu .aylik-tablo").dxDataGrid({
                    columnAutoWidth: true,
                    columns: [
                        {
                            dataField: "GiderTipi",
                            caption: "Gider Tipi",
                            lookup: {
                                dataSource: ["Araç Maliyeti", "Dükkan Gideri", "Faaliyet Dışı Gider"],
                                allowClearing: true
                            }
                        },
                        {
                            dataField: "AracMaliyetTipi",
                            caption: "Araç Maliyet Tipi",
                            lookup: {
                                dataSource: ["Diğer", "Mekanik", "Kaporta-Boya", "Yıkama"],
                                allowClearing: true
                            }
                        },
                        {
                            dataField: "Plaka",
                            caption: "Plaka"
                        },
                        {
                            dataField: "Marka",
                            caption: "Araç"
                        },
                        {
                            dataField: "Gider",
                            caption: "Gider",
                            dataType: "number"
                        },
                        {
                            dataField: "Aciklama",
                            caption: "Açıklama"
                        },
                        {
                            dataField: "Tarih",
                            caption: "Tarih"
                        }
                    ],
                    summary: {
                        totalItems: [
                            {
                                column: "Gider",
                                summaryType: "sum",
                                customizeText:
                                    function (data) {
                                        var val = data.value.BasamakGrupla();
                                        return "Toplam : " + val + " ₺";
                                    }
                            }
                        ],
                        groupItems: [
                            {
                                column: "Gider",
                                summaryType: "sum",
                                customizeText:
                                    function (data) {
                                        var val = data.value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");
                                        return "Toplam : " + val + " ₺";
                                    },
                                showInGroupFooter: true
                            }
                        ]
                    },
                    dataSource: giderler,
                    hoverStateEnabled: true,
                    rowAlternationEnabled: true,
                    onRowPrepared:
                        function (ev) {
                            ev.rowElement.attr("gider-tipi", ev.data.GiderTipi);
                            if (ev.data.AracID != "" && ev.data.AracID != null)
                                ev.rowElement.attr("arac-id", ev.data.AracID);
                        },
                    onCellPrepared:
                        function (info) {
                            if (info.column.dataField == "Marka") {
                                info.cellElement.text(info.data.Marka + " " + info.data.Seri + " " + info.data.Model);
                            }
                        },
                    groupPanel: {
                        visible: true,
                        emptyPanelText: "Gruplandırmak için sütun başlığını buraya sürükleyin"
                    },
                    grouping: {
                        autoExpandAll: false
                    },
                    filterRow: {
                        visible: true,
                        showOperationChooser: true,
                        resetOperationText: "Sıfırla",
                        applyFilterText: "Filtreyi Uygula",
                        showAllText: "(Hepsi)",
                        operationDescriptions: {
                            '=': 'Eşit',
                            '<>': 'Eşit Değil',
                            '<': 'Küçük',
                            '<=': 'Küçük-Eşit',
                            '>': 'Büyük',
                            '>=': 'Büyük-Eşit',
                            'startswith': 'ile Başlayan',
                            'contains': 'İçinde Geçen',
                            'notcontains': 'İçinde Geçmeyen',
                            'endswith': 'ile Biten'
                        }
                    },
                    searchPanel: {
                        visible: true,
                        placeholder: "Ara..."
                    },
                    sorting: {
                        ascendingText: "Artan",
                        descendingText: "Azalan",
                        clearText: "Temizle"
                    },
                    loadPanel: {
                        text: "Hazırlanıyor..."
                    }
                });
            },
        error:
            function (jqxhr) {
                noty({
                    layout: "center",
                    theme: 'relax',
                    type: "error",
                    text: "Aylık Giderler Alınamadı! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                    dismissQueue: true,
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: false,
                    killer: true,
                    modal: true,
                    closeWith: ['click', 'backdrop']
                });
                console.log(jqxhr);
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
});
$(document).on("click", ".aylik-gider-tablosu .filtrele", function () {
    var aylikgider = $(".aylik-gider-tablosu");

    var ay = aylikgider.find(".ay-yil .ay").val(),
        yil = aylikgider.find(".ay-yil .yil").val();

    $.ajax({
        url: "../../Data/GiderAl",
        type: "post",
        data: {
            Data: JSON.stringify({
                Tarih_min: "01." + ay + "." + yil,
                Tarih_max: new Date(yil, parseInt(ay), 0).getTime().getShortDate()
            })
        },
        beforeSend:
            function () { FullPagePreload(); },
        success:
            function (data) {
                var giderler = JSON.parse(data);
                $(".aylik-gider-tablosu .aylik-tablo").dxDataGrid("instance").option("dataSource", giderler);
            },
        error:
            function (jqxhr) {
                noty({
                    layout: "center",
                    theme: 'relax',
                    type: "error",
                    text: "Aylık Giderler Alınamadı! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                    dismissQueue: true,
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: false,
                    killer: true,
                    modal: true,
                    closeWith: ['click', 'backdrop']
                });
                console.log(jqxhr);
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
});


//#region document ready
$(document).ready(function () {
    kasafoyugetir();
    //#region contextmenu
    $.contextMenu({
        selector: ".aylik-gider-tablosu .dx-data-row[gider-tipi='Araç Maliyeti']",
        items: {
            detayli_liste: {
                name: "Araç Detaylarına Git",
                callback:
                    function () {
                        AracAra({ Arac_Uid: $(this).attr("arac-id") }, 0);
                    }
            }
        }
    });
    //#endregion
  
    //#region Klavye Hareketi
    $(document).keydown(function (e) {

        var kasafoyu = jQuery(".kasa-foyu");
        //#region KasaFoyu Giriş 
        if (e.which === 71 && e.altKey && e.ctrlKey && kasafoyu.hasClass("kasa-foyu")) {
            if (!$(".kasa-foyu").hasClass("Giris")) {
              
                    KasaFoyu_TabloOlustur(kasa_data);
                    kasafoyu.removeClass("Cikis");
                    kasafoyu.addClass("Giris");
                    kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append("<tr>");
                    kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Fiyat").addClass("form-control sayi")));
                    kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Açıklama").addClass("form-control aciklama")));
                    kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append("</tr>");
                    $(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .sayi").focus();
                
               

            }
        }
        //#endregion
        //#region KasaFoyu Çıkış
        if (e.which === 67 && e.altKey && e.ctrlKey && kasafoyu.hasClass("kasa-foyu")) {
            if (!$(".kasa-foyu").hasClass("Cikis")) {
                
                    KasaFoyu_TabloOlustur(kasa_data);
                    kasafoyu.removeClass("Giris");
                    kasafoyu.addClass("Cikis");
                    kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append("<tr>");
                    kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Fiyat").addClass("form-control sayi")));
                    kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Açıklama").addClass("form-control aciklama")));
                    kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append("</tr>");
                    $(".kasa-foyu .kasa-gider .kasa-foyu-tablo .sayi").focus();
               
              
            }
        }
        //#endregion
        //#region KasaFoyu Enter
        if (e.which === 13) {
            //#region Giriş if
            if (kasafoyu.hasClass("Giris") && kasafoyu.hasClass("kasa-foyu")) {


                if ($(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .sayi").val() == "" && $(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .aciklama").val() == "") {
                    kasafoyu.removeClass("Giris");
                    KasaFoyu_TabloOlustur(kasa_data);

                }
                else if ($(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .sayi").val() == "") {
                    kasafoyu.removeClass("Giris");
                    KasaFoyu_TabloOlustur(kasa_data);

                }
                else if ($(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .aciklama").val() == "") {
                    kasafoyu.removeClass("Giris");
                    KasaFoyu_TabloOlustur(kasa_data);

                }
                else {

                    //#region KasafoyuKaydet
                    $.ajax({
                        url: "../../Data/KasaFoyuGir",
                        type: "post",
                        data: {
                            Data: JSON.stringify({
                                Tip: "Giriş",
                                Miktar: $(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .sayi").val(),
                                ParaBirimi: "TR",
                                Aciklama: $(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .aciklama").val(),
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

                                    kasafoyugetir().done(function (datas) {
                                        console.log(datas);
                                        if (datas.length > 0) {
                                            KasaFoyu_TabloOlustur(datas);
                                            kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append("<tr>");
                                            kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Fiyat").addClass("form-control sayi")));
                                            kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Açıklama").addClass("form-control aciklama")));
                                            kasafoyu.find(".kasa-gelir .kasa-foyu-tablo").append("</tr>");
                                            $(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .sayi").focus();
                                        }
                                        return;
                                    });
                                }
                                else if (data == "Lütfen giriş yapın.") {

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
                    //#endregion
                }
            }

            //#endregion
            //#region Çıkış if
            if (kasafoyu.hasClass("Cikis") && kasafoyu.hasClass("kasa-foyu")) {
                if ($(".kasa-foyu .kasa-gider .kasa-foyu-tablo .sayi").val() == "" && $(".kasa-foyu .kasa-gider .kasa-foyu-tablo .aciklama").val() == "") {
                    kasafoyu.removeClass("Cikis");
                    KasaFoyu_TabloOlustur(kasa_data);

                }
                else if ($(".kasa-foyu .kasa-gider .kasa-foyu-tablo .sayi").val() == "") {
                    kasafoyu.removeClass("Cikis");
                    KasaFoyu_TabloOlustur(kasa_data);
                }
                else if ($(".kasa-foyu .kasa-gider .kasa-foyu-tablo .aciklama").val() == "") {
                    kasafoyu.removeClass("Cikis");
                    KasaFoyu_TabloOlustur(kasa_data);
                }
                else {

                    //#region KasafoyuKaydet
                    $.ajax({
                        url: "../../Data/KasaFoyuGir",
                        type: "post",
                        data: {
                            Data: JSON.stringify({
                                Tip: "Çıkış",
                                Miktar: $(".kasa-foyu .kasa-gider .kasa-foyu-tablo .sayi").val(),
                                ParaBirimi: "TR",
                                Aciklama: $(".kasa-foyu .kasa-gider .kasa-foyu-tablo .aciklama").val(),
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

                                    kasafoyugetir().done(function (datas) {
                                        KasaFoyu_TabloOlustur(datas);
                                        kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append("<tr>");
                                        kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Fiyat").addClass("form-control sayi")));
                                        kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append($("<td>").append($("<input>").attr("type", "text").attr("placeholder", "Açıklama").addClass("form-control aciklama")));
                                        kasafoyu.find(".kasa-gider .kasa-foyu-tablo").append("</tr>");
                                        $(".kasa-foyu .kasa-gider .kasa-foyu-tablo .sayi").focus();
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
                                modal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                                console.log(jqxhr);
                                modal.modal("handleUpdate");
                            },
                        complete:
                            function () { Remove_FullPagePreload(); }
                    });
                    //#endregion
                }
            }
            //#endregion

        }
        //#endregion
        //#region KasaFoyu ESC
        if (e.which === 27 && kasafoyu.hasClass("kasa-foyu")) {
            //#region Giriş if
            if (kasafoyu.hasClass("Giris")) {


                if ($(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .sayi").val() == "" && $(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .aciklama").val() == "") {
                    kasafoyu.removeClass("Giris");
                    KasaFoyu_TabloOlustur(kasa_data);

                }
                else if ($(".kasa-foyu .kasa-gelir .kasa-foyu-tablo .sayi").val() == "") {
                    kasafoyu.removeClass("Giris");
                    KasaFoyu_TabloOlustur(kasa_data);

                }
                else {
                    kasafoyu.removeClass("Giris");
                     KasaFoyu_TabloOlustur(kasa_data);

                }

            }

            //#endregion
            //#region Çıkış if
            if (kasafoyu.hasClass("Cikis")) {
                if ($(".kasa-foyu .kasa-gider .kasa-foyu-tablo .sayi").val() == "" && $(".kasa-foyu .kasa-gider .kasa-foyu-tablo .aciklama").val() == "") {
                    kasafoyu.removeClass("Cikis");
                    KasaFoyu_TabloOlustur(kasa_data);

                }
                else if ($(".kasa-foyu .kasa-gider .kasa-foyu-tablo .sayi").val() == "") {
                    kasafoyu.removeClass("Cikis");
                    KasaFoyu_TabloOlustur(kasa_data);
                }
                else {
                    kasafoyu.removeClass("Cikis");
                    KasaFoyu_TabloOlustur(kasa_data);
                }

            }
            //#endregion

        }
        //#endregion

    });

});

//#endregion
//#endregion
function AracSatisYap(AracID, AracBilgileri) {
    if (AracID == null || AracBilgileri == null)
        return alert("Eksik bilgi.");
    var modal = $(".satis-yap.modal").modal("show");
    modal.attr("arac-id", AracID);
    modal.data("AracBilgileri", AracBilgileri);

    modal.find(".durum").text(AracBilgileri.Durum);
    modal.find(".giris-durumu").text(AracBilgileri.GirisDurumu);
    modal.find(".arac").text(AracBilgileri.Marka + " " + AracBilgileri.Seri + " " + AracBilgileri.Model);
    modal.find(".plaka").text(AracBilgileri.Plaka);
    modal.find(".belirlenen-satis-fiyati").text(AracBilgileri.BelirlenenSatisFiyati.BasamakGrupla() + " ₺");

    modal.find("#arac-satis-satis-fiyati").val(AracBilgileri.BelirlenenSatisFiyati);
    modal.find("#arac-satis-satis-tarihi").val(Date.now().getShortDate());
}
$(document).on("hidden.bs.modal", ".satis-yap.modal", function () {
    $(this).removeAttr("arac-id");
    $(this).find("input").val("");
    $(this).find("#arac-satis-alici").empty().attr("iletisim-id", "");
    $(this).find(".row div:nth-child(2)").empty();
});
$(document).on("click", ".satis-yap.modal .btn.kaydet", function () {
    var modal = $(this).closest(".modal");
    var emptyreq = modal.find(".required").filter(function (i, el) { return $(this).val().length <= 0 });
    if (!modal.find("#arac-satis-alici").attr("iletisim-id")) {
        emptyreq = emptyreq.add(modal.find("#arac-satis-alici"));
    }
    if (emptyreq.length) {
        emptyreq.eq(0).focus();
        var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(emptyreq.eq(0).hasClass("required") ? emptyreq.eq(0).parent() : emptyreq.eq(0)).show(200);
        setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
        return;
    }

    $.ajax({
        url: "../../Data/AracSatisYap",
        type: "post",
        data: {
            Data: JSON.stringify({
                AracID: modal.attr("arac-id"),
                AliciID: modal.find("#arac-satis-alici").attr("iletisim-id"),
                SatisFiyati: modal.find("#arac-satis-satis-fiyati").val(),
                SatisTarihi: modal.find("#arac-satis-satis-tarihi").val(),
                NoterDevirTarihi: modal.find("#arac-satis-noter-devir-tarihi").val(),
                ResmiSatisFiyati: modal.find("#arac-satis-resmi-satis-fiyati").val()
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
                        text: "Araç Satışı başarıyla kaydedildi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                } else {
                    console.log(data);
                }

                modal.modal("hide");
            },
        error:
            function (jqxhr) {
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
                console.log(jqxhr);
            },
        complete:
            function () { Remove_FullPagePreload(); }
    });
});
$(document).on("click", ".satis-yap.modal .alici-sec", function () {
    var $this = $(this),
        modal = $(".kisi-kurum-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        var span = $this.siblings("#arac-satis-alici"),
            dxLI = modal.find(".kisi-kurum-lookup").dxLookup("instance");
        span.attr("iletisim-id", dxLI.option("value"));
        span.text(dxLI.option("text"));

        modal.modal("hide");
    });
});


$(document).on("click", ".foot-bar-container #full-screen", function () {
    var requestMethod = document.body.requestFullScreen || document.body.webkitRequestFullScreen || document.body.mozRequestFullScreen || document.body.msRequestFullscreen;

    if (requestMethod) { // Native full screen.
        requestMethod.call(document.body);
    }
    else if (typeof window.ActiveXObject !== "undefined") { // Older IE.
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript !== null) {
            wscript.SendKeys("{F11}");
        }
    }
});
$(document).on("click", ".foot-bar-container #panic-button", function () {
    $.get("../../Data/PanicButton");
});

//#region Araç Seç
$(document).on("show.bs.modal", ".arac-sec.modal", function () {
    var modal = $(this),
        arac_list;

    if (modal.data("AracList")) {
        arac_list = modal.data("AracList");
    } else {
        var parameters = [];

        $.ajax({
            url: "../../Data/AracAra",
            type: "post",
            async: false,
            data: {
                Data: JSON.stringify(parameters)
            },
            beforeSend:
                function () { FullPagePreload(); },
            success:
                function (data) {
                    try {
                        arac_list = JSON.parse(data);
                    } catch (e) {
                        console.log(data);
                        return;
                    }
                    modal.find(".arac-sec-lookup").dxLookup({
                        cancelButtonText: "İptal",
                        clearButtonText: "Temizle",
                        dataSource: new DevExpress.data.DataSource({
                            store: arac_list,
                            key: "AracUID",
                            group: "Liste",
                            sort: "Marka"
                        }),
                        displayExpr: function (itemData) { return !!itemData ? itemData.Plaka + " - " + itemData.Marka + "  " + itemData["Seri"] + "  " + itemData["Model"] : ""; },
                        grouped: true,
                        noDataText: "No Data",
                        onValueChanged: function (e) {
                            //Temizle - Default duruma getir

                            if (!e.itemData || Object.keys(e.itemData).indexOf("items") > -1) return;

                            var table = modal.find(".secili-iletisim-bilgileri table");
                            table.find(".plaka td:nth-child(2)").text(e.itemData["Plaka"]);
                            table.find(".marka td:nth-child(2)").text(e.itemData["Marka"]);
                            table.find(".seri td:nth-child(2)").text(e.itemData["Seri"]);
                            table.find(".model td:nth-child(2)").text(e.itemData["Model"]);
                            table.find(".alinis-tarih td:nth-child(2)").text(e.itemData["AlinisTarihi"]);


                        },
                        pageLoadingText: "Yükleniyor...",
                        placeholder: "Seç",
                        searchExpr: ["Marka", "Model", "Seri"],
                        searchPlaceholder: "Ara (Marka, Model, Seri)",
                        showClearButton: true,
                        showPopupTitle: false,
                        value: null,
                        valueExpr: "AracUID"
                    });
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

});

//#endregion

//#region Senet Defteri
var SenetProfil_DS;
var senetdatam;
function Senet_ProfilDetaylariGoruntule(Index) {
    console.log(Index);
    /// <param name="Profil" type="Int">Gösterilecek kişinin listedeki index numarası</param>
    var profilData = $(".senet-defteri .senet-profil-list .dx-scrollview-content .dx-list-item").eq(Index).find(".profil-item").data("profilData"),
        $profil = $(".senet-defteri .profil-bilgileri");
    console.log(profilData);
    if (!profilData) return false;

    //Loader göster ve işlem sonuçlarını takip etmek için deferred objelerini oluştur
    var d1 = $.Deferred(), d3 = $.Deferred(), d4 = $.Deferred();
    FullPagePreload();

    //Riskleri gir
    $.post("../../Data/RisklerVeLimitAl", { ContactUID: profilData.ContactUID }, function (data) {
        try {
            var risk = JSON.parse(data);
        } catch (e) {
            console.log(e);
            console.log(data);
            return;
        }
        var rc = $(".senet-defteri .senet-bloklari .senetriskler");
        rc.find(".senet").text(risk.SenetRiski.BasamakGrupla());
        rc.find(".cek").text(risk.CekRiski.BasamakGrupla());
        rc.find(".toplam").text(risk.ToplamRisk.BasamakGrupla());
        rc.find(".limit").text(!risk.RiskLimit ? "Tanımsız" : risk.RiskLimit.BasamakGrupla());
        $(".senet-defteri .cek-list .cek-riski span").text(risk.CekRiski.BasamakGrupla());
    }).always(function () { d1.resolve(); });

    //profil bilgilerini doldur
    $profil.empty();
    $profil = $profil.prepend("<table><tbody></tbody></table>").find("tbody");
    if (profilData.Type == "Kişi") {
        $profil.append($("<tr>").append("<td><span>Ad Soyad</span><span class='iletisim-duzenle' iletisim-id='{0}'></span></td>".format(profilData.ContactUID)).append("<td>" + profilData.Ad + "</td>"));
        $profil.append($("<tr>").append("<td><span>TC Kimlik No</span></td>").append("<td>" + profilData.KimlikNo + "</td>"));
    } else if (profilData.Type == "Kurum") {
        $profil.append($("<tr>").append("<td><span>Ad</span></td>").append("<td>" + profilData.Ad + "</td>"));
        $profil.append($("<tr>").append("<td><span>Vergi Dairesi</span></td>").append("<td>" + profilData.VergiDairesi + "</td>"));
        $profil.append($("<tr>").append("<td><span>Vergi No</span></td>").append("<td>" + profilData.VergiNo + "</td>"));
    }
    $profil.append($("<tr>").append("<td><span>Birincil Telefon</span></td>").append("<td>{0}</td>".format(profilData.BirincilTelefon)));
    $profil.append($("<tr>").append("<td><span>Birincil Adres</span></td>").append("<td>{0}</td>".format(profilData.BirincilAdres)));

    /* Telefonlar ve Adresler
    var tel_td = $("<td>");
    $profil.append($("<tr>").append("<td><span>Telefon</span></td>").append(tel_td));
    $.each(profilData.Telefonlar, function (i, val) {
        if (i > 0)
            tel_td.append("<br />");
        tel_td.append($("<span>").text(val));
    });
    var adr_td = $("<td>");
    $profil.append($("<tr>").append("<td><span>Adres</span></td>").append(adr_td));
    $.each(profilData.Adresler, function (i, val) {
        if (i > 0)
            adr_td.append("<br />");
        adr_td.append($("<span>").text(val));
    });
    */
    if (profilData.SenetNot.ReplaceNewlineTobr() == "") {
        $profil.append($("<tr>").append("<td><span>Not</span><i class='fa fa-pencil-square-o not-edit'></i></td>").append("<td>" + profilData.SenetNot.ReplaceNewlineTobr() + "</td>"));
    } else {
        $profil.append($("<tr>").css({ "outline": "1px solid limegreen" }).append("<td><span>Not</span><i class='fa fa-pencil-square-o not-edit'></i></td>").append("<td>" + profilData.SenetNot.ReplaceNewlineTobr() + "</td>"));
    }

    $profil.closest(".profil-bilgileri").attr("contact-uid", profilData.ContactUID);
    $(".senet-defteri .senet-bloklari").attr("profil-index", Index);

    $(".senet-defteri .senet-profil").hide();
    $(".senet-defteri .senet-bloklari").show();


    //Blokları Al ve Çiz
    $.ajax({
        url: "../../Data/SenetBlokAl",
        type: "post",
        data: { Borclu: profilData.ContactUID },
        success:
            function (data) {
                try {
                    var senetler = JSON.parse(data);
                   
                } catch (e) {
                    console.log(data);
                    return;
                }
                console.log(senetler);
                var bloklar = {};
                for (var i = 0; i < senetler.length; i++) {
                    if (Object.keys(bloklar).indexOf(senetler[i].SenetBlokID) == -1)
                        bloklar[senetler[i].SenetBlokID] = [];
                    bloklar[senetler[i].SenetBlokID].push(senetler[i]);
                }

                $(".senet-defteri .senet-bloklari-list .body").empty();
                var ind = 1;
                $.each(bloklar, function (key, blok) {

                    var table = $("<table>"),
                       blokB = $("<div>"),
                       editRow = $("<div>").addClass("control-buttons"),
                       editbutton = $("<button>").addClass("btn btn-default senet-blok-edit edit-mode").appendTo(editRow);
                    $(".senet-defteri .senet-bloklari-list .body").append($("<div>").addClass("senet-blok-panel-wrapper col-md-12").attr("senet-blok-id", blok[0]["SenetBlokID"]).append($("<div>").addClass("senet-blok-panel clearfix").append(table).append(blokB).append(editRow)));
                    blokB.addClass("senet-blok-bilgileri clearfix");
                    table.addClass("senet-table").append($("<thead>").append($("<tr>")
                        .append("<th>No</th>")
                        .append("<th>Tarih</th>")
                        .append("<th>Miktar</th>")
                        .append("<th>Ödenen</th>")
                        .append("<th>Kalan</th>")
                        .append("<th>Not</th>")
                    ));
                    var tbody = $("<tbody>").appendTo(table);
                    var tmiktar = todenen = tkalan = 0;
                    $.each(blok, function (i, senet) {
                        var $tr = $("<tr>");
                        $tr.appendTo(tbody);

                        $tr
                            .append($("<td>").text(senet["SenetBlokNo"]).addClass("senet-no"))
                            .append($("<td>").text(moment(senet["OdemeTarihi"], "YYYY/MM/DD").format("DD.MM.YYYY")))
                            .append($("<td>").text(senet["Miktar"].BasamakGrupla()).addClass("symbol-TL"))
                            .append($("<td>").text(senet["Odenen"].BasamakGrupla()).addClass("symbol-TL"))
                            .append($("<td>").text(senet["Kalan"].BasamakGrupla()).addClass("symbol-TL"))
                            .append($("<td>").text(senet["SenetNot"]).addClass("senet-not"))
                            .addClass(parseInt(senet["Kalan"]) <= 0 ? "odenmis-senet" : (parseInt(senet["Kalan"]) >= parseInt(senet["Miktar"]) ? "" : "kismen-odenmis-senet"))
                            .addClass(moment(senet["OdemeTarihi"], "YYYY/MM/DD").isBefore(moment(), "day") && parseInt(senet["Kalan"]) > 0 ? "tarihi-gecmis-senet" : "")
                            .attr({ "senet-id": senet["SenetID"] });

                        //toplamları duzenle
                        tmiktar += parseInt(senet["Miktar"]);
                        todenen += parseInt(senet["Odenen"]);
                        tkalan += parseInt(senet["Kalan"]);
                    });
                    var tfoot = $("<tfoot>").appendTo(table);
                    tfoot.append("<tr>").find("tr")
                        .append("<td>")
                        .append("<td>")
                        .append("<td class='symbol-TL'>{0}</td>".format(tmiktar.BasamakGrupla()))
                        .append("<td class='symbol-TL'>{0}</td>".format(todenen.BasamakGrupla()))
                        .append("<td class='symbol-TL'>{0}</td>".format(tkalan.BasamakGrupla()))
                        .append("<td>");


                    var div1 = $("<div>").append($("<table>").append("<tr>", "<tr>", "<tr>", "<tr>")),
                        div2 = $("<div>").append($("<table>").append("<tr>", "<tr>", "<tr>", "<tr>", "<tr>", "<tr>")),
                        div3 = $("<div>").append($("<table>").append("<tr>"));
                    div1.find("table tr:nth-child(1)").append($("<td>").text("Seneti İmzalayan").append(!blok[0]["SenetiImzalayan"] ? "" : "<span class='iletisim-duzenle' iletisim-id='{0}'></span>".format(blok[0]["SenetiImzalayan"]))).append($("<td>").text(!blok[0]["SenetiImzalayanAdi"] ? "---" : blok[0]["SenetiImzalayanAdi"]));
                    div1.find("table tr:nth-child(2)").append($("<td>").text("İmzlayan Telefonu")).append($("<td>").text(blok[0]["SenetiImzalayanTelefon"]));
                    div1.find("table tr:nth-child(3)").append($("<td>").text("Kefil Adı").append(!blok[0]["Kefil"] ? "" : "<span class='iletisim-duzenle' iletisim-id='{0}'></span>".format(blok[0]["Kefil"]))).append($("<td>").text(!blok[0]["KefilAdi"] ? "---" : blok[0]["KefilAdi"]).attr("kefil-id", blok[0]["Kefil"])).addClass("Kefil");
                    div1.find("table tr:nth-child(4)").append($("<td>").text("Kefil Telefonu")).append($("<td>").text(blok[0]["KefilTelefon"]));

                    /* Kefil Telefonları
                    div1.find("table tr:nth-child(2)").append($("<td>").text("Kefil Telefonları")).append($("<td>")).addClass("KefilTelefon");
                    $.each(blok[0]["KefilTelefonlari"], function (i, tel) {
                        if (i > 0)
                            div1.find("table tr:nth-child(2) td:nth-child(2)").append("<br/>");
                        div1.find("table tr:nth-child(2) td:nth-child(2)").append($("<span>").text(tel));
                    });
                    */

                    /* Seneti İmzalayan Telefonları
                    div1.find("table tr:nth-child(4)").append($("<td>").text("İmzalayan Telefonları")).append($("<td>"));
                    $.each(blok[0]["SenetiImzalayanTelefonlari"], function (i, tel) {
                        if (i > 0)
                            div1.find("table tr:nth-child(4) td:nth-child(2)").append("<br/>");
                        div1.find("table tr:nth-child(4) td:nth-child(2)").append($("<span>").text(tel));
                    });
                    */


                    div2.find("table tr:nth-child(1)").append($("<td>").text("Alacak Tipi")).append($("<td>").text(blok[0]["AlacakTipi"])).addClass("AlacakTipi");
                    div2.find("table tr:nth-child(2)").append($("<td>").text("Ana Para")).append($("<td>").text(blok[0]["AnaPara"] == "" ? "" : blok[0]["AnaPara"].BasamakGrupla() + " ₺"));
                    div2.find("table tr:nth-child(3)").append($("<td>").text("Vade Oranı")).append($("<td>").text(blok[0]["VadeOrani"]));
                    div2.find("table tr:nth-child(4)").append($("<td>").text("Senet Oluşturulma Tarihi")).append($("<td>").text(blok[0]["SenetOlusturulmaTarihi"]));
                    div2.find("table tr:nth-child(5)").append($("<td>").text("Araç Plakası")).append($("<td>").text(blok[0]["AracPlakasi"]));
                    div2.find("table tr:nth-child(6)").append($("<td>").text("Araç Başlığı")).append($("<td>").text(blok[0]["AracBasligi"]));


                    if (blok[0]["SenetBlokNot"].ReplaceNewlineTobr() == "") {
                        div3.find("table tr").append($("<td>").text("Notlar").append('<i class="fa fa-pencil-square-o not-edit"></i>').data("senet-blok-not", blok[0]["SenetBlokNot"])).append($("<td>").html(blok[0]["SenetBlokNot"].ReplaceNewlineTobr()));

                    }
                    else {
                        div3.css({ "outline": "1px solid limegreen" }).find("table tr").append($("<td>").text("Notlar").append('<i class="fa fa-pencil-square-o not-edit"></i>').data("senet-blok-not", blok[0]["SenetBlokNot"])).append($("<td>").html(blok[0]["SenetBlokNot"].ReplaceNewlineTobr()));
                    }


                    blokB.append(div1).append(div2).append(div3);

                    if (ind % 2 == 0) $(".senet-defteri .senet-bloklari-list .body").append($("<div>").addClass("clearfix").css("margin", "10px"));
                    ind++;
                });
                $(".senet-defteri .senet-bloklari").data("SenetBloklari", bloklar);
            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
            },
        complete: function () { d3.resolve(); }
    });

    //Çekleri temizle
    $(".senet-defteri .senet-bloklari .cek-list .cek-table").empty();
    //Çekleri Al ve Çiz
    $.ajax({
        url: "../../Data/CekAl",
        type: "post",
        data: { CekAlinanKisi: profilData.ContactUID },
        success:
            function (data) {
                try {
                    var ceklist = JSON.parse(data);
                } catch (e) {
                    console.log(data);
                    return;
                }
                //cek yoksa boş bırak
                if (!ceklist.length) return;

                //table header oluştur
                var $th = $("<tr>");
                $(".senet-defteri .senet-bloklari .cek-list .cek-table").append("<thead>").children("thead").append($th);
                $th
                    .append($("<th>").text("Tarih"))
                    .append($("<th>").text("Miktar"))
                    .append($("<th>").text("Çekin Asıl Sahibi"))
                    .append($("<th>").text("Banka"))
                    .append($("<th>").text("Banka Şubesi"))
                    .append($("<th>").text("Çek No"))
                    .append($("<th>").text("Takasta Old. Hesap"))
                    .append($("<th>").text("Not"));

                //cekleri göster
                $.each(ceklist, function (i, cek) {
                    var $tr = $("<tr>");
                    $tr
                        .append($("<td>").text(moment(cek["Tarih"], "YYYY/MM/DD").format("DD.MM.YYYY")))
                        .append($("<td>").text(cek["Miktar"].BasamakGrupla()).addClass("symbol-TL"))
                        .append($("<td>").text(cek["CekAsilSahibi"]))
                        .append($("<td>").text(cek["Banka"]))
                        .append($("<td>").text(cek["BankaSubesi"]))
                        .append($("<td>").text(cek["CekNo"]))
                        .append($("<td>").text(cek["TakastaOlduguHesap"]))
                        .append($("<td>").text(cek["CekNot"]))
                        .attr("cek-id", cek["CekID"])
                        .appendTo(".senet-defteri .senet-bloklari .cek-list .cek-table");
                });
            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
            },
        complete: function () { d4.resolve(); }
    });

    //remove loader when all deferreds are resolved
    $.when(d1, d3, d4).always(Remove_FullPagePreload);
    return true;
}

function Senet_ProfilDetaylariGoruntule2(data) {
    senetdatam = data;



    $(".content-container").empty();
    $(".templates .senet-defteri-template").clone().removeClass("senet-defteri-template").addClass("senet-defteri").addClass("asd").appendTo(".content-container");
    /// <param name="Profil" type="Int">Gösterilecek kişinin listedeki index numarası</param>
    var profilData = JSON.parse(data),
        $profil = $(".senet-defteri .profil-bilgileri");


    $(".content-container .senet-defteri .senet-bloklari .header-bar .navigation").hide();

    if (!profilData[0]) return false;

    //Loader göster ve işlem sonuçlarını takip etmek için deferred objelerini oluştur
    var d1 = $.Deferred(), d3 = $.Deferred(), d4 = $.Deferred();
    FullPagePreload();

    //Riskleri gir
    $.post("../../Data/RisklerVeLimitAl", { ContactUID: profilData[0].ContactUID }, function (data) {
        try {
            var risk = JSON.parse(data);
        } catch (e) {
            console.log(e);
            console.log(data);
            return;
        }
        var rc = $(".senet-defteri .senet-bloklari .senetriskler");
        rc.find(".senet").text(risk.SenetRiski.BasamakGrupla());
        rc.find(".cek").text(risk.CekRiski.BasamakGrupla());
        rc.find(".toplam").text(risk.ToplamRisk.BasamakGrupla());
        rc.find(".limit").text(!risk.RiskLimit ? "Tanımsız" : risk.RiskLimit.BasamakGrupla());
        $(".senet-defteri .cek-list .cek-riski span").text(risk.CekRiski.BasamakGrupla());
    }).always(function () { d1.resolve(); });

    //profil bilgilerini doldur
    $profil.empty();
    $profil = $profil.prepend("<table><tbody></tbody></table>").find("tbody");
    if (profilData[0].Type == "Kişi") {
        $profil.append($("<tr>").append("<td><span>Ad Soyad</span><span class='iletisim-duzenle' iletisim-id='{0}'></span></td>".format(profilData[0].ContactUID)).append("<td>" + profilData[0].Ad + "</td>"));
        $profil.append($("<tr>").append("<td><span>TC Kimlik No</span></td>").append("<td>" + profilData[0].KimlikNo + "</td>"));
    } else if (profilData[0].Type == "Kurum") {
        $profil.append($("<tr>").append("<td><span>Ad</span></td>").append("<td>" + profilData[0].Ad + "</td>"));
        $profil.append($("<tr>").append("<td><span>Vergi Dairesi</span></td>").append("<td>" + profilData[0].VergiDairesi + "</td>"));
        $profil.append($("<tr>").append("<td><span>Vergi No</span></td>").append("<td>" + profilData[0].VergiNo + "</td>"));
    }
    $profil.append($("<tr>").append("<td><span>Birincil Telefon</span></td>").append("<td>{0}</td>".format(profilData[0].BirincilTelefon)));
    $profil.append($("<tr>").append("<td><span>Birincil Adres</span></td>").append("<td>{0}</td>".format(profilData[0].BirincilAdres)));

    /* Telefonlar ve Adresler
    var tel_td = $("<td>");
    $profil.append($("<tr>").append("<td><span>Telefon</span></td>").append(tel_td));
    $.each(profilData.Telefonlar, function (i, val) {
        if (i > 0)
            tel_td.append("<br />");
        tel_td.append($("<span>").text(val));
    });
    var adr_td = $("<td>");
    $profil.append($("<tr>").append("<td><span>Adres</span></td>").append(adr_td));
    $.each(profilData.Adresler, function (i, val) {
        if (i > 0)
            adr_td.append("<br />");
        adr_td.append($("<span>").text(val));
    });
    */
    if (profilData[0].SenetNot.ReplaceNewlineTobr() == "") {
        $profil.append($("<tr>").append("<td><span>Not</span><i class='fa fa-pencil-square-o not-edit'></i></td>").append("<td>" + profilData[0].SenetNot.ReplaceNewlineTobr() + "</td>"));
    } else {
        $profil.append($("<tr>").css({ "outline": "1px solid limegreen" }).append("<td><span>Not</span><i class='fa fa-pencil-square-o not-edit'></i></td>").append("<td>" + profilData[0].SenetNot.ReplaceNewlineTobr() + "</td>"));
    }

    $profil.closest(".profil-bilgileri").attr("contact-uid", profilData[0].ContactUID);
    $(".senet-defteri .senet-bloklari").attr("profil-index", profilData[0].ListIndex);

    $(".senet-defteri .senet-profil").hide();
    $(".senet-defteri .senet-bloklari").show();

    //Blokları Al ve Çiz
    $.ajax({
        url: "../../Data/SenetBlokAl",
        type: "post",
        data: { Borclu: profilData[0].ContactUID },
        success:
            function (data) {
                try {
                    var senetler = JSON.parse(data);
                } catch (e) {
                    console.log(e);
                    return;
                }
                console.log(senetler);
                var bloklar = {};
                for (var i = 0; i < senetler.length; i++) {
                    if (Object.keys(bloklar).indexOf(senetler[i].SenetBlokID) == -1)
                        bloklar[senetler[i].SenetBlokID] = [];
                    bloklar[senetler[i].SenetBlokID].push(senetler[i]);
                }

                $(".senet-defteri .senet-bloklari-list .body").empty();
                var ind = 1;
                $.each(bloklar, function (key, blok) {

                    var table = $("<table>"),
                       blokB = $("<div>"),
                       editRow = $("<div>").addClass("control-buttons"),
                       editbutton = $("<button>").addClass("btn btn-default senet-blok-edit edit-mode").appendTo(editRow);
                    $(".senet-defteri .senet-bloklari-list .body").append($("<div>").addClass("senet-blok-panel-wrapper col-md-12").attr("senet-blok-id", blok[0]["SenetBlokID"]).append($("<div>").addClass("senet-blok-panel clearfix").append(table).append(blokB).append(editRow)));
                    blokB.addClass("senet-blok-bilgileri clearfix");
                    table.addClass("senet-table").append($("<thead>").append($("<tr>")
                        .append("<th>No</th>")
                        .append("<th>Tarih</th>")
                        .append("<th>Miktar</th>")
                        .append("<th>Ödenen</th>")
                        .append("<th>Kalan</th>")
                        .append("<th>Not</th>")
                    ));
                    var tbody = $("<tbody>").appendTo(table);
                    var tmiktar = todenen = tkalan = 0;
                    $.each(blok, function (i, senet) {
                        var $tr = $("<tr>");
                        $tr.appendTo(tbody);

                        $tr
                            .append($("<td>").text(senet["SenetBlokNo"]).addClass("senet-no"))
                            .append($("<td>").text(moment(senet["OdemeTarihi"], "YYYY/MM/DD").format("DD.MM.YYYY")))
                            .append($("<td>").text(senet["Miktar"].BasamakGrupla()).addClass("symbol-TL"))
                            .append($("<td>").text(senet["Odenen"].BasamakGrupla()).addClass("symbol-TL"))
                            .append($("<td>").text(senet["Kalan"].BasamakGrupla()).addClass("symbol-TL"))
                            .append($("<td>").text(senet["SenetNot"]).addClass("senet-not"))
                            .addClass(parseInt(senet["Kalan"]) <= 0 ? "odenmis-senet" : (parseInt(senet["Kalan"]) >= parseInt(senet["Miktar"]) ? "" : "kismen-odenmis-senet"))
                            .addClass(moment(senet["OdemeTarihi"], "YYYY/MM/DD").isBefore(moment(), "day") && parseInt(senet["Kalan"]) > 0 ? "tarihi-gecmis-senet" : "")
                            .attr({ "senet-id": senet["SenetID"] });

                        //toplamları duzenle
                        tmiktar += parseInt(senet["Miktar"]);
                        todenen += parseInt(senet["Odenen"]);
                        tkalan += parseInt(senet["Kalan"]);
                    });
                    var tfoot = $("<tfoot>").appendTo(table);
                    tfoot.append("<tr>").find("tr")
                        .append("<td>")
                        .append("<td>")
                        .append("<td class='symbol-TL'>{0}</td>".format(tmiktar.BasamakGrupla()))
                        .append("<td class='symbol-TL'>{0}</td>".format(todenen.BasamakGrupla()))
                        .append("<td class='symbol-TL'>{0}</td>".format(tkalan.BasamakGrupla()))
                        .append("<td>");


                    var div1 = $("<div>").append($("<table>").append("<tr>", "<tr>", "<tr>", "<tr>")),
                        div2 = $("<div>").append($("<table>").append("<tr>", "<tr>", "<tr>", "<tr>", "<tr>", "<tr>")),
                        div3 = $("<div>").append($("<table>").append("<tr>"));
                    div1.find("table tr:nth-child(1)").append($("<td>").text("Seneti İmzalayan").append(!blok[0]["SenetiImzalayan"] ? "" : "<span class='iletisim-duzenle' iletisim-id='{0}'></span>".format(blok[0]["SenetiImzalayan"]))).append($("<td>").text(!blok[0]["SenetiImzalayanAdi"] ? "---" : blok[0]["SenetiImzalayanAdi"]));
                    div1.find("table tr:nth-child(2)").append($("<td>").text("İmzlayan Telefonu")).append($("<td>").text(blok[0]["SenetiImzalayanTelefon"]));
                    div1.find("table tr:nth-child(3)").append($("<td>").text("Kefil Adı").append(!blok[0]["Kefil"] ? "" : "<span class='iletisim-duzenle' iletisim-id='{0}'></span>".format(blok[0]["Kefil"]))).append($("<td>").text(!blok[0]["KefilAdi"] ? "---" : blok[0]["KefilAdi"]).attr("kefil-id", blok[0]["Kefil"])).addClass("Kefil");
                    div1.find("table tr:nth-child(4)").append($("<td>").text("Kefil Telefonu")).append($("<td>").text(blok[0]["KefilTelefon"]));

                    /* Kefil Telefonları
                    div1.find("table tr:nth-child(2)").append($("<td>").text("Kefil Telefonları")).append($("<td>")).addClass("KefilTelefon");
                    $.each(blok[0]["KefilTelefonlari"], function (i, tel) {
                        if (i > 0)
                            div1.find("table tr:nth-child(2) td:nth-child(2)").append("<br/>");
                        div1.find("table tr:nth-child(2) td:nth-child(2)").append($("<span>").text(tel));
                    });
                    */

                    /* Seneti İmzalayan Telefonları
                    div1.find("table tr:nth-child(4)").append($("<td>").text("İmzalayan Telefonları")).append($("<td>"));
                    $.each(blok[0]["SenetiImzalayanTelefonlari"], function (i, tel) {
                        if (i > 0)
                            div1.find("table tr:nth-child(4) td:nth-child(2)").append("<br/>");
                        div1.find("table tr:nth-child(4) td:nth-child(2)").append($("<span>").text(tel));
                    });
                    */


                    div2.find("table tr:nth-child(1)").append($("<td>").text("Alacak Tipi")).append($("<td>").text(blok[0]["AlacakTipi"])).addClass("AlacakTipi");
                    div2.find("table tr:nth-child(2)").append($("<td>").text("Ana Para")).append($("<td>").text(blok[0]["AnaPara"] == "" ? "" : blok[0]["AnaPara"].BasamakGrupla() + " ₺"));
                    div2.find("table tr:nth-child(3)").append($("<td>").text("Vade Oranı")).append($("<td>").text(blok[0]["VadeOrani"]));
                    div2.find("table tr:nth-child(4)").append($("<td>").text("Senet Oluşturulma Tarihi")).append($("<td>").text(blok[0]["SenetOlusturulmaTarihi"]));
                    div2.find("table tr:nth-child(5)").append($("<td>").text("Araç Plakası")).append($("<td>").text(blok[0]["AracPlakasi"]));
                    div2.find("table tr:nth-child(6)").append($("<td>").text("Araç Başlığı")).append($("<td>").text(blok[0]["AracBasligi"]));

                    if (blok[0]["SenetBlokNot"].ReplaceNewlineTobr() == "") {
                        div3.find("table tr").append($("<td>").text("Notlar").append('<i class="fa fa-pencil-square-o not-edit"></i>').data("senet-blok-not", blok[0]["SenetBlokNot"])).append($("<td>").html(blok[0]["SenetBlokNot"].ReplaceNewlineTobr()));
                    }
                    else {
                        div3.css({ "outline": "1px solid limegreen" }).find("table tr").append($("<td>").text("Notlar").append('<i class="fa fa-pencil-square-o not-edit"></i>').data("senet-blok-not", blok[0]["SenetBlokNot"])).append($("<td>").html(blok[0]["SenetBlokNot"].ReplaceNewlineTobr()));
                    }


                    blokB.append(div1).append(div2).append(div3);

                    if (ind % 2 == 0) $(".senet-defteri .senet-bloklari-list .body").append($("<div>").addClass("clearfix").css("margin", "10px"));
                    ind++;
                });
                $(".senet-defteri .senet-bloklari").data("SenetBloklari", bloklar);
            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
            },
        complete: function () { d3.resolve(); }
    });

    //Çekleri temizle
    $(".senet-defteri .senet-bloklari .cek-list .cek-table").empty();
    //Çekleri Al ve Çiz
    $.ajax({
        url: "../../Data/CekAl",
        type: "post",
        data: { CekAlinanKisi: profilData[0].ContactUID },
        success:
            function (data) {
                try {
                    var ceklist = JSON.parse(data);
                } catch (e) {
                    console.log(data);
                    return;
                }
                //cek yoksa boş bırak
                if (!ceklist.length) return;

                //table header oluştur
                var $th = $("<tr>");
                $(".senet-defteri .senet-bloklari .cek-list .cek-table").append("<thead>").children("thead").append($th);
                $th
                    .append($("<th>").text("Tarih"))
                    .append($("<th>").text("Miktar"))
                    .append($("<th>").text("Çekin Asıl Sahibi"))
                    .append($("<th>").text("Banka"))
                    .append($("<th>").text("Banka Şubesi"))
                    .append($("<th>").text("Çek No"))
                    .append($("<th>").text("Takasta Old. Hesap"))
                    .append($("<th>").text("Not"));

                //cekleri göster
                $.each(ceklist, function (i, cek) {
                    var $tr = $("<tr>");
                    $tr
                        .append($("<td>").text(moment(cek["Tarih"], "YYYY/MM/DD").format("DD.MM.YYYY")))
                        .append($("<td>").text(cek["Miktar"].BasamakGrupla()).addClass("symbol-TL"))
                        .append($("<td>").text(cek["CekAsilSahibi"]))
                        .append($("<td>").text(cek["Banka"]))
                        .append($("<td>").text(cek["BankaSubesi"]))
                        .append($("<td>").text(cek["CekNo"]))
                        .append($("<td>").text(cek["TakastaOlduguHesap"]))
                        .append($("<td>").text(cek["CekNot"]))
                        .attr("cek-id", cek["CekID"])
                        .appendTo(".senet-defteri .senet-bloklari .cek-list .cek-table");
                });
            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
            },
        complete: function () { d4.resolve(); }
    });

    //remove loader when all deferreds are resolved
    $.when(d1, d3, d4).always(Remove_FullPagePreload);
    return true;
}

//#region Senet Profil List Actions
$(document).on("click", ".senet-defteri .senet-profil .senet-profil-list-actions .senet-profil-ekle", function () {
    var modal = $(".kisi-kurum-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        $.ajax({
            url: "../../Data/SenetProfilEkle",
            type: "post",
            data: { ContactID: modal.find(".kisi-kurum-lookup").dxLookup("instance").option("value") },
            success: function (data) {
                var Profil = JSON.parse(data); //Eklenen profil bilgilerini al
                modal.modal("hide");

                //Profili listeye ekle
                $(".senet-defteri .senet-profil-list").dxList("instance").option("dataSource").store().insert(Profil);
                //Yeni eklenen Profilin içine gir
                $(".senet-defteri .senet-profil-list").dxList("instance").option("dataSource").load().done(function () {
                    var profiles = $(".senet-defteri .senet-profil-list").dxList("instance")["_dataSource"]["_items"],
                        j = 0;
                    for (var i = 0; i < profiles.length; i++) {
                        if (profiles[i].ContactUID == Profil.ContactUID) {
                            j = i;
                            break;
                        }
                    }
                    Senet_ProfilDetaylariGoruntule(j);
                });
            },
            error: function (jqxhr) {
                console.log(jqxhr);
            }
        });
    });
});
$(document).on("click", ".senet-defteri .senet-profil .senet-profil-list-actions .sort-by a.ad", function () {
    SenetProfil_DS.sort("ListIndex");
    SenetProfil_DS.load();
    return;
});
$(document).on("click", ".senet-defteri .senet-profil .senet-profil-list-actions .sort-by a.senet-risk", function () {
    SenetProfil_DS.sort({ getter: "SenetRiski", desc: true }, { getter: "ToplamRisk", desc: true }, "Ad");
    SenetProfil_DS.load();
    return;
});
$(document).on("click", ".senet-defteri .senet-profil .senet-profil-list-actions .sort-by a.toplam-risk", function () {
    SenetProfil_DS.sort({ getter: "ToplamRisk", desc: true }, "Ad");
    SenetProfil_DS.load();
    return;
});
$(document).on("click", ".senet-defteri .senet-profil .senet-profil-list-actions .sort-by a", function () {
    //Riskleri en genişine göre ayarla
    if ($(".senet-profil .senet-profil-list").hasClass("risk-shown")) {
        var maxw = 0;
        $(".senet-profil .senet-profil-list .riskler").each(function (i, el) {
            var w = parseInt($(el).css("width"));
            maxw = w > maxw ? w : maxw;
        });
        $(".riskler").css("width", maxw + 2 + "px");
    }
});
$(document).on("click", ".senet-defteri .senet-profil .senet-profil-list-actions .risk-toggle", function () {
    //Listenin en üstündeki item ı al
    var st = $(".senet-defteri .senet-profil-list").dxList("instance").scrollTop(),
        th = 0,
        topItem;
    $(".senet-defteri .senet-profil-list .dx-scrollview-content .dx-list-item").each(function () { var h = parseFloat($(this).css("height")); th += h; if (th >= st + (h / 2)) { topItem = this; return false; } });

    $(".senet-profil .senet-profil-list").toggleClass("risk-shown");
    //Riskleri en genişine göre ayarla
    if ($(".senet-profil .senet-profil-list").hasClass("risk-shown")) {
        var maxw = 0;
        $(".senet-profil .senet-profil-list .riskler").each(function (i, el) {
            var w = parseInt($(el).css("width"));
            maxw = w > maxw ? w : maxw;
        });
        $(".senet-defteri .senet-profil-list .riskler").css("width", maxw + 2 + "px");
    }

    $(".senet-defteri .senet-profil-list").dxList("instance").updateDimensions();

    //Listenin en üstündeki item a scrolla
    var scrt = 0;
    $(".senet-defteri .senet-profil-list .dx-scrollview-content .dx-list-item").each(function () { if (topItem != this) scrt += parseFloat($(this).css("height")); else return false });
    $(".senet-defteri .senet-profil-list").dxList("instance").scrollTo(scrt);
});
//#endregion

//#region Navigate
$(document).on("click", ".content-container .senet-defteri .senet-bloklari .header-bar .navigation .goback", function () {
    $(this).closest(".senet-bloklari").hide().siblings(".senet-profil").show();
});
$(document).on("click", ".content-container .senet-defteri .senet-bloklari .header-bar .navigation .back", function () {
    var currentIndex = parseInt($(this).closest(".senet-bloklari").attr("profil-index"));
    Senet_ProfilDetaylariGoruntule(currentIndex - 1);
});
$(document).on("click", ".content-container .senet-defteri .senet-bloklari .header-bar .navigation .forward", function () {
    var currentIndex = parseInt($(this).closest(".senet-bloklari").attr("profil-index"));
    Senet_ProfilDetaylariGoruntule(currentIndex + 1);
});

//#endregion

//#region Not Edit
$(document).on("click", ".senet-defteri .senet-bloklari .profil-bilgileri i.not-edit.fa-pencil-square-o", function () {

    var td = $(this).closest("td").next("td");

    if (!$(".senet-defteri").hasClass("asd")) {
        not = $(".senet-defteri .senet-profil-list").dxList("instance").option("dataSource")["_items"][$(this).closest(".senet-bloklari").attr("profil-index")]["SenetNot"];
    } else {

        var data = JSON.parse(SenetProfiller);
        var profilindex = $(".senet-bloklari").attr("profil-index");
        not = data[profilindex].SenetNot;
    }

    ta = $("<textarea>");
    ta.val(not);
    td.html(ta);
    $(this).removeClass("fa-pencil-square-o").addClass("fa-check-square-o");
});
$(document).on("click", ".senet-defteri .senet-bloklari .profil-bilgileri i.not-edit.fa-check-square-o", function () {

    var td = $(this).closest("td").next("td"),
        ta = td.find("textarea"),
        not = ta.val();
    if (!$(".senet-defteri").hasClass("asd")) {
        profilB = $(".senet-defteri .senet-profil-list").dxList("instance").option("dataSource")["_items"][$(this).closest(".senet-bloklari").attr("profil-index")],
        _oldNote = profilB["SenetNot"];
        profilB["SenetNot"] = not;
    } else {
        var profilindex = $(".senet-bloklari").attr("profil-index");
        var data = JSON.parse(SenetProfiller);
        profilB = data[profilindex];
        _oldNote = data[profilindex].SenetNot;
        data[profilindex].SenetNot = not;
        SenetProfiller = JSON.stringify(data);
    }


    td.html(not.ReplaceNewlineTobr());
    $(this).removeClass("fa-check-square-o").addClass("fa-pencil-square-o");
    $.ajax({
        url: "../../Data/SenetProfilNotKaydet",
        type: "post",
        data: { ContactID: $(this).closest(".profil-bilgileri").attr("contact-uid"), Not: not },
        success:
            function (ret) {
                if (ret == "OK") {
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: profilB.Ad + " notu başarıyla güncellendi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    if (not != "") {
                        td.closest("tr").css({ "outline": "1px solid limegreen" });
                    }
                    else {
                        td.closest("tr").removeAttr("style");
                    }
                } else {
                    noty({
                        layout: "center",
                        theme: 'relax',
                        type: "error",
                        text: profilB["Ad"] + " notu güncellenemedi!",
                        animation: {
                            open: 'animated fadeIn'
                        },
                        timeout: false,
                        killer: true,
                        modal: true,
                        closeWith: ['click', 'backdrop']
                    });
                    profilB["SenetNot"] = _oldNote;
                    td.html(_oldNote.ReplaceNewlineTobr());
                }
            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
                noty({
                    layout: "center",
                    theme: 'relax',
                    type: "error",
                    text: profilB["Ad"] + " notu güncellenemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: false,
                    killer: true,
                    modal: true,
                    closeWith: ['click', 'backdrop']
                });
                profilB["SenetNot"] = _oldNote;
                td.html(_oldNote.ReplaceNewlineTobr());
            }
    })
});
$(document).on("click", ".senet-defteri .senet-bloklari .senet-blok-panel .senet-blok-bilgileri i.not-edit.fa-pencil-square-o", function () {
    var td = $(this).closest("td").next("td"),
        ta = $("<textarea>");
    ta.val($(this).closest("td").data("senet-blok-not"));
    td.html(ta);
    $(this).removeClass("fa-pencil-square-o").addClass("fa-check-square-o");
});
$(document).on("click", ".senet-defteri .senet-bloklari .senet-blok-panel .senet-blok-bilgileri i.not-edit.fa-check-square-o", function () {
    var _td = $(this).closest("td"),
        td = _td.next("td"),
        ta = td.find("textarea"),
        not = ta.val();
    td.html(not.ReplaceNewlineTobr());
    $(this).removeClass("fa-check-square-o").addClass("fa-pencil-square-o");
    $.ajax({
        url: "../../Data/SenetBlokNotKaydet",
        type: "post",
        data: { SenetBlokID: $(this).closest(".senet-blok-panel-wrapper").attr("senet-blok-id"), Not: not },
        success:
            function (data) {
                if (data == "OK") {
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Senet Blok Notu başarıyla güncellendi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });

                    _td.data("senet-blok-not", not);
                    if (not != "") {
                        td.closest("div").css({ "outline": "1px solid limegreen" })
                    }
                    else {
                        td.closest("div").removeAttr("style");
                    }


                } else {
                    noty({
                        layout: "center",
                        theme: 'relax',
                        type: "error",
                        text: "Senet Blok Notu güncellenemedi!",
                        animation: {
                            open: 'animated fadeIn'
                        },
                        timeout: false,
                        killer: true,
                        modal: true,
                        closeWith: ['click', 'backdrop']
                    });
                    td.html(_td.data("senet-blok-not").ReplaceNewlineTobr());
                }
            },
        error:
            function (jqxhr) {
                console.log(jqxhr);
                noty({
                    layout: "center",
                    theme: 'relax',
                    type: "error",
                    text: "Senet Blok Notu güncellenemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                    animation: {
                        open: 'animated fadeIn'
                    },
                    timeout: false,
                    killer: true,
                    modal: true,
                    closeWith: ['click', 'backdrop']
                });
                td.html(_td.data("senet-blok-not").ReplaceNewlineTobr());
            }
    });
});
//#endregion

//#region Senet Blok Edit
$(document).on("click", ".senet-defteri .senet-bloklari .senet-blok-panel .control-buttons .senet-blok-edit.edit-mode", function () {
    var panel = $(this).closest(".senet-blok-panel"),
        senetRows = panel.find(".senet-table  tbody tr"),
        blokBilgileri = panel.children(".senet-blok-bilgileri");
    $(this).closest(".senet-blok-panel-wrapper").addClass("editing");
    //Rowları editlenebilir yap
    $.each(senetRows, function (i, el) {
        //inputa çevir
        var t1 = $(el).find("td:nth-child(1)"),
            t2 = $(el).find("td:nth-child(2)"),
            t3 = $(el).find("td:nth-child(3)"),
            t4 = $(el).find("td:nth-child(4)");
        t5 = $(el).find("td:nth-child(6)");
        t1.html($("<input>").attr("type", "text").addClass("form-control sayi").val(t1.text()));
        t2.html($("<input>").attr("type", "text").addClass("form-control tarih").val(t2.text()));
        t3.html($("<input>").attr("type", "text").addClass("form-control sayi").val(t3.text().replace('.', ''))).removeClass("symbol-TL");
        t4.html($("<input>").attr("type", "text").addClass("form-control sayi").val(t4.text().replace('.', ''))).removeClass("symbol-TL");
        t5.html($("<input>").attr("type", "text").addClass("form-control").val(t5.text()));


        //edit sütunu ekle
        var editcolumn = $("<td>").addClass("edit-column");
        editcolumn.append($("<button>").addClass("btn btn-danger senet-sil"));
        editcolumn.appendTo(el);

        //ara senet butonlarını ekle
        $(el).append($("<td>").addClass("ara-senet-ekle-wrap").append('<i class="fa fa-plus ara-senet-ekle"></i>'));
        if (i == 0)
            $(".ara-senet-ekle-wrap", el).prepend('<i class="fa fa-plus ara-senet-ekle add-before"></i>');
    });

    //Senet Blok bilgilerini editlenebilir yap
    //Mevcut seçim ilk sırada olacak şekilde alac tiplerini selectbox yap
    var alacakTipi = blokBilgileri.find("tr.AlacakTipi td:nth-child(2)"),
        atSelect = $("<select>");
    atSelect.append("<option>ŞİRKET</option>");
    if (alacakTipi.text() == "BATAK")
        atSelect.prepend("<option>BATAK</option>");
    else
        atSelect.append("<option>BATAK</option>");
    atSelect.append("<option class='elle-gir'>ELLE GİR</option>");
    if (!alacakTipi.text().match(/ŞİRKET|BATAK/)) {
        atSelect.prepend("<option>" + alacakTipi.text() + "</option>");
    }
    alacakTipi.append("<option class='elle-gir'>ELLE GİR</option>");
    atSelect.on("change", function () {
        if ($("option:selected", this).hasClass("elle-gir")) {
            var atInp = $("<input>").addClass("form-control uppercase");
            atInp.attr("type", "text");
            atInp.insertAfter(this);

            //textbox value değiştiğinde option/select value sunu değiştir
            atInp.on("change", function () { $("option.elle-gir", atSelect).val(atInp.val()); });
        }
        else {
            $("option.elle-gir", this).val("ELLE GİR");
            $("input", alacakTipi).remove();
        }
    });
    alacakTipi.html(atSelect);
    //Kefil seçilebilir yap
    var kefil = blokBilgileri.find("tr.Kefil td:nth-child(2)"),
        kefilAd = kefil.text();
    kefil.empty();
    kefil.append($("<button>").addClass("btn btn-default kefil-sec").text("Seç"));
    kefil.append($("<span>").addClass("kefil").text(kefilAd));
    kefil.append($("<input>").attr("nzl-field", "Kefil").val(kefil.attr("kefil-id")).css("display", "none"));

    //senet blok sil butonu ekle
    $(this).closest(".control-buttons").append($("<button>").addClass("btn btn-danger senet-blok-sil"));
    $(this).removeClass("edit-mode btn-default").addClass("save-mode btn-success");
});
$(document).on("click", ".senet-defteri .senet-bloklari .senet-blok-panel .ara-senet-ekle", function () {
    var _tr = $(this).closest("tr"),
        tr = $("<tr>");

    tr
        .append($("<td>").append($("<input>").val("Ara Senet").attr("type", "text").addClass("form-control sayi")))
        .append($("<td>").append($("<input>").attr("type", "text").addClass("form-control tarih")))
        .append($("<td>").append($("<input>").attr("type", "text").addClass("form-control sayi")))
        .append($("<td>").append($("<input>").attr("type", "text").addClass("form-control sayi")))
        .append($("<td>").html("&#8212"))
        .append($("<td>").append($("<input>").addClass("form-control").attr({ "type": "text", "nzl-field": "SenetNot" })))
        .append($("<td>").addClass("edit-column").append($("<button>").addClass("btn btn-danger senet-sil")))
        .append($("<td>").addClass("ara-senet-ekle-wrap").append('<i class="fa fa-plus ara-senet-ekle"></i>'))
        .addClass("yeni-senet");
    if ($(this).hasClass("add-before")) {
        tr.insertBefore(_tr);
        $(".ara-senet-ekle-wrap", tr).prepend('<i class="fa fa-plus ara-senet-ekle add-before"></i>');
        $(this).remove();
    }
    else
        tr.insertAfter(_tr);
});
//$(document).on("dblclick", ".senet-defteri .senet-bloklari .senet-blok-panel-wrapper.editing .senet-table tbody td.senet-no", function () {
//    var td = $(this),
//        no = td.text(),
//        inp = $("<input>").attr({ type: "text" }).val(no);
//    td.html(inp);
//    inp.focus();
//    inp.on("blur", function () {
//        td.html(inp.val());
//    });
//});
$(document).on("click", ".senet-defteri .senet-bloklari .senet-table .edit-column .btn.senet-sil", function () {
    var tr = $(this).closest("tr");
    if (tr.hasClass("yeni-senet")) {
        //Yeni ara senet ise direk kaldır

        if (tr.index() == 0) {
            //kaldırılan en üstte ise üste ara senet ekle butonunu bir sonrakine koy
            tr.next("tr").find(".ara-senet-ekle-wrap").prepend('<i class="fa fa-plus ara-senet-ekle add-before"></i>');
        }

        tr.remove();
        return;
    }
    tr.toggleClass("silinecek-senet");
});
$(document).on("click", ".senet-defteri .senet-bloklari .senet-blok-panel .control-buttons .senet-blok-sil", function () {
    var conf = confirm("Bu senet bloğunu kalıcı olarak silmek üzeresiniz. Bu işlem geri alınamaz. \r\n Devam etmek istediğinize emin misiniz?");
    var $this = $(this);
    if (conf) {
        $.ajax({
            url: "../../Data/SenetBlokSil",
            type: "post",
            data: {
                SenetBlokID: $(this).closest(".senet-blok-panel-wrapper").attr("senet-blok-id")
            },
            beforeSend: function () { FullPagePreload(); },
            success:
                function (data) {
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Senet Bloğu silindi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    $this.closest(".senet-blok-panel-wrapper").remove();
                },
            error:
                function (jqxhr) {
                    noty({
                        layout: "center",
                        theme: 'relax',
                        type: "error",
                        text: "Senet Bloğu silinemedi. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                        animation: {
                            open: 'animated fadeIn'
                        },
                        timeout: false,
                        killer: true,
                        modal: true,
                        closeWith: ['click', 'backdrop']
                    });
                },
            complete: function () { Remove_FullPagePreload(); }
        });
    }
});
$(document).on("click", ".senet-defteri .senet-bloklari .senet-blok-panel .control-buttons .senet-blok-edit.save-mode", function () {
    var $this = $(this),
        contactuid = $this.closest(".senet-bloklari").find(".profil-bilgileri").attr("contact-uid"),
        panel = $(this).closest(".senet-blok-panel"),
        senetRows = panel.find(".senet-table  tbody tr"),
        blokBilgileri = panel.children(".senet-blok-bilgileri");
    var update = [],
        add = [],
        remove = [],
        blokColumns = {};
    var senetbloklarıBosmi = "";

    //Row bilgilerini al
    $.each(senetRows, function (i, el) {
        if ($(el).hasClass("yeni-senet")) {
            var addS = {};
            console.log("yeni" + $(el).find("td:nth-child(1) input").val());
            addS.SenetBlokNo = $(el).find("td:nth-child(1) input").val();
            addS.Miktar = $(el).find("td:nth-child(3) input").val() || 0;
            addS.Odenen = $(el).find("td:nth-child(4) input").val() || 0;
            addS.OdemeTarihi = $(el).find("td:nth-child(2) input").val();
            addS.Not = $(el).find("td:nth-child(6) input").val();
            if ($(el).find("td:nth-child(1) input").val() == "") {
                senetbloklarıBosmi = "boş";

            } else {
                add.push(addS);
            }

        }
        else if ($(el).hasClass("silinecek-senet")) {
            remove.push({ SenetID: $(el).attr("senet-id") });
        }
        else {
            var updateS = {};
            console.log("update"+$(el).find("td:nth-child(1) input").val());
            updateS.SenetID = $(el).attr("senet-id");
            updateS.SenetBlokNo = $(el).find("td:nth-child(1) input").val();
            updateS.Miktar = $(el).find("td:nth-child(3) input").val() || 0;
            updateS.Odenen = $(el).find("td:nth-child(4) input").val() || 0;
            updateS.OdemeTarihi = $(el).find("td:nth-child(2) input").val();
            updateS.Not = $(el).find("td:nth-child(6) input").val();
            if ($(el).find("td:nth-child(1) input").val() == "") {
                senetbloklarıBosmi = "boş";

            } else {

                update.push(updateS);
            }

        }
    });
    if (senetbloklarıBosmi == "boş") {

        senetbloklarıBosmi = "";

        return;
    }
    else {
        //Blok Bilgilerini al
        blokColumns["AlacakTipi"] = blokBilgileri.find("tr.AlacakTipi td select option:selected").index() > 0 ? blokBilgileri.find("tr.AlacakTipi td select").val() : null; //Alacaktipi değişmişse yeni tipi gönder
        blokColumns["Kefil"] = blokBilgileri.find("[nzl-field=Kefil]").val(); //Kefil id gönder

        //Loader göster ve işlem sonuçlarını takip etmek için deferred objelerini oluştur
        var d1 = $.Deferred(), d3 = $.Deferred(), d4 = $.Deferred();
        FullPagePreload();

        $.ajax({
            url: "../../Data/SenetDuzenle",
            type: "post",
            data: {
                DuzenlenenSenetler: JSON.stringify(update),
                EklenenSenetler: JSON.stringify(add),
                SilinenSenetler: JSON.stringify(remove),
                BlokBilgileri: JSON.stringify(blokColumns),
                SenetBlokID: $(this).closest(".senet-blok-panel-wrapper").attr("senet-blok-id")
            },
            success:
                function (data) {
                    try {
                        var senetler = JSON.parse(data);
                    } catch (e) {
                        console.log(data);
                        return;
                    }
                    noty({
                        layout: "topRight",
                        theme: 'relax',
                        type: "information",
                        text: "Senetler başarıyla güncellendi.",
                        dismissQueue: true,
                        animation: {
                            open: 'animated bounceInRight',
                            close: 'animated bounceOutRight'
                        },
                        maxVisible: 10,
                        timeout: 5000
                    });
                    var index = $(".senet-defteri .senet-bloklari").attr("profil-index");
                    if (!$(".senet-defteri").hasClass("asd"))
                        Senet_ProfilDetaylariGoruntule(index);
                    else
                        Senet_ProfilDetaylariGoruntule2(senetdatam);
                  
             

                    ////Rowları düzenle
                    //var tbody = $this.closest(".senet-blok-panel").find(".senet-table tbody");
                    //tbody.empty();
                    //var tmiktar = todenen = tkalan = 0;

               
                    //$.each(senetler, function (i, senet) {
                    //    var $tr = $("<tr>");
                    //    $tr.appendTo(tbody);
                    //    $tr
                    //        .append($("<td>").text(senet["SenetBlokNo"]).addClass("senet-no"))
                    //        .append($("<td>").text(moment(senet["OdemeTarihi"], "YYYY/MM/DD").format("DD.MM.YYYY")))
                    //        .append($("<td>").text(senet["Miktar"].BasamakGrupla()).addClass("symbol-TL"))
                    //        .append($("<td>").text(senet["Odenen"].BasamakGrupla()).addClass("symbol-TL"))
                    //        .append($("<td>").text(senet["Kalan"].BasamakGrupla()).addClass("symbol-TL"))
                    //        .append($("<td>").text(senet["SenetNot"]).addClass("senet-not"))
                    //        .addClass(parseInt(senet["Kalan"]) <= 0 ? "odenmis-senet" : (parseInt(senet["Kalan"]) >= parseInt(senet["Miktar"]) ? "" : "kismen-odenmis-senet"))
                    //        .addClass(moment(senet["OdemeTarihi"], "YYYY/MM/DD").isBefore(moment(), "day") ? "tarihi-gecmis-senet" : "")
                    //        .attr({ "senet-id": senet["SenetID"], "senet-no": senet["SenetBlokNo"] });

                    //    //toplamları al
                    //    tmiktar += parseInt(senet["Miktar"]);
                    //    todenen += parseInt(senet["Odenen"]);
                    //    tkalan += parseInt(senet["Kalan"]);
                    //});
                   
                    ////toplamları düzenle
                    //var tfoot = $this.closest(".senet-blok-panel").find(".senet-table tfoot");
                    //tfoot.find("td:nth-child(3)").text(parseInt(tmiktar).BasamakGrupla());
                    //tfoot.find("td:nth-child(4)").text(parseInt(todenen).BasamakGrupla());
                    //tfoot.find("td:nth-child(5)").text(parseInt(tkalan).BasamakGrupla());

                    ////Blok bilgilerini düzenle
                    //blokBilgileri.find("tr.AlacakTipi td:nth-child(2)").html(senetler[0].AlacakTipi);
                    //blokBilgileri.find("tr.Kefil td:nth-child(2)").html(senetler[0].KefilAdi).attr("kefil-id", senetler[0].Kefil);
                    //var teltd = blokBilgileri.find("tr.KefilTelefon td:nth-child(2)");
                    //$.each(senetler[0]["KefilTelefonlari"], function (i, tel) {
                    //    if (i > 0)
                    //        teltd.append("<br/>");
                    //    teltd.append($("<span>").text(tel));
                    //});

                    ////butonu değiştir
                    //$this.removeClass("save-mode btn-success").addClass("edit-mode btn-default");

                    ////Scroll to top of senet blok panel
                    //$(".content-container").scrollTop($this.closest(".senet-blok-panel-wrapper").offset().top - $(".senet-defteri").offset().top - 10);
                },
            error:
                function (jqxhr) {
                    console.log(jqxhr);
                    noty({
                        layout: "center",
                        theme: 'relax',
                        type: "error",
                        text: "Senetler güncellenemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                        animation: {
                            open: 'animated fadeIn'
                        },
                        timeout: false,
                        killer: true,
                        modal: true,
                        closeWith: ['click', 'backdrop']
                    });
                },
            complete: function () { d1.resolve(); }
        });


        //Bloğu güncelle


        //Riskleri Güncelle
        $.post("../../Data/RisklerVeLimitAl", { ContactUID: contactuid }, function (data) {
            var risk = JSON.parse(data),
                rc = $(".senet-defteri .senet-bloklari .senetriskler");
            rc.find(".senet").text(risk.SenetRiski.BasamakGrupla());
            rc.find(".cek").text(risk.CekRiski.BasamakGrupla());
            rc.find(".toplam").text(risk.ToplamRisk.BasamakGrupla());
            rc.find(".limit").text(!risk.RiskLimit ? "Tanımsız" : risk.RiskLimit.BasamakGrupla());
            $(".senet-defteri .cek-list .cek-riski span").text(risk.CekRiski.BasamakGrupla());
        }).always(function () { d3.resolve(); });

        //Çekleri temizle
        $(".senet-defteri .senet-bloklari .cek-list .cek-table").empty();
        //Çekleri Güncelle
        $.ajax({
            url: "../../Data/CekAl",
            type: "post",
            data: { CekAlinanKisi: contactuid },
            success:
                function (data) {
                    try {
                        var ceklist = JSON.parse(data);
                    } catch (e) {
                        console.log(data);
                        return;
                    }
                    //cek yoksa boş bırak
                    if (!ceklist.length) return;

                    //table header oluştur
                    var $th = $("<tr>");
                    $(".senet-defteri .senet-bloklari .cek-list .cek-table").append("<thead>").children("thead").append($th);
                    $th
                        .append($("<th>").text("Tarih"))
                        .append($("<th>").text("Miktar"))
                        .append($("<th>").text("Çekin Asıl Sahibi"))
                        .append($("<th>").text("Banka"))
                        .append($("<th>").text("Banka Şubesi"))
                        .append($("<th>").text("Çek No"))
                        .append($("<th>").text("Takasta Old. Hesap"))
                        .append($("<th>").text("Not"));

                    //cekleri göster
                    $.each(ceklist, function (i, cek) {
                        var $tr = $("<tr>");
                        $tr
                            .append($("<td>").text(moment(cek["Tarih"], "YYYY/MM/DD").format("DD.MM.YYYY")))
                            .append($("<td>").text(cek["Miktar"].BasamakGrupla()).addClass("symbol-TL"))
                            .append($("<td>").text(cek["CekAsilSahibi"]))
                            .append($("<td>").text(cek["Banka"]))
                            .append($("<td>").text(cek["BankaSubesi"]))
                            .append($("<td>").text(cek["CekNo"]))
                            .append($("<td>").text(cek["TakastaOlduguHesap"]))
                            .append($("<td>").text(cek["CekNot"]))
                            .attr("cek-id", cek["CekID"])
                            .appendTo(".senet-defteri .senet-bloklari .cek-list .cek-table");
                    });
                },
            error:
                function (jqxhr) {
                    console.log(jqxhr);
                },
            complete: function () { d4.resolve(); }

        });

        //remove loader when all deferreds are resolved
        $.when(d1, d3, d4).always(Remove_FullPagePreload);

        $(this).siblings(".senet-blok-sil").remove();
    }
});
$(document).on("keydown", ".senet-defteri .senet-blok-panel .senet-table input", function (ev) {
    if (ev.which == 13)
        $(this).closest(".senet-blok-panel").find(".btn.senet-blok-edit").trigger("click");
    var fInput;
    if (ev.which == 39) {
        //sağ ok
        if (this.selectionStart != this.selectionEnd)
            return;
        if ($(this).CursorPosition("get") < $(this).val().length)
            return;
        var td = $(this).closest("td");
        if (td.index() == 0 || td.index() == 1 || td.index() == 2)
            fInput = td.next("td").find("input");
        else if (td.index() == 3)
            fInput = td.next().next().find("input");
        else if (td.index() == 5) {
            var tr = td.closest("tr");
            if (tr.is(":last-of-type")) return;

            fInput = tr.next("tr").find("td:nth-child(1) input");
        }
        console.log(td.index());
    }
    else if (ev.which == 37) {
        //sol ok
        if (this.selectionStart != this.selectionEnd)
            return;
        if ($(this).CursorPosition("get") > 0)
            return;
        var td = $(this).closest("td");
        if (td.index() == 2 || td.index() == 3)
            fInput = td.prev("td").find("input");
        else if (td.index() == 5)
            fInput = td.prev().prev().find("input");
        else if (td.index() == 1)
            fInput = td.prev().find("input");
        else if (td.index() == 0) {
            var tr = td.closest("tr");
            if (tr.is(":first-of-type")) return;
            fInput = tr.prev("tr").find("td:nth-child(1) input");
        }
    }
    else if (ev.which == 38) {
        //yukarı ok
        if (this.selectionStart != this.selectionEnd)
            return;
        if ($(this).CursorPosition("get") > 0)
            return;
        var td = $(this).closest("td"),
            tr = td.closest("tr");
        if (tr.is(":first-of-type")) return;
        if (td.index() == 0 || td.index() == 1 || td.index() == 2 || td.index() == 3 || td.index() == 5)
            fInput = tr.prev("tr").children("td").eq(td.index()).find("input");
    }
    else if (ev.which == 40) {
        //aşağı ok
        if (this.selectionStart != this.selectionEnd)
            return;
        if ($(this).CursorPosition("get") < $(this).val().length)
            return;
        var td = $(this).closest("td"),
            tr = td.closest("tr");
        if (tr.is(":last-of-type")) return;
        if (td.index() == 0 || td.index() == 1 || td.index() == 2 || td.index() == 3 || td.index() == 5)
            fInput = tr.next("tr").children("td").eq(td.index()).find("input");
    }

    //focus input end set selection
    if (!!fInput) {
        fInput.focus();
        if (fInput.closest("td").index() != 5)
            setTimeout(function () { fInput.get(0).setSelectionRange(-1, fInput.val().length); }, 100);
    }
});
//#endregion

$(document).on("dblclick", ".senet-defteri .senet-blok-panel .senet-table td.senet-not", function () {
    if ($(this).text().length < 1) return;
    Modal_TextGoruntule($(this).text(), "Senet Notu");
});

//#region Excell Aktar
$(document).on("click", ".senet-defteri .senet-bloklari-list .senet-blok-export", function () {
    FullPagePreload();

    var _blokdata = $(this).closest(".senet-bloklari").data("SenetBloklari"),
        blokdata = [],
        i = 1;
    console.log(_blokdata);
    $.each(_blokdata, function (k, v) {
        $.each(v, function (kk, vv) {
            vv.SenetBlokAd = "Senet Blok " + i;
            blokdata.push(vv);
        });
        i++;
    });

    var tempdg = $("<div>"),
        isim = $(".senet-bloklari .profil-bilgileri tbody tr:first-child td:nth-child(2)").text();
    tempdg.dxDataGrid({
        dataSource: new DevExpress.data.DataSource({
            store: blokdata,
            group: "SenetBlokAd"
        }),
        columns: [
            "SenetBlokAd",
            "SenetBlokNo",
             {
                 dataField: "OdemeTarihi",
                 dataType: "date",
                 caption: "Ödeme Tarihi",
                 customizeText: function (data) {

                     return moment(data.value).format("DD.MM.YYYY");
                 }
             },
            "Miktar",
            "Odenen",
            "Kalan",
            "AlacakTipi",
        ],
        "export": {
            enabled: true,
            fileName: isim + " - Senet Blokları"
        },
        grouping: {
            autoExpandAll: true
        },
        paging: {
            enabled: false
        },
        onContentReady: function () {
            tempdg.dxDataGrid("instance").exportToExcel(false);
        },
        onExported: function () {
            tempdg.remove();
            Remove_FullPagePreload();
        }
    });
    tempdg.appendTo(".content-container");
});
//#endregion

//#region Yeni Senet Blok
$(document).on("click", ".senet-defteri .senet-bloklari-list .senet-blok-ekle", function () {
    $(this).closest(".senet-bloklari-list").children(".body").empty()
        .append($(".templates .yeni-senet-blok-template").clone().removeClass("yeni-senet-blok-template").addClass("yeni-senet-blok"));
});
$(document).on("click", ".senet-defteri .senet-bloklari-list .kefil-sec", function () {
    var span = $(this).next(".kefil"),
        modal = $(".kisi-kurum-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        var ibil = modal.find(".kisi-kurum-lookup").dxLookup("instance").option("selectedItem");
        span.text(ibil.Ad);
        span.siblings("input").val(ibil.ContactUID);
        modal.modal("hide");
    });
});
$(document).on("click", ".senet-defteri .senet-bloklari-list .seneti-imzalayan-sec", function () {
    var span = $(this).next(".seneti-imzalayan"),
        modal = $(".kisi-kurum-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        var ibil = modal.find(".kisi-kurum-lookup").dxLookup("instance").option("selectedItem");
        span.text(ibil.Ad);
        span.siblings("input").val(ibil.ContactUID);
        modal.modal("hide");
    });
});
$(document).on("click", ".senet-defteri .yeni-senet-blok .listelestir", function () {
    var blok = $(this).closest(".yeni-senet-blok");

    var emptyreq = blok.find(".senet-blok-bilgiler .required").filter(function (i, el) { return $(this).val().length <= 0 });
    if (emptyreq.length) {
        emptyreq.eq(0).focus();
        var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(emptyreq.eq(0).parent(".input-group").length ? emptyreq.eq(0).parent() : emptyreq.eq(0)).show(200);
        setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
        return;
    }

    var senet = blok.find(".senet-table"),
        baslangic = moment(blok.find("#yeni-senet-blok-baslangic").val(), "DD.MM.YYYY"),
        miktar = blok.find("#yeni-senet-blok-taksit-miktari").val().BasamakGrupla();
    senet.find("tbody").empty();
    for (i = 1; i <= parseInt(blok.find("#yeni-senet-blok-taksit-sayisi").val()) ; i++) {
        var tr = $("<tr>"),
            tarih = baslangic.clone().add(parseInt(i - 1), "M");
        tr
            .append($("<td>").text(i).attr("nzl-field", "SenetBlokNo"))
            .append($("<td>").text(tarih.format("DD.MM.YYYY")).attr("nzl-field", "OdemeTarihi"))
            .append($("<td>").text(miktar).addClass("symbol-TL").attr("nzl-field", "Miktar"))
            .append($("<td>").append($("<input>").addClass("form-control").attr({ "type": "text", "nzl-field": "SenetNot" })))
            .append($("<td>").addClass("ara-senet-ekle-wrap").append('<i class="fa fa-plus ara-senet-ekle"></i>'));

        if (i == 1)
            tr.find(".ara-senet-ekle-wrap").prepend('<i class="fa fa-plus ara-senet-ekle add-before"></i>')
        senet.find("tbody").append(tr);
    }
    YeniSenetBlok_SummaryUpdate();
});
function YeniSenetBlok_SummaryUpdate() {
    var tmiktar = 0;
    $(".content-container .yeni-senet-blok .senet-table tbody tr td:nth-child(3)").each(function (i, el) {
        if ($(this).children("input").length)
            tmiktar += parseInt($(this).children("input").val());
        else
            tmiktar += parseInt($(this).text().replace(/[^\d]/g, ""));
    });
    $(".content-container .yeni-senet-blok .senet-table tfoot tr td:nth-child(3)").text(tmiktar.BasamakGrupla());
}
$(document).on("change", ".senet-defteri .yeni-senet-blok .senet-blok-bilgiler #yeni-senet-blok-alacak-tipi", function () {
    if ($(this).val() == "ELLE GİR")
        $(this).next("#yeni-senet-blok-alacak-tipi2").slideDown();
    else
        $(this).next("#yeni-senet-blok-alacak-tipi2").slideUp();
});
$(document).on("dblclick", ".senet-defteri .yeni-senet-blok .senet-table tbody tr td:not(.edit-mode)", function () {
    var cVal = $(this).text();
    var init = function () {
        $(this).addClass("edit-mode");
        $(this).text("");
        $(this).append($("<input>").attr("type", "text"));
    };
    switch ($(this).attr("nzl-field")) {
        default:
            break;
        case "SenetBlokNo":
            init.call(this);
            $("input", this).addClass("sayi").val(cVal).focus();
            break;
        case "OdemeTarihi":
            init.call(this);
            $("input", this).addClass("tarih").val(cVal).focus();
            break;
        case "Miktar":
            init.call(this);
            $("input", this).addClass("sayi").val(cVal.replace(/\./g, "")).focus();
            break;
    }
});
$(document).on("blur", ".senet-defteri .yeni-senet-blok .senet-table tbody tr td.edit-mode input", function () {
    var $this = $(this);
    setTimeout(function () {
        if ($this.parent().index() == 2) YeniSenetBlok_SummaryUpdate();
        $this.parent().removeClass("edit-mode").html($this.parent().index() == 2 ? $this.val().BasamakGrupla() : $this.val());
    }, 100);
});
$(document).on("keydown", ".senet-defteri .yeni-senet-blok .senet-table tbody tr td input", function (ev) {
    if (ev.which == 13 || ev.which == 27)
        $(this).blur();
    if (ev.which == 39) {
        //sağ ok
        if (this.selectionStart != this.selectionEnd)
            return;
        if ($(this).CursorPosition("get") < $(this).val().length)
            return;
        var td = $(this).closest("td");
        if (td.index() == 1)
            td.next("td").trigger("dblclick");
        else if (td.index() == 2)
            td.next("td").find("input").focus();
        else if (td.index() == 3) {
            var tr = td.closest("tr");
            if (tr.is(":last-of-type")) return;
            tr.next("tr").children("td:nth-child(2)").trigger("dblclick");
        }
    }
    else if (ev.which == 37) {
        //sol ok
        if (this.selectionStart != this.selectionEnd)
            return;
        if ($(this).CursorPosition("get") > 0)
            return;
        var td = $(this).closest("td");
        if (td.index() == 2 || td.index() == 3)
            td.prev("td").trigger("dblclick");
        else if (td.index() == 1) {
            var tr = td.closest("tr");
            if (tr.is(":first-of-type")) return;
            tr.prev("tr").children("td:nth-child(2)").trigger("dblclick");
        }
    }
    else if (ev.which == 38) {
        //yukarı ok
        if (this.selectionStart != this.selectionEnd)
            return;
        if ($(this).CursorPosition("get") > 0)
            return;
        var td = $(this).closest("td"),
            tr = td.closest("tr");
        if (tr.is(":first-of-type")) return;
        if (td.index() == 1 || td.index() == 2)
            tr.prev("tr").children("td").eq(td.index()).trigger("dblclick");
        else if (td.index() == 3)
            tr.prev("tr").children("td").eq(td.index()).find("input").focus();
    }
    else if (ev.which == 40) {
        //aşağı ok
        if (this.selectionStart != this.selectionEnd)
            return;
        if ($(this).CursorPosition("get") < $(this).val().length)
            return;
        var td = $(this).closest("td"),
            tr = td.closest("tr");
        if (tr.is(":last-of-type")) return;
        if (td.index() == 1 || td.index() == 2)
            tr.next("tr").children("td").eq(td.index()).trigger("dblclick");
        else if (td.index() == 3)
            tr.next("tr").children("td").eq(td.index()).find("input").focus();
    }
});
$(document).on("click", ".senet-defteri .yeni-senet-blok .senet-table .ara-senet-ekle", function () {
    var _tr = $(this).closest("tr"),
        tr = $("<tr>");

    tr
        .append($("<td>").text("Ara Senet").attr("nzl-field", "SenetBlokNo"))
        .append($("<td>").text($("[nzl-field=OdemeTarihi]", _tr).text()).attr("nzl-field", "OdemeTarihi"))
        .append($("<td>").text(0).addClass("symbol-TL").attr("nzl-field", "Miktar"))
        .append($("<td>").append($("<input>").addClass("form-control").attr({ "type": "text", "nzl-field": "SenetNot" })).append("<i class='fa fa-close sil' title:'Sil'></i>"))
        .append($("<td>").addClass("ara-senet-ekle-wrap").append('<i class="fa fa-plus ara-senet-ekle"></i>'));
    if ($(this).hasClass("add-before")) {
        tr.insertBefore(_tr);
        $(".ara-senet-ekle-wrap", tr).prepend('<i class="fa fa-plus ara-senet-ekle add-before"></i>');
        $(this).remove();
    }
    else
        tr.insertAfter(_tr);
});
$(document).on("click", ".senet-defteri .yeni-senet-blok .senet-table tr td .sil", function () {
    var tr = $(this).closest("tr");
    if ($(".ara-senet-ekle.add-before", tr).length) {
        tr.next("tr").find(".ara-senet-ekle-wrap").prepend('<i class="fa fa-plus ara-senet-ekle add-before"></i>');
    }
    tr.remove();
    YeniSenetBlok_SummaryUpdate();
});
$(document).on("click", ".senet-defteri .yeni-senet-blok .senetler .yeni-senet-blok-kontroller button.kaydet", function () {


    var blok = $(this).closest(".yeni-senet-blok");

    var emptyreq = blok.find(".senet-blok-bilgiler .required").filter(function (i, el) { return $(this).val().length <= 0 });
    if (emptyreq.length) {
        emptyreq.eq(0).focus();
        var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(emptyreq.eq(0).parent(".input-group").length ? emptyreq.eq(0).parent() : emptyreq.eq(0)).show(200);
        setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
        return;
    }

    var data = {},
        rows = $(this).closest(".senetler").find(".senet-table tbody tr"),
        senetbilgileri = $(this).closest(".yeni-senet-blok").find(".senet-blok-bilgiler");



    $("[nzl-field]", senetbilgileri).each(function () {
        data[$(this).attr("nzl-field")] = $(this).val();
    });
    data.Borclu = $(this).closest(".senet-bloklari").find(".profil-bilgileri").attr("contact-uid");
    data.AlacakTipi = senetbilgileri.find("#yeni-senet-blok-alacak-tipi").val() == "ELLE GİR" ? senetbilgileri.find("#yeni-senet-blok-alacak-tipi2").val() : senetbilgileri.find("#yeni-senet-blok-alacak-tipi").val();
    data.Senetler = [];
    var senetbloklarbosmi = "";
    console.log(senetbloklarbosmi);
    $.each(rows, function (i, el) {
        var senet = {};

        $("[nzl-field]", this).each(function () {
            var fieldName = $(this).attr("nzl-field"),
                val = $(this).is("input") ? $(this).val() : $(this).text();
            if (fieldName == "Miktar")
                val = val.replace(/\./g, "");
            senet[fieldName] = val;
            if (fieldName == "SenetBlokNo") {
                if (val == "") {

                    senetbloklarbosmi = "boş";
                    console.log(senetbloklarbosmi);
                }
            }

        });
        data.Senetler.push(senet);
    });
    if (data.Senetler.length == 0) {
        //#region noty
        noty({
            layout: "topRight",
            theme: 'relax',
            type: "information",
            text: "Boş Senet Bloğu Eklenemez Listeliştire Tıklayın..",
            dismissQueue: true,
            animation: {
                open: 'animated bounceInRight',
                close: 'animated bounceOutRight'
            },
            maxVisible: 10,
            timeout: 5000
        });
        //#endregion
    }
    else {

        if (senetbloklarbosmi == "boş") {
            senetbloklarbosmi = "";

            return;
        }
        else {
            var $this = $(this);
            $.ajax({
                url: "../../Data/YeniSenetBlok",
                type: "post",
                data: { Data: JSON.stringify(data) },
                success:
                    function (data) {
                        if (!$(".senet-defteri").hasClass("asd"))
                            Senet_ProfilDetaylariGoruntule($this.closest(".senet-bloklari").attr("profil-index"));
                        else
                            Senet_ProfilDetaylariGoruntule2(senetdatam);
                    },
                error:
                    function (jqxhr) {
                        console.log(jqxhr);
                    }
            });
        }

    }

});
$(document).on("click", ".senet-defteri .yeni-senet-blok .senetler .yeni-senet-blok-kontroller button.iptal", function () {
    if (!$(".senet-defteri").hasClass("asd"))
        Senet_ProfilDetaylariGoruntule($(".senet-defteri .senet-bloklari").attr("profil-index"));
    else
        Senet_ProfilDetaylariGoruntule2(senetdatam);
});
//#endregion

$(document).on("dblclick", ".senet-defteri .senet-bloklari .cek-list .cek-table td:nth-child(8)", function () {
    if ($(this).text().length < 1) return;
    Modal_TextGoruntule($(this).text(), "Çek Notu");
});
//#endregion

//#region Çek Defteri
$(document).on("click", ".left-menu-container li.cekdefteri", function () {
    var cekdefteri = $(".templates .cek-defteri-template").clone().removeClass("cek-defteri-template").addClass("cek-defteri");
    $(".content-container").empty();
    cekdefteri.appendTo(".content-container");

    footbarFill([
        {
            text: "Çek Listesi",
            onClick: function () {
                if ($("#s-cek-listesi").is(":visible")) return;
                $("#s-cek-odenmis").addClass('animated zoomOut').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                    $("#s-cek-odenmis").hide().removeClass('animated zoomOut');
                    $("#s-cek-listesi").show().addClass('animated zoomIn').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                        $("#s-cek-listesi").removeClass('animated zoomIn');
                    });
                });
            }
        },
        {
            text: "Ödenmiş Çekler",
            onClick: function () {
                if ($("#s-cek-odenmis").is(":visible")) return;
                $("#s-cek-listesi").addClass('animated zoomOut').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                    $("#s-cek-listesi").hide().removeClass('animated zoomOut');
                    $("#s-cek-odenmis").show().addClass('animated zoomIn').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                        $("#s-cek-listesi").removeClass('animated zoomIn');
                    });
                });
            }
        }
    ]);

    CekListesiAlDoldur();
    OdenmisCekleriAlDoldur();
});

function CekListesiAlDoldur() {
    $.ajax({
        url: "../../Data/CekListesiAl",
        type: "get",
        beforeSend: function () { FullPagePreload(); },
        success: function (data) {
            var dataS;
            try {
                dataS = JSON.parse(data);
            } catch (e) {
                dataS = [];
            }

            try {
                var ds = $(".cek-defteri #cek-datagrid").dxDataGrid("instance").option("dataSource").option("store", dataS).load();
                return;
            } catch (e) {

            }

            $(".cek-defteri #cek-datagrid").dxDataGrid({
                dataSource: new DevExpress.data.DataSource({
                    store: dataS
                }),
                columns: [
                    {
                        dataField: "Tarih",
                        dataType: "date",
                        customizeText: function (data) {

                            return moment(data.value).format("DD.MM.YYYY");
                        },
                        sortOrder: "asc"
                    },
                    {
                        dataField: "Miktar",
                        dataType: "number",
                        customizeText: function (cellData) {
                            return !cellData.value ? "" : cellData.value.BasamakGrupla() + " ₺";
                        }
                    },
                    {
                        dataField: "CekAlinanKisi_Ad",
                        caption: "Çek Alınan Kişi",
                        editCellTemplate: function (elem, cellInfo) {
                            var button = $("<button>").addClass("btn btn-default cek-alinan-kisi-sec").text("Seç"),
                                span = $("<span>").addClass("cek-alinan-kisi").text(cellInfo.value).attr("iletisim-id", cellInfo.data.CekAlinanKisi);
                            elem.append(button).append(span).css("text-align", "center");
                            button.click(function () {
                                var $this = $(this),
                                    modal = $(".kisi-kurum-sec.modal").modal("show");

                                modal.find(".btn.sec").off("click").on("click", function () {
                                    var span = $this.siblings("span"),
                                        dxLI = modal.find(".kisi-kurum-lookup").dxLookup("instance");
                                    span.attr("iletisim-id", dxLI.option("value"));
                                    span.text(dxLI.option("text"));

                                    modal.modal("hide");

                                    cellInfo.setValue(dxLI.option("value"));
                                });
                            });
                        }
                    },
                    {
                        dataField: "CekAsilSahibi",
                        caption: "Çekin Asıl Sahibi"
                    },
                    "Banka",
                    {
                        dataField: "BankaSubesi",
                        caption: "Banka Şubesi"
                    },
                    {
                        dataField: "CekNo",
                        caption: "Çek No"
                    },
                    {
                        dataField: "TakastaOlduguHesap",
                        caption: "Takasta Old. Hesap"
                    },
                    {
                        dataField: "CekNot",
                        caption: "Not"
                    }
                ],
                "export": {
                    enabled: true,
                    fileName: "ÇekListesi"
                },
                filterRow: {
                    showOperationChooser: true,
                    visible: true
                },
                grouping: {
                    autoExpandAll: false
                },
                groupPanel: {
                    visible: true
                },
                headerFilter: {
                    visible: true
                },
                onRowPrepared: function (e) {
                    if (!e.data) return;
                    if (moment().isAfter(moment(e.data.Tarih, "YYYY.MM.DD"), "day")) {
                        $(e.rowElement).addClass("tarihi-gecmis-cek");
                    }
                    else if (moment().add(8, 'day').isAfter(moment(e.data.Tarih, "YYYY.MM.DD"), "day")) {
                        $(e.rowElement).addClass("tarihi-yakin-cek");
                    }
                },
                onRowUpdating: function (e) {
                    FullPagePreload();

                    if (e.newData.CekAlinanKisi_Ad) {
                        e.newData.CekAlinanKisi = e.newData.CekAlinanKisi_Ad;
                        delete e.newData.CekAlinanKisi_Ad;
                    }

                    $.ajax({
                        url: "../../Data/CekDuzenle",
                        type: "post",
                        data: {
                            CekID: e.oldData.CekID,
                            Data: JSON.stringify(e.newData)
                        },
                        async: false,
                        success: function (data) {
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: e.oldData.CekAlinanKisi_Ad + " çeki başarıyla düzenlendi.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });
                        },
                        error: function (jqxhr) {
                            e.cancel = true;
                            noty({
                                layout: "center",
                                theme: 'relax',
                                type: "error",
                                text: "Çek düzenlenemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü." : jqxhr.responseText),
                                animation: {
                                    open: 'animated fadeIn'
                                },
                                timeout: false,
                                killer: true,
                                modal: true,
                                closeWith: ['click', 'backdrop']
                            });
                        },
                        complete: function () { Remove_FullPagePreload(); }
                    });
                },
                searchPanel: {
                    visible: true
                },
                showRowLines: true,
                summary: {
                    groupItems: [{
                        column: "Miktar",
                        customizeText: function (itemInfo) { return "Toplam : " + itemInfo.value.BasamakGrupla() + " ₺"; },
                        alignByColumn: true,
                        summaryType: "sum"
                    }],
                    totalItems: [{
                        column: "Miktar",
                        customizeText: function (itemInfo) { return itemInfo.value.BasamakGrupla() + " ₺"; },
                        summaryType: "sum"
                    }]
                }
            });

            //Context menu
            var cmItems = [
                { text: "Düzenle" },
                { text: "Ödendi" },
                { text: "Sil" }
            ];
            var cmItemClick = function (cmOptions, rowOptions) {
                switch (cmOptions.itemData.text) {
                    default:
                        break;
                    case 'Düzenle':
                        {
                            rowOptions.component.editRow(rowOptions.rowIndex);
                        }
                        break;
                    case 'Ödendi':
                        {
                            $.ajax({
                                url: "../../Data/CekSilArsivle",
                                type: "post",
                                data: { CekID: rowOptions.data.CekID },
                                success: function (data) {
                                    noty({
                                        layout: "topRight",
                                        theme: 'relax',
                                        type: "information",
                                        text: rowOptions.data.CekAlinanKisi_Ad + " (" + rowOptions.data.Miktar.BasamakGrupla() + " ₺) çeki ödendi olarak işaretlendi ve arşivlendi.",
                                        dismissQueue: true,
                                        animation: {
                                            open: 'animated bounceInRight',
                                            close: 'animated bounceOutRight'
                                        },
                                        maxVisible: 10,
                                        timeout: 5000
                                    });

                                    CekListesiAlDoldur();
                                    OdenmisCekleriAlDoldur();
                                },
                                error: function (jqxhr) {
                                    noty({
                                        layout: "center",
                                        theme: 'relax',
                                        type: "error",
                                        text: "Çek arşivlenemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü." : jqxhr.responseText),
                                        animation: {
                                            open: 'animated fadeIn'
                                        },
                                        timeout: false,
                                        killer: true,
                                        modal: true,
                                        closeWith: ['click', 'backdrop']
                                    });
                                },
                                complete: function () { Remove_FullPagePreload(); }
                            });
                        }
                        break;
                    case 'Sil':
                        {
                            var sil = confirm("Çeki kalıcı olarak silmek istediğinize emin misiniz?");
                            if (sil) {
                                FullPagePreload();
                                $.ajax({
                                    url: "../../Data/CekSil",
                                    type: "post",
                                    data: { CekID: rowOptions.data.CekID },
                                    success: function (data) {
                                        noty({
                                            layout: "topRight",
                                            theme: 'relax',
                                            type: "information",
                                            text: rowOptions.data.CekAlinanKisi_Ad + " (" + rowOptions.data.Miktar.BasamakGrupla() + " ₺) çek kalıcı olarak silindi.",
                                            dismissQueue: true,
                                            animation: {
                                                open: 'animated bounceInRight',
                                                close: 'animated bounceOutRight'
                                            },
                                            maxVisible: 10,
                                            timeout: 5000
                                        });

                                        CekListesiAlDoldur();
                                    },
                                    error: function (jqxhr) {
                                        noty({
                                            layout: "center",
                                            theme: 'relax',
                                            type: "error",
                                            text: "Çek silinemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü." : jqxhr.responseText),
                                            animation: {
                                                open: 'animated fadeIn'
                                            },
                                            timeout: false,
                                            killer: true,
                                            modal: true,
                                            closeWith: ['click', 'backdrop']
                                        });
                                    },
                                    complete: function () { Remove_FullPagePreload(); }
                                });
                            }
                        }
                        break;
                }
            };
            DataGridContextMenu($('.cek-defteri #cek-datagrid'), cmItems, cmItemClick);
        },
        error: function (jqxhr) { },
        complete: function () { Remove_FullPagePreload(); }
    });
}
function OdenmisCekleriAlDoldur() {
    $.ajax({
        url: "../../Data/CekArsivAl",
        type: "get",
        beforeSend: function () { FullPagePreload(); },
        success: function (data) {
            var dataS;
            try {
                dataS = JSON.parse(data);
            } catch (e) {
                dataS = [];
            }

            try {
                var ds = $(".cek-defteri #cek-datagrid").dxDataGrid("instance").option("dataSource").option("store", dataS).load();
                return;
            } catch (e) {

            }

            $(".cek-defteri #odenmis-cek-datagrid").dxDataGrid({
                dataSource: new DevExpress.data.DataSource({
                    store: dataS
                }),
                columns: [
                    {
                        dataField: "Tarih",
                        dataType: "date",
                        customizeText: function (data) {

                            return moment(data.value).format("DD.MM.YYYY");
                        }
                    },
                    {
                        dataField: "ArsivlenmeTarihi",
                        caption: "Arşivlenme Tarihi",
                        dataType: "datetime",

                        sortOrder: "desc"

                    },
                    {
                        dataField: "ArsivleyenKisi",
                        caption: "Arşivleyen Kişi"
                    },
                    {
                        dataField: "Miktar",
                        dataType: "number",
                        customizeText: function (cellData) {
                            return !cellData.value ? "" : cellData.value.BasamakGrupla() + " ₺";
                        }
                    },
                    {
                        dataField: "CekAlinanKisi_Ad",
                        caption: "Çek Alınan Kişi"
                    },
                    {
                        dataField: "CekAsilSahibi",
                        caption: "Çekin Asıl Sahibi"
                    },
                    "Banka",
                    {
                        dataField: "BankaSubesi",
                        caption: "Banka Şubesi"
                    },
                    {
                        dataField: "CekNo",
                        caption: "Çek No"
                    },
                    {
                        dataField: "TakastaOlduguHesap",
                        caption: "Takasta Old. Hesap"
                    },
                    {
                        dataField: "CekNot",
                        caption: "Not"
                    }
                ],
                "export": {
                    enabled: true,
                    fileName: "ÇekListesi"
                },
                filterRow: {
                    showOperationChooser: true,
                    visible: true
                },
                grouping: {
                    autoExpandAll: false
                },
                groupPanel: {
                    visible: true
                },
                headerFilter: {
                    visible: true
                },
                searchPanel: {
                    visible: true
                },
                showRowLines: true,
                summary: {
                    groupItems: [{
                        column: "Miktar",
                        customizeText: function (itemInfo) { return "Toplam : " + itemInfo.value.BasamakGrupla() + " ₺"; },
                        alignByColumn: true,
                        summaryType: "sum"
                    }]
                }
            });

            //context menu
            //var cmItems = [
            //    { text: "Sil" }
            //];
            //var cmItemClick = function (cmOptions, rowOptions) {
            //    switch (cmOptions.itemData.text) {
            //        default:
            //            break;
            //        case 'Sil':
            //            {
            //                var sil = confirm("Çeki kalıcı olarak silmek istediğinize emin misiniz?");
            //                if (sil) {
            //                    FullPagePreload();
            //                    $.ajax({
            //                        url: "../../Data/CekArsivSil",
            //                        type: "post",
            //                        data: { CekID: rowOptions.data.CekID },
            //                        success: function (data) {
            //                            noty({
            //                                layout: "topRight",
            //                                theme: 'relax',
            //                                type: "information",
            //                                text: rowOptions.data.CekAlinanKisi_Ad + " (" + rowOptions.data.Miktar.BasamakGrupla() + " ₺) çek kalıcı olarak silindi.",
            //                                dismissQueue: true,
            //                                animation: {
            //                                    open: 'animated bounceInRight',
            //                                    close: 'animated bounceOutRight'
            //                                },
            //                                maxVisible: 10,
            //                                timeout: 5000
            //                            });

            //                            OdenmisCekleriAlDoldur();
            //                        },
            //                        error: function (jqxhr) {
            //                            noty({
            //                                layout: "center",
            //                                theme: 'relax',
            //                                type: "error",
            //                                text: "Çek silinemedi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü." : jqxhr.responseText),
            //                                animation: {
            //                                    open: 'animated fadeIn'
            //                                },
            //                                timeout: false,
            //                                killer: true,
            //                                modal: true,
            //                                closeWith: ['click', 'backdrop']
            //                            });
            //                        },
            //                        complete: function () { Remove_FullPagePreload(); }
            //                    });
            //                }
            //            }
            //            break;
            //    }
            //};
            //DataGridContextMenu($(".cek-defteri #odenmis-cek-datagrid"), cmItems, cmItemClick);
        },
        error: function (jqxhr) { console.log(jqxhr); },
        complete: function () { Remove_FullPagePreload(); }
    });
}

//Yeni Çek
$(document).on("click", ".cek-defteri .yeni-cek .cek-alinan-kisi-sec", function () {
    var $this = $(this),
        modal = $(".kisi-kurum-sec.modal").modal("show");

    modal.find(".btn.sec").off("click").on("click", function () {
        var span = $this.siblings("span"),
            dxLI = modal.find(".kisi-kurum-lookup").dxLookup("instance");
        span.attr("iletisim-id", dxLI.option("value"));
        span.text(dxLI.option("text"));

        modal.modal("hide");
    });
});
$(document).on("click", ".cek-defteri .yeni-cek .btn.ekle", function () {
    var tr = $(this).closest("tr");

    //Check required
    var emptyreq = tr.find(".required").filter(function (i, el) {
        var val;
        if ($(this).find("input").length)
            val = $(this).find("input").val();
        else
            val = $(this).find("span").attr("iletisim-id");
        return !val || val.length <= 0;
    });
    if (emptyreq.length) {
        emptyreq.eq(0).find("input, button").focus();
        var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").appendTo(emptyreq.eq(0)).show(200);
        setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
        return;
    }

    $.ajax({
        url: "../../Data/CekEkle",
        type: "post",
        data: {
            Data: JSON.stringify({
                Tarih: tr.find("#yeni-cek-tarih").val(),
                Miktar: tr.find("#yeni-cek-miktar").val(),
                CekAlinanKisi: tr.find("#yeni-cek-alinan-kisi").attr("iletisim-id"),
                CekAsilSahibi: tr.find("#yeni-cek-asil-sahibi").val(),
                Banka: tr.find("#yeni-cek-banka").val(),
                BankaSubesi: tr.find("#yeni-cek-sube").val(),
                CekNo: tr.find("#yeni-cek-cek-no").val(),
                TakastaOlduguHesap: tr.find("#yeni-cek-takasta-old-hesap").val(),
                CekNot: tr.find("#yeni-cek-not").val()
            })
        },
        beforeSend: function () { FullPagePreload(); },
        success: function (data) {
            noty({
                layout: "topRight",
                theme: 'relax',
                type: "information",
                text: tr.find("#yeni-cek-alinan-kisi").text().replace(/\s*-.*/, "") + "'e (" + tr.find("#yeni-cek-miktar").val().BasamakGrupla() + " ₺) değerinde yeni çek eklendi.",
                dismissQueue: true,
                animation: {
                    open: 'animated bounceInRight',
                    close: 'animated bounceOutRight'
                },
                maxVisible: 10,
                timeout: 5000
            });

            CekListesiAlDoldur();
        },
        error: function (jqxhr) {
            noty({
                layout: "center",
                theme: 'relax',
                type: "error",
                text: "Çek eklenemdi! Bir hata ile kaşılaşıldı. <br>" + (jqxhr.responseText.length > 2000 ? "Server Status : " + jqxhr.status : jqxhr.responseText),
                animation: {
                    open: 'animated fadeIn'
                },
                timeout: false,
                killer: true,
                modal: true,
                closeWith: ['click', 'backdrop']
            });
        },
        complete: function () { Remove_FullPagePreload(); }
    });
});
//#endregion

//#region Risk Limitleri
$(document).on("click", ".risk-limitleri .risk-tanimla .btn.kaydet", function () {
    var limit = $(".risk-limitleri .risk-tanimla .risk-bilgileri .limit input").val();
    $.ajax({
        url: "../../Data/RiskLimitDuzenle",
        type: "post",
        data: {
            ContactUID: $(".risk-limitleri .risk-tanimla #risk-lookup").dxLookup("instance").option("value"),
            RiskLimit: limit
        },
        beforeSend: FullPagePreload,
        success: function () {
            //#region noty
            noty({
                layout: "topRight",
                theme: 'relax',
                type: "information",
                text: "Risk limiti " + (!!limit && parseInt(limit) > 0 ? limit.BasamakGrupla() + " ₺" : "'Tanımsız'") + " olarak düzenlendi.",
                dismissQueue: true,
                animation: {
                    open: 'animated bounceInRight',
                    close: 'animated bounceOutRight'
                },
                maxVisible: 10,
                timeout: 5000
            });

            //#endregion
        },
        error: function (jqxhr) { },
        complete: Remove_FullPagePreload
    });
});
//#endregion

//#region GenelRisk Düzenle
$(document).on("click", ".genelrisk-limitleri .genelrisk-tanimla .btn.guncelle", function () {
    var limit = $(".genelrisk-limitleri .genelrisk-tanimla .genelrisk-bilgileri .genellimit input").val();
    $.ajax({
        url: "../../Data/GenelRiskGuncelle",
        type: "post",
        data: { Limit: limit },
        beforeSend: FullPagePreload,
        success: function (data) {
            //#region noty
            noty({
                layout: "topRight",
                theme: 'relax',
                type: "information",
                text: "Genel Risk " + data + " limiti olarak düzenlendi.",
                dismissQueue: true,
                animation: {
                    open: 'animated bounceInRight',
                    close: 'animated bounceOutRight'
                },
                maxVisible: 10,
                timeout: 5000
            });
            //#endregion
        },
        error: function (jqxhr) { },
        complete: Remove_FullPagePreload
    });
});
//#endregion

//#region Borçlu Filtreleri
$(document).on("change", ".borclu-filtre .filter-row select.filtre-tipi", function () {
    var bu = $(this),
        filtre = bu.val(),
        inputs = bu.siblings(".inputs");
    inputs.children().hide(300);
    bu.find("[value=null]").remove();
    switch (filtre) {
        default:
            break;
        case "senet-tarihi-gecmis":
            BorcluFiltre_SenetAra("TarihiGecmis");
            break;
        case "senet-tarih-araligi":
            var ta = inputs.find(".tarih-araligi").show(300);
            ta.children(".ta1, .ta2").dxDateBox({
                formatString: "dd.MM.yyyy",
                width: 180,
                value: null,
            });
            break;
        case "senet-alacak-tipi":
            inputs.find(".alacak-tipi").show(300);
            break;
        case "senet-alacak-tipi-ozet":
            //#region data grid options
            var opt = {
                columns: [
                    "AlacakTipi",
                    {
                        dataField: "SenetSayisi",
                        caption: "Kalan Senet Sayısı",
                        dataType: "number"
                    },
                    {
                        dataField: "ToplamKalan",
                        caption: "Toplam Kalan Senet Ödemesi",
                        dataType: "number",
                        customizeText: function (cellData) {
                            return !cellData.value ? "" : cellData.value.BasamakGrupla() + " ₺";
                        }
                    },
                    {
                        dataField: "TarihiGecmisSenetSayisi",
                        caption: "Tarihi Geçmiş Senet Sayısı",
                        dataType: "number"
                    },
                    {
                        dataField: "TarihiGecmisToplamKalan",
                        caption: "Toplam Kalan Tarihi Geçmiş Senet Ödemesi",
                        dataType: "number",
                        customizeText: function (cellData) {
                            return !cellData.value ? "" : cellData.value.BasamakGrupla() + " ₺";
                        }
                    }
                ],
                "export": {
                    enabled: true,
                    fileName: moment().format("DD.MM.YYYY")
                },
                paging: {
                    enabled: false
                },
                searchPanel: {
                    visible: true
                },
                showRowLines: true
            }
            //#endregion
            BorcluFiltre_SenetAra("AlacakTipiOzet", null, opt, true);
            break;
        case "risk-limit-asan":
            BorcluFiltre_RiskAra("LimitAsan");
            break;
        case "risk-aralik":
            inputs.find(".risk-aralik").show(300);
            break;
    }
});
$(document).on("click", ".borclu-filtre .filter-row .inputs .tarih-araligi .ara", function () {
    var params = {
        BasTarih: moment($(this).siblings(".ta1").dxDateBox("instance").option("value")).format("YYYY/MM/DD"),
        SonTarih: moment($(this).siblings(".ta2").dxDateBox("instance").option("value")).format("YYYY/MM/DD")
    };
    BorcluFiltre_SenetAra("TarihAraligi", params);
});
$(document).on("click", ".borclu-filtre .filter-row .inputs .alacak-tipi .ara", function () {
    var params = {
        AlacakTipi: $(this).siblings("input").val()
    };
    BorcluFiltre_SenetAra("AlacakTipi", params);
});
$(document).on("click", ".borclu-filtre .filter-row .inputs .risk-aralik .ara", function () {
    var params = {
        Min: $(this).siblings("input.ra1").val(),
        Max: $(this).siblings("input.ra2").val()
    };
    console.log(params);
    BorcluFiltre_RiskAra("RiskAralik", params);
});

$(document).on("keydown", ".borclu-filtre .filter-row .inputs input", function (e) {
    if (e.which == 13)
        $(this).siblings(".btn.ara").trigger("click");
});

function BorcluFiltre_SenetAra(type, params, addGridOpt, gridOptOverride) {
    var data = { type: type },
        params = params || {},
        addGridOpt = addGridOpt || {},
        gridOptOverride = gridOptOverride === true;
    $.extend(true, data, params);

    $.ajax({
        url: "../../Data/SenetFiltre",
        data: data,
        beforeSend: function () { FullPagePreload(); },
        success: function (data) {
            try {
                var senetler = JSON.parse(data);
            } catch (e) {
                console.log(data);
                return;
            }

            //#region grid options
            var opt = {
                columns: [
                     {
                         dataField: "BorcluAdi",
                         caption: "Borçlu Adı"
                     },
                    {
                        dataField: "OdemeTarihi",
                        dataType: "date",
                        caption: "Ödeme Tarihi",
                        customizeText: function (data) {

                            return moment(data.value).format("DD.MM.YYYY");
                        }
                    },
                    {
                        dataField: "Miktar",
                        dataType: "number",
                        customizeText: customizeText_TL
                    },
                    {
                        dataField: "Odenen",
                        dataType: "number",
                        customizeText: customizeText_TL
                    },
                    {
                        dataField: "Kalan",
                        dataType: "number",
                        customizeText: customizeText_TL
                    },

                    {
                        dataField: "BorcluTelefon",
                        caption: "Borçlu Birincil Telefon"
                    },
                    {
                        dataField: "BorcluTelefonlari",
                        caption: "Borçlu Telefonları"
                    },
                    {
                        dataField: "KefilAdi",
                        caption: "Kefil Adı"
                    },
                    {
                        dataField: "KefilTelefon",
                        caption: "Kefil Birincil Telefon"
                    },
                    {
                        dataField: "KefilTelefonlari",
                        caption: "Kefil Telefonları"
                    },
                    {
                        dataField: "SenetiImzalayanAdi",
                        caption: "Seneti İmzalayan Adı"
                    },
                    {
                        dataField: "SenetiImzalayanTelefon",
                        caption: "Seneti İmzalayan Birincil Telefon"
                    },
                    {
                        dataField: "SenetiImzalayanTelefonlari",
                        caption: "Seneti İmzalayan Telefonları"
                    },
                    "AlacakTipi",
                    {
                        dataField: "AracPlakasi",
                        caption: "Araç Plakası"
                    },
                    {
                        dataField: "AracBasligi",
                        caption: "Araç Başlığı"
                    },
                    "SenetNot"
                ],
                summary: {
                    groupItems: [{
                        column: "Kalan",
                        customizeText: function (itemInfo) { return "Toplam : " + itemInfo.value.BasamakGrupla() + " ₺"; },
                        alignByColumn: true,
                        summaryType: "sum"
                    }],
                    totalItems: [{
                        column: "Kalan",
                        customizeText: function (itemInfo) { return itemInfo.value.BasamakGrupla() + " ₺"; },
                        summaryType: "sum"
                    }]
                }
            };
            if (gridOptOverride)
                opt = addGridOpt;
            else
                $.extend(true, opt, addGridOpt);
            //#endregion
            BorcluFiltre_GridPaint(senetler, opt, gridOptOverride);
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            //todo noty
        },
        complete: function () { Remove_FullPagePreload(); }
    });
}
function BorcluFiltre_RiskAra(type, params, gridOpt) {
    var data = { type: type },
        params = params || {};
    $.extend(true, data, params);

    $.ajax({
        url: "../../Data/RiskFiltre",
        data: data,
        beforeSend: function () { FullPagePreload(); },
        success: function (data) {
            try {
                var response = JSON.parse(data);
            } catch (e) {
                console.log(e);
                console.log(data);
                return;
            }
            console.log(response);
            //#region grid options
            var opt = {
                columns: [
                    {
                        dataField: "Ad",
                        sortOrder: "asc"
                    },
                    {
                        caption: "Tip",
                        dataField: "Type"
                    },
                    "KimlikNo",
                    "VergiDairesi",
                    "VergiNo",
                    {
                        caption: "Risk Marjin",
                        dataField: "RiskMargin",
                        dataType: "number",
                        customizeText: customizeText_Number
                    },
                    {
                        caption: "Risk Limiti",
                        dataField: "RiskLimit",
                        dataType: "number",
                        customizeText: customizeText_TL
                    },

                    {
                        dataField: "ToplamRisk",
                        dataType: "number",
                        customizeText: customizeText_TL
                    },
                    {
                        dataField: "SenetRiski",
                        dataType: "number",
                        customizeText: customizeText_TL
                    },
                    {
                        caption: "Çek Riski",
                        dataField: "CekRiski",
                        dataType: "number",
                        customizeText: customizeText_TL
                    }
                ]
            };
            $.extend(true, opt, gridOpt);
            //#endregion
            BorcluFiltre_GridPaint(response, opt);
        },
        error: function (jqxhr) {
            console.log(jqxhr);
            //todo noty
        },
        complete: function () { Remove_FullPagePreload(); }
    });
}

function BorcluFiltre_GridPaint(data, gridOpt, gridOptOverride) {
    var rw = $(".borclu-filtre .result-row .result-wrapper"),
        rc = $("<div>"),
        gridOptOverride = gridOptOverride === true;

    rw.find("#borclu-filtre-result").remove();
    rc.attr("id", "borclu-filtre-result");
    rc.appendTo(rw);

    //#region Grid Options
    var opt = {
        columnChooser: {
            enabled: true
        },

        export: {
            enabled: true,
            fileName: moment().format("DD.MM.YYYY")
        },
        filterRow: {
            showOperationChooser: true,
            visible: true
        },
        grouping: {
            autoExpandAll: false
        },
        groupPanel: {
            visible: true
        },
        headerFilter: {
            visible: true
        },
        paging: {
            enabled: false
        },
        selection: {
            mode: "single"
        },
        onRowClick: function (e) {

            if (!!e.rowElement.data("LastClick") && e.rowElement.data("LastClick") > (Date.now() - 500))


                $.ajax({
                    url: "../../Data/SecilenSenetProfilAl",
                    type: "post",
                    data: { ContactUID: e.key.Borclu },
                    success:
                        function (gelendata) {
                            $(".borclu-filtre").hide();

                            Senet_ProfilDetaylariGoruntule2(gelendata);

                        },
                    error:
                        function (jqxhr) {
                            console.log(jqxhr);
                        },
                    complete: function () { console.log(e.key.Borclu); }
                });


            e.rowElement.data("LastClick", Date.now());



        },
        searchPanel: {
            visible: true
        },
        showRowLines: true
    };
    if (gridOptOverride)
        opt = gridOpt;
    else
        $.extend(true, opt, gridOpt);
    opt.dataSource = data;
    //#endregion
    rc.dxDataGrid(opt);
}
//#endregion

//#region Ayarlar
$(document).on("click", ".left-menu-container li.programayarlar", function () {
    var ayrlar = $(".templates .program-ayarlar-template").clone().removeClass("program-ayarlar-template").addClass("program-ayarlar");
    $(".content-container").empty();
    ayrlar.appendTo(".content-container");
});
//#endregion

//#region İletişim İşlemleri
$(document).on("click", ".content-container .iletisim-islemleri .actions .ekle", function () {
    var modal = $(".kisi-kurum-ekle.modal").modal("show");
    modal.find(".btn.kaydet").off("click").on("click", function () {
        modal.find(".modal-feedback").empty();
        var telefonlar = [];
        modal.find("input.telefon").each(function (i, el) {
            if ($(this).val().length)
                telefonlar.push($(this).val());
        });
        var adresler = [];
        modal.find("input.adres").each(function (i, el) {
            if ($(this).val().length)
                adresler.push($(this).val());
        });

        if (modal.find("#kisi-kurum-ekle-ad").val() == "") {
            modal.find("#kisi-kurum-ekle-ad").focus();
            var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(modal.find("#kisi-kurum-ekle-ad").parent(".input-group").length ? modal.find("#kisi-kurum-ekle-ad").parent() : modal.find("#kisi-kurum-ekle-ad")).show(200);
            setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
            return;
            modal.find(".modal-feedback").append(Alert("danger", "KimlikNo Boş Geçilemez"));
        }
        else if (modal.find("#kisi-kurum-ekle-tip").val() == "Kişi" && modal.find("#kisi-kurum-ekle-kimlik-no").val() == "") {

            modal.find("#kisi-kurum-ekle-kimlik-no").focus();
            var warn = $("<div>").text("Bu alanın doldurulması zorunludur.").css("display", "none").insertAfter(modal.find("#kisi-kurum-ekle-kimlik-no").parent(".input-group").length ? modal.find("#kisi-kurum-ekle-kimlik-no").parent() : modal.find("#kisi-kurum-ekle-kimlik-no")).show(200);
            setTimeout(function () { warn.hide(200, function () { warn.remove(); }) }, 1500);
            return;
        }

        else {
            $.ajax({
                url: "../../Data/IletisimBilgisiKaydet",
                type: "post",
                data: {
                    Data: JSON.stringify({
                        Ad: modal.find("#kisi-kurum-ekle-ad").val(),
                        Type: modal.find("#kisi-kurum-ekle-tip").val(),
                        KimlikNo: modal.find("#kisi-kurum-ekle-kimlik-no").val(),
                        VergiDairesi: modal.find("#kisi-kurum-ekle-vergi-dairesi").val(),
                        VergiNo: modal.find("#kisi-kurum-ekle-vergi-no").val(),
                        BirincilAdres: modal.find("#kisi-kurum-ekle-birincil-adres").val(),
                        Adresler: adresler,
                        BirincilTelefon: modal.find("#kisi-kurum-ekle-birincil-telefon").val(),
                        Telefonlar: telefonlar
                    })
                },
                beforeSend:
                    function () { FullPagePreload(); },
                error:
                    function (jqxhr) {
                        if (jqxhr.responseText.length)
                            modal.find(".modal-feedback").append(Alert("danger", jqxhr.responseText));
                        else
                            modal.find(".modal-feedback").append(Alert("danger", "Kayıt Başarısız! Server " + jqxhr.status + " " + jqxhr.statusText + " döndürdü."));
                    },
                success:
                    function (data) {
                        try {
                            var kisi_bilgisi = JSON.parse(data);
                        } catch (e) {
                            console.error(e);
                            console.log(data);
                            return;
                        }
                        if (kisi_bilgisi.Kontrol == "1") {
                            modal.find(".modal-feedback").append(Alert("danger", "Bu Tc Kimlik Numarası Başkasına Kayıtlıdır."));
                        }
                        else if (kisi_bilgisi.Kontrol == "2") {
                            modal.find(".modal-feedback").append(Alert("danger", "Bu Vergi Numarası Başkasına Kayıtlıdır."));
                        }
                        else {
                            modal.modal("hide");

                            var dxLI = $(".content-container .iletisim-islemleri .iletisim-lookup .lookup").dxLookup("instance");
                            dxLI.option("dataSource").store().insert(kisi_bilgisi);
                            dxLI.option("dataSource").load().done(function () {
                                dxLI.option("value", kisi_bilgisi["ContactUID"]);
                            });

                            //#region noty
                            noty({
                                layout: "topRight",
                                theme: 'relax',
                                type: "information",
                                text: kisi_bilgisi.Ad + " iletişim bilgileri eklendi.",
                                dismissQueue: true,
                                animation: {
                                    open: 'animated bounceInRight',
                                    close: 'animated bounceOutRight'
                                },
                                maxVisible: 10,
                                timeout: 5000
                            });
                            //#endregion
                        }
                    },
                complete:
                    function () { Remove_FullPagePreload(); }
            });
        }


    });
});

$(document).on("click", ".content-container .iletisim-islemleri .actions .duzenle", function () {
    var lookup = $(".content-container .iletisim-islemleri .iletisim-lookup .lookup").dxLookup("instance"),
        info = lookup.option("selectedItem");
    KisiKurumDuzenle(info).done(function (kisi_bilgileri) {
        lookup.option("dataSource").store().remove(info).done(function () {
            lookup.option("dataSource").store().insert(kisi_bilgileri).done(function () {
                lookup.option("dataSource").load().done(function () {
                    lookup.reset();
                    lookup.option("value", kisi_bilgileri["ContactUID"]);
                });
            });
        });
    });
});
//#endregion

