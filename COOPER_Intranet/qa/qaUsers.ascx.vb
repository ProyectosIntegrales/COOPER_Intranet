
Partial Class qa_users
    Inherits System.Web.UI.UserControl

    Public Sub Update(sender As Object, e As ImageClickEventArgs)

        Dim uid As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim gvr As GridViewRow = sender.parent.parent

        cntrlError1.errorMessage = doSQLProcedure("qaa.spUsers", Data.CommandType.StoredProcedure, _
                       "@action", "UPD",
                       "@userID", uid, _
                       "@privID", DirectCast(gvr.FindControl("ddlPrivs"), DropDownList).SelectedValue)

        GridView1.EditIndex = -1

        GridView1.DataBind()
    End Sub

    Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = True
        GridView1.EditIndex = -1
        Dim gvf As GridViewRow = GridView1.FooterRow

        DirectCast(gvf.FindControl("txtEmployeeNo"), TextBox).Text = ""
        DirectCast(gvf.FindControl("txtEmployeeNo"), TextBox).Focus()

    End Sub

    Public Sub Insert(sender As Object, e As ImageClickEventArgs)
        Dim UID As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim gvf As GridViewRow = GridView1.FooterRow
        cntrlError1.errorMessage = doSQLProcedure("qaa.spUsers", Data.CommandType.StoredProcedure, _
                "@action", "ADD",
                "@userID", UID, _
                "@privID", DirectCast(gvf.FindControl("ddlPrivs"), DropDownList).SelectedValue)

        GridView1.DataBind()
        GridView1.ShowFooter = False
    End Sub

    Public Sub Cancel(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = False
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        cntrlError1.errorMessage = doSQLProcedure("qaa.spUsers", Data.CommandType.StoredProcedure, "@action", "DEL", "@userId", DirectCast(sender, ImageButton).CommandArgument)
        GridView1.DataBind()
    End Sub

    Public Sub getEmployeeInfo(sender As Object, e As EventArgs)

        Dim tb As TextBox = sender
        If tb.Text <> "" Then
            Dim gvr As GridViewRow = tb.Parent.Parent

            Dim dt As Data.DataTable = SQLDataTable("select * from tblUsers where userEmployeeNo = " & tb.Text)
            If dt.Rows.Count = 1 Then
                Dim dr As Data.DataRow = dt.Rows(0)
                DirectCast(gvr.FindControl("lblUsername"), Label).Text = dr.Item("userName")
                DirectCast(gvr.FindControl("lblFullName"), Label).Text = dr.Item("userFirstName") & " " & dr.Item("userLastName")
                DirectCast(gvr.FindControl("imbOK0"), ImageButton).CommandArgument = dr.Item("userID")
                DirectCast(gvr.FindControl("imbOK0"), ImageButton).Enabled = True
            Else
                DirectCast(gvr.FindControl("lblFullName"), Label).Text = "[No se encontró empleado con ese Número]"
                DirectCast(gvr.FindControl("imbOK0"), ImageButton).Enabled = False
            End If

        End If
    End Sub


End Class
