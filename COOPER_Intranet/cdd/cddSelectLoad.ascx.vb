
Partial Class cdd_cddSelectLoad
    Inherits System.Web.UI.UserControl

    Public Property DeptoID As Integer
        Get
            Return hflDeptId.Value
        End Get
        Set(value As Integer)
            hflDeptId.Value = value
            Dim dt As Data.DataTable = SQLDataTable("select deptoName, deptoMnemonic from tblDeptos where deptoID = " & value)
            If dt.Rows.Count > 0 Then
                Dim dr As Data.DataRow = dt.Rows(0)
                lnbDeptoName.Text = Mid(dr.Item("deptoName"), 1, 1) & Mid(dr.Item("deptoName"), 2).ToLower
                hflMnemDepto.Value = isNull(dr.Item("deptoMnemonic"), "")
            Else
                lnbDeptoName.Text = "[Seleccionar Departamento]"
            End If
        End Set
    End Property

    Public Property AreaID As Integer
        Get
            Return hflAreaID.Value
        End Get
        Set(value As Integer)
            hflAreaID.Value = value
            populateAreas()
        End Set
    End Property

    Public Property CeldaID As Integer
        Get
            Return hflCeldaID.Value
        End Get
        Set(value As Integer)
            hflCeldaID.Value = value
            populateCeldas()
        End Set
    End Property

    Public ReadOnly Property DeptoName As String
        Get
            Return lnbDeptoName.Text
        End Get
    End Property

    Public ReadOnly Property AreaName As String
        Get
            Return lnbAreaName.Text
        End Get
    End Property

    Public ReadOnly Property CeldaName As String
        Get
            Return lnbCeldaName.Text
        End Get
    End Property

    Public WriteOnly Property Enabled As Boolean
        Set(value As Boolean)
            pnlPopUp.Visible = value
            pnlAreasPopUp.Visible = value

            pnlCeldasPopUp.Visible = value
        End Set
    End Property

    Public ReadOnly Property Mnemonic As String
        Get
            If hflMnemCelda.Value.Trim <> "" Then
                Return hflMnemCelda.Value
            ElseIf hflMnemArea.Value.Trim <> "" Then
                Return hflMnemArea.Value
            Else
                Return hflMnemDepto.Value
            End If

        End Get
    End Property

    Public ReadOnly Property areaMnemonic As String
        Get
            Return hflMnemArea.Value
        End Get
    End Property

    Public ReadOnly Property deptoMnemonic As String
        Get
            Return hflMnemDepto.Value
        End Get
    End Property

    Public Sub populateAreas()
        Dim dt1 As Data.DataTable = SQLDataTable("select * from tblAreas where areaDeptoID = " & hflDeptId.Value)
        If dt1.Rows.Count > 0 Then
            Dim dt As Data.DataTable = SQLDataTable("select areaName, areaMnemonic from tblAreas where areaID = " & hflAreaID.Value)
            If dt.Rows.Count > 0 Then
                Dim dr As Data.DataRow = dt.Rows(0)
                lnbAreaName.Text = dr.Item("areaName")
                hflMnemArea.Value = dr.Item("areaMnemonic")
            Else
                lnbAreaName.Text = "Todas las areas"
                hflAreaID.Value = 0
            End If
            lblSep1.Visible = True
        Else
            lnbAreaName.Text = ""
            lnbCeldaName.Text = ""
            lblSep1.Visible = False
            lblSep2.Visible = False
        End If

    End Sub

    Public Sub populateCeldas()

        Dim dt1 As Data.DataTable = SQLDataTable("select * from cdd.tblCeldas where celdaAreaID = " & hflAreaID.Value)
        If dt1.Rows.Count > 0 Then
            Dim dt As Data.DataTable = SQLDataTable("select celdaName, celdaMnemonic from cdd.tblCeldas where celdaID = " & hflCeldaID.Value)
            If dt.Rows.Count > 0 Then
                Dim dr As Data.DataRow = dt.Rows(0)
                lnbCeldaName.Text = dr.Item("celdaName")
                hflMnemCelda.Value = dr.Item("celdaMnemonic")
            Else
                lnbCeldaName.Text = "Todas las celdas"
                hflCeldaID.Value = 0
            End If
            lblSep2.Visible = True
        Else
            lnbCeldaName.Text = ""
            lblSep2.Visible = False
        End If

    End Sub

    Public Sub deptSelected(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnb As LinkButton = sender
        hflDeptId.Value = lnb.CommandArgument
        lnbDeptoName.Text = lnb.Text
        hflMnemDepto.Value = DirectCast(lnb.Parent.FindControl("hflMnemDepto"), HiddenField).Value
        hflAreaID.Value = 0
        hflCeldaID.Value = 0
        hflMnemArea.Value = ""
        hflMnemCelda.Value = ""
        populateAreas()
        RaiseEvent Changed()
    End Sub

    Public Sub areaSelected(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnb As LinkButton = sender
        hflAreaID.Value = lnb.CommandArgument
        lnbAreaName.Text = lnb.Text
        hflMnemArea.Value = DirectCast(lnb.Parent.FindControl("hflMnemArea"), HiddenField).Value
        hflCeldaID.Value = 0
        hflMnemCelda.Value = ""
        populateCeldas()
        RaiseEvent Changed()
    End Sub

    Public Sub celdaSelected(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnb As LinkButton = sender
        hflCeldaID.Value = lnb.CommandArgument
        lnbCeldaName.Text = lnb.Text
        hflMnemCelda.Value = DirectCast(lnb.Parent.FindControl("hflMnemCelda"), HiddenField).Value
        RaiseEvent Changed()
    End Sub

    Public Event Changed()

End Class
