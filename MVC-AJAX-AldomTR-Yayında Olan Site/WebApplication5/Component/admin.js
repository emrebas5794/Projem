/// <reference path="C:\Users\o\Documents\Visual Studio 2013\Projects\AldomTR\WebApplication5\External/jquery-2.1.4.min.js" />

$(document).ajaxSuccess(function (e, jqxhr, opt, data) {
    if (/^ERROR:/.test(data)) {
        var code = parseInt(data.replace(/ERROR:.*?(\d+).*/, "$1"));
        window.location = "../Admin/Giris?e=" + code;
    }
});

//#region Referans
//#region Ekle
$(document).on("click", "#s-referans .referans-ekle .kaydet", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    $.ajax({
        url: "../Admin/ReferansEkle",
        type: "post",
        data: {
            Parent: panel.find(".parent").val(),
            Name: panel.find(".name").val(),
            Text: panel.find(".text").val()
        },
        success: function (data) {
            window.location.reload();
        },
        error: function (jqxhr) {
            console.log(jqxhr);
        }
    });
});
//#region Urun
//#region Ekle
$(document).on("click", "#s-urun .urun-ekle .kaydet", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    $.ajax({
        url: "../Admin/UrunEkle",
        type: "post",
        data: {
            Parent: panel.find(".parent").val(),
            Name: panel.find(".name").val(),
            Text: panel.find(".text").val()
        },
        success: function (data) {
            window.location.reload();
        },
        error: function (jqxhr) {
            console.log(jqxhr);
        }
    });
});

//#region UrunKategori
//#region Ekle
$(document).on("click", "#s-urun .kategori-ekle .kaydet", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }
    if ($("input[name='gtur']:checked").val() == "yaziekle") {

        tbl = $("#s-urun .kategori-ekle table");
   
        tbl.find(".yname").val("");
    }
    else {
        tbl = $("#s-urun .kategori-ekle table");
        tbl.find(".name").val("");
        tbl.find(".text").val("");
    }
  
    $.ajax({
        url: "../Admin/KategoriYaziEkle",
        type: "post",
        data: {
            Action: panel.find(".parent").val(),
            PageTitle: $("#name").val(),
            PageText: $("#text").val(),
            SubID:"~/"+ $("#yname").val()
        },
        success: function (data) {
           
            window.location.reload();
        },
        error: function (jqxhr) {
            console.log(jqxhr);
        }
    });
});

function goster() {

  
    $("tr#katebaslik").show(100);
    $("tr#yazigovde").show(100);
    $("tr#yadres").hide(100);

   


}

function gizle() {


    $("tr#yadres").show(100);
    $("tr#katebaslik").hide(100);
    $("tr#yazigovde").hide(100);
    


}



$(document).on("change", "#s-urun .kategori-ekle .parent", function () {
    var ref = $("#s-urun .kategori-ekle");
    ref.find(".text, .name").val("");
   

    if ($(this).val() == null || $(this).val() == "")
        return;

    if ($("input[name='gtur']:checked").val() == "yaziekle") {



        $.ajax({
            url: "../Admin/KategoriBilgiAl",
            type: "post",
            data: {
                Action: ref.find(".parent").val(),

            },
            success: function (data) {
                var info = JSON.parse(data),

                tbl = $("#s-urun .kategori-ekle table");
                tbl.find(".name").val(info[0].PageTitle);
                tbl.find(".text").val(info[0].PageText);
                tbl.find(".yname").val(info[0].SubID);



            },
            error: function (jqxhr) { console.log(jqxhr); }
        });
    }
    else {


        $.ajax({
            url: "../Admin/KategoriBilgiAl",
            type: "post",
            data: {
                Action: ref.find(".parent").val(),

            },
            success: function (data) {
                var info = JSON.parse(data),

                tbl = $("#s-urun .kategori-ekle table");
                tbl.find(".name").val(info[0].PageTitle);
                tbl.find(".text").val(info[0].PageText);
                tbl.find(".yname").val(info[0].SubID);



            },
            error: function (jqxhr) { console.log(jqxhr); }
        });


    }
});

