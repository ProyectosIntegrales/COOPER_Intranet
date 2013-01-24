
Partial Class cddCeldas
    Inherits System.Web.UI.UserControl

    Public Property Mode As String
        Get
            Return hflMode.Value
        End Get
        Set(value As String)
            hflMode.Value = value
            pnlItem.Visible = hflMode.Value = "I"
            pnlEdit.Visible = hflMode.Value = "E"

        End Set
    End Property

    Public Property AreaId As Integer
        Get
            Return hflAreaID.Value
        End Get
        Set(value As Integer)
            hflAreaID.Value = value
        End Set
    End Property

    Public Function Update() As Boolean
        Try
            If txtCeldaMnemonic.Text.Trim <> "" Then
                doSQLProcedure("cdd.spCeldas", Data.CommandType.StoredProcedure, _
                               "@action", "ADD", _
                               "@celdaID", 0, _
                               "@celdaMnemonic", txtCeldaMnemonic.Text.ToUpper.Trim, _
                               "@celdaName", txtCeldaName.Text.Trim, _
                               "@celdaAreaId", hflAreaID.Value)
            End If

            For Each ri As RepeaterItem In repEdit.Items
                Dim celdaMnemonic = DirectCast(ri.FindControl("txtCeldaMnemonic"), TextBox).Text.Trim

                If celdaMnemonic <> "" Then
                    doSQLProcedure("cdd.spCeldas", Data.CommandType.StoredProcedure, _
                               "@action", "UPD", _
                               "@celdaID", DirectCast(ri.FindControl("lblCeldaID"), Label).Text, _
                               "@celdaMnemonic", DirectCast(ri.FindControl("txtCeldaMnemonic"), TextBox).Text.ToUpper.Trim, _
                               "@celdaName", DirectCast(ri.FindControl("txtCeldaName"), TextBox).Text.Trim, _
                               "@celdaAreaId", hflAreaID.Value)
                Else
                    doSQLProcedure("cdd.spCeldas", Data.CommandType.StoredProcedure, _
                                       "@action", "DEL", _
                                       "@celdaID", DirectCast(ri.FindControl("lblCeldaID"), Label).Text)
                End If

            Next

            Return True
        Catch ex As Exception

            Return False
        End Try
        repItem.DataBind()
    End Function

    Protected Sub repItem_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repItem.ItemDataBound
        Dim dv As Data.DataView = DirectCast(dsCeldas.Select(DataSourceSelectArguments.Empty), Data.DataView)
       

        Dim ri As RepeaterItem = e.Item
        If dv.Count > 1 Then
            If ri.ItemIndex = 0 Then
                DirectCast(ri.FindControl("tdCelda"), HtmlTableCell).Attributes.Add("Class", "T")
            Else
                If ri.ItemIndex <> dv.Count - 1 Then
                    DirectCast(ri.FindControl("tdCelda"), HtmlTableCell).Attributes.Add("Class", "F")
                Else
                    DirectCast(ri.FindControl("tdCelda"), HtmlTableCell).Attributes.Add("Class", "L")
                End If

            End If

        End If
    End Sub

    Protected Sub repEdit_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repEdit.ItemDataBound
        Dim dv As Data.DataView = DirectCast(dsCeldas.Select(DataSourceSelectArguments.Empty), Data.DataView)

        Dim ri As RepeaterItem = e.Item
        If dv.Count >= 1 Then
            If ri.ItemIndex = 0 Then
                DirectCast(ri.FindControl("tdCelda"), HtmlTableCell).Attributes.Add("Class", "T")
            Else

                DirectCast(ri.FindControl("tdCelda"), HtmlTableCell).Attributes.Add("Class", "F")

            End If

        End If
    End Sub

    Protected Sub tdNewCelda_PreRender(sender As Object, e As System.EventArgs) Handles tdNewCelda.PreRender
        Dim dv As Data.DataView = DirectCast(dsCeldas.Select(DataSourceSelectArguments.Empty), Data.DataView)

        If dv.Count = 0 Then
            tdNewCelda.Attributes.Add("Class", "M")
        Else
            tdNewCelda.Attributes.Add("Class", "L")
        End If
    End Sub
End Class
