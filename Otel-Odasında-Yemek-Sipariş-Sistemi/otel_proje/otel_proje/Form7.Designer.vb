<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form7
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.SatislarBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.SatislarDataSet = New otel_proje.satislarDataSet()
        Me.VtDataSet3BindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.VtDataSet3 = New otel_proje.vtDataSet3()
        Me.PictureBox3 = New System.Windows.Forms.PictureBox()
        Me.LinkLabel4 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel3 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel2 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel1 = New System.Windows.Forms.LinkLabel()
        Me.PictureBox2 = New System.Windows.Forms.PictureBox()
        Me.PictureBox1 = New System.Windows.Forms.PictureBox()
        Me.SatislarTableAdapter = New otel_proje.satislarDataSetTableAdapters.satislarTableAdapter()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Button4 = New System.Windows.Forms.Button()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.RichTextBox1 = New System.Windows.Forms.RichTextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.ofd = New System.Windows.Forms.OpenFileDialog()
        Me.LinkLabel7 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel6 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel5 = New System.Windows.Forms.LinkLabel()
        CType(Me.SatislarBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.SatislarDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.VtDataSet3BindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.VtDataSet3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PictureBox3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PictureBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'SatislarBindingSource
        '
        Me.SatislarBindingSource.DataMember = "satislar"
        Me.SatislarBindingSource.DataSource = Me.SatislarDataSet
        '
        'SatislarDataSet
        '
        Me.SatislarDataSet.DataSetName = "satislarDataSet"
        Me.SatislarDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'VtDataSet3BindingSource
        '
        Me.VtDataSet3BindingSource.DataSource = Me.VtDataSet3
        Me.VtDataSet3BindingSource.Position = 0
        '
        'VtDataSet3
        '
        Me.VtDataSet3.DataSetName = "vtDataSet3"
        Me.VtDataSet3.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'PictureBox3
        '
        Me.PictureBox3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PictureBox3.Location = New System.Drawing.Point(878, 470)
        Me.PictureBox3.Name = "PictureBox3"
        Me.PictureBox3.Size = New System.Drawing.Size(98, 34)
        Me.PictureBox3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom
        Me.PictureBox3.TabIndex = 70
        Me.PictureBox3.TabStop = False
        '
        'LinkLabel4
        '
        Me.LinkLabel4.AccessibleRole = System.Windows.Forms.AccessibleRole.None
        Me.LinkLabel4.ActiveLinkColor = System.Drawing.Color.MidnightBlue
        Me.LinkLabel4.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.LinkLabel4.AutoSize = True
        Me.LinkLabel4.BackColor = System.Drawing.SystemColors.ActiveCaption
        Me.LinkLabel4.LinkBehavior = System.Windows.Forms.LinkBehavior.HoverUnderline
        Me.LinkLabel4.LinkColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(89, Byte), Integer), CType(CType(106, Byte), Integer))
        Me.LinkLabel4.Location = New System.Drawing.Point(463, 118)
        Me.LinkLabel4.Name = "LinkLabel4"
        Me.LinkLabel4.Size = New System.Drawing.Size(59, 13)
        Me.LinkLabel4.TabIndex = 69
        Me.LinkLabel4.TabStop = True
        Me.LinkLabel4.Text = "SATIŞLAR"
        Me.LinkLabel4.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'LinkLabel3
        '
        Me.LinkLabel3.AccessibleRole = System.Windows.Forms.AccessibleRole.None
        Me.LinkLabel3.ActiveLinkColor = System.Drawing.Color.MidnightBlue
        Me.LinkLabel3.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.LinkLabel3.AutoSize = True
        Me.LinkLabel3.BackColor = System.Drawing.SystemColors.ActiveCaption
        Me.LinkLabel3.LinkBehavior = System.Windows.Forms.LinkBehavior.HoverUnderline
        Me.LinkLabel3.LinkColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(89, Byte), Integer), CType(CType(106, Byte), Integer))
        Me.LinkLabel3.Location = New System.Drawing.Point(349, 118)
        Me.LinkLabel3.Name = "LinkLabel3"
        Me.LinkLabel3.Size = New System.Drawing.Size(92, 13)
        Me.LinkLabel3.TabIndex = 68
        Me.LinkLabel3.TabStop = True
        Me.LinkLabel3.Text = "KULLANICI EKLE"
        Me.LinkLabel3.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'LinkLabel2
        '
        Me.LinkLabel2.AccessibleRole = System.Windows.Forms.AccessibleRole.None
        Me.LinkLabel2.ActiveLinkColor = System.Drawing.Color.MidnightBlue
        Me.LinkLabel2.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.LinkLabel2.AutoSize = True
        Me.LinkLabel2.BackColor = System.Drawing.SystemColors.ActiveCaption
        Me.LinkLabel2.LinkBehavior = System.Windows.Forms.LinkBehavior.HoverUnderline
        Me.LinkLabel2.LinkColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(89, Byte), Integer), CType(CType(106, Byte), Integer))
        Me.LinkLabel2.Location = New System.Drawing.Point(255, 118)
        Me.LinkLabel2.Name = "LinkLabel2"
        Me.LinkLabel2.Size = New System.Drawing.Size(74, 13)
        Me.LinkLabel2.TabIndex = 67
        Me.LinkLabel2.TabStop = True
        Me.LinkLabel2.Text = "YEMEK EKLE"
        '
        'LinkLabel1
        '
        Me.LinkLabel1.AccessibleRole = System.Windows.Forms.AccessibleRole.None
        Me.LinkLabel1.ActiveLinkColor = System.Drawing.Color.MidnightBlue
        Me.LinkLabel1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.LinkLabel1.AutoSize = True
        Me.LinkLabel1.BackColor = System.Drawing.SystemColors.ActiveCaption
        Me.LinkLabel1.LinkBehavior = System.Windows.Forms.LinkBehavior.HoverUnderline
        Me.LinkLabel1.LinkColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(89, Byte), Integer), CType(CType(106, Byte), Integer))
        Me.LinkLabel1.Location = New System.Drawing.Point(163, 118)
        Me.LinkLabel1.Name = "LinkLabel1"
        Me.LinkLabel1.Size = New System.Drawing.Size(69, 13)
        Me.LinkLabel1.TabIndex = 66
        Me.LinkLabel1.TabStop = True
        Me.LinkLabel1.Text = "MENÜ EKLE"
        '
        'PictureBox2
        '
        Me.PictureBox2.BackgroundImage = Global.otel_proje.My.Resources.Resources.alttasarim
        Me.PictureBox2.Dock = System.Windows.Forms.DockStyle.Top
        Me.PictureBox2.Location = New System.Drawing.Point(0, 115)
        Me.PictureBox2.Name = "PictureBox2"
        Me.PictureBox2.Size = New System.Drawing.Size(988, 22)
        Me.PictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
        Me.PictureBox2.TabIndex = 65
        Me.PictureBox2.TabStop = False
        '
        'PictureBox1
        '
        Me.PictureBox1.BackgroundImage = Global.otel_proje.My.Resources.Resources.arkaplan
        Me.PictureBox1.Dock = System.Windows.Forms.DockStyle.Top
        Me.PictureBox1.Location = New System.Drawing.Point(0, 0)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(988, 115)
        Me.PictureBox1.TabIndex = 64
        Me.PictureBox1.TabStop = False
        '
        'SatislarTableAdapter
        '
        Me.SatislarTableAdapter.ClearBeforeFill = True
        '
        'Button2
        '
        Me.Button2.BackgroundImage = Global.otel_proje.My.Resources.Resources.Images_icon
        Me.Button2.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom
        Me.Button2.Location = New System.Drawing.Point(455, 171)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(225, 53)
        Me.Button2.TabIndex = 78
        Me.Button2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Button4
        '
        Me.Button4.BackgroundImage = Global.otel_proje.My.Resources.Resources.sil
        Me.Button4.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom
        Me.Button4.Location = New System.Drawing.Point(218, 301)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(191, 48)
        Me.Button4.TabIndex = 77
        Me.Button4.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.Button4.UseVisualStyleBackColor = True
        '
        'Button3
        '
        Me.Button3.BackgroundImage = Global.otel_proje.My.Resources.Resources.guncelle
        Me.Button3.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom
        Me.Button3.Location = New System.Drawing.Point(12, 301)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(191, 48)
        Me.Button3.TabIndex = 76
        Me.Button3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.Button3.UseVisualStyleBackColor = True
        '
        'DataGridView1
        '
        Me.DataGridView1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.DataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Location = New System.Drawing.Point(0, 355)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.Size = New System.Drawing.Size(835, 159)
        Me.DataGridView1.TabIndex = 75
        '
        'Button1
        '
        Me.Button1.BackgroundImage = Global.otel_proje.My.Resources.Resources.k_ekle
        Me.Button1.Location = New System.Drawing.Point(455, 240)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(155, 55)
        Me.Button1.TabIndex = 74
        Me.Button1.UseVisualStyleBackColor = True
        '
        'RichTextBox1
        '
        Me.RichTextBox1.Location = New System.Drawing.Point(0, 171)
        Me.RichTextBox1.Name = "RichTextBox1"
        Me.RichTextBox1.Size = New System.Drawing.Size(449, 124)
        Me.RichTextBox1.TabIndex = 79
        Me.RichTextBox1.Text = ""
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 155)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(72, 13)
        Me.Label1.TabIndex = 80
        Me.Label1.Text = "Activite Yazısı"
        '
        'ofd
        '
        Me.ofd.FileName = "OpenFileDialog1"
        '
        'LinkLabel7
        '
        Me.LinkLabel7.AccessibleRole = System.Windows.Forms.AccessibleRole.None
        Me.LinkLabel7.ActiveLinkColor = System.Drawing.Color.MidnightBlue
        Me.LinkLabel7.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.LinkLabel7.AutoSize = True
        Me.LinkLabel7.BackColor = System.Drawing.SystemColors.ActiveCaption
        Me.LinkLabel7.LinkBehavior = System.Windows.Forms.LinkBehavior.HoverUnderline
        Me.LinkLabel7.LinkColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(89, Byte), Integer), CType(CType(106, Byte), Integer))
        Me.LinkLabel7.Location = New System.Drawing.Point(703, 118)
        Me.LinkLabel7.Name = "LinkLabel7"
        Me.LinkLabel7.Size = New System.Drawing.Size(75, 13)
        Me.LinkLabel7.TabIndex = 83
        Me.LinkLabel7.TabStop = True
        Me.LinkLabel7.Text = "ODA SERVİSİ"
        Me.LinkLabel7.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'LinkLabel6
        '
        Me.LinkLabel6.AccessibleRole = System.Windows.Forms.AccessibleRole.None
        Me.LinkLabel6.ActiveLinkColor = System.Drawing.Color.MidnightBlue
        Me.LinkLabel6.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.LinkLabel6.AutoSize = True
        Me.LinkLabel6.BackColor = System.Drawing.SystemColors.ActiveCaption
        Me.LinkLabel6.LinkBehavior = System.Windows.Forms.LinkBehavior.HoverUnderline
        Me.LinkLabel6.LinkColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(89, Byte), Integer), CType(CType(106, Byte), Integer))
        Me.LinkLabel6.Location = New System.Drawing.Point(604, 118)
        Me.LinkLabel6.Name = "LinkLabel6"
        Me.LinkLabel6.Size = New System.Drawing.Size(76, 13)
        Me.LinkLabel6.TabIndex = 82
        Me.LinkLabel6.TabStop = True
        Me.LinkLabel6.Text = "AKTİVİTELER"
        Me.LinkLabel6.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'LinkLabel5
        '
        Me.LinkLabel5.AccessibleRole = System.Windows.Forms.AccessibleRole.None
        Me.LinkLabel5.ActiveLinkColor = System.Drawing.Color.MidnightBlue
        Me.LinkLabel5.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.LinkLabel5.AutoSize = True
        Me.LinkLabel5.BackColor = System.Drawing.SystemColors.ActiveCaption
        Me.LinkLabel5.LinkBehavior = System.Windows.Forms.LinkBehavior.HoverUnderline
        Me.LinkLabel5.LinkColor = System.Drawing.Color.FromArgb(CType(CType(51, Byte), Integer), CType(CType(89, Byte), Integer), CType(CType(106, Byte), Integer))
        Me.LinkLabel5.Location = New System.Drawing.Point(540, 118)
        Me.LinkLabel5.Name = "LinkLabel5"
        Me.LinkLabel5.Size = New System.Drawing.Size(46, 13)
        Me.LinkLabel5.TabIndex = 81
        Me.LinkLabel5.TabStop = True
        Me.LinkLabel5.Text = "GALERİ"
        Me.LinkLabel5.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'Form7
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(988, 516)
        Me.Controls.Add(Me.LinkLabel7)
        Me.Controls.Add(Me.LinkLabel6)
        Me.Controls.Add(Me.LinkLabel5)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.RichTextBox1)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button4)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.DataGridView1)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.PictureBox3)
        Me.Controls.Add(Me.LinkLabel4)
        Me.Controls.Add(Me.LinkLabel3)
        Me.Controls.Add(Me.LinkLabel2)
        Me.Controls.Add(Me.LinkLabel1)
        Me.Controls.Add(Me.PictureBox2)
        Me.Controls.Add(Me.PictureBox1)
        Me.Name = "Form7"
        Me.Text = "Form7"
        CType(Me.SatislarBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.SatislarDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.VtDataSet3BindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.VtDataSet3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PictureBox3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PictureBox2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents SatislarBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents SatislarDataSet As otel_proje.satislarDataSet
    Friend WithEvents VtDataSet3BindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents VtDataSet3 As otel_proje.vtDataSet3
    Friend WithEvents PictureBox3 As System.Windows.Forms.PictureBox
    Friend WithEvents LinkLabel4 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel3 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel2 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel1 As System.Windows.Forms.LinkLabel
    Friend WithEvents PictureBox2 As System.Windows.Forms.PictureBox
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents SatislarTableAdapter As otel_proje.satislarDataSetTableAdapters.satislarTableAdapter
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents RichTextBox1 As System.Windows.Forms.RichTextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents ofd As System.Windows.Forms.OpenFileDialog
    Friend WithEvents LinkLabel7 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel6 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel5 As System.Windows.Forms.LinkLabel
End Class