//#region Diger
//#region Ekle
$(document).on("click", "#s-diger .diger-ekle .kaydet", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    $.ajax({
        url: "../Admin/DigerEkle",
        type: "post",
        data: {
            Parent: panel.find(".parent").val(),
            Name: panel.find(".name").val(),
            Text: panel.find(".text").val()
        },
        success: function (data) {
            window.location.reload();
        },
        error: function (jqxhr) {
            console.log(jqxhr);
        }
    });
});




//#endregion
//#region Düzenle
$(document).on("change", "#s-referans .referans-duzenle .parent", function () {
    $(this).find(".null").remove();

    $.ajax({
        url: "../Admin/ReferansBilgiAl",
        type: "post",
        data: {
            Parent: $(this).val()
        },
        success: function (data) {
            var response = JSON.parse(data),
                select = $("#s-referans .referans-duzenle .id");
            select.empty();
            $.each(response, function (i, ref) {
                select.append($("<option>").text(ref.Name).attr("value", ref.id));
            });
            select.prop("disabled", false).trigger("change");
        },
        error: function (jqxhr) { console.log(jqxhr); }
    })
});
$(document).on("change", "#s-referans .referans-duzenle .id", function () {
    var ref = $("#s-referans .referans-duzenle");
    ref.find(".text, .name").val("");
    var inp = ref.find(".images");
    inp.replaceWith(inp.clone(true));

    if ($(this).val() == null || $(this).val() == "")
        return;

    $.ajax({
        url: "../Admin/ReferansBilgiAl",
        type: "post",
        data: {
            Parent: ref.find(".parent").val(),
            id: $(this).val()
        },
        success: function (data) {
            var info = JSON.parse(data),
                tbl = $("#s-referans .referans-duzenle table");
            tbl.find(".name").val(info.Name);
            tbl.find(".text").val(info.Text);
            tbl.find(".image-container").empty();
            $.each(info.Images, function (i, imgName) {
                tbl.find(".image-container").append($("<div>").addClass("image-wrapper").attr("image-name", imgName).append($("<img>").attr("src", "../images/" + imgName)));
            });
        },
        error: function (jqxhr) { console.log(jqxhr); }
    });
});
$(document).on("click", "#s-referans .referans-duzenle .image-container .image-wrapper", function () {
    if ($(this).hasClass("silinecek")) {
        $(this).removeClass("silinecek");
        $(this).find(".sil-label").remove();
    }
    else {
        $(this).addClass("silinecek");
        $(this).append($("<div>").addClass("sil-label"))
    }
});
$(document).on("click", "#s-referans .referans-duzenle .sil", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    swal({
        title: "Emin misiniz?",
        text: "Referansı sistemden silmek istediğinize emin misiniz? Bu işlem geri alınamaz!",
        type: "warning",
        showCancelButton: true,
        cancelButtonText: "İptal",
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Evet",
        closeOnConfirm: false
    }, function () {
        var silinecekResimler = [],
            ref = $("#s-referans .referans-duzenle");
        $("#s-referans .referans-duzenle .image-container .image-wrapper").each(function () { silinecekResimler.push($(this).attr("image-name")) });

        $.ajax({
            url: "../Admin/ReferansSil",
            type: "post",
            data: {
                id: ref.find(".id").val(),
                SilResim: JSON.stringify(silinecekResimler)
            },
            success: function (data) {
                window.location.reload();
            },
            error: function (jqxhr) { console.log(jqxhr); }
        });
    });


});
$(document).on("click", "#s-referans .referans-duzenle .kaydet", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    var silinecekResimler = [],
        ref = $("#s-referans .referans-duzenle");
    $("#s-referans .referans-duzenle .image-container .silinecek").each(function () { silinecekResimler.push($(this).attr("image-name")) });

    var formdata = new FormData();
    formdata.append("Parent", ref.find(".parent").val());
    formdata.append("id", ref.find(".id").val());
    formdata.append("Name", ref.find(".name").val());
    formdata.append("Text", ref.find(".text").val());
    formdata.append("SilResim", JSON.stringify(silinecekResimler));
    $.each(ref.find(".images").get(0).files, function (i, v) {
        formdata.append("file" + i, v);
    });

    $.ajax({
        url: "../Admin/ReferansDuzenle",
        type: "post",
        data: formdata,
        cache: false,
        processData: false,
        contentType: false,
        success: function (data) {
            window.location.reload();
        },
        error: function (jqxhr) { console.log(jqxhr); }
    });

});
//#endregion
//#endregion

