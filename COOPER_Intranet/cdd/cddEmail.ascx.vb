
Partial Class cdd_cddEmail
    Inherits System.Web.UI.UserControl

    Protected Sub setlabels()

        GridView1.Columns(1).HeaderText = "Tipo de Documento "



    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        setlabels()
    End Sub

    Public Sub Update(sender As Object, e As ImageClickEventArgs)

        Dim uid As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim gvr As GridViewRow = sender.parent.parent

        doSQLProcedure("cdd.spDocTypes", Data.CommandType.StoredProcedure, _
                       "@action", "UPD",
                       "@typeID", uid, _
                       "@typeNameEsp", DirectCast(gvr.FindControl("txtTypeNameEsp"), TextBox).Text, _
                       "@mgrApproval", DirectCast(gvr.FindControl("chkreqApproval"), CheckBox).Checked, _
                       "@mfgEngApproval", DirectCast(gvr.FindControl("chkmfgEngApproval"), CheckBox).Checked, _
                       "@calEngApproval", DirectCast(gvr.FindControl("chkcalEngApproval"), CheckBox).Checked, _
                       "@typeFolderName", DirectCast(gvr.FindControl("txtFoldername"), TextBox).Text.ToUpper,
                       "@typeNameFormat", DirectCast(gvr.FindControl("txtNameFormat"), TextBox).Text.ToUpper)


        GridView1.EditIndex = -1

        GridView1.DataBind()
    End Sub

    Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = True
        GridView1.EditIndex = -1
        Dim gvf As GridViewRow = GridView1.FooterRow
        DirectCast(gvf.FindControl("txtTypeNameEsp"), TextBox).Text = ""

        DirectCast(gvf.FindControl("txtTypeNameEsp"), TextBox).Focus()

    End Sub

    Public Sub Insert(sender As Object, e As ImageClickEventArgs)
        Dim gvf As GridViewRow = GridView1.FooterRow
        doSQLProcedure("cdd.spDocTypes", Data.CommandType.StoredProcedure, _
                "@action", "ADD",
                "@typeNameEsp", DirectCast(gvf.FindControl("txtTypeNameEsp"), TextBox).Text, _
                "@mgrApproval", DirectCast(gvf.FindControl("reqApproval"), CheckBox).Checked, _
                "@mfgEngApproval", DirectCast(gvf.FindControl("chkMfgEngApproval"), CheckBox).Checked, _
                "@calEngApproval", DirectCast(gvf.FindControl("chkCalEngApproval"), CheckBox).Checked, _
                "@typeFolderName", DirectCast(gvf.FindControl("txtFoldername"), TextBox).Text.ToUpper,
                "@typeNameFormat", DirectCast(gvf.FindControl("txtNameformat"), TextBox).Text.ToUpper)

        GridView1.DataBind()
        GridView1.ShowFooter = False
    End Sub

    Public Sub Cancel(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = False
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("cdd.spDocTypes", Data.CommandType.StoredProcedure, "@action", "DEL", "@typeId", DirectCast(sender, ImageButton).CommandArgument)
        GridView1.DataBind()
    End Sub
End Class
