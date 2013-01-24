
Partial Class app_addIns_adm_adm_Users
    Inherits System.Web.UI.Page
    Public Sub Update(sender As Object, e As ImageClickEventArgs)

        Dim uid As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim gvr As GridViewRow = sender.parent.parent

        doSQLProcedure("spUsers", Data.CommandType.StoredProcedure, _
                       "@action", "UPD",
                       "@userID", uid, _
                       "@userName", DirectCast(gvr.FindControl("txtUserName"), TextBox).Text, _
                       "@userFirstName", DirectCast(gvr.FindControl("txtUserFirstName"), TextBox).Text, _
                       "@userLastName", DirectCast(gvr.FindControl("txtUserLastName"), TextBox).Text, _
                       "@userLang", "esp", _
                       "@userEmployeeNo", DirectCast(gvr.FindControl("txtUserEmployeeNo"), TextBox).Text, _
                       "@userDept", DirectCast(gvr.FindControl("ddlUserDept"), DropDownList).SelectedValue, _
                       "@userArea", DirectCast(gvr.FindControl("txtUserArea"), TextBox).Text, _
                       "@userBirthDate", "1/1/1900", _
                       "@userGender", DirectCast(gvr.FindControl("ddlUserGender"), DropDownList).SelectedValue, _
                       "@userEmailAddress", DirectCast(gvr.FindControl("txtUserEmailAddress"), TextBox).Text, _
                       "@userIsAdmin", DirectCast(gvr.FindControl("chkIsAdmin"), CheckBox).Checked)
        ' dsUsers.Update()
        GridView1.EditIndex = -1

        GridView1.DataBind()
    End Sub

    Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = True
        Dim gvf As GridViewRow = GridView1.FooterRow
        DirectCast(gvf.FindControl("txtUsername"), TextBox).Text = ""
        GridView1.EditIndex = -1
    End Sub

    Public Sub showHidePrivs(sender As Object, e As EventArgs)
        Dim chk As CheckBox = sender
        DirectCast(chk.Parent.FindControl("imbPrivs"), ImageButton).Visible = Not chk.Checked
    End Sub

    Public Sub Insert(sender As Object, e As ImageClickEventArgs)
        Dim gvf As GridViewRow = GridView1.FooterRow
        doSQLProcedure("spUsers", Data.CommandType.StoredProcedure, _
               "@action", "ADD",
               "@userName", DirectCast(gvf.FindControl("txtUserName"), TextBox).Text, _
               "@userFirstName", DirectCast(gvf.FindControl("txtUserFirstName"), TextBox).Text, _
               "@userLastName", DirectCast(gvf.FindControl("txtUserLastName"), TextBox).Text, _
               "@userLang", "esp", _
               "@userEmployeeNo", DirectCast(gvf.FindControl("txtUserEmployeeNo"), TextBox).Text, _
               "@userDept", DirectCast(gvf.FindControl("ddlUserDept"), DropDownList).SelectedValue, _
               "@userArea", DirectCast(gvf.FindControl("txtUserArea"), TextBox).Text, _
               "@userBirthDate", "1/1/1900", _
               "@userGender", DirectCast(gvf.FindControl("ddlUserGender"), DropDownList).SelectedValue, _
               "@userEmailAddress", DirectCast(gvf.FindControl("txtUserEmailAddress"), TextBox).Text, _
               "@userIsAdmin", DirectCast(gvf.FindControl("chkUserIsAdmin"), CheckBox).Checked)

        GridView1.DataBind()
        GridView1.ShowFooter = False
    End Sub

    Public Sub Cancel(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = False
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spUsers", Data.CommandType.StoredProcedure, "@action", "DEL", "@userId", DirectCast(sender, ImageButton).CommandArgument)
        GridView1.DataBind()
    End Sub

    Public Sub Privs(sender As Object, e As ImageClickEventArgs)

        Dim uid As Integer = DirectCast(sender, ImageButton).CommandArgument
        adm_Privs1.userID = uid
        adm_Privs1.FullName = DirectCast(sender.parent.parent.findcontrol("txtUserFirstName"), TextBox).Text & " " & DirectCast(sender.parent.parent.findcontrol("txtUserLastName"), TextBox).Text
        adm_Privs1.UserName = DirectCast(sender.parent.parent.findcontrol("txtUserName"), TextBox).Text

        adm_Privs1.Show()
    End Sub
End Class
