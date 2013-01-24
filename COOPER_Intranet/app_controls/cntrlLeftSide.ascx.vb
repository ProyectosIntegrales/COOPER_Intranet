Imports System.Web.UI

Partial Class app_controls_cntrlLeftSide
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init

    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        pnlAdd.Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
        Session("parentID") = getParentID(Session("myID"))
        repLeftSide.DataBind()
    End Sub

    Protected Sub imbAdd_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbAdd.Click

        cntrlEditor1.Size = "Left"
        cntrlEditor1.ItemID = 0
        cntrlEditor1.Header = "Encabezado aquí"
        cntrlEditor1.Content = "Escriba el texto aquí"
        cntrlEditor1.Show()

    End Sub

    Protected Sub repLeftSide_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repLeftSide.ItemDataBound
        DirectCast(e.Item.FindControl("imbEdit"), ImageButton).Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
        DirectCast(e.Item.FindControl("imbUp"), ImageButton).Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
        DirectCast(e.Item.FindControl("imbDn"), ImageButton).Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
    End Sub

    Public Sub editLeftSide(sender As Object, e As ImageClickEventArgs)
        Dim imb As ImageButton = sender
        Dim itemID As Integer = imb.CommandArgument
        Dim ri As RepeaterItem = imb.Parent.Parent

        cntrlEditor1.Size = "Left"
        cntrlEditor1.itemid = itemID
        cntrlEditor1.Header = DirectCast(ri.FindControl("lblHeader"), Label).Text
        cntrlEditor1.Content = DirectCast(ri.FindControl("lblContent"), Label).Text
        cntrlEditor1.Show()

    End Sub

    Protected Sub cntrlEditor1_DeleteClicked() Handles cntrlEditor1.DeleteClicked
        If cntrlEditor1.ItemID > 0 Then
            doSQLProcedure("spDeleteLeftSide", Data.CommandType.StoredProcedure, "@itemSection", Session("parentID"), "@itemLang", "esp", "@itemID", cntrlEditor1.ItemID)
        End If
    End Sub

    Protected Sub EditOk() Handles cntrlEditor1.OKClicked
        If cntrlEditor1.itemId > 0 Then
            doSQLProcedure("spUpdateLeftSide", Data.CommandType.StoredProcedure, "@itemSection", Session("parentID"), "@itemID", cntrlEditor1.ItemID, "@itemHeader", cntrlEditor1.Header, "@itemText", cntrlEditor1.Content)
        Else
            doSQLProcedure("spInsertLeftSide", Data.CommandType.StoredProcedure, "@itemSection", Session("parentID"), "@itemLang", "esp", "@itemHeader", cntrlEditor1.Header, "@itemText", cntrlEditor1.Content)
        End If

        repLeftSide.DataBind()
    End Sub

    Public Sub moveUp(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spMoveLeftSide", Data.CommandType.StoredProcedure, "@itemSection", Session("parentID"), "@itemLang", "esp", "@itemID", DirectCast(sender, ImageButton).CommandArgument, "@itemPos", -1)
        repLeftSide.DataBind()
    End Sub

    Public Sub moveDn(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spMoveLeftSide", Data.CommandType.StoredProcedure, "@itemSection", Session("parentID"), "@itemLang", "esp", "@itemID", DirectCast(sender, ImageButton).CommandArgument, "@itemPos", 1)
        repLeftSide.DataBind()
    End Sub
End Class
