
Partial Class app_admin_adm_ChildMenus
    Inherits System.Web.UI.UserControl

    Public Property menuParent As Integer
        Get
            Return hflParentMenu.Value
        End Get
        Set(value As Integer)
            hflParentMenu.Value = value
            repChilds.DataBind()
        End Set
    End Property

    Public Property selectedID As Integer
        Get
            Return hflSelectedID.Value
        End Get
        Set(value As Integer)
            hflSelectedID.Value = value
        End Set
    End Property

    Public Event Click()

    Public Event AddNewButton()

    Public Sub Selected(sender As Object, e As EventArgs)
        Dim lnb As LinkButton = sender
        hflSelectedID.Value = lnb.CommandArgument
        resetPanels()
        DirectCast(lnb.Parent, Panel).CssClass = "selected"
        RaiseEvent Click()
    End Sub

    Public Sub resetPanels()
        For Each ri As RepeaterItem In repChilds.Items
            Dim p As Panel = ri.FindControl("pnlChild")
            p.CssClass = "unselected"
        Next
        pnlAdd.CssClass = "unselected"
    End Sub

    Public Sub Refresh()
        repChilds.DataBind()
    End Sub

    Public Sub Update(sender As Object, e As ImageClickEventArgs)

        Dim sid As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim gvr As GridViewRow = sender.parent.parent

        doSQLProcedure("spSections", Data.CommandType.StoredProcedure, _
                       "@action", "UPD", _
                       "@sectionID", sid, _
                       "@sectionTitleEsp", DirectCast(gvr.FindControl("txtSectionTitleEsp"), TextBox).Text, _
                       "@sectionTitleEng", DirectCast(gvr.FindControl("txtSectionTitleEng"), TextBox).Text, _
                       "@sectionControlName", DirectCast(gvr.FindControl("txtSectionControlName"), TextBox).Text, _
                       "@sectionLeftMenu", DirectCast(gvr.FindControl("Checkbox1"), CheckBox).Checked)

        'repChilds.EditIndex = -1

        repChilds.DataBind()
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spSections", Data.CommandType.StoredProcedure, "@action", "DEL", "@sectionId", DirectCast(sender, ImageButton).CommandArgument)
        repChilds.DataBind()
    End Sub

    Protected Sub lnbAdd_Click(sender As Object, e As System.EventArgs) Handles lnbAdd.Click
        AddButton()
    End Sub

    Protected Sub imbAdd_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbAdd.Click
        AddButton()
    End Sub

    Protected Sub AddButton()
        resetPanels()
        pnlAdd.CssClass = "selected"
        RaiseEvent AddNewButton()
    End Sub

    Public Sub moveLf(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spMoveMenuItems", Data.CommandType.StoredProcedure, "@menuId", sender.commandargument, "@menuParent", hflParentMenu.Value, "@itemPos", -1)
        repChilds.DataBind()
    End Sub

    Public Sub moveRt(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spMoveMenuItems", Data.CommandType.StoredProcedure, "@menuId", sender.commandargument, "@menuParent", hflParentMenu.Value, "@itemPos", 1)
        repChilds.DataBind()
    End Sub

End Class
