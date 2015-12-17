Imports System.Data.OleDb
Imports System.IO

Public Class Form4

    Dim secilen As Integer
  
   
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        'Dim servis As ServiceReference1.Service1SoapClient
        'Dim sql As String = "insert into kullanici_ekle (kul_adi) values ('" + kulAdi.Text & "')"
        'servis.calistir(sql)
        'MessageBox.Show("Başarıyla Eklendi.")


        If IsNumeric(kulAdi.Text) Then
            Dim servis As New ServiceReference1.Service1SoapClient

            Dim sql As String = "insert into  kullaniciler (kullaniciadi,sifre) values ('" & kulAdi.Text & "','" & TextBox1.Text & "')"
            servis.calistir(sql)
            MessageBox.Show("Başarıyla Eklendi.")


            Dim sql2 As String = "select * from kullaniciler"
            Dim ds As New DataSet
            ds = servis.vericekme(sql2)
            DataGridView1.DataSource = ds.Tables(0)
        Else
            MsgBox("Lütfen Sayı Giriniz.")

        End If
       
    End Sub

    Private Sub Form4_FormClosing(sender As Object, e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Application.Exit()
    End Sub

    Private Sub LinkLabel1_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel1.LinkClicked

        Me.Hide()
        Form2.Show()

    End Sub

    Private Sub LinkLabel2_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel2.LinkClicked
        Me.Hide()
        Form3.Show()
    End Sub

    Private Sub LinkLabel4_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel4.LinkClicked
        Me.Hide()
        Form5.Show()
    End Sub

    Private Sub Form4_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim servis As New com.otelservisi.www.Service1
        
        Dim sql As String = "select * from kullaniciler"
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
        If IsNumeric(kulAdi.Text) Then


            Dim servis As New com.otelservisi.www.Service1
            Dim sql As String = "update kullaniciler set kullaniciadi='" + kulAdi.Text + "',sifre='" + TextBox1.Text + "' where id=" & secilen
            servis.calistir(sql)

            Dim sql3 As String = "select * from kullaniciler"
            Dim ds As New DataSet
            ds = servis.vericekme(sql3)
            DataGridView1.DataSource = ds.Tables(0)

            MessageBox.Show("Başarıyla Güncellendi.")
        Else
            MessageBox.Show("Lütfen Sayı Giriniz.")
        End If

    End Sub

    Private Sub DataGridView1_RowEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.RowEnter
        secilen = DataGridView1.Rows(e.RowIndex).Cells(0).Value
        kulAdi.Text = DataGridView1.Rows(e.RowIndex).Cells(1).Value
  
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim servis As New com.otelservisi.www.Service1
        Dim sql As String = "delete * from kullaniciler  where id=" & secilen
        servis.calistir(sql)

        Dim sql3 As String = "select * from kullaniciler"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)

        MessageBox.Show("Başarıyla Silindi.")
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

  
    Private Sub Label1_Click(sender As System.Object, e As System.EventArgs) Handles Label1.Click

    End Sub
End Class