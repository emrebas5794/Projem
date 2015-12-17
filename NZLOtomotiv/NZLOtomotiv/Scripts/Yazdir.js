console.log(Arac_Data);
Number.prototype.BasamakGrupla = function () {
    return this.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");
}
String.prototype.BasamakGrupla = function () {
    return this.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");
}
function bugun() {
    var zaman = new Date();
    var aylar = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
    var tarih = ((zaman.getDate() < 10) ? "0" : "") + zaman.getDate();
    function cevir(number) {
        return (number < 1000) ? number + 1900 : number;
    }
    var bugun = aylar[zaman.getMonth()] + "." + tarih + "." + (cevir(zaman.getYear()));
    return bugun;
}
$(".tarih").text(bugun());
$(".marka").text(Arac_Data.Marka);
$(".MotorNo").text(Arac_Data.MotorNo);
$(".model").text(Arac_Data.Model);
$(".sase-no").text(Arac_Data.SasiNo);
$(".plaka").text(Arac_Data.Plaka);
$(".ruhsatsahibi").text(Arac_Data.RuhsatSahibi);
$(".km").text(Arac_Data.KM.BasamakGrupla());
$(".yakit").text(Arac_Data.YakitTipi);
$(".kalanvade").text(Arac_Data.KalanVade);
$(".not").text(Arac_Data.Not);
$(".satisbedeli").text(Arac_Data.SatisBedeli.BasamakGrupla() + " TL");
$(".alinanpara").text(Arac_Data.AlinanPara.BasamakGrupla() + " TL");
$(".satici-ad").text(Arac_Data.SaticiAd);
$(".alici-ad").text(Arac_Data.AliciAd);
$(".satici-tc").text(Arac_Data.SaticiKimlikNo);
$(".alici-tc").text(Arac_Data.AliciKimlikNo);
var saticitel = Arac_Data.SaticiTelefon;
var saticiadres = Arac_Data.SaticiAdres;
var alicitel = Arac_Data.AliciTelefon;
var aliciadres = Arac_Data.AliciAdres;

$(".satici-tel").text(saticitel==""? "" : saticitel);
$(".alici-tel").text(alicitel == "" ? "" : alicitel);
$(".satici-adres").text(saticiadres == "" ? "" : saticiadres);
$(".alici-adres").text(aliciadres == "" ? "" : aliciadres);

$(".sahit-ad").text(Arac_Data.SahitAd);
$(".sahit-tel").text(Arac_Data.SahitTelefon);
$(".sahit-adres").text(Arac_Data.SahitAdres);
$(".sahit-tc").text(Arac_Data.SahitKimlikNo);

window.print();



