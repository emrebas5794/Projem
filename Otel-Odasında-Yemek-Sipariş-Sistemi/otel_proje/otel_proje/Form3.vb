Imports System.Data.OleDb
Imports System.Linq
Imports System.Text
Imports System.Windows.Forms
Imports System.IO


Public Class Form3
    Dim secilen As Integer
    Dim yol As String
    Dim yolResim As String
    Dim secMenu As Integer

    Public Function paradonustur(ByVal para As String) As String
        Dim fiyat As String
        If IsNumeric(para) Then
            fiyat = para.Replace(",", ".")
            Return fiyat
        Else
            Return 0
        End If


    End Function

    Private Sub Form3_FormClosing(sender As Object, e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Application.Exit()
    End Sub
    Dim isimler() As String
    Dim menuid() As String
    Dim secilenid As Integer
    Private Sub Form3_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Dim servis As New com.otelservisi.www.Service1
        Dim sql As String = "select * from yemek_ekle"
        Dim ds As New DataSet
        ds = servis.vericekme(sql)
        DataGridView1.DataSource = ds.Tables(0)

        isimler = servis.yemekgosterisim.Split(",")
        menuid = servis.yemekgosterid.Split(",")

        For i As Integer = 0 To servis.yemekgosterisim.Length

            comboMenu.Items.Add(isimler(i))
        Next

        If My.Computer.Network.IsAvailable = True Then
            PictureBox3.Image = Image.FromFile(Application.StartupPath + "/icon/var.png")
        Else
            PictureBox3.Image = Image.FromFile(Application.StartupPath + "/icon/yok.png")
        End If

        Dim sql3 As String = "select * from yemek_ekle"
        Dim dt As New DataSet
        dt = servis.vericekme(sql3)
        DataGridView1.DataSource = dt.Tables(0)
    End Sub

    Private Sub LinkLabel1_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel1.LinkClicked

        Me.Hide()
        Form2.Show()

    End Sub


    Private Sub LinkLabel3_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel3.LinkClicked
        Me.Hide()
        Form4.Show()
    End Sub


    Private Sub LinkLabel4_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel4.LinkClicked
        Me.Hide()
        Form5.Show()
    End Sub

    Private Sub Button1_Click(sender As System.Object, e As System.EventArgs) Handles Button1.Click
        ofd.Title = "Resim Dosyası Aç"
        ofd.Filter = "resim dosyaları (*.jpg)|*.jpg|Tüm dosyalar (*.*)|*.*"
        If ofd.ShowDialog = Windows.Forms.DialogResult.OK Then
            yol = ofd.FileName
        End If

        ' File.WriteAllBytes("image/yemek_resim/" & Path.GetFileName(yol), File.ReadAllBytes(ofd.FileName))
        MessageBox.Show("Resim Seçildi.")

    End Sub

    Private Sub Button2_Click(sender As System.Object, e As System.EventArgs) Handles Button2.Click
        'File.WriteAllBytes(yemekIsim.Text, File.ReadAllBytes(ofd.FileName))
       

        Dim servis As New com.otelservisi.www.Service1

        Dim sql As String = "insert into  yemek_ekle (yemek_isim,yemek_fiyat,yemek_resim,menu_adi) values ('" & yemekIsim.Text & "','" & paradonustur(yemekFiyat.Text) & "', '" & "image/yemek_resim/" & Path.GetFileName(yol) & "','" & menuid(secilenid) & "')"
        servis.calistir(sql)
        My.Computer.Network.UploadFile(ofd.FileName, "ftp://ftp.otelservisi.com/httpdocs/demo/image/yemek_resim/" & Path.GetFileName(yol), "potelsD5", "ote62Ffg", True, 10, FileIO.UICancelOption.DoNothing)
        MessageBox.Show("Başarıyla Eklendi.")
        Dim sql3 As String = "select * from yemek_ekle"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub

    Private Sub comboMenu_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles comboMenu.SelectedIndexChanged
        secilenid = comboMenu.SelectedIndex
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim servis As New com.otelservisi.www.Service1

        If Path.GetFileName(yol) = "" Then
            Dim sql As String = "update yemek_ekle set yemek_isim='" + yemekIsim.Text + "',yemek_fiyat='" + yemekFiyat.Text + "',yemek_resim,menu_adi= where id=" & secilen
            servis.calistir(sql)
        Else
            Dim sql2 As String = "update yemek_ekle set isim='" + yemekFiyat.Text + "',resimyol='" & "image/yemek_resim/" & Path.GetFileName(yol) & "'where id=" & secilen
            servis.calistir(sql2)
            My.Computer.Network.UploadFile(ofd.FileName, "ftp://ftp.otelservisi.com/httpdocs/demo/image/yemek_resim/" & Path.GetFileName(yol), "potelsD5", "ote62Ffg", True, 10, FileIO.UICancelOption.DoNothing)
        End If

        Dim sql3 As String = "select * from yemek_ekle"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)

        MessageBox.Show("Başarıyla Güncellendi.")
    End Sub

    Private Sub DataGridView1_RowEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.RowEnter
        secilen = DataGridView1.Rows(e.RowIndex).Cells(0).Value
        yemekIsim.Text = DataGridView1.Rows(e.RowIndex).Cells(1).Value
        yemekFiyat.Text = DataGridView1.Rows(e.RowIndex).Cells(2).Value
        secMenu = DataGridView1.Rows(e.RowIndex).Cells(2).Value


        
        yolResim = DataGridView1.Rows(e.RowIndex).Cells(2).Value
    End Sub


    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim servis As New com.otelservisi.www.Service1
        Dim sql As String = "delete * from yemek_ekle where id=" & secilen & ""
        servis.calistir(sql)

        MessageBox.Show("Başarıyla Silindi.")

        Dim sql3 As String = "select * from yemek_ekle"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub

    Private Sub LinkLabel5_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel5.LinkClicked
        Me.Hide()
        Form6.Show()
    End Sub

    Private Sub LinkLabel6_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel6.LinkClicked
        Me.Hide()
        Form7.Show()
    End Sub

    Private Sub LinkLabel7_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel7.LinkClicked
        Me.Hide()
        Form8.Show()
    End Sub
End Class