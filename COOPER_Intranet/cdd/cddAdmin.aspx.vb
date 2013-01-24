
Partial Class cdd_cddAdmin
    Inherits System.Web.UI.Page

    Protected Sub setLabels()

        lnbDeptos.Text = "Departamentos"
        lnbUsers.Text = "Usuarios"
        lnbDocTypes.Text = "Tipos de Documentos"
        lnbPDFC.Text = "Bitácora de Convertidor PDF"

    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            pnlDeptos.CssClass = "activeMenu"
        End If
    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        Dim mee As New cddUserx(Session("myUsername"))
        If mee.PrivLevel = 9 Then
            setLabels()
        Else
            pnlAdmin.Visible = False
            cntrlError1.errorMessage = "Esta opción está disponible solamente para el Administrador de la sección de Control de Documentos."
        End If

    End Sub

    Protected Sub lnbMenu_Click(sender As Object, e As System.EventArgs) Handles lnbUsers.Click, lnbDocTypes.Click, lnbDeptos.Click, lnbPDFC.Click
        resetPanels()
        DirectCast(sender.Parent, Panel).CssClass = "activeMenu"
        Dim arg As String = DirectCast(sender, LinkButton).CommandArgument

        cddDeptos1.Visible = arg = "DEPTOS"
        cddDocTypes1.Visible = arg = "TYPES"
        cddUsers1.Visible = arg = "USERS"
        cddPDFCLog1.Visible = arg = "REPORTS"
        'cntrlReports1.Visible = arg = "REPORTS"

    End Sub

    Protected Sub resetPanels()
        pnlDocTypes.CssClass = "grayMenu"
        pnlMenuUsers.CssClass = "grayMenu"
        pnlDeptos.CssClass = "grayMenu"
        pnlReports.CssClass = "grayMenu"

        cddDocTypes1.Visible = False
        cddUsers1.Visible = False
        cddDeptos1.Visible = False
        cddPDFCLog1.Visible = False
    End Sub


End Class
