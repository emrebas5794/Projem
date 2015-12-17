Imports System.Data.OleDb
Imports System.Linq
Imports System.Text
Imports System.Windows.Forms
Imports System.IO
Public Class Form7

    Private Sub RichTextBox1_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RichTextBox1.TextChanged

    End Sub
    Dim yol As String
    Dim yolResim As String
    Dim secilenid As Integer
    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        ofd.Title = "Resim Dosyası Aç"
        ofd.Filter = "resim dosyaları (*.jpg)|*.jpg|(*.png)|*.png |Tüm dosyalar (*.*)|*.*"
        If ofd.ShowDialog = Windows.Forms.DialogResult.OK Then
            yol = ofd.FileName
        End If
        '    File.WriteAllBytes("www.kralled.com/kralled.com/wwwroot/image/menu_resim/" & txtInsResimadi.Text & Path.GetExtension(yol), File.ReadAllBytes(ofd.FileName))
        MessageBox.Show("Resim Seçildi.")
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim servis As New com.otelservisi.www.Service1

        Dim sql As String = "insert into  aktiviteler(aktivite_yazi,aktivite_resim) values ('" & RichTextBox1.Text & "','" & "image/aktiviteler/" & Path.GetFileName(yol) & "')"
        servis.calistir(sql)
        My.Computer.Network.UploadFile(ofd.FileName, "ftp://ftp.otelservisi.com/httpdocs/demo/image/aktiviteler/" & Path.GetFileName(yol), "potelsD5", "ote62Ffg", True, 10, FileIO.UICancelOption.DoNothing)
        MessageBox.Show("Başarıyla Eklendi.")
        Dim sql3 As String = "select * from aktiviteler"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub

   
    Private Sub LinkLabel6_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs)

    End Sub

    Private Sub LinkLabel1_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel1.LinkClicked
        Me.Hide()
        Form2.Show()
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

    Private Sub LinkLabel5_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel5.LinkClicked
        Me.Hide()
        Form6.Show()
    End Sub

    Private Sub LinkLabel7_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel7.LinkClicked
        Me.Hide()
        Form8.Show()
    End Sub

    Private Sub Form7_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Dim servis As New com.otelservisi.www.Service1
        Dim sql3 As String = "select * from aktiviteler"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub
End Class