
Partial Class qa_cAdmin
    Inherits System.Web.UI.UserControl

    Protected Sub setLabels()

        lnbDefectos.Text = "Defectos"
        lnbAreas.Text = "Areas"
        lnbUsers.Text = "Usuarios"
    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        Dim mee As New qaUser(Session("myUsername"))
        If mee.PrivLevel = 2 Then
            setLabels()
        Else
            pnlAdmin.Visible = False
            cntrlError1.errorMessage = "Esta opción está disponible solamente para el Administrador de la sección de Calidad."
        End If

    End Sub

    Protected Sub lnbMenu_Click(sender As Object, e As System.EventArgs) Handles lnbDefectos.Click, lnbAreas.Click, lnbUsers.Click
        resetPanels()
        DirectCast(sender.Parent, Panel).CssClass = "activeMenu"
        Dim arg As String = DirectCast(sender, LinkButton).CommandArgument

        qaDefectos1.Visible = arg = "DEFS"
        qaAreas1.Visible = arg = "AREAS"
        qaUsers1.Visible = arg = "USERS"
    End Sub

    Protected Sub resetPanels()
        pnlDefectos.CssClass = "grayMenu"
        pnlAreas.CssClass = "grayMenu"
        pnlUsers.CssClass = "grayMenu"

        qaAreas1.Visible = False
        qaDefectos1.Visible = False
        qaUsers1.Visible = False
    End Sub
End Class
