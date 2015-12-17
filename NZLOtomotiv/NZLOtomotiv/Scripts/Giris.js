/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/jquery-2.1.3.js" />
/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/bootstrap.js" />
/// <reference path="C:\Users\o\documents\visual studio 2013\Projects\NZLOtomotiv\NZLOtomotiv\Components/jquery-ui.js" />

$(document).on("submit", "form", function (ev) {
    ev.preventDefault();
    var $form = $(this);
    $.ajax({
        url: "/NZLOto/Login",
        type: "post",
        data: $(this).serialize(),
        beforeSend:
            function () {
                $(this).find("input").prop("disabled", true);
            },
        success:
            function (data, status, jqxhr) {
                if (data == "OK") {
                    localStorage["username"] = $form.find("input[name=username]").val();
                    window.location = "/NZLOto/Main";
                }
                else if (data == "Şifre Hatalı")
                    alert(data);
                else
                    console.log(data);
            },
        error:
            function (jqxhr, status, text) {
                console.log(jqxhr);
            },
        complete:
            function () {
                $(this).find("input").prop("disabled", false);
            }
    });
});