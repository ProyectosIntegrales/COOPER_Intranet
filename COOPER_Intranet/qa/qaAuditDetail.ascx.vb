Imports System.Data

Partial Class qa_qaAuditDetail
    Inherits System.Web.UI.UserControl

    Public Event Closed()

    Public WriteOnly Property NoFolio As Integer
        Set(value As Integer)

            Select Case value
                Case Is < 0
                    hflAction.Value = "DEL"
                    lblAction.Text = "Borrar Registro"
                    btnOK.Visible = True
                    btnOK.Text = "Borrar"
                    btnClose.Text = "Cancelar"
                    deleteRecord(value)
                Case 0
                    hflAction.Value = "ADD"
                    lblAction.Text = "Nuevo Registro"
                    btnOK.Visible = True
                    btnOK.Text = "Agregar"
                    btnClose.Text = "Cancelar"
                    addNewRecord()
                Case Is > 0
                    Dim mee As New qaUser(Session("myUsername"))
                    If mee.PrivLevel = 0 Then
                        hflAction.Value = "UPD"
                        lblAction.Text = "Modificando Registro"
                        editRecord(value)
                        btnOK.Visible = True
                        btnOK.Text = "Actualizar"
                        btnClose.Text = "Cancelar"
                    Else
                        hflAction.Value = "INQ"
                        lblAction.Text = "Consulta"
                        displayRecord(value)
                        btnOK.Visible = False
                        btnClose.Text = "Cerrar"
                    End If

            End Select
         
        End Set
    End Property

    Protected Sub deleteRecord(folioID As Integer)
        folioID = folioID * -1
        showData(folioID)
    End Sub

    Protected Sub displayRecord(folioID As Integer)
        showData(folioID)
    End Sub

    Protected Sub addNewRecord()
        Dim maxFolio As Object = doSQLProcedure("select max(dataId) from qaa.tblAuditData", Data.CommandType.Text)
        Dim nextFolio As Integer = isNull(maxFolio, 0) + 1
        lblFolio.Text = nextFolio
        Session("dtDefectos") = Nothing

        disableEnableFields()
        initializeValues()
        txtDate.Focus()
    End Sub

    Protected Sub editRecord(folioID As Integer)
        showData(folioID)

    End Sub

    Protected Sub showData(folioID As Integer)
        disableEnableFields()

        lblFolio.Text = folioID
        Dim dr As DataRow = SQLDataTable("select * from qaa.tblAuditData where dataId = " & folioID).Rows(0)
        txtDate.Text = CDate(dr.Item("auditDate")).ToString("dd/MM/yyyy")
        ddlAuditor.SelectedValue = dr.Item("userID")
        ddlArea.SelectedValue = dr.Item("areaID")
        txtOrder.Text = dr.Item("workOrder")
        txtPartNo.Text = dr.Item("partNo")
        txtDatecode.Text = dr.Item("dateCode")
        txtLotPlan.Text = dr.Item("lotPlan")
        txtLotInsp.Text = dr.Item("lotQty")
        txtQtyInsp.Text = dr.Item("samSize")
        txtRework.Text = isNull(dr.Item("rewQty"), "")
        txtAceptadas.Text = dr.Item("accQty")
        txtDr.Text = isNull(dr.Item("dr"), "")
        txtComments.Text = dr.Item("comments")

        Dim dt As DataTable = SQLDataTable("SELECT qaa.tblAuditDefectos.defectoID, CAST(qaa.tblAuditDefectos.defectoID AS nchar(2)) + ' - ' + qaa.tblDefectos.defectoDescription AS defectoDesc, qaa.tblAuditDefectos.defectoQty FROM qaa.tblAuditDefectos INNER JOIN qaa.tblDefectos ON qaa.tblAuditDefectos.defectoID = qaa.tblDefectos.defectoID where dataId = " & folioID)
        If dt.Rows.Count > 0 Then
            Session("dtDefectos") = dt
            repDefectos.DataSource = Session("dtDefectos")
            repDefectos.DataBind()
            fillDefectos()
        End If

    End Sub

    Protected Sub disableEnableFields()
        Dim Show As Boolean = Not (hflAction.Value = "UPD" Or hflAction.Value = "ADD")
        txtDate.ReadOnly = Show
        txtDate_CalendarExtender.Enabled = Not Show
        ddlAuditor.Enabled = Not Show
        txtDatecode.ReadOnly = Show
        ddlArea.Enabled = Not Show
        txtLotPlan.ReadOnly = Show
        txtOrder.ReadOnly = Show
        txtPartNo.ReadOnly = Show
        txtLotInsp.ReadOnly = Show
        txtDr.ReadOnly = Show
        txtAceptadas.ReadOnly = Show
        txtComments.ReadOnly = Show
        txtQtyDef.ReadOnly = Show
        txtQtyInsp.ReadOnly = Show
        txtRework.ReadOnly = Show
        imbAdd.Visible = Not Show
        ddlDefectos.Visible = Not Show
        txtQtyDef.Visible = Not Show
    End Sub

    Protected Sub btnClose_Click(sender As Object, e As System.EventArgs) Handles btnClose.Click
        Session("dtDefectos") = Nothing
        RaiseEvent Closed()
    End Sub

    Protected Sub btnOK_Click(sender As Object, e As System.EventArgs) Handles btnOK.Click
        lblError.Text = ""

        Select Case hflAction.Value

            Case "ADD"

                If Not validateData() Then Exit Sub
                cntrlError1.errorMessage = doSQLProcedure("qaa.spAuditData", _
                    Data.CommandType.StoredProcedure, _
                    "@action", hflAction.Value, _
                    "@auditDate", Mid(txtDate.Text, 4, 2) & "/" & Mid(txtDate.Text, 1, 2) & "/" & Mid(txtDate.Text, 7, 11), _
                    "@userID", ddlAuditor.SelectedValue, _
                    "@areaID", ddlArea.SelectedValue, _
                    "@workOrder", txtOrder.Text.ToUpper, _
                    "@partNo", txtPartNo.Text.ToUpper, _
                    "@lotPlan", txtLotPlan.Text, _
                    "@lotQty", txtLotInsp.Text, _
                    "@samSize", txtQtyInsp.Text, _
                    "@comments", txtComments.Text, _
                    "@dr", txtDr.Text, _
                    "@datecode", txtDatecode.Text, _
                    "@rewQty", txtRework.Text, _
                    "@accQty", txtAceptadas.Text)

                Dim folio As Integer = SQLDataTable("select max(dataID) from qaa.tblAuditData").Rows(0).Item(0)

                saveDefectos(folio)
                saveSessionVars()
                saveReferenceData()
                initializeValues()
                addNewRecord()

            Case "UPD"
                If Not validateData() Then Exit Sub
                cntrlError1.errorMessage = doSQLProcedure("qaa.spAuditData", _
                    Data.CommandType.StoredProcedure, _
                    "@action", hflAction.Value, _
                    "@dataID", lblFolio.Text, _
                    "@auditDate", Mid(txtDate.Text, 4, 2) & "/" & Mid(txtDate.Text, 1, 2) & "/" & Mid(txtDate.Text, 7, 11), _
                    "@userID", ddlAuditor.SelectedValue, _
                    "@areaID", ddlArea.SelectedValue, _
                    "@workOrder", txtOrder.Text.ToUpper, _
                    "@partNo", txtPartNo.Text.ToUpper, _
                    "@lotPlan", txtLotPlan.Text, _
                    "@lotQty", txtLotInsp.Text, _
                    "@samSize", txtQtyInsp.Text, _
                    "@comments", txtComments.Text, _
                    "@dr", txtDr.Text, _
                    "@datecode", txtDatecode.Text, _
                    "@rewQty", txtRework.Text, _
                    "@accQty", txtAceptadas.Text)

                saveDefectos(lblFolio.Text)
                saveReferenceData()
                RaiseEvent Closed()

            Case "DEL"
                cntrlError1.errorMessage = doSQLProcedure("qaa.spAuditData", _
                            CommandType.StoredProcedure, _
                            "@action", "DEL", _
                            "@dataID", lblFolio.Text)
                doSQLProcedure("qaa.spAuditDefectos", CommandType.StoredProcedure, _
                          "@action", "DEL", _
                          "@dataID", lblFolio.Text)
                RaiseEvent Closed()

        End Select

    End Sub

    Protected Sub saveDefectos(folio As Integer)
        If Not Session("dtDefectos") Is Nothing Then
            Dim dtDefectos As DataTable = Session("dtDefectos")
            doSQLProcedure("qaa.spAuditDefectos", CommandType.StoredProcedure, _
                           "@action", "DEL", _
                           "@dataID", folio)
            If dtDefectos.Rows.Count > 0 Then
                For Each dr As DataRow In dtDefectos.Rows
                    doSQLProcedure("qaa.spAuditDefectos", CommandType.StoredProcedure, _
                                   "@action", "ADD", _
                                   "@dataID", folio, _
                                   "@defectoID", dr.Item("defectoID"), _
                                   "@defectoQty", dr.Item("defectoQty"))
                Next
            End If
        End If

    End Sub

    Protected Function validateData() As Boolean

        Try
            Dim dateValid As Date = Mid(txtDate.Text, 4, 2) & "/" & Mid(txtDate.Text, 1, 2) & "/" & Mid(txtDate.Text, 7, 11)
            If dateValid > Now Then
                cntrlError1.errorMessage = "La Fecha de Inspección no debe ser posterior al día de hoy."
                Return False
            End If

            If dateValid < CDate("1/1/2000") Then
                cntrlError1.errorMessage = "Parece haber un error en la Fecha de Inspección."
                Return False
            End If

        Catch ex As Exception
            cntrlError1.errorMessage = "El valor de la Fecha de Inspección es inválido."
            Return False
        End Try

        If txtLotPlan.Text.Trim = "" Then
            cntrlError1.errorMessage = "El valor de Lote Planeado no debe quedar vacío."
        End If

        If Not IsNumeric(txtLotPlan.Text) Then
            cntrlError1.errorMessage = "El valor de Lote Planeado es incorrecto."
            Return False
        End If

        If txtLotInsp.Text.Trim = "" Then
            cntrlError1.errorMessage = "El valor de Lote Entragado no debe quedar vacío."
            Return False
        End If

        If Not IsNumeric(txtLotInsp.Text) Then
            cntrlError1.errorMessage = "El valor de Lote Entregado es incorrecto."
            Return False
        End If

        If txtQtyInsp.Text.Trim = "" Then
            cntrlError1.errorMessage = "El valor de Cant. Inspeccionada no debe quedar vacío."
            Return False
        End If

        If Not IsNumeric(txtQtyInsp.Text) Then
            cntrlError1.errorMessage = "El valor de Cant. Inspeccionada es incorrecto."
            Return False
        End If

        If txtOrder.Text.Trim = "" Then
            cntrlError1.errorMessage = "El valor de Orden de Trabajo no debe quedar vacío."
            Return False
        End If

        If txtPartNo.Text.Trim = "" Then
            cntrlError1.errorMessage = "El valor de No. de Parte no debe quedar vacío."
            Return False
        End If

        If txtAceptadas.Text.Trim = "" Then
            cntrlError1.errorMessage = "El valor de Pzas. Aceptadas no debe quedar vacío."
            Return False
        End If

        If Not IsNumeric(txtAceptadas.Text) Then
            cntrlError1.errorMessage = "El valor de Pzas. Aceptadas es incorrecto."
            Return False
        End If

        Return True
    End Function

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender

        If hflAction.Value = "ADD" And Not IsPostBack Then
            initializeValues()
        End If
    End Sub

    Protected Sub initializeValues()
        If Not Session("lastDate") Is Nothing Then
            txtDate.Text = Session("lastDate")
        End If

        If Not Session("lastAuditor") Is Nothing Then
            ddlAuditor.SelectedValue = Session("lastAuditor")
        End If

        If Not Session("lastArea") Is Nothing Then
            ddlArea.SelectedValue = Session("lastArea")
        End If

        If Not Session("lastOrder") Is Nothing And Not Session("lastOrder") = "" Then
            txtOrder.Text = Session("lastOrder")
        End If

        If Not Session("lastPartNo") Is Nothing Then
            txtPartNo.Text = Session("lastPartNo")
        End If

        txtLotPlan.Text = ""
        txtLotInsp.Text = ""
        txtQtyInsp.Text = ""
        txtQtyDef.Text = ""
        txtAceptadas.Text = ""
        txtRework.Text = ""

        repDefectos.DataSource = Session("dtDefectos")
        repDefectos.DataBind()

        fillDefectos()

    End Sub

    Protected Sub fillDefectos()
        Dim dt As DataTable = SQLDataTable("SELECT CONVERT (nchar(2), defectoID) + ' - ' + defectoDescription AS Defecto, defectoID FROM qaa.tblDefectos WHERE (NOT defectoID in (" & listDefectos() & "))")
        ddlDefectos.DataSource = dt
        ddlDefectos.DataTextField = "Defecto"
        ddlDefectos.DataValueField = "DefectoID"
        ddlDefectos.DataBind()
    End Sub

    Protected Function listDefectos() As String
        If Not Session("dtDefectos") Is Nothing Then

            Dim list As String
            Dim dtDefectos As DataTable = Session("dtDefectos")
            If dtDefectos.Rows.Count > 0 Then
                For Each dr As DataRow In dtDefectos.Rows
                    list &= dr.Item("defectoID") & ","
                Next
                Return Mid(list, 1, list.Length - 1)
            Else
                Return "0"
            End If
        Else
            Return "0"
        End If
    End Function

    Protected Sub saveSessionVars()
        Session("lastDate") = txtDate.Text
        Session("lastAuditor") = ddlAuditor.SelectedValue
        Session("lastArea") = ddlArea.SelectedValue
        Session("lastOrder") = txtOrder.Text
        Session("lastPartNo") = txtPartNo.Text

    End Sub

    Protected Sub saveReferenceData()
        doSQLProcedure("qaa.spOrders", CommandType.StoredProcedure, _
                       "@action", "ADDUPD", _
                       "@orderNo", txtOrder.Text.ToUpper, _
                       "@areaID", ddlArea.SelectedValue, _
                       "@auditorID", ddlAuditor.SelectedValue, _
                       "@lotPlan", txtLotPlan.Text, _
                       "@partNo", txtPartNo.Text.ToUpper, _
                       "@dateCode", txtDatecode.Text, _
                       "@lotQty", txtLotInsp.Text)

        doSQLProcedure("qaa.spPartByArea", CommandType.StoredProcedure, _
                       "@action", "ADD", _
                       "@partNo", txtPartNo.Text.ToUpper, _
                       "@areaID", ddlArea.SelectedValue)

    End Sub

    Protected Sub imbAdd_Click(sender As Object, e As System.EventArgs) Handles imbAdd.Click
        lblError.Text = ""
        If Val(txtQtyDef.Text) > 0 Then
            Dim dtDefectos As New DataTable

            If Session("dtDefectos") Is Nothing Then
                Dim c1 As New DataColumn("defectoID")
                Dim c2 As New DataColumn("defectoDesc")
                Dim c3 As New DataColumn("defectoQty")

                c1.DataType = GetType(Integer)
                c2.DataType = GetType(String)
                c3.DataType = GetType(Integer)

                dtDefectos.Columns.Add(c1)
                dtDefectos.Columns.Add(c2)
                dtDefectos.Columns.Add(c3)
            Else
                dtDefectos = Session("dtDefectos")
            End If

            Dim dr As DataRow = dtDefectos.NewRow
            dr("defectoID") = ddlDefectos.SelectedValue
            dr("defectoDesc") = ddlDefectos.SelectedItem.Text
            dr("defectoQty") = Val(txtQtyDef.Text)

            dtDefectos.Rows.Add(dr)
            dtDefectos.AcceptChanges()

            Session("dtDefectos") = dtDefectos
            repDefectos.DataSource = Session("dtDefectos")
            repDefectos.DataBind()

            ddlDefectos.SelectedIndex = 0
            fillDefectos()
        Else
            lblError.Text = "La cantidad debe ser mayor de cero."
        End If

    End Sub

    Public Sub deleteDefecto(sender As Object, e As ImageClickEventArgs)
        Dim dtDefectos As DataTable = Session("dtDefectos")
        Dim defectoID As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim i As Integer = 0
        For Each dr As DataRow In dtDefectos.Rows
            If dr.Item("defectoID") = defectoID Then
                Exit For
            End If
            i += 1
        Next

        dtDefectos.Rows.RemoveAt(i)
        dtDefectos.AcceptChanges()

        Session("dtDefectos") = dtDefectos
        repDefectos.DataSource = Session("dtDefectos")
        repDefectos.DataBind()
        fillDefectos()

    End Sub


End Class
