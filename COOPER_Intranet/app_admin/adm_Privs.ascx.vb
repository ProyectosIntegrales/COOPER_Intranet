Partial Class app_addIns_adm_privs
    Inherits System.Web.UI.UserControl

    Public Property userID As Integer
        Get
            Return hflUserID.Value
        End Get
        Set(value As Integer)
            hflUserID.Value = value
        End Set
    End Property

    Public WriteOnly Property FullName As String
        Set(value As String)
            lblfullName.Text = value
        End Set
    End Property

    Public WriteOnly Property UserName As String
        Set(value As String)
            lbluserName.Text = value
        End Set
    End Property

    Public Sub Show()
        ModalPopupExtender1.Show()
    End Sub

    Private Sub setlabels()
        
            lblPrivLabel.Text = "Privilegios para:"


    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        setlabels()
    End Sub

    Protected Sub btnOK_Click(sender As Object, e As System.EventArgs) Handles btnOK.Click
        For Each item As DataListItem In DataList1.Items
            doSQLProcedure("spUpdatePrivs", Data.CommandType.StoredProcedure, "@userID", userID, "@sectionID", DirectCast(item.FindControl("lblSectionID"), Label).Text, "@value", DirectCast(item.FindControl("chkPriv"), CheckBox).Checked)
        Next
    End Sub
End Class