//#endregion Urun
//#region Düzenle
$(document).on("change", "#s-urun .urun-duzenle .parent", function () {
    $(this).find(".null").remove();

    $.ajax({
        url: "../Admin/UrunBilgiAl",
        type: "post",
        data: {
            Parent: $(this).val()
        },
        success: function (data) {
            var response = JSON.parse(data),
                select = $("#s-urun .urun-duzenle .id");
            select.empty();
            $.each(response, function (i, ref) {
                select.append($("<option>").text(ref.Name).attr("value", ref.id));
            });
            select.prop("disabled", false).trigger("change");
        },
        error: function (jqxhr) { console.log(jqxhr); }
    })
});
$(document).on("change", "#s-urun .urun-duzenle .id", function () {
    var ref = $("#s-urun .urun-duzenle");
    ref.find(".text, .name").val("");
    var inp = ref.find(".images");
    inp.replaceWith(inp.clone(true));

    if ($(this).val() == null || $(this).val() == "")
        return;

    $.ajax({
        url: "../Admin/UrunBilgiAl",
        type: "post",
        data: {
            Parent: ref.find(".parent").val(),
            id: $(this).val()
        },
        success: function (data) {
            var info = JSON.parse(data),
                tbl = $("#s-urun .urun-duzenle table");
            tbl.find(".name").val(info.Name);
            tbl.find(".text").val(info.Text);
            tbl.find(".image-container").empty();
            $.each(info.Images, function (i, imgName) {
                tbl.find(".image-container").append($("<div>").addClass("image-wrapper").attr("image-name", imgName).append($("<img>").attr("src", "../images/" + imgName)));
            });
        },
        error: function (jqxhr) { console.log(jqxhr); }
    });
});
$(document).on("click", "#s-urun .urun-duzenle .image-container .image-wrapper", function () {
    if ($(this).hasClass("silinecek")) {
        $(this).removeClass("silinecek");
        $(this).find(".sil-label").remove();
    }
    else {
        $(this).addClass("silinecek");
        $(this).append($("<div>").addClass("sil-label"))
    }
});
$(document).on("click", "#s-urun .urun-duzenle .sil", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    swal({
        title: "Emin misiniz?",
        text: "Ürünü sistemden silmek istediğinize emin misiniz? Bu işlem geri alınamaz!",
        type: "warning",
        showCancelButton: true,
        cancelButtonText: "İptal",
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Evet",
        closeOnConfirm: false
    }, function () {
        var silinecekResimler = [],
            ref = $("#s-urun .urun-duzenle");
        $("#s-urun .urun-duzenle .image-container .image-wrapper").each(function () { silinecekResimler.push($(this).attr("image-name")) });

        $.ajax({
            url: "../Admin/UrunSil",
            type: "post",
            data: {
                id: ref.find(".id").val(),
                SilResim: JSON.stringify(silinecekResimler)
            },
            success: function (data) {
                window.location.reload();
            },
            error: function (jqxhr) { console.log(jqxhr); }
        });
    });


});
$(document).on("click", "#s-urun .urun-duzenle .kaydet", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    var silinecekResimler = [],
        ref = $("#s-urun .urun-duzenle");
    $("#s-urun .urun-duzenle .image-container .silinecek").each(function () { silinecekResimler.push($(this).attr("image-name")) });

    var formdata = new FormData();
    formdata.append("Parent", ref.find(".parent").val());
    formdata.append("id", ref.find(".id").val());
    formdata.append("Name", ref.find(".name").val());
    formdata.append("Text", ref.find(".text").val());
    formdata.append("SilResim", JSON.stringify(silinecekResimler));
    $.each(ref.find(".images").get(0).files, function (i, v) {
        formdata.append("file" + i, v);
    });

    $.ajax({
        url: "../Admin/UrunDuzenle",
        type: "post",
        data: formdata,
        cache: false,
        processData: false,
        contentType: false,
        success: function (data) {
            window.location.reload();
        },
        error: function (jqxhr) { console.log(jqxhr); }
    });

});


