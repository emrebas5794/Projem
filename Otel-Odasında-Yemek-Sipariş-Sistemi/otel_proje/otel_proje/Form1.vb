Public Class Form1

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
    Private Sub LinkLabel4_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel4.LinkClicked
        Me.Hide()
        Form5.Show()
    End Sub

    Private Sub Form1_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        'TODO: This line of code loads data into the 'SatislarDataSet.satislar' table. You can move, or remove it, as needed.
        Dim servis As New com.otelservisi.www.Service1
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


    
   
    Private Sub LinkLabel5_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel5.LinkClicked
        Me.Hide()
        Form6.Show()
    End Sub

    Private Sub LinkLabel6_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel6.LinkClicked
        Me.Hide()
        Form7.Show()
    End Sub

    Private Sub PictureBox2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PictureBox2.Click

    End Sub

    Private Sub LinkLabel7_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel7.LinkClicked
        Me.Hide()
        Form8.Show()
    End Sub
End Class
