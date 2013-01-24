Imports System.Data

Partial Class app_addIns_adm_Menus
    Inherits System.Web.UI.Page

    Public Sub Update(sender As Object, e As ImageClickEventArgs)

        Dim sid As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim gvr As GridViewRow = sender.parent.parent

        doSQLProcedure("spMenuItems", Data.CommandType.StoredProcedure, _
                       "@action", "UPD", _
                       "@menuID", sid, _
                       "@menuTextEsp", DirectCast(gvr.FindControl("txtMenuTextEsp"), TextBox).Text, _
                       "@menuTextEng", DirectCast(gvr.FindControl("txtMenuTextEng"), TextBox).Text, _
                       "@menuParent", DBNull.Value)

        repTopMenu.DataBind()
        adm_ChildMenus1.refresh()
    End Sub

    'Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
    '    GridView1.ShowFooter = True
    '    Dim gvf As GridViewRow = GridView1.FooterRow
    '    DirectCast(gvf.FindControl("txtMenuTextEsp"), TextBox).Text = ""
    '    DirectCast(gvf.FindControl("txtMenuTextEng"), TextBox).Text = ""
    '    GridView1.EditIndex = -1
    'End Sub

    'Public Sub Insert(sender As Object, e As ImageClickEventArgs)
    '    Dim gvf As GridViewRow = GridView1.FooterRow
    '    doSQLProcedure("spMenuItems", Data.CommandType.StoredProcedure, _
    '                 "@action", "ADD", _
    '                 "@menuID", 0, _
    '                 "@menuTextEsp", DirectCast(gvf.FindControl("txtMenuTextEsp"), TextBox).Text, _
    '                 "@menuTextEng", DirectCast(gvf.FindControl("txtMenuTextEng"), TextBox).Text, _
    '                 "@menuParent", DBNull.Value)

    '    GridView1.DataBind()
    '    GridView1.ShowFooter = False
    'End Sub

    'Public Sub Cancel(sender As Object, e As ImageClickEventArgs)
    '    GridView1.ShowFooter = False
    'End Sub

    'Public Sub Delete(sender As Object, e As ImageClickEventArgs)
    '    doSQLProcedure("spMenuItems", Data.CommandType.StoredProcedure, "@action", "DEL", "@menuId", DirectCast(sender, ImageButton).CommandArgument)
    '    GridView1.DataBind()
    'End Sub

    Protected Sub repTopMenu_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repTopMenu.ItemDataBound
        DirectCast(e.Item.FindControl("pnlTopMenu"), Panel).CssClass = "blackMenu"
        '  activateMenu()
    End Sub

    Public Sub selectedMenuItem(sender As Object, e As EventArgs)
        resetPanels()
        Dim lnb As LinkButton = sender
        DirectCast(lnb.Parent, Panel).CssClass = "activeMenu"

        Dim menuID As Integer = lnb.CommandArgument
        hflMenuParent.Value = 0
        adm_ChildMenus1.menuParent = menuID
        showText(menuID)
    End Sub

    Protected Sub showText(menuId As Integer)
        pnlDetails.Visible = True
        hflMenuId.Value = menuId

        If menuId > 0 Then
            Try
                Dim dr As DataRow = SQLDataTable("Select menuId, menuTextESP, menuSection from tblMenuItems where menuId = " & menuId).Rows(0)
                txtMenuTextEsp.Text = isNull(dr.Item("menuTextEsp"), "")
                ddlsectionEsp.SelectedValue = isNull(dr.Item("menuSection"), -1000)
            Catch ex As Exception

            End Try

            If hflMenuParent.Value = 0 Then adm_ChildMenus1.resetPanels()
            adm_ChildMenus1.Visible = True
            cntrlButtons1.deletebuttonvisible = True
        Else
            txtMenuTextEsp.Text = ""
            ddlsectionEsp.SelectedValue = -1000
            adm_ChildMenus1.Visible = hflMenuParent.Value > 0
            cntrlButtons1.deletebuttonvisible = False
        End If

    End Sub

    Public Sub Refresh()
        repTopMenu.DataBind()
    End Sub

    Private Sub resetPanels()
        For Each ri As RepeaterItem In repTopMenu.Items
            DirectCast(ri.FindControl("pnlTopMenu"), Panel).CssClass = "blackMenu"
        Next
        pnlAdd.CssClass = "blackMenu"
    End Sub

    Protected Sub adm_ChildMenus1_AddNewButton() Handles adm_ChildMenus1.AddNewButton
        hflMenuParent.Value = adm_ChildMenus1.menuParent
        showText(0)

    End Sub

    Protected Sub adm_ChildMenus1_Click() Handles adm_ChildMenus1.Click
        hflMenuParent.Value = adm_ChildMenus1.menuParent
        showText(adm_ChildMenus1.selectedID)
    End Sub

    Protected Sub lnbAdd_Click(sender As Object, e As System.EventArgs) Handles lnbAdd.Click
        AddParentButton()
    End Sub

    Protected Sub imbAdd_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbAdd.Click
        AddParentButton()
    End Sub

    Protected Sub AddParentButton()
        hflMenuParent.Value = 0
        resetPanels()
        pnlAdd.CssClass = "activeMenu"
        showText(0)

    End Sub

    Protected Sub Cancel() Handles cntrlButtons1.Cancel_Clicked
        resetPanels()
        pnlDetails.Visible = False
    End Sub

    Protected Sub OK() Handles cntrlButtons1.OK_Clicked

        If hflMenuId.Value = 0 Then
            doSQLProcedure("spMenuitems", CommandType.StoredProcedure, _
                           "@action", "ADD", _
                           "@menuTextEsp", txtMenuTextEsp.Text, _
                           "@menuParent", IIf(hflMenuParent.Value = 0, DBNull.Value, hflMenuParent.Value), _
                           "@menuSection", ddlsectionEsp.SelectedValue)
        Else
            doSQLProcedure("spMenuitems", CommandType.StoredProcedure, "@action", "UPD", "@menuID", hflMenuId.Value, "@menuTextEsp", txtMenuTextEsp.Text, "@menuTextEng", "", "@menuParent", IIf(hflMenuParent.Value = 0, DBNull.Value, hflMenuParent.Value), "@menuSection", ddlsectionEsp.SelectedValue)
        End If
        repTopMenu.DataBind()
        If hflMenuParent.Value > 0 Then adm_ChildMenus1.menuParent = hflMenuParent.Value
    End Sub

    Protected Sub Delete() Handles cntrlButtons1.Trash_Clicked
        doSQLProcedure("spMenuItems", Data.CommandType.StoredProcedure, "@action", "DEL", "@menuId", hflMenuId.Value)
        repTopMenu.DataBind()
        If hflMenuParent.Value > 0 Then adm_ChildMenus1.menuParent = hflMenuParent.Value
    End Sub

    Public Sub moveLf(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spMoveMenuItems", Data.CommandType.StoredProcedure, "@menuId", sender.commandargument, "@menuParent", DBNull.Value, "@itemPos", -1)
        repTopMenu.DataBind()
    End Sub

    Public Sub moveRt(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spMoveMenuItems", Data.CommandType.StoredProcedure, "@menuId", sender.commandargument, "@menuParent", DBNull.Value, "@itemPos", 1)
        repTopMenu.DataBind()
    End Sub

End Class
