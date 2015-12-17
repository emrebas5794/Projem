$(document).ready(function () {
    String.prototype.format = function () {
        var str = this;
        for (var i = 0; i < arguments.length; i++) {
            str = str.replace("{" + i + "}", arguments[i]);
        }
        return str;
    }
});

(function () {

    var closeOverlay = function () {
        $(".overlay").remove();
    };
    $(document).on("click", ".overlay .close-button", closeOverlay);
    $(document).on("keydown", "body", function (e) {
        if (e.which == 27)
            closeOverlay();
    });

}());