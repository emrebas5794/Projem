Public Class Form8
    Dim secilen As Integer
    Dim yol As String
    Dim yolResim As String
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim servis As New com.otelservisi.www.Service1

        Dim sql As String = "insert into  odaservisi(kategori) values ('" & TextBox1.Text & "')"
        servis.calistir(sql)
        MessageBox.Show("Başarıyla Eklendi.")


        Dim sql2 As String = "select * from odaservisi"
        Dim ds As New DataSet
        ds = servis.vericekme(sql2)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub

    Private Sub Form8_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Dim servis As New com.otelservisi.www.Service1
        Dim sql2 As String = "select * from odaservisi"
        Dim ds As New DataSet
        ds = servis.vericekme(sql2)
        DataGridView1.DataSource = ds.Tables(0)
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

    Private Sub LinkLabel6_LinkClicked(sender As System.Object, e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel6.LinkClicked
        Me.Hide()
        Form7.Show()
    End Sub


    Private Sub DataGridView1_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.RowEnter
        secilen = DataGridView1.Rows(e.RowIndex).Cells(0).Value
        TextBox1.Text = DataGridView1.Rows(e.RowIndex).Cells(1).Value



    End Sub

    Private Sub Button3_Click(sender As System.Object, e As System.EventArgs) Handles Button3.Click
        Dim servis As New com.otelservisi.www.Service1
        Dim sql As String = "update odaservisi set kategori='" + TextBox1.Text + "' where id=" & secilen
        servis.calistir(sql)
        Dim sql3 As String = "select * from odaservisi"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)

        MessageBox.Show("Başarıyla Güncellendi.")
    End Sub

    Private Sub Button4_Click(sender As System.Object, e As System.EventArgs) Handles Button4.Click
        Dim servis As New com.otelservisi.www.Service1
        Dim sql As String = "delete * from odaservisi where id=" & secilen & ""
        servis.calistir(sql)

        MessageBox.Show("Başarıyla Silindi.")

        Dim sql3 As String = "select * from odaservisi"
        Dim ds As New DataSet
        ds = servis.vericekme(sql3)
        DataGridView1.DataSource = ds.Tables(0)
    End Sub
End Class