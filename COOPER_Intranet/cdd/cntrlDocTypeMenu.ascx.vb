
Partial Class cdd_cntrlDocTypeMenu
    Inherits System.Web.UI.UserControl

    Public WriteOnly Property Area As Integer
        Set(value As Integer)
            hflArea.Value = value
        End Set
    End Property

    Public Property Type As Integer
        Get
            Return hflType.Value
        End Get
        Set(value As Integer)
            hflType.Value = value
        End Set
    End Property

    Public Event TypeSelected()

    Protected Sub resetPanels()
        For Each i As RepeaterItem In repTypes.Items
            DirectCast(i.FindControl("pnlMenu"), Panel).CssClass = "grayMenu"
        Next
    End Sub

    Public Sub lnbClick(sender As Object, e As EventArgs)
        Dim lnb As LinkButton = sender
        resetPanels()
        DirectCast(lnb.Parent, Panel).CssClass = "activeMenu"
        hflType.Value = lnb.CommandArgument
        RaiseEvent TypeSelected()
    End Sub

    Protected Sub repTypes_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repTypes.ItemDataBound
        If e.Item.ItemIndex = 0 Then
            DirectCast(e.Item.FindControl("pnlMenu"), Panel).CssClass = "activeMenu"
            lnbClick(DirectCast(e.Item.FindControl("lnbType"), LinkButton), EventArgs.Empty)
        End If
    End Sub
End Class
