<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
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
        Me.LinkLabel4 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel3 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel2 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel1 = New System.Windows.Forms.LinkLabel()
        Me.SatislarBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.SatislarDataSet = New otel_proje.satislarDataSet()
        Me.SatislarTableAdapter = New otel_proje.satislarDataSetTableAdapters.satislarTableAdapter()
        Me.VtDataSet3 = New otel_proje.vtDataSet3()
        Me.VtDataSet3BindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.LinkLabel5 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel6 = New System.Windows.Forms.LinkLabel()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.İdDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.YemekIsımDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.YemekFiyatDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.OdanoDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.SiptarihDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.PictureBox3 = New System.Windows.Forms.PictureBox()
        Me.PictureBox2 = New System.Windows.Forms.PictureBox()
        Me.PictureBox1 = New System.Windows.Forms.PictureBox()
        Me.LinkLabel7 = New System.Windows.Forms.LinkLabel()
        CType(Me.SatislarBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.SatislarDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.VtDataSet3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.VtDataSet3BindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PictureBox3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PictureBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
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
        Me.LinkLabel4.Location = New System.Drawing.Point(459, 120)
        Me.LinkLabel4.Name = "LinkLabel4"
        Me.LinkLabel4.Size = New System.Drawing.Size(59, 13)
        Me.LinkLabel4.TabIndex = 15
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
        Me.LinkLabel3.Location = New System.Drawing.Point(345, 120)
        Me.LinkLabel3.Name = "LinkLabel3"
        Me.LinkLabel3.Size = New System.Drawing.Size(92, 13)
        Me.LinkLabel3.TabIndex = 14
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
        Me.LinkLabel2.Location = New System.Drawing.Point(251, 120)
        Me.LinkLabel2.Name = "LinkLabel2"
        Me.LinkLabel2.Size = New System.Drawing.Size(74, 13)
        Me.LinkLabel2.TabIndex = 13
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
        Me.LinkLabel1.Location = New System.Drawing.Point(159, 120)
        Me.LinkLabel1.Name = "LinkLabel1"
        Me.LinkLabel1.Size = New System.Drawing.Size(69, 13)
        Me.LinkLabel1.TabIndex = 12
        Me.LinkLabel1.TabStop = True
        Me.LinkLabel1.Text = "MENÜ EKLE"
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
        'SatislarTableAdapter
        '
        Me.SatislarTableAdapter.ClearBeforeFill = True
        '
        'VtDataSet3
        '
        Me.VtDataSet3.DataSetName = "vtDataSet3"
        Me.VtDataSet3.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'VtDataSet3BindingSource
        '
        Me.VtDataSet3BindingSource.DataSource = Me.VtDataSet3
        Me.VtDataSet3BindingSource.Position = 0
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
        Me.LinkLabel5.Location = New System.Drawing.Point(536, 120)
        Me.LinkLabel5.Name = "LinkLabel5"
        Me.LinkLabel5.Size = New System.Drawing.Size(46, 13)
        Me.LinkLabel5.TabIndex = 62
        Me.LinkLabel5.TabStop = True
        Me.LinkLabel5.Text = "GALERİ"
        Me.LinkLabel5.TextAlign = System.Drawing.ContentAlignment.TopCenter
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
        Me.LinkLabel6.Location = New System.Drawing.Point(600, 120)
        Me.LinkLabel6.Name = "LinkLabel6"
        Me.LinkLabel6.Size = New System.Drawing.Size(76, 13)
        Me.LinkLabel6.TabIndex = 63
        Me.LinkLabel6.TabStop = True
        Me.LinkLabel6.Text = "AKTİVİTELER"
        Me.LinkLabel6.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'GroupBox1
        '
        Me.GroupBox1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.GroupBox1.BackgroundImage = Global.otel_proje.My.Resources.Resources.alttasarim
        Me.GroupBox1.Controls.Add(Me.DataGridView1)
        Me.GroupBox1.Location = New System.Drawing.Point(28, 152)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(776, 264)
        Me.GroupBox1.TabIndex = 18
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Son Satışlar"
        '
        'DataGridView1
        '
        Me.DataGridView1.AutoGenerateColumns = False
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.İdDataGridViewTextBoxColumn, Me.YemekIsımDataGridViewTextBoxColumn, Me.YemekFiyatDataGridViewTextBoxColumn, Me.OdanoDataGridViewTextBoxColumn, Me.SiptarihDataGridViewTextBoxColumn})
        Me.DataGridView1.DataSource = Me.SatislarBindingSource
        Me.DataGridView1.Location = New System.Drawing.Point(56, 24)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.Size = New System.Drawing.Size(543, 229)
        Me.DataGridView1.TabIndex = 0
        '
        'İdDataGridViewTextBoxColumn
        '
        Me.İdDataGridViewTextBoxColumn.DataPropertyName = "id"
        Me.İdDataGridViewTextBoxColumn.HeaderText = "id"
        Me.İdDataGridViewTextBoxColumn.Name = "İdDataGridViewTextBoxColumn"
        '
        'YemekIsımDataGridViewTextBoxColumn
        '
        Me.YemekIsımDataGridViewTextBoxColumn.DataPropertyName = "yemekIsım"
        Me.YemekIsımDataGridViewTextBoxColumn.HeaderText = "yemekIsım"
        Me.YemekIsımDataGridViewTextBoxColumn.Name = "YemekIsımDataGridViewTextBoxColumn"
        '
        'YemekFiyatDataGridViewTextBoxColumn
        '
        Me.YemekFiyatDataGridViewTextBoxColumn.DataPropertyName = "yemekFiyat"
        Me.YemekFiyatDataGridViewTextBoxColumn.HeaderText = "yemekFiyat"
        Me.YemekFiyatDataGridViewTextBoxColumn.Name = "YemekFiyatDataGridViewTextBoxColumn"
        '
        'OdanoDataGridViewTextBoxColumn
        '
        Me.OdanoDataGridViewTextBoxColumn.DataPropertyName = "odano"
        Me.OdanoDataGridViewTextBoxColumn.HeaderText = "odano"
        Me.OdanoDataGridViewTextBoxColumn.Name = "OdanoDataGridViewTextBoxColumn"
        '
        'SiptarihDataGridViewTextBoxColumn
        '
        Me.SiptarihDataGridViewTextBoxColumn.DataPropertyName = "siptarih"
        Me.SiptarihDataGridViewTextBoxColumn.HeaderText = "siptarih"
        Me.SiptarihDataGridViewTextBoxColumn.Name = "SiptarihDataGridViewTextBoxColumn"
        '
        'PictureBox3
        '
        Me.PictureBox3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PictureBox3.Location = New System.Drawing.Point(746, 422)
        Me.PictureBox3.Name = "PictureBox3"
        Me.PictureBox3.Size = New System.Drawing.Size(98, 34)
        Me.PictureBox3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom
        Me.PictureBox3.TabIndex = 17
        Me.PictureBox3.TabStop = False
        '
        'PictureBox2
        '
        Me.PictureBox2.BackgroundImage = Global.otel_proje.My.Resources.Resources.alttasarim
        Me.PictureBox2.Dock = System.Windows.Forms.DockStyle.Top
        Me.PictureBox2.Location = New System.Drawing.Point(0, 115)
        Me.PictureBox2.Name = "PictureBox2"
        Me.PictureBox2.Size = New System.Drawing.Size(844, 22)
        Me.PictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
        Me.PictureBox2.TabIndex = 11
        Me.PictureBox2.TabStop = False
        '
        'PictureBox1
        '
        Me.PictureBox1.BackgroundImage = Global.otel_proje.My.Resources.Resources.arkaplan
        Me.PictureBox1.Dock = System.Windows.Forms.DockStyle.Top
        Me.PictureBox1.Location = New System.Drawing.Point(0, 0)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(844, 115)
        Me.PictureBox1.TabIndex = 10
        Me.PictureBox1.TabStop = False
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
        Me.LinkLabel7.Location = New System.Drawing.Point(699, 120)
        Me.LinkLabel7.Name = "LinkLabel7"
        Me.LinkLabel7.Size = New System.Drawing.Size(75, 13)
        Me.LinkLabel7.TabIndex = 64
        Me.LinkLabel7.TabStop = True
        Me.LinkLabel7.Text = "ODA SERVİSİ"
        Me.LinkLabel7.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(844, 456)
        Me.Controls.Add(Me.LinkLabel7)
        Me.Controls.Add(Me.LinkLabel6)
        Me.Controls.Add(Me.LinkLabel5)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.PictureBox3)
        Me.Controls.Add(Me.LinkLabel4)
        Me.Controls.Add(Me.LinkLabel3)
        Me.Controls.Add(Me.LinkLabel2)
        Me.Controls.Add(Me.LinkLabel1)
        Me.Controls.Add(Me.PictureBox2)
        Me.Controls.Add(Me.PictureBox1)
        Me.Name = "Form1"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Form1"
        CType(Me.SatislarBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.SatislarDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.VtDataSet3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.VtDataSet3BindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PictureBox3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PictureBox2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents LinkLabel4 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel3 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel2 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel1 As System.Windows.Forms.LinkLabel
    Friend WithEvents PictureBox2 As System.Windows.Forms.PictureBox
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents PictureBox3 As System.Windows.Forms.PictureBox
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
    Friend WithEvents VtDataSet3BindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents VtDataSet3 As otel_proje.vtDataSet3
    Friend WithEvents SatislarDataSet As otel_proje.satislarDataSet
    Friend WithEvents SatislarBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents SatislarTableAdapter As otel_proje.satislarDataSetTableAdapters.satislarTableAdapter
    Friend WithEvents İdDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents YemekIsımDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents YemekFiyatDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents OdanoDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents SiptarihDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents LinkLabel5 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel6 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel7 As System.Windows.Forms.LinkLabel

End Class
