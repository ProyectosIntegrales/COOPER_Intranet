
Partial Class qa_qaAreas
    Inherits System.Web.UI.UserControl

    Public Sub Update(sender As Object, e As ImageClickEventArgs)
        Dim gvr As GridViewRow = sender.parent.parent
        doSQLProcedure("qaa.spareas", Data.CommandType.StoredProcedure, _
                       "@action", "UPD",
                       "@areaID", DirectCast(sender, ImageButton).CommandArgument, _
                       "@areaMnemonic", DirectCast(gvr.FindControl("txtareaMnemonic"), TextBox).Text, _
                       "@areaName", DirectCast(gvr.FindControl("txtareaName"), TextBox).Text)

        GridView1.EditIndex = -1
        GridView1.DataBind()
    End Sub

    Public Sub Insert(sender As Object, e As ImageClickEventArgs)

        Dim gvf As GridViewRow = GridView1.FooterRow
        doSQLProcedure("qaa.spareas", Data.CommandType.StoredProcedure, _
                "@action", "ADD",
                "@areaMnemonic", DirectCast(gvf.FindControl("txtareaMnemonic"), TextBox).Text, _
                "@areaName", DirectCast(gvf.FindControl("txtareaName"), TextBox).Text)

        GridView1.DataBind()
        GridView1.ShowFooter = False
    End Sub

    Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
        GridView1.EditIndex = -1
        GridView1.ShowFooter = True
        Dim gvf As GridViewRow = GridView1.FooterRow

        DirectCast(gvf.FindControl("txtareaMnemonic"), TextBox).Text = ""
        DirectCast(gvf.FindControl("txtareaName"), TextBox).Text = ""
        DirectCast(gvf.FindControl("txtareaMnemonic"), TextBox).Focus()
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("qaa.spareas", Data.CommandType.StoredProcedure, "@action", "DEL", "@areaId", DirectCast(sender, ImageButton).CommandArgument)
        GridView1.DataBind()
    End Sub

    Public Sub Cancel(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = False
    End Sub

    Protected Sub GridView1_PreRender(sender As Object, e As System.EventArgs) Handles GridView1.PreRender
        Dim gvf As GridViewRow = GridView1.FooterRow
        If DirectCast(gvf.FindControl("txtAreaMnemonic"), TextBox).Text = "" Then
            DirectCast(gvf.FindControl("txtareaMnemonic"), TextBox).Focus()
        Else
            DirectCast(gvf.FindControl("txtareaName"), TextBox).Focus()
        End If
    End Sub

    Protected Sub getAreaPre(sender As Object, e As EventArgs)
        Dim gvf As GridViewRow = GridView1.FooterRow
        DirectCast(gvf.FindControl("txtAreaMnemonic"), TextBox).Text = DirectCast(gvf.FindControl("txtAreaMnemonic"), TextBox).Text.ToUpper
        DirectCast(gvf.FindControl("txtAreaName"), TextBox).Text = isNull(doSQLProcedure("select areaName from qaa.vAreasPre where areaMnemonic = '" & DirectCast(gvf.FindControl("txtAreaMnemonic"), TextBox).Text.Trim & "'", Data.CommandType.Text), "")
    End Sub
End Class