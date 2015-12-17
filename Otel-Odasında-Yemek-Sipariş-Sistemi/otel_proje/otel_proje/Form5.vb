Imports System.IO

Public Class Form5
    Dim secilenid As Integer
    Dim secilenyemekadi As String
    Dim secilenyemekadet As String
    Dim secilenoda As String

    Private Sub LinkLabel1_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel1.LinkClicked
        Me.Hide()
        Form2.Show()
    End Sub

    Private Sub LinkLabel2_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel2.LinkClicked
        Me.Hide()
        Form3.Show()
    End Sub

    Private Sub LinkLabel3_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel3.LinkClicked
        Me.Hide()
        Form4.Show()
    End Sub

    Private Sub Form5_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Application.Exit()
    End Sub


    Private Sub Form5_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

       

        Timer1.Start()

        Dim servis As New ServiceReference1.Service1SoapClient
        Dim sql As String = "select * from siparis"
        Dim ds As New DataSet

      

        ds = servis.vericekme(sql)
        DataGridView1.DataSource = ds.Tables(0)
        If My.Computer.Network.IsAvailable = True Then
            PictureBox3.Image = Image.FromFile(Application.StartupPath + "/icon/var.png")
        Else
            PictureBox3.Image = Image.FromFile(Application.StartupPath + "/icon/yok.png")
        End If
    End Sub



    Private Sub DataGridView1_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.RowEnter
        secilenid = DataGridView1.Rows(e.RowIndex).Cells(0).Value
        secilenoda = DataGridView1.Rows(e.RowIndex).Cells(1).Value
        secilenyemekadi = DataGridView1.Rows(e.RowIndex).Cells(2).Value
        secilenyemekadet = DataGridView1.Rows(e.RowIndex).Cells(3).Value

    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        Dim servis As New com.otelservisi.www.Service1

        Dim sql As String = "insert into yemekhane (odano,yemekadi,yemekadet) values('" & secilenoda & "','" & secilenyemekadi & "','" & secilenyemekadet & "')"
        Dim sql2 As String = "delete * from siparis where id=" & secilenid & ""

        servis.calistir(sql)
        servis.calistir(sql2)
        MsgBox("Onay Verilmiştir..")

        Dim sql3 As String = "select * from siparis"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim servis As New com.otelservisi.www.Service1
        Dim sql3 As String = "select * from siparis"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim servis As New com.otelservisi.www.Service1

        Dim sql2 As String = "delete * from siparis where id=" & secilenid & ""

        servis.calistir(sql2)
        Dim sql3 As String = "select * from siparis"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        Dim servis As New com.otelservisi.www.Service1
        Dim sql3 As String = "select * from siparis"
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