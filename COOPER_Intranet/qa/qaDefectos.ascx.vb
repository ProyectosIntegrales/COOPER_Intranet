
Partial Class qa_qaDefectos
    Inherits System.Web.UI.UserControl

    Public Sub Update(sender As Object, e As ImageClickEventArgs)
        Dim gvr As GridViewRow = sender.parent.parent
        doSQLProcedure("qaa.spDefectos", Data.CommandType.StoredProcedure, _
                       "@action", "UPD",
                       "@defectoID", DirectCast(sender, ImageButton).CommandArgument, _
                       "@defectoDesc", DirectCast(gvr.FindControl("txtDefectoDesc"), TextBox).Text)

        GridView1.EditIndex = -1
        GridView1.DataBind()
    End Sub

    Public Sub Insert(sender As Object, e As ImageClickEventArgs)

        Dim gvf As GridViewRow = GridView1.FooterRow
        doSQLProcedure("qaa.spDefectos", Data.CommandType.StoredProcedure, _
                "@action", "ADD",
                "@defectoID", DirectCast(gvf.FindControl("lblDefectoID"), Label).Text, _
                "@defectoDesc", DirectCast(gvf.FindControl("txtDefectoDesc"), TextBox).Text)

        GridView1.DataBind()
        GridView1.ShowFooter = False
    End Sub

    Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
        GridView1.EditIndex = -1
        GridView1.ShowFooter = True
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("qaa.spDefectos", Data.CommandType.StoredProcedure, "@action", "DEL", "@defectoId", DirectCast(sender, ImageButton).CommandArgument)
        GridView1.DataBind()
    End Sub

    Public Sub Cancel(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = False
    End Sub

    Protected Sub GridView1_PreRender(sender As Object, e As System.EventArgs) Handles GridView1.PreRender
        If GridView1.ShowFooter Then
            Dim gvf As GridViewRow = GridView1.FooterRow
            Dim NextID As Integer = doSQLProcedure("select MAX(defectoID) from qaa.tblDefectos", Data.CommandType.Text) + 1
            DirectCast(gvf.FindControl("lblDefectoID"), Label).Text = NextID

            DirectCast(gvf.FindControl("txtDefectoDesc"), TextBox).Text = ""
            DirectCast(gvf.FindControl("txtDefectoDesc"), TextBox).Focus()
        End If
    End Sub
End Class