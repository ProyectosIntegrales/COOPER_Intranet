
Partial Class cddAreas
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

    Public Property Deptoid As Integer
        Get
            Return hflDeptoID.Value
        End Get
        Set(value As Integer)
            hflDeptoID.Value = value
        End Set
    End Property

    Public Function Update() As Boolean

        Try

            If txtAreaMnemonic.Text.Trim <> "" Then
                doSQLProcedure("spAreas", Data.CommandType.StoredProcedure, _
                               "@action", "ADD", _
                               "@areaID", 0, _
                               "@areaMnemonic", txtAreaMnemonic.Text.ToUpper.Trim, _
                               "@areaName", txtAreaname.Text, _
                               "@areaDeptoID", hflDeptoID.Value)
            End If

            For Each ri As RepeaterItem In repEdit.Items
                Dim areaMnemonic = DirectCast(ri.FindControl("txtAreaMnemonic"), TextBox).Text.Trim
                Dim cEngs As cdd_cddEngs = ri.FindControl("cddEngs1")
                cEngs.update()

                Dim cCelda As cddCeldas = ri.FindControl("cddCeldas1")
                If cCelda.Update Then

                    If areaMnemonic <> "" Then
                        doSQLProcedure("spAreas", Data.CommandType.StoredProcedure, _
                                   "@action", "UPD", _
                                   "@areaID", DirectCast(ri.FindControl("lblAreaID"), Label).Text, _
                                   "@areaMnemonic", DirectCast(ri.FindControl("txtAreaMnemonic"), TextBox).Text.ToUpper.Trim, _
                                   "@areaName", DirectCast(ri.FindControl("txtAreaname"), TextBox).Text.Trim, _
                                   "@areaDeptoID", hflDeptoID.Value)
                    Else
                        doSQLProcedure("spAreas", Data.CommandType.StoredProcedure, _
                                           "@action", "DEL", _
                                           "@areaID", DirectCast(ri.FindControl("lblAreaID"), Label).Text)
                    End If
                Else

                    'TODO Mostrar error cuando no se actualice la Celda

                End If

            Next

            Return True
        Catch ex As Exception

            Return False
        End Try
    End Function

    Protected Sub repItem_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repItem.ItemDataBound
        Dim dv As Data.DataView = DirectCast(dsAreas.Select(DataSourceSelectArguments.Empty), Data.DataView)
        Dim ri As RepeaterItem = e.Item
        If dv.Count > 1 Then
            If ri.ItemIndex = 0 Then
                DirectCast(ri.FindControl("tdArea"), HtmlTableCell).Attributes.Add("Class", "T")
            Else
                If ri.ItemIndex <> dv.Count - 1 Then
                    DirectCast(ri.FindControl("tdArea"), HtmlTableCell).Attributes.Add("Class", "F")
                Else
                    DirectCast(ri.FindControl("tdArea"), HtmlTableCell).Attributes.Add("Class", "L")
                End If

            End If

        End If
    End Sub

    Protected Sub repEdit_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repEdit.ItemDataBound
        Dim dv As Data.DataView = DirectCast(dsAreas.Select(DataSourceSelectArguments.Empty), Data.DataView)
        Dim ri As RepeaterItem = e.Item
        If dv.Count >= 1 Then
            If ri.ItemIndex = 0 Then
                DirectCast(ri.FindControl("tdArea"), HtmlTableCell).Attributes.Add("Class", "T")
            Else
                DirectCast(ri.FindControl("tdArea"), HtmlTableCell).Attributes.Add("Class", "F")
            End If

        End If
    End Sub

    Protected Sub tdNewArea_PreRender(sender As Object, e As System.EventArgs) Handles tdNewArea.PreRender
        Dim dv As Data.DataView = DirectCast(dsAreas.Select(DataSourceSelectArguments.Empty), Data.DataView)

        If dv.Count = 0 Then
            tdNewArea.Attributes.Add("Class", "M")
        Else
            tdNewArea.Attributes.Add("Class", "L")
        End If
    End Sub
End Class
