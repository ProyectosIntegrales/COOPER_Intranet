
Partial Class App_controls_cntrlError
    Inherits System.Web.UI.UserControl

    Public WriteOnly Property errorMessage As String
        Set(ByVal value As String)
            lblError.Text = value
            If lblError.Text <> "" Then
                ModalPopupExtender1.Show()
            End If

        End Set
    End Property

    Public Event closeError()

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        ModalPopupExtender1.Hide()
        RaiseEvent closeError()
    End Sub
End Class
