Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Configuration
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Web.UI

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class Service1
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function HelloWorld() As String
        Return "Hotel Otomasyon Projesi"
    End Function
    
   
    <WebMethod(True)> _
    Public Function login(ByVal odano As String) As String
        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))
        Dim durum As Integer
        Dim sql As String = ("select * from kullaniciler where odano='" & odano & "'")
        Dim adap As New OleDbDataAdapter(sql, baglanti)
        Dim al As New DataSet()
        adap.Fill(al, "verial")
        If al.Tables("verial").Rows.Count > 0 Then
            durum = 1
        Else
            durum = 0
        End If
        Return durum
    End Function
    <WebMethod(True)> _
    Public Function asd(ByVal odano As String) As DataSet
        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~/App_data/vt.mdb"))
        ' string sonuc = "";
        Dim sql As String = "select count(odano) as toplam from  kullaniciler where odano='" & odano & "'"
        Dim adap As New OleDbDataAdapter(sql, baglanti)
        Dim al As New DataSet()
        adap.Fill(al, "veri_cek")
        Return al
    End Function
    <WebMethod(True)> _
    Public Sub calistir(ByVal sql As String)

        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~/App_data/vt.mdb"))
        baglanti.Open()
        'string sql = "insert into uyeler (uye_isim,uye_soyisim,uye_sifre,uye_dogtar,uye_tel,uye_mail,uye_adres,uye_cihaz,uye_onay)values ('value1','value2','value3',1990,'5','123','123','123',true)";
        Dim komut As New OleDbCommand(sql, baglanti)
        komut.ExecuteNonQuery()
        baglanti.Close()
    End Sub
    <WebMethod(True)> _
    Public Function sipariskayit(ByVal odano As String, ByVal yemekadi As String, ByVal yemekadet As String, ByVal yemekfiyat As String)


        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~/App_data/vt.mdb"))
        baglanti.Open()
        Dim sql As String = "insert into siparis(odano,yemekadi,yemekadet,yemekfiyat) values('" & odano & "','" & yemekadi & "','" & yemekadet & "','" & yemekfiyat & "')"

        Dim komut As New OleDbCommand(sql, baglanti)

        komut.ExecuteNonQuery()
        baglanti.Close()
        Return "kayit"
    End Function
    <WebMethod(True)> _
    Public Function yemekhanesil(ByVal id As String)


        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~/App_data/vt.mdb"))
        baglanti.Open()
        Dim sql As String = "delete * from yemekhane where id=" & id & ""

        Dim komut As New OleDbCommand(sql, baglanti)

        komut.ExecuteNonQuery()
        baglanti.Close()
        Return "silindi"
    End Function
    <WebMethod(True)> _
    Public Function servissil(ByVal id As String)


        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~/App_data/vt.mdb"))
        baglanti.Open()
        Dim sql As String = "delete * from servis where id=" & id & ""

        Dim komut As New OleDbCommand(sql, baglanti)

        komut.ExecuteNonQuery()
        baglanti.Close()
        Return "silindi"
    End Function
    <WebMethod(True)> _
    Public Function servisekle(ByVal odano As String)


        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~/App_data/vt.mdb"))
        baglanti.Open()
        Dim sql As String = "insert into servis(odano) values('" & odano & "')"

        Dim komut As New OleDbCommand(sql, baglanti)

        komut.ExecuteNonQuery()
        baglanti.Close()
        Return "eklendi"
    End Function
    <WebMethod(True)> _
    Public Function odaservisiistek(ByVal kategori As String, ByVal tarihsaat As String, ByVal kullaniciadi As String, ByVal sifre As String)


        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~/App_data/vt.mdb"))
        baglanti.Open()
        Dim sql As String = "insert into odaservisiistek(kategori,tarih-saat,kullaniciadi,sifre) values('" & kategori & "','" & tarihsaat & "','" & kullaniciadi & "','" & sifre & "')"

        Dim komut As New OleDbCommand(sql, baglanti)

        komut.ExecuteNonQuery()
        baglanti.Close()
        Return "eklendi"
    End Function
    <WebMethod(True)> _
    Public Function yemekgosterid() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from menu_ekle")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("id").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function yemekgosterisim() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from menu_ekle")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("isim").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function yemekgosterresim() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from menu_ekle")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("resimyol").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function

    <WebMethod(True)> _
    Public Function vericekme(ByVal sql As String) As DataSet

        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))

        Dim adaptor As New OleDbDataAdapter(sql, baglanti)
        Dim dt As New DataSet
        adaptor.Fill(dt)
        baglanti.Close()

        Return dt

    End Function

    <WebMethod(True)> _
    Public Function yemeklerigosterid(ByVal menuidsi As Integer) As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from yemek_ekle where menu_adi='" & menuidsi & "' ")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("id").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function

    <WebMethod(True)> _
    Public Function yemeklerigosterisim(ByVal menuidsi As Integer) As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from yemek_ekle where menu_adi='" & menuidsi & "' ")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("yemek_isim").ToString() & ","

        End While

        baglanti.Close()
        Return yazi

    End Function

    <WebMethod(True)> _
    Public Function yemeklerigosterfiyat(ByVal menuidsi As Integer) As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from yemek_ekle where menu_adi='" & menuidsi & "' ")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("yemek_fiyat").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function



    <WebMethod(True)> _
    Public Function yemeklerigosterresim(ByVal menuidsi As Integer) As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from yemek_ekle where menu_adi='" & menuidsi & "' ")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("yemek_resim").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function yemekhaneodano() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from yemekhane")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("odano").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function yemekhaneyemekid() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from yemekhane")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("id").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function yemekhaneyemekadi() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from yemekhane")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("yemekadi").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function yemekhaneyemekadet() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from yemekhane")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("yemekadet").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function serviselamanid() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from servis")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("id").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function serviselamanoda() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from servis")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("odano").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function

    <WebMethod(True)> _
    Public Function kullaniciid() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from kullaniciler")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("id").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function

    <WebMethod(True)> _
    Public Function kullaniciadi() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from kullaniciler")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("odano").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function galeriid() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from galeri")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("id").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function galeriodano() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from galeri")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("odano").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function galeriresim() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from galeri")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("resim").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function aktivite_id() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from aktiviteler")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("id").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function aktivite_yazi() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from aktiviteler")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("aktivite_yazi").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function aktivite_resim() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from aktiviteler")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("aktivite_resim").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function odaservisiid() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from odaservisi")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("id").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function
    <WebMethod(True)> _
    Public Function odaservisikate() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from odaservisi")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim yazi As String = ""
        While (oku.Read())

            yazi = yazi + oku("kategori").ToString() & ","

        End While







        baglanti.Close()
        Return yazi

    End Function

    <WebMethod(True)> _
    Public Function siparisgelensayi() As String




        Dim baglanti As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/App_data/vt.mdb"))



        baglanti.Open()

        Dim sql As String = ("select * from siparis")

        Dim kmt As New OleDbCommand(sql, baglanti)
        Dim oku As OleDbDataReader
        oku = kmt.ExecuteReader()

        Dim toplamsayi As Integer = 0
        While (oku.Read())

            toplamsayi = toplamsayi + 1


        End While







        baglanti.Close()
        Return toplamsayi

    End Function
    <WebMethod(True)> _
    Public Function menugoster() As String

        Dim komut As New OleDbCommand("select * from menu_ekle")

        Dim dr As OleDbDataReader = komut.ExecuteReader()
        While dr.Read()
            TextBox1.Text = dr(0).ToString()

        End While


    End Function

   
End Class