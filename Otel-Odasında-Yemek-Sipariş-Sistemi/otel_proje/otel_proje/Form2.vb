Imports System.Data.OleDb
Imports System.Net
Imports System.IO


Public Class Form2
    'Sub veriyenile()
    '    Dim servis As New ServiceReference1.Service1SoapClient
    '    Dim sql As String = "select * from stok"
    '    'Dim adaptor As New OleDbDataAdapter(sql, baglanti)
    '    Dim dt As New DataTable
    '    'adaptor.Fill(dt)
    '    servis.calistir(sql)
    '    DataGridView1.DataSource = dt
    'End Sub
    Dim secilen As Integer
    Dim yol As String
    Dim yolResim As String


    Private Sub Button1_Click(sender As System.Object, e As System.EventArgs) Handles Button1.Click
        ofd.Title = "Resim Dosyası Aç"
        ofd.Filter = "resim dosyaları (*.jpg)|*.jpg|Tüm dosyalar (*.*)|*.*"
        If ofd.ShowDialog = Windows.Forms.DialogResult.OK Then
            yol = ofd.FileName
        End If
        '    File.WriteAllBytes("www.kralled.com/kralled.com/wwwroot/image/menu_resim/" & txtInsResimadi.Text & Path.GetExtension(yol), File.ReadAllBytes(ofd.FileName))
        MessageBox.Show("Resim Seçildi.")
    End Sub



    Private Sub LinkLabel2_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel2.LinkClicked
        Me.Hide()
        Form3.Show()
    End Sub

    Private Sub LinkLabel3_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel3.LinkClicked
        Me.Hide()
        Form4.Show()
    End Sub
    Private Sub LinkLabel4_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel4.LinkClicked
        Me.Hide()
        Form5.Show()
    End Sub



    Private Sub Form2_FormClosing(sender As Object, e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Application.Exit()

    End Sub


    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim servis As New com.otelservisi.www.Service1

        Dim sql As String = "insert into menu_ekle (isim,resimyol) values ('" + txtInsResimadi.Text & "','" & "image/menu_resim/" & Path.GetFileName(yol) & "')"
        servis.calistir(sql)
        My.Computer.Network.UploadFile(ofd.FileName, "ftp://ftp.otelservisi.com/httpdocs/demo/image/menu_resim/" & Path.GetFileName(yol), "potelsD5", "ote62Ffg", True, 10, FileIO.UICancelOption.DoNothing)
        MessageBox.Show("Başarıyla Eklendi.")


        Dim sql3 As String = "select * from menu_ekle"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub


    Private Sub Form2_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load


        Dim servis As New com.otelservisi.www.Service1
        Dim sql As String = "select * from menu_ekle"
        Dim ds As New DataSet
        ds = servis.vericekme(sql)
        DataGridView1.DataSource = ds.Tables(0)
       
        If My.Computer.Network.IsAvailable = True Then
            PictureBox3.Image = Image.FromFile(Application.StartupPath + "/icon/var.png")
        Else
            PictureBox3.Image = Image.FromFile(Application.StartupPath + "/icon/yok.png")
        End If

    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim servis As New com.otelservisi.www.Service1

        If Path.GetFileName(yol) = "" Then
            Dim sql As String = "update menu_ekle set isim='" + txtInsResimadi.Text + "' where id=" & secilen
            servis.calistir(sql)
        Else
            Dim sql2 As String = "update menu_ekle set isim='" + txtInsResimadi.Text + "',resimyol='" & "image/menu_resim/" & Path.GetFileName(yol) & "'where id=" & secilen
            servis.calistir(sql2)


            
            My.Computer.Network.UploadFile(ofd.FileName, "ftp://ftp.otelservisi.com/httpdocs/demo/image/menu_resim/" & Path.GetFileName(yol), "potelsD5", "ote62Ffg", True, 10, FileIO.UICancelOption.DoNothing)
        End If

        Dim sql3 As String = "select * from menu_ekle"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)

        MessageBox.Show("Başarıyla Güncellendi.")
    End Sub


    Private Sub DataGridView1_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.RowEnter
        secilen = DataGridView1.Rows(e.RowIndex).Cells(0).Value
        txtInsResimadi.Text = DataGridView1.Rows(e.RowIndex).Cells(1).Value

        yolResim = DataGridView1.Rows(e.RowIndex).Cells(2).Value

    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click

        Dim servis As New com.otelservisi.www.Service1
        Dim sql As String = "delete * from menu_ekle where id=" & secilen & ""
        servis.calistir(sql)

        MessageBox.Show("Başarıyla Silindi.")

        Dim sql3 As String = "select * from menu_ekle"
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