Imports System.Data
Partial Class cntrlTopMenu
    Inherits System.Web.UI.UserControl

    Public Event ItemSelected()
    Public Event SubItemSelected()

    Protected Sub repTopMenu_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repTopMenu.ItemDataBound
        DirectCast(e.Item.FindControl("pnlTopMenu"), Panel).CssClass = "blackMenu"
        activateMenu()
    End Sub

    Public Sub selectMenuItem(sender As Object, e As EventArgs)
        resetPanels()
        Dim lnb As LinkButton = sender
        DirectCast(lnb.Parent, Panel).CssClass = "activeMenu"

        Dim menuID As Integer = lnb.CommandArgument
        createMenuChilds(menuID)
        activateChild()
        RaiseEvent ItemSelected()
    End Sub

    'Public Sub Refresh()
    '    repTopMenu.DataBind()
    '    '  activateMenu()
    'End Sub

    Private Sub resetPanels()
        For Each ri As RepeaterItem In repTopMenu.Items
            DirectCast(ri.FindControl("pnlTopMenu"), Panel).CssClass = "blackMenu"
        Next
    End Sub

    Private Sub createMenuChilds(menuId As Integer)
        Dim dt As DataTable = SQLDataTable("Select menuId,  menuTextESP as menuText, menuSection from tblMenuItems where menuParent = " & menuId & " order by menuSortKey")
        repMenuChilds.DataSource = dt
        repMenuChilds.DataBind()
        If dt.Rows.Count > 0 Then
            Session("myID") = DirectCast(repMenuChilds.Items(0).FindControl("lnbChildmenu"), LinkButton).CommandArgument

            activateChild()
        End If
    End Sub

    Public Sub selectMenuChild(sender As Object, e As EventArgs)
        Session("myID") = DirectCast(sender, LinkButton).CommandArgument
        RaiseEvent ItemSelected()
        activateChild()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim ID As Integer = Request.QueryString("ID")
            Session("myID") = IIf(ID < 6, 6, ID)
            createMenuChilds(1)
            RaiseEvent ItemSelected()
            activateMenu()
            activateChild()
        End If

        Dim mee As New User(Session("myusername"))
        Session("isAdmin") = mee.Admin

    End Sub

    Private Sub activateMenu()
        Dim dt As DataTable = SQLDataTable("Select menuParent from tblmenuItems where menuID = " & Session("myID"))

        For Each ri As RepeaterItem In repTopMenu.Items
            Dim lnb As LinkButton = DirectCast(ri.FindControl("lnbTopMenu"), LinkButton)
            If lnb.CommandArgument = isNull(dt.Rows(0).Item("menuParent"), 0) Then
                DirectCast(ri.FindControl("pnlTopMenu"), Panel).CssClass = "activeMenu"
                createMenuChilds(lnb.CommandArgument)
                Exit For
            End If
        Next

    End Sub

    Private Sub activateChild()
        For Each ri As RepeaterItem In repMenuChilds.Items
            Dim lnb As LinkButton = DirectCast(ri.FindControl("lnbChildmenu"), LinkButton)
            If lnb.CommandArgument = Session("myID") Then
                DirectCast(lnb.Parent, Panel).CssClass = "menuChildActive"
            Else
                DirectCast(lnb.Parent, Panel).CssClass = "menuChild"
            End If
        Next
    End Sub

End Class
