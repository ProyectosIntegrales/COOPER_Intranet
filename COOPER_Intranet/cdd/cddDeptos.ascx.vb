
Partial Class cddDeptos
    Inherits System.Web.UI.UserControl

    Public Sub Update(sender As Object, e As ImageClickEventArgs)
        Dim imb As ImageButton = sender

        Dim cArea As cddAreas = imb.Parent.FindControl("cddAreas1")

        If cArea.update = True Then

            Dim uid As Integer = imb.CommandArgument
            Dim gvr As GridViewRow = sender.parent.parent

            doSQLProcedure("spDeptos", Data.CommandType.StoredProcedure, _
                           "@action", "UPD",
                           "@deptoID", uid, _
                           "@deptoName", DirectCast(gvr.FindControl("txtdeptoName"), TextBox).Text, _
                           "@deptoManagerNo", DirectCast(gvr.FindControl("txtdeptomanagerNo"), TextBox).Text, _
                           "@deptoMnemonic", DirectCast(gvr.FindControl("txtDeptoMnemonic"), TextBox).Text.ToUpper.Replace(" ", ""))

            GridView1.EditIndex = -1

            GridView1.DataBind()
        Else
            'TODO Mostrar error cuando no se actualice el Area

        End If

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
                       "@deptoMnemonic", DirectCast(gvf.FindControl("txtDeptoMnemonic"), TextBox).Text.ToUpper.Replace(" ", ""))

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

        If txtmgrno.Text.Trim <> "" Then

            DirectCast(txtmgrno.Parent.FindControl("lblMgrName"), Label).Text = New Employee(txtmgrno.Text).FullName
        Else
            DirectCast(txtmgrno.Parent.FindControl("lblMgrName"), Label).Text = ""
        End If

    End Sub

End Class
