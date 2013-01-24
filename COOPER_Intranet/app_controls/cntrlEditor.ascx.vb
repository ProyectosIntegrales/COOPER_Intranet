
Imports System.Collections.ObjectModel
Imports System.Globalization
Imports System.IO

Partial Class app_controls_cntrlEditor
    Inherits System.Web.UI.UserControl

    Public Property Header As String
        Get
            Return txtHeader.Text
        End Get
        Set(value As String)
            txtHeader.Text = value
        End Set
    End Property

    Public Property Content As String
        Get
            Return Editor1.Text
        End Get
        Set(value As String)
            Editor1.Text = value
        End Set
    End Property

    Public Property ImageURL As String
        Get
            Return Request.Cookies("imageData").Value.Replace("~/", "")
        End Get
        Set(value As String)
            Response.Cookies("imageData").Value = value
            bodyImage.ImageUrl = value
        End Set
    End Property

    Public WriteOnly Property Size As String
        Set(value As String)
            Select Case value
                Case "Left"
                    txtHeader.CssClass = "leftSideTextBox"
                    txtHeader.MaxLength = 50
                    txtHeader.TextMode = TextBoxMode.SingleLine
                    pnlEdit.CssClass = "modalPopupSml"
                    ModalPopupExtender1.X = 8
                    Editor1.Width = 200
                    setImages(ServerPath)
                    pnlImg.Visible = False
                Case "Body"
                    txtHeader.CssClass = "bodyHeaderTextBox"
                    txtHeader.MaxLength = 1000
                    txtHeader.TextMode = TextBoxMode.MultiLine
                    pnlEdit.CssClass = "modalPopupBody"
                    ModalPopupExtender1.X = IIf(Me.Parent.Parent.ToString = "ASP.masterempty_master", 160, 380)
                    ModalPopupExtender1.Y = IIf(Me.Parent.Parent.ToString = "ASP.masterempty_master", 0, 150)

                    Editor1.Width = 700
                    setImages(ServerPath)
                    pnlImg.Visible = True
            End Select
        End Set
    End Property

    Public ReadOnly Property ServerPath As String
        Get
            If System.Web.HttpContext.Current.Request.Url.AbsolutePath.IndexOf("/COOPER_Intranet") = 0 Then
                Return "/COOPER_Intranet/"
            Else
                Return "/"
            End If
        End Get
    End Property

    Public Property ItemID As Integer
        Get
            Return hflItemID.Value
        End Get
        Set(value As Integer)
            hflItemID.Value = value
            imbTrash.Visible = hflItemID.Value > 0
        End Set
    End Property

    Public Event OKClicked()
    Public Event CancelClicked()
    Public Event DeleteClicked()

    Protected Sub imbOK_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbOK.Click
        '  If validateFields() Then
        ModalPopupExtender1.Hide()
        RaiseEvent OKClicked()
        '    Else
        'pnlError.Visible = True
        'End If
    End Sub

    Public Sub Show()
        ModalPopupExtender1.Show()
    End Sub

    Protected Sub imbCancel_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbCancel.Click
        ModalPopupExtender1.Hide()
        RaiseEvent CancelClicked()
    End Sub

    Protected Sub setImages(path As String)

        imbOK.Attributes.Add("onmouseover", "this.src='" & path & "images/buttons/applyHover.png'")
        imbOK.Attributes.Add("onmouseout", "this.src='" & Path & "images/buttons/apply.png'")
        imbOK.Attributes.Add("onclick", "this.src='" & Path & "images/buttons/applyClick.png'")
        imbCancel.Attributes.Add("onmouseover", "this.src='" & Path & "images/buttons/cancelHover.png'")
        imbCancel.Attributes.Add("onmouseout", "this.src='" & Path & "images/buttons/cancel.png'")
        imbCancel.Attributes.Add("onclick", "this.src='" & Path & "images/buttons/cancelClick.png'")
        imbTrash.Attributes.Add("onmouseover", "this.src='" & Path & "images/buttons/trashHover.png'")
        imbTrash.Attributes.Add("onmouseout", "this.src='" & Path & "images/buttons/trash.png'")
        imbTrash.Attributes.Add("onclick", "this.src='" & Path & "images/buttons/trashClick.png'")
        imbPicture.Attributes.Add("onmouseover", "this.src='" & Path & "images/buttons/imageHover.png'")
        imbPicture.Attributes.Add("onmouseout", "this.src='" & Path & "images/buttons/image.png'")
        imbPicture.Attributes.Add("onclick", "this.src='" & Path & "images/buttons/imageClick.png'")

    End Sub

    Protected Sub imbTrash_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbTrash.Click
        ModalPopupExtender1.Hide()
        RaiseEvent DeleteClicked()
    End Sub

    Protected Sub AsyncFileUpload1_UploadedComplete(sender As Object, e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete
        Dim ufn As String = DateTime.Now.Ticks.ToString("x") & Mid(AsyncFileUpload1.FileName, AsyncFileUpload1.FileName.LastIndexOf(".") + 1)
        Dim path As String = "~/images/body"
        Dim fn As String = MapPath(path) & "\" & ufn
        Response.Cookies("imageData").Value = path.Replace("~/", "") & "/" & ufn
        AsyncFileUpload1.SaveAs(fn)

    End Sub


End Class
