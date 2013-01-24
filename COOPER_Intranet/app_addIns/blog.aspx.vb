
Partial Class app_addIns_blog
    Inherits System.Web.UI.Page

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        pnlAdd.Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
        repContent.DataBind()


    End Sub

    Protected Sub imbAdd_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbAdd.Click

        showEditor(0, "~/images/Icons/Picture.png", "Encabezado aquí", "Escriba el texto aquí")
    End Sub

    Protected Sub repContent_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repContent.ItemDataBound

        Select Case e.Item.ItemType

            Case ListItemType.Item, ListItemType.AlternatingItem
                DirectCast(e.Item.FindControl("imbEdit"), ImageButton).Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
                DirectCast(e.Item.FindControl("imbUp"), ImageButton).Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
                DirectCast(e.Item.FindControl("imbDn"), ImageButton).Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))

            Case ListItemType.Footer
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                Dim lblFooter1 As Label = CType(e.Item.FindControl("lblEmptyData1"), Label)
                Dim lblFooter2 As Label = CType(e.Item.FindControl("lblEmptyData2"), Label)
                Dim imbFooter As ImageButton = CType(e.Item.FindControl("imbAdd"), ImageButton)
                If repContent.Items.Count = 0 Then
                    lblFooter.Text = "No existen comentarios para mostrar en esta página."
                    lblFooter1.Text = "Utilice el botón "
                    lblFooter2.Text = " para agregar uno."
                    lblFooter.Visible = True
                    lblFooter1.Visible = True And Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
                    lblFooter2.Visible = True And Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
                    imbFooter.Visible = True And Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))
                Else
                    lblFooter.Visible = False
                    lblFooter1.Visible = False
                    lblFooter2.Visible = False
                    imbFooter.Visible = False
                End If

        End Select

    End Sub

    Public Sub editContent(sender As Object, e As ImageClickEventArgs)

        Dim imb As ImageButton = sender
        Dim itemID As Integer = imb.CommandArgument
        Dim ri As RepeaterItem = imb.Parent.Parent

        showEditor(itemID, DirectCast(ri.FindControl("Image1"), Image).ImageUrl, DirectCast(ri.FindControl("lblHeader"), Label).Text, DirectCast(ri.FindControl("lblContent"), Label).Text)

    End Sub

    Protected Sub showEditor(itemId As Integer, ImageURL As String, HeaderText As String, ContentText As String)
        Session("ItemID") = itemId
        Session("ImageURL") = ImageURL
        Session("HeaderText") = HeaderText
        Session("ContentText") = ContentText

        ClientScript.RegisterStartupScript(Me.GetType(), "showEditor", "<script type='text/javascript'>var btn = window.parent.document.getElementById('imbShowEditor');if (btn) btn.click('a');</script>")

    End Sub

    Public Sub moveUp(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spMoveContent", Data.CommandType.StoredProcedure, "@itemSection", Session("sectionID"), "@itemLang", "esp", "@itemID", DirectCast(sender, ImageButton).CommandArgument, "@itemPos", -1)
        repContent.DataBind()
    End Sub

    Public Sub moveDn(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spMoveContent", Data.CommandType.StoredProcedure, "@itemSection", Session("sectionID"), "@itemLang", "esp", "@itemID", DirectCast(sender, ImageButton).CommandArgument, "@itemPos", 1)
        repContent.DataBind()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

    End Sub
End Class
