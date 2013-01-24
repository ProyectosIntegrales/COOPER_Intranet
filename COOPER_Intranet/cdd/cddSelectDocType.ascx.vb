
Partial Class cdd_cddSelectDocType
    Inherits System.Web.UI.UserControl

    Public Property DeptoID As Integer
        Get
            Return hflDeptoID.Value
        End Get
        Set(value As Integer)
            hflDeptoID.Value = value
            Repeater1.DataBind()
        End Set
    End Property

    Public Property AreaID As Integer
        Get
            Return hflAreaID.Value
        End Get
        Set(value As Integer)
            hflAreaID.Value = value
            Repeater1.DataBind()
        End Set
    End Property

    Public Property CeldaID As Integer
        Get
            Return hflCeldaID.Value
        End Get
        Set(value As Integer)
            hflCeldaID.Value = value
            Repeater1.DataBind()
        End Set
    End Property

    Public ReadOnly Property SelectedDocType As Integer
        Get
            Return hflSelectedDocType.Value
        End Get
    End Property

    Public Event DocTypeSelected()

    Public Sub selectDocType(sender As Object, e As EventArgs)
        resetPanels()
        DirectCast(sender.Parent, Panel).CssClass = "activeMenu"
        hflSelectedDocType.Value = DirectCast(sender, LinkButton).CommandArgument
        RaiseEvent DocTypeSelected()
    End Sub

    Protected Sub resetPanels()
        For Each ri As RepeaterItem In Repeater1.Items
            DirectCast(ri.FindControl("pnlDocType"), Panel).CssClass = "grayMenu"
        Next
    End Sub

    Protected Sub Repeater1_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        If e.Item.ItemIndex = 0 Then
            Dim pnl As Panel = DirectCast(e.Item.FindControl("pnlDocType"), Panel)
            pnl.CssClass = "activeMenu"
            hflSelectedDocType.Value = DirectCast(pnl.FindControl("lnbDocType"), LinkButton).CommandArgument
            RaiseEvent DocTypeSelected()
        End If
    End Sub

    Public Sub Refresh()
        Repeater1.DataBind()

    End Sub
End Class
