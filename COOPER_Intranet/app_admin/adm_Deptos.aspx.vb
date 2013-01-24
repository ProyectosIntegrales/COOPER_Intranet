
Partial Class app_admin_adm_Deptos
    Inherits System.Web.UI.Page
    Public Sub Update(sender As Object, e As ImageClickEventArgs)

        Dim uid As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim gvr As GridViewRow = sender.parent.parent

        doSQLProcedure("spDeptos", Data.CommandType.StoredProcedure, _
                       "@action", "UPD",
                       "@deptoID", uid, _
                       "@deptoName", DirectCast(gvr.FindControl("txtdeptoName"), TextBox).Text, _
                       "@deptoManagerNo", DirectCast(gvr.FindControl("txtdeptomanagerNo"), TextBox).Text, _
                       "@deptoMnemonic", DirectCast(gvr.FindControl("txtDeptoShort"), TextBox).Text.ToUpper.Replace(" ", ""))

        GridView1.EditIndex = -1

        GridView1.DataBind()
    End Sub

    Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = True
        Dim gvf As GridViewRow = GridView1.FooterRow
        DirectCast(gvf.FindControl("txtdeptoName"), TextBox).Text = ""
        GridView1.EditIndex = -1
    End Sub

    Public Sub showHidePrivs(sender As Object, e As EventArgs)
        Dim chk As CheckBox = sender
        DirectCast(chk.Parent.FindControl("imbPrivs"), ImageButton).Visible = Not chk.Checked
    End Sub

    Public Sub Insert(sender As Object, e As ImageClickEventArgs)
        Dim gvf As GridViewRow = GridView1.FooterRow
        doSQLProcedure("spDeptos", Data.CommandType.StoredProcedure, _
                       "@action", "ADD",
                       "@deptoName", DirectCast(gvf.FindControl("txtdeptoName"), TextBox).Text, _
                       "@deptoManagerNo", DirectCast(gvf.FindControl("txtdeptomanagerNo"), TextBox).Text, _
                       "@deptoMnemonic", DirectCast(gvf.FindControl("txtDeptoShort"), TextBox).Text.ToUpper.Replace(" ", ""))

        GridView1.DataBind()
        GridView1.ShowFooter = False
    End Sub

    Public Sub Cancel(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = False
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spDeptos", Data.CommandType.StoredProcedure, "@action", "DEL", "@deptoId", DirectCast(sender, ImageButton).CommandArgument)
        GridView1.DataBind()
    End Sub

    Protected Sub MgrnoChanged(sender As Object, e As System.EventArgs)

        Dim txtmgrno As TextBox = DirectCast(sender, TextBox)

        Try
            DirectCast(txtmgrno.Parent.FindControl("lblMgrName"), Label).Text = SQLDataTable("select userFirstName + ' ' + userLastName from tblUsers where userEmployeeNo = " & txtmgrno.Text).Rows(0).Item(0)

        Catch ex As Exception
            DirectCast(txtmgrno.Parent.FindControl("lblMgrName"), Label).Text = "Número de Empleado no válido"
        End Try



    End Sub
End Class
