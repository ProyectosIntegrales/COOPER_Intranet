Imports System.Data
Imports System.IO

Partial Class cdd_cddDocsList
    Inherits System.Web.UI.UserControl

    Public WriteOnly Property ButtonsVisible As Boolean
        Set(value As Boolean)
            _buttonsVisible = value
        End Set
    End Property

    Public mee As cddUserx
    Dim _buttonsVisible As Boolean = True

    Public Sub Edit(sender As Object, e As ImageClickEventArgs)
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.Modify(DirectCast(sender, ImageButton).CommandArgument, 0)
    End Sub

    Public Sub Modify(sender As Object, e As ImageClickEventArgs)
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.Modify(DirectCast(sender, ImageButton).CommandArgument, 3)
    End Sub

    Public Sub Lock(sender As Object, e As ImageClickEventArgs)
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.Modify(DirectCast(sender, ImageButton).CommandArgument, 1)
    End Sub

    Public Sub Aprove(sender As Object, e As ImageClickEventArgs)
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.Modify(DirectCast(sender, ImageButton).CommandArgument, 2)
    End Sub

    Public Sub Publish(sender As Object, e As ImageClickEventArgs)
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.Modify(DirectCast(sender, ImageButton).CommandArgument, 3)
    End Sub

    Public Sub ObsoletAuthorize(sender As Object, e As ImageClickEventArgs)
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.Modify(DirectCast(sender, ImageButton).CommandArgument, 5)
    End Sub

    Public Sub ObsoletDone(sender As Object, e As ImageClickEventArgs)
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.Modify(DirectCast(sender, ImageButton).CommandArgument, 6)
    End Sub

    Public Sub Training(sender As Object, e As ImageClickEventArgs)
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.Modify(DirectCast(sender, ImageButton).CommandArgument, 7)
    End Sub

    Protected Sub cddSelectArea1_Selected() Handles cddSelectArea1.Selected
        cddSelectDocType1.AreaID = cddSelectArea1.SelectedAreaID
        cddSelectDocType1.CeldaID = cddSelectArea1.SelectedCeldaID

        BindData()
    End Sub

    Protected Sub cdd_cddDocsList_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        mee = New cddUserx(Session("myUsername"))
        Dim depto As String = Request.QueryString("dept")
        _buttonsVisible = Depto <> "NONE"
        pnlAdd.Visible = mee.PrivLevel > 0 And Session("editEnabled") 'And _buttonsVisible
        pnlObsoletos.Visible = mee.PrivLevel = 9 And _buttonsVisible

        Session("editEnabled") = True

        hflPrivLevel.Value = mee.PrivLevel

        If Not IsPostBack Then
            Session("inProc") = True
            hflDeptID.Value = deptoID(depto)

            If depto <> "NONE" And depto.Trim <> "" Then
                Dim dt As Data.DataTable = SQLDataTable("select deptoId from tblDeptos where deptoMnemonic = '" & depto.Trim & "'")
                If dt.Rows.Count = 1 Then
                    cddSelectDocType1.DeptoID = dt.Rows(0).Item(0)
                End If
                grvProduccion.Visible = True
                cddSelectArea1.Visible = True
                cddSelectDocType1.Visible = True
            Else
                grvProduccion.Visible = txtSearch.Text.Trim <> ""
                cddSelectArea1.Visible = False
                cddSelectDocType1.Visible = False
                cddSelectDocType1.DeptoID = 0

            End If

        End If
        BindData()
    End Sub

    Public Sub BindData()
        mee = New cddUserx(Session("myUsername"))
        Dim depto As String = Request.QueryString("dept")

        hflAreaID.Value = cddSelectArea1.SelectedAreaID
        hflCeldaID.Value = cddSelectArea1.SelectedCeldaID

        hflDocType.Value = IIf(depto <> "NONE", cddSelectDocType1.SelectedDocType, 0)
        pnlSide_AlwaysVisibleControlExtender.Enabled = True

        cntrlReports1.ParamOptional1 = deptoID(depto)
        cntrlReports1.ParamOptional2 = hflAreaID.Value
        cntrlReports1.ParamOptional3 = hflCeldaID.Value

        dsDocsProc.DataBind()

        grvProceso.DataBind()
   
        grvObsoletos.DataBind()

        pnlProceso.Visible = grvProceso.Rows.Count > 0 And IIf(Session("inProc") Is Nothing, True, Session("inProc")) And mee.PrivLevel > 0
        pnlBtnProceso.Visible = Not pnlProceso.Visible And mee.PrivLevel > 0 And grvProceso.Rows.Count > 0 And _buttonsVisible

        If pnlProceso.Visible Or grvObsoletos.Visible Then
            grvProduccion.PageSize = 10
        Else
            grvProduccion.PageSize = 15
        End If

        grvProduccion.DataBind()
    End Sub

    Protected Sub cddSelectDocType1_DocTypeSelected() Handles cddSelectDocType1.DocTypeSelected
        BindData()
    End Sub

    Protected Function deptoID(deptMnem As String) As Integer
        Dim dt As Data.DataTable = SQLDataTable("select deptoID from tblDeptos where deptoMnemonic = '" & deptMnem & "'")
        If dt.Rows.Count > 0 Then
            Return dt.Rows(0).Item(0)
        Else
            Return 0
        End If
    End Function

    Protected Sub GridView1_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grvProduccion.RowDataBound
        If grvProduccion.Visible Then


            mee = New cddUserx(Session("myUsername"))

            If e.Row.RowType = DataControlRowType.EmptyDataRow Then
                DirectCast(e.Row.FindControl("lblAdd1"), Label).Text = "No se encontraron documentos publicados en esta área. "
            End If

            If e.Row.RowType = DataControlRowType.DataRow Then

                DirectCast(e.Row.FindControl("imbDelete"), ImageButton).Attributes.Add("OnClick", "return confirm('Estás seguro de querer borrar este elemento?');")
                Dim canEdit As Boolean = False
                Try
                    canEdit = Session("editEnabled") And (mee.PrivLevel = 9 Or Session("myUsername").trim.tolower = DirectCast(e.Row.FindControl("lblAuthor"), Label).Text.Trim.ToLower)
                Catch
                    canEdit = False
                End Try
                ' DirectCast(e.Row.FindControl("imbDelete"), ImageButton).Visible = canEdit
                DirectCast(e.Row.FindControl("imbEdit"), ImageButton).Visible = canEdit

                If Not IO.File.Exists(MapPath(DirectCast(e.Row.FindControl("imgDocumentType"), Image).ImageUrl)) Then
                    DirectCast(e.Row.FindControl("imgDocumentType"), Image).ImageUrl = "~/images/icons/files/emp.png"
                End If

            End If
        End If
    End Sub

    Protected Sub lnbAdd_Click(sender As Object, e As System.EventArgs) Handles lnbAdd.Click
        pnlList.Visible = False
        cntrlDocDetails1.Visible = True
        cntrlDocDetails1.AddNew(hflDeptID.Value, hflAreaID.Value, hflCeldaID.Value, hflDocType.Value)
    End Sub

    Protected Sub docDetails1_Closed() Handles cntrlDocDetails1.Closed
        pnlList.Visible = True
        cntrlDocDetails1.Visible = False
        BindData()

    End Sub


    Protected Sub ImageButton2_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click
        Dim depto As String = Request.QueryString("dept")

        If Depto <> "NONE" Then

            grvProduccion.Visible = True
            _buttonsVisible = True
        Else
            grvProduccion.Visible = txtSearch.Text.Trim <> ""
            _buttonsVisible = False

        End If
    End Sub

    Protected Sub imbHide_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbHide.Click
        Session("inProc") = False
    End Sub

    Protected Sub lnbShow_Click(sender As Object, e As System.EventArgs) Handles lnbShow.Click
        Session("inProc") = True
    End Sub

    Protected Sub lnbObsoletos_Click(sender As Object, e As System.EventArgs) Handles lnbObsoletos.Click
        pnlProceso.Visible = False
        pnlObsoletosList.Visible = True
        pnlObsoletos.Visible = False
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("cdd.spDocuments", Data.CommandType.StoredProcedure, "@action", "DEL", "@documentID", DirectCast(sender, ImageButton).CommandArgument)
        BindData()
    End Sub

    Public Sub DeleteObs(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("cdd.spDocuments", Data.CommandType.StoredProcedure, "@action", "DELF", "@documentID", DirectCast(sender, ImageButton).CommandArgument)
        BindData()
    End Sub

    Public Sub Reactivate(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("cdd.spDocuments", Data.CommandType.StoredProcedure, "@action", "RACT", "@documentID", DirectCast(sender, ImageButton).CommandArgument)
        BindData()
    End Sub

    Protected Sub imbHide0_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbHide0.Click
        pnlObsoletosList.Visible = False
        pnlObsoletos.Visible = True
    End Sub

    Public Function getIcon(f1 As Object, f2 As Object) As String
        Dim value As String

        If Not f1 Is DBNull.Value Then
            value = Mid(f1.ToString.Trim, 1, 3)
        Else
            If Not f2 Is DBNull.Value Then
                value = Mid(f2.ToString.Trim, 1, 3)
            End If
        End If

        If value = "" Or Not File.Exists(MapPath("~/images/icons/files/" & Mid(value, 1, 3) & ".png")) Then
            value = "emp"
        End If

        Return value

    End Function

    Public Function ApprovalStatus(docId As Integer) As String

        ApprovalStatus = ""

        Dim dv As DataView = DirectCast(dsDocsProc.Select(DataSourceSelectArguments.Empty), DataView)
        dv.RowFilter = "documentID = " & docId
        Dim dr As DataRow = dv.Item(0).Row
        Dim st As Integer = isNull(dr.Item("documentAuthLevel"), 0)

        Dim reqMgrAp As Boolean = isNull(dr.Item("mgrApproval"), False) And isNull(dr.Item("documentMgrAppr"), "") = ""
        Dim reqMfgAp As Boolean = isNull(dr.Item("mfgEngApproval"), False) And isNull(dr.Item("documentMfgEngAppr"), "") = ""
        Dim reqCalAp As Boolean = isNull(dr.Item("calEngApproval"), False) And isNull(dr.Item("documentCalEngAppr"), "") = ""
        Dim names As String = ""

        If isNull(dr.Item("obsoleteLevel"), 0) > 0 Then

            reqMgrAp = isNull(dr.Item("mgrApproval"), False)
            reqMfgAp = isNull(dr.Item("mfgEngApproval"), False)
            reqCalAp = isNull(dr.Item("calEngApproval"), False)

            If reqMgrAp Then
                If isNull(dr.Item("documentObsolete2"), "") = "" Then
                    st = 4
                Else
                    st = 6
                End If
            End If

            If reqMfgAp Or reqCalAp Then
                If isNull(dr.Item("documentObsolete2"), "") = "" Or isNull(dr.Item("documentObsolete3"), "") = "" Then
                    st = 4
                Else
                    st = 5
                End If
            End If

            If reqMfgAp And reqCalAp Then
                If isNull(dr.Item("documentObsolete2"), "") <> "" And isNull(dr.Item("documentObsolete3"), "") <> "" Then
                    st = 6
                End If
            End If

            If st = 3 And isNull(dr.Item("documentTrainer"), "") = "" Then st = 7

        End If

        If reqMgrAp Then
            names &= isNull(dr.Item("deptoManagerName"), "Gerente")
        End If

        If reqMfgAp Then
            names &= IIf(names <> "", ", ", "")
            names &= isNull(dr.Item("areaMfgEngName"), "Ing. de Manufactura")
        End If

        If reqCalAp Then
            names &= IIf(names <> "", " y ", "")
            names &= isNull(dr.Item("areaCalEngName"), "Ing. de Calidad")
        End If

        Select Case st
            Case 0
                If isNull(dr.Item("documentfinalFileName"), "") <> "" Then
                    ApprovalStatus = isNull(dr.Item("authLevelDescription"), "") & " esperando revisión por Control de Documentos"
                Else
                    If isNull(dr.Item("documentRevChange"), False) Then
                        ApprovalStatus = "Cambio de Revisión. Esperando que el documento sea revisado por Control de Documentos"
                    Else
                        ApprovalStatus = "Documento modificado esperando revisión por Control de Documentos"
                    End If

                End If

            Case 1
                ApprovalStatus = isNull(dr.Item("authLevelDescription"), "") & " por " & names
            Case 4
                ApprovalStatus = "Proceso de Obsolescencia Iniciado por " & isNull(dr.Item("documentObsolete1Name"), "") & ", Esperando aprobación de " & names
            Case 5
                ApprovalStatus = "Proceso de Obsolescencia en espera de autorización por " & names
            Case 6
                ApprovalStatus = "Proceso de Obsolescencia Autorizado, esperando revisión por Control de Documentos."
            Case 7
                ApprovalStatus = "Esperando aprobación de Entrenamiento"
            Case Is < 0
                ApprovalStatus = isNull(dr.Item("authLevelDescription"), "") & " por " & dr.Item("documentRejecterName")

            Case Else
                ApprovalStatus = isNull(dr.Item("authLevelDescription"), "")
        End Select

    End Function

    Public Function CommaConcatenate(a1 As String, a2 As String, a3 As String) As String
        Dim c As String


        a2 = IIf(a2 <> "", a2 & ",<br>", "")

        c = a1 & a2 & a3
        Return c
    End Function

    Public Function ApprovalNames(docId As Integer) As String

        Dim dv As DataView = DirectCast(dsDocsProc.Select(DataSourceSelectArguments.Empty), DataView)
        dv.RowFilter = "documentID = " & docId
        Dim dr As DataRow = dv.Item(0).Row

        Dim obs1 As String = isNull(dr.Item("documentObsolete1"), "")
        If obs1 = "" Then
            Dim mgrAppr As Boolean = isNull(dr.Item("mgrApproval"), False)
            Dim mfgEngAppr As Boolean = isNull(dr.Item("mfgEngApproval"), False)
            Dim calEngAppr As Boolean = isNull(dr.Item("calEngApproval"), False)

            If isNull(dr.Item("documentInitializer"), "") = "" Then Return ""

            If mgrAppr Then Return isNull(dr.Item("documentMgrApprName"), "[Aún sin aprobar]")


            If mfgEngAppr Or calEngAppr Then

                Dim mfgEngName As String = isNull(dr.Item("documentMfgEngApprname"), "")
                Dim calEngName As String = isNull(dr.Item("documentCalEngApprname"), "")

                If mfgEngName <> "" And calEngName <> "" Then
                    Return mfgEngName & "<br>" & calEngName
                End If

                If mfgEngName & calEngName <> "" Then
                    Return mfgEngName & calEngName
                Else
                    Return "[Aún sin aprobar]"
                End If

            End If



        Else
            Dim mgrAppr As Boolean = isNull(dr.Item("mgrApproval"), False)
            Dim mfgEngAppr As Boolean = isNull(dr.Item("mfgEngApproval"), False)
            Dim calEngAppr As Boolean = isNull(dr.Item("calEngApproval"), False)

            Dim ApprName1 = isNull(dr.Item("documentObsolete2Name"), IIf(mgrAppr, "[Aún sin autorizar]", ""))
            Dim ApprName2 = isNull(dr.Item("documentObsolete3Name"), "")

            If mgrAppr Then Return ApprName1

            If mfgEngAppr Or calEngAppr Then

                If ApprName1 <> "" And ApprName2 <> "" Then
                    Return ApprName1 & "<br>" & ApprName2
                End If

                If ApprName1 & ApprName2 <> "" Then
                    Return ApprName1 & ApprName2
                Else
                    Return "[Aún sin autorizar]"
                End If
            End If

        End If

        Return ""
    End Function

    Public Function ObsoleteAuthorizeVisible(docID As Integer) As Boolean
        Dim dv As DataView = DirectCast(dsDocsProc.Select(DataSourceSelectArguments.Empty), DataView)
        dv.RowFilter = "documentID = " & docID
        Dim dr As DataRow = dv.Item(0).Row

        Dim authLevel As Boolean = isNull(dr.Item("documentAuthLevel"), 0) = 3
        Dim obsLevel As Boolean = isNull(dr.Item("obsoleteLevel"), 0) > 0

        Dim mgrAppr As Boolean = isNull(dr.Item("mgrApproval"), False)
        Dim mfgEngAppr As Boolean = isNull(dr.Item("mfgEngApproval"), False)
        Dim calEngAppr As Boolean = isNull(dr.Item("calEngApproval"), False)

        Dim ApprName1 = isNull(dr.Item("documentObsolete2"), IIf(mgrAppr, "[Aún sin autorizar]", ""))
        Dim ApprName2 = isNull(dr.Item("documentObsolete3"), "")

        Dim nameOK As Boolean = False
        Dim un As String = Session("myUsername").ToString.ToLower.Trim

        nameOK = isNull(dr.Item("deptoManagerUsername"), "").ToString.ToLower.Trim = un And mgrAppr And isNull(dr.Item("documentObsolete2"), "") = "" _
            Or isNull(dr.Item("areaMfgEngUsername"), "").ToString.ToLower.Trim = un And mfgEngAppr And isNull(dr.Item("documentObsolete2"), "") <> un And isNull(dr.Item("documentObsolete3"), "") <> un _
            Or isNull(dr.Item("areaCalEngUsername"), "").ToString.ToLower.Trim = un And calEngAppr And isNull(dr.Item("documentObsolete2"), "") <> un And isNull(dr.Item("documentObsolete3"), "") <> un

        Return mee.PrivLevel > 0 And mee.PrivLevel <> 7 And Session("editEnabled") And authLevel And obsLevel And nameOK

    End Function

    Public Function ObsoleteDoneVisible(docID As Integer) As Boolean
        Dim dv As DataView = DirectCast(dsDocsProc.Select(DataSourceSelectArguments.Empty), DataView)
        dv.RowFilter = "documentID = " & docID
        Dim dr As DataRow = dv.Item(0).Row

        Dim authLevel As Boolean = isNull(dr.Item("documentAuthLevel"), 0) = 3
        Dim obsLevel As Boolean = isNull(dr.Item("obsoleteLevel"), 0) = 2

        Dim mgrAppr As Boolean = isNull(dr.Item("mgrApproval"), False)
        Dim mfgEngAppr As Boolean = isNull(dr.Item("mfgEngApproval"), False)
        Dim calEngAppr As Boolean = isNull(dr.Item("calEngApproval"), False)

        Dim Appr1 = isNull(dr.Item("documentObsolete2"), "") <> ""
        Dim Appr2 = isNull(dr.Item("documentObsolete3"), "") <> ""

        Dim authOK As Boolean = False
        Dim un As String = Session("myUsername").ToString.ToLower.Trim


        authOK = Appr1 And mgrAppr _
            Or (Appr1 And mfgEngAppr And Appr2 And calEngAppr)

        Return mee.PrivLevel = 9 And Session("editEnabled") And authLevel And obsLevel And authOK

    End Function

    Protected Sub lnbVerTodoProc_Click(sender As Object, e As System.EventArgs) Handles lnbVerTodoProc.Click
        grvProceso.AllowPaging = False
        lnbVerPaginas.Visible = True
        lnbVerTodoProc.Visible = False
        pnlProceso.ScrollBars = ScrollBars.Auto
        pnlProceso.Height = 500
    End Sub

    Protected Sub lnbVerPaginas_Click(sender As Object, e As System.EventArgs) Handles lnbVerPaginas.Click
        grvProceso.AllowPaging = True
        lnbVerPaginas.Visible = False
        lnbVerTodoProc.Visible = True
        pnlProceso.Height = Nothing
        pnlProceso.ScrollBars = ScrollBars.None
    End Sub
End Class
