
Partial Class MasterEmpty
    Inherits System.Web.UI.MasterPage

    Protected Sub btnShowEditor_Click(sender As Object, e As ImageClickEventArgs) Handles imbShowEditor.Click
        cntrlEditor1.Size = "Body"
        cntrlEditor1.ItemID = Session("itemID")
        cntrlEditor1.ImageURL = Session("imageURL")
        cntrlEditor1.Header = Session("HeaderText")
        cntrlEditor1.Content = Session("ContentText")
        cntrlEditor1.Show()
    End Sub

    Protected Sub cntrlEditor1_DeleteClicked() Handles cntrlEditor1.DeleteClicked
        If cntrlEditor1.ItemID > 0 Then
            doSQLProcedure("spDeleteContent", Data.CommandType.StoredProcedure, "@itemSection", Session("sectionID"), "@itemID", cntrlEditor1.ItemID, "@itemLang", Session("myLanguage"))
        End If
        ' repContent.DataBind()
    End Sub

    Protected Sub EditOk() Handles cntrlEditor1.OKClicked
        If cntrlEditor1.ItemID > 0 Then
            doSQLProcedure("spUpdateContent", Data.CommandType.StoredProcedure, "@itemSection", Session("sectionID"), "@itemID", cntrlEditor1.ItemID, "@itemHeader", cntrlEditor1.Header, "@itemText", cntrlEditor1.Content, "@imageURL", cntrlEditor1.ImageURL)
        Else
            doSQLProcedure("spInsertContent", Data.CommandType.StoredProcedure, "@itemSection", Session("sectionID"), "@itemLang", Session("myLanguage"), "@itemHeader", cntrlEditor1.Header, "@itemText", cntrlEditor1.Content, "@imageURL", cntrlEditor1.ImageURL)
        End If
        ' repContent.DataBind()
    End Sub

End Class

