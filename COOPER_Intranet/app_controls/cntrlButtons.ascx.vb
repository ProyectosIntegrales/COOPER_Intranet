
Partial Class app_controls_cntrlButtons
    Inherits System.Web.UI.UserControl

    Public Property DeleteButtonVisible As Boolean
        Get
            Return imbDelete.Visible
        End Get
        Set(value As Boolean)
            imbDelete.Visible = value
        End Set
    End Property

    Public Event OK_Clicked()
    Public Event Trash_Clicked()
    Public Event Cancel_Clicked()


    Protected Sub imbOK_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbOK.Click
        RaiseEvent OK_Clicked()
    End Sub

    Protected Sub imbDelete_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbDelete.Click
        RaiseEvent Trash_Clicked()
    End Sub

    Protected Sub imbCancel_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbCancel.Click
        RaiseEvent Cancel_Clicked()
    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        Dim path As String = "../"
        imbDelete.Attributes.Add("OnClick", "return confirm('¿Estás seguro de eliminar este elemento?');")
        imbOK.Attributes.Add("onmouseover", "this.src='" & path & "images/buttons/applyBigHover.png'")
        imbOK.Attributes.Add("onmouseout", "this.src='" & path & "images/buttons/applyBig.png'")
        imbOK.Attributes.Add("onclick", "this.src='" & path & "images/buttons/applyBigClick.png'")
        imbCancel.Attributes.Add("onmouseover", "this.src='" & Path & "images/buttons/cancelHover.png'")
        imbCancel.Attributes.Add("onmouseout", "this.src='" & Path & "images/buttons/cancel.png'")
        imbCancel.Attributes.Add("onclick", "this.src='" & Path & "images/buttons/cancelClick.png'")
        imbDelete.Attributes.Add("onmouseover", "this.src='" & path & "images/buttons/trashHover.png'")
        imbDelete.Attributes.Add("onmouseout", "this.src='" & Path & "images/buttons/trash.png'")
        imbDelete.Attributes.Add("onclick", "this.src='" & path & "images/buttons/trashClick.png';return confirm('¿Estás seguro de eliminar este elemento?');")
    End Sub
End Class
