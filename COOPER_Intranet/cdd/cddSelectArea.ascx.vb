
Partial Class cdd_cddSelectArea
    Inherits System.Web.UI.UserControl

    Public ReadOnly Property SelectedAreaID As Integer
        Get
            Return isNull(hflSelAreaID.Value, 0)
        End Get
    End Property

    Public ReadOnly Property SelectedCeldaID As Integer
        Get
            Return hflSelCeldaID.Value
        End Get
    End Property

    Protected Sub cdd_cddSelectArea_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        hflDept.Value = Request.QueryString("dept")

    End Sub

    Public Event Selected()

    Public Sub SelectArea(sender As Object, e As EventArgs)
        Dim lnb As LinkButton = sender
        hflSelAreaID.Value = lnb.CommandArgument
        hflSelCeldaID.Value = 0
        RaiseEvent Selected()
    End Sub

    Public Sub SelectCelda(sender As Object, e As EventArgs)
        Dim lnb As LinkButton = sender
        Dim parentPanel As Panel = DirectCast(lnb.Parent, Panel)
        resetCeldas(parentPanel.Parent.Parent)
        hflSelCeldaID.Value = lnb.CommandArgument
        parentPanel.CssClass = "celdasPanelActive"
        RaiseEvent Selected()
    End Sub

    Public Sub resetCeldas(repItem As Repeater)

        For Each ri As RepeaterItem In repItem.Items
            DirectCast(ri.FindControl("pnlCeldas"), Panel).CssClass = "celdasPanel"
        Next

    End Sub

    Protected Sub Accordion1_ItemCommand(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs) Handles Accordion1.ItemCommand

        For Each ac As AjaxControlToolkit.AccordionPane In Accordion1.Panes
            Dim rp As Repeater = DirectCast(ac.Controls(1).Controls(5), Repeater)
            resetCeldas(rp)
        Next


    End Sub
End Class