//#endregion Urun
//#region Düzenle
$(document).on("change", "#s-diger .diger-duzenle .parent", function () {
    $(this).find(".null").remove();

    $.ajax({
        url: "../Admin/DigerBilgiAl",
        type: "post",
        data: {
            Parent: $(this).val()
        },
        success: function (data) {
            var response = JSON.parse(data),
                select = $("#s-diger .diger-duzenle .id");
            select.empty();
            $.each(response, function (i, ref) {
                select.append($("<option>").text(ref.PageTitle).attr("value", ref.id));
            });
            select.prop("disabled", false).trigger("change");
        },
        error: function (jqxhr) { console.log(jqxhr); }
    })
});
$(document).on("change", "#s-diger .diger-duzenle .id", function () {
    var ref = $("#s-diger .diger-duzenle");
    ref.find(".text, .name").val("");
    var inp = ref.find(".images");
    inp.replaceWith(inp.clone(true));

    if ($(this).val() == null || $(this).val() == "")
        return;

    $.ajax({
        url: "../Admin/DigerBilgiAl",
        type: "post",
        data: {
            Parent: ref.find(".parent").val(),
            id: $(this).val()
        },
        success: function (data) {
            var info = JSON.parse(data),
                tbl = $("#s-diger .diger-duzenle table");
            tbl.find(".name").val(info.PageTitle);
            tbl.find(".text").val(info.PageText);
            tbl.find(".image-container").empty();
            $.each(info.Images, function (i, imgName) {
                tbl.find(".image-container").append($("<div>").addClass("image-wrapper").attr("image-name", imgName).append($("<img>").attr("src", "../images/" + imgName)));
            });
        },
        error: function (jqxhr) { console.log(jqxhr); }
    });
});
$(document).on("click", "#s-diger .diger-duzenle .image-container .image-wrapper", function () {
    if ($(this).hasClass("silinecek")) {
        $(this).removeClass("silinecek");
        $(this).find(".sil-label").remove();
    }
    else {
        $(this).addClass("silinecek");
        $(this).append($("<div>").addClass("sil-label"))
    }
});
$(document).on("click", "#s-diger .diger-duzenle .sil", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    swal({
        title: "Emin misiniz?",
        text: "Ürünü sistemden silmek istediğinize emin misiniz? Bu işlem geri alınamaz!",
        type: "warning",
        showCancelButton: true,
        cancelButtonText: "İptal",
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Evet",
        closeOnConfirm: false
    }, function () {
        var silinecekResimler = [],
            ref = $("#s-diger .diger-duzenle");
        $("#s-diger .diger-duzenle .image-container .image-wrapper").each(function () { silinecekResimler.push($(this).attr("image-name")) });

        $.ajax({
            url: "../Admin/DigerSil",
            type: "post",
            data: {
                id: ref.find(".id").val(),
                SilResim: JSON.stringify(silinecekResimler)
            },
            success: function (data) {
                window.location.reload();
            },
            error: function (jqxhr) { console.log(jqxhr); }
        });
    });


});
$(document).on("click", "#s-diger .diger-duzenle .kaydet", function () {
    var panel = $(this).closest(".panel"),
        invalid = panel.find(".required").filter(function () { return !$(this).val() });
    if (invalid.length) {
        invalid.eq(0).focus();
        return;
    }

    var silinecekResimler = [],
        ref = $("#s-diger .diger-duzenle");
    $("#s-diger .diger-duzenle .image-container .silinecek").each(function () { silinecekResimler.push($(this).attr("image-name")) });

    var formdata = new FormData();
    formdata.append("Parent", ref.find(".parent").val());
    formdata.append("id", ref.find(".id").val());
    formdata.append("Name", ref.find(".name").val());
    formdata.append("Text", ref.find(".text").val());
    formdata.append("SilResim", JSON.stringify(silinecekResimler));
    $.each(ref.find(".images").get(0).files, function (i, v) {
        formdata.append("file" + i, v);
    });

    $.ajax({
        url: "../Admin/DigerDuzenle",
        type: "post",
        data: formdata,
        cache: false,
        processData: false,
        contentType: false,
        success: function (data) {
            window.location.reload();
        },
        error: function (jqxhr) { console.log(jqxhr); }
    });

});

