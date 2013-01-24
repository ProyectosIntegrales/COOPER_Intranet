
Partial Class cdd_cddEngs
    Inherits System.Web.UI.UserControl
    Public Property Mode As String
        Get
            Return hflMode.Value
        End Get
        Set(value As String)
            hflMode.Value = value
        
            txtCalEngNo.Visible = hflMode.Value = "E"
            txtMfgEngNo.Visible = hflMode.Value = "E"

            lblCalEngNo.Visible = hflMode.Value = "I"
            lblMfgEngNo.Visible = hflMode.Value = "I"
        End Set
    End Property

    Public Property AreaId As Integer
        Get
            Return hflAreaID.Value
        End Get
        Set(value As Integer)
            hflAreaID.Value = value
            setLabels()
        End Set
    End Property

    Protected Sub pnlEngs_PreRender(sender As Object, e As System.EventArgs) Handles pnlEngs.PreRender

        Dim dt As Data.DataTable = SQLDataTable("select * from cdd.tblCeldas where celdaAreaId = " & hflAreaID.Value)

        pnlEngs.Visible = dt.Rows.Count > 0

    End Sub

    Public Sub Update()

        Try
            doSQLProcedure("spEngs", Data.CommandType.StoredProcedure, _
                           "@areaId", hflAreaID.Value, _
                           "@calEngNo", IIf(txtCalEngNo.Text.Trim = "" Or txtCalEngNo.Text.Trim = "0", Nothing, txtCalEngNo.Text), _
                           "@mfgEngNo", IIf(txtMfgEngNo.Text.Trim = "" Or txtMfgEngNo.Text.Trim = "0", Nothing, txtMfgEngNo.Text))

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub txtMfgEngNo_TextChanged(sender As Object, e As System.EventArgs) Handles txtMfgEngNo.TextChanged

        If txtMfgEngNo.Text.Trim <> "" Then
            lblMfgEngName.Text = New Employee(txtMfgEngNo.Text).FullName
        Else
            lblMfgEngName.Text = ""
        End If

    End Sub

    Protected Sub txtCalEngNo_TextChanged(sender As Object, e As System.EventArgs) Handles txtCalEngNo.TextChanged

        If txtCalEngNo.Text.Trim <> "" Then
            lblCalEngName.Text = New Employee(txtCalEngNo.Text).FullName
        Else
            lblCalEngName.Text = ""
        End If

    End Sub

    Protected Sub setLabels()

        Dim dt As Data.DataTable = SQLDataTable("select * from vAreas where areaId = " & hflAreaID.Value)

        If dt.Rows.Count > 0 Then
            Dim dr As Data.DataRow = dt.Rows.Item(0)
            lblCalEngNo.Text = isNull(dr.Item("calEngEmpNo"), "")
            lblMfgEngNo.Text = isNull(dr.Item("mfgEngEmpNo"), "")

            txtCalEngNo.Text = isNull(dr.Item("calEngEmpNo"), "")
            txtMfgEngNo.Text = isNull(dr.Item("mfgEngEmpNo"), "")

            'lblCalEngName.Text = New Employee(lblCalEngNo.Text).FullName
            'lblMfgEngName.Text = New Employee(lblMfgEngNo.Text).FullName

            lblCalEngName.Text = isNull(dr.Item("calEngName"), "<span class='blink'>No hay Ingeniero de Calidad</span>")
            lblMfgEngName.Text = isNull(dr.Item("mfgEngName"), "<span class='blink'>No hay Ingeniero de Manufactura</span>")

        End If
    End Sub
End Class
