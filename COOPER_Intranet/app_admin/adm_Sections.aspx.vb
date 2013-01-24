
Partial Class app_addIns_adm_Sections
    Inherits System.Web.UI.Page

    Public Sub Update(sender As Object, e As ImageClickEventArgs)

        Dim sid As Integer = DirectCast(sender, ImageButton).CommandArgument
        Dim gvr As GridViewRow = sender.parent.parent

        doSQLProcedure("spSections", Data.CommandType.StoredProcedure, _
                       "@action", "UPD", _
                       "@sectionID", sid, _
                       "@sectionTitleEsp", DirectCast(gvr.FindControl("txtSectionTitleEsp"), TextBox).Text, _
                       "@sectionTitleEng", DirectCast(gvr.FindControl("txtSectionTitleEng"), TextBox).Text, _
                       "@sectionControlName", DirectCast(gvr.FindControl("txtSectionControlName"), TextBox).Text, _
                       "@sectionLeftMenu", DirectCast(gvr.FindControl("Checkbox1"), CheckBox).Checked, _
                       "@sectionHelpFile", DirectCast(gvr.FindControl("txtSectionHelpFile"), TextBox).Text)

        GridView1.EditIndex = -1

        GridView1.DataBind()
    End Sub

    Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = True
        Dim gvf As GridViewRow = GridView1.FooterRow
        DirectCast(gvf.FindControl("txtSectiontitleEsp"), TextBox).Text = ""
        DirectCast(gvf.FindControl("txtSectiontitleEng"), TextBox).Text = ""
        DirectCast(gvf.FindControl("txtSectionControlname"), TextBox).Text = ""
        DirectCast(gvf.FindControl("Checkbox1"), CheckBox).Checked = True
        DirectCast(gvf.FindControl("txtSectionHelpFile"), TextBox).Text = ""
        GridView1.EditIndex = -1
    End Sub

    Public Sub Insert(sender As Object, e As ImageClickEventArgs)
        Dim gvf As GridViewRow = GridView1.FooterRow
        doSQLProcedure("spSections", Data.CommandType.StoredProcedure, _
                     "@action", "ADD", _
                     "@sectionID", 0, _
                     "@sectionTitleEsp", DirectCast(gvf.FindControl("txtSectionTitleEsp"), TextBox).Text, _
                     "@sectionTitleEng", DirectCast(gvf.FindControl("txtSectionTitleEng"), TextBox).Text, _
                     "@sectionControlName", DirectCast(gvf.FindControl("txtSectionControlName"), TextBox).Text, _
                     "@sectionLeftMenu", DirectCast(gvf.FindControl("Checkbox1"), CheckBox).Checked, _
                     "@sectionHelpFile", DirectCast(gvf.FindControl("txtSectionHelpFile"), TextBox).Text)

        GridView1.DataBind()
        GridView1.ShowFooter = False
    End Sub

    Public Sub Cancel(sender As Object, e As ImageClickEventArgs)
        GridView1.ShowFooter = False
    End Sub

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)
        doSQLProcedure("spSections", Data.CommandType.StoredProcedure, "@action", "DEL", "@sectionId", DirectCast(sender, ImageButton).CommandArgument)
        GridView1.DataBind()
    End Sub
End Class
