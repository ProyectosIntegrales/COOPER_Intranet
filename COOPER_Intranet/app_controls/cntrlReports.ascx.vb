Imports System.Data
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports CrystalDecisions.ReportSource
Imports System.Threading
Imports System.IO
Imports System.Net

Partial Class cntrlReports
    Inherits System.Web.UI.UserControl

    Public Event LinkClicked(ByVal id As Integer)


    Public Property ReportType() As String
        Get
            Return hfReportType.Value
        End Get
        Set(ByVal value As String)
            hfReportType.Value = value
            Refresh()
        End Set
    End Property

    Public WriteOnly Property ParamID As String
        Set(ByVal value As String)
            hfParamID.Value = value
        End Set

    End Property

    Public WriteOnly Property ParamOptional1() As String
        Set(ByVal value As String)
            hfParamOptional1.Value = value
        End Set

    End Property

    Public WriteOnly Property ParamOptional2() As String
        Set(ByVal value As String)
            hfParamOptional2.Value = value
        End Set

    End Property

    Public WriteOnly Property ParamOptional3() As String
        Set(ByVal value As String)
            hfParamOptional3.Value = value
        End Set

    End Property

    Public WriteOnly Property Header() As String
        Set(ByVal value As String)
            lblHeader.Text = value

        End Set
    End Property

    Public WriteOnly Property HeaderClass() As String
        Set(ByVal value As String)
            lblHeader.CssClass = value

        End Set
    End Property

    Public WriteOnly Property ItemClass As String
        Set(ByVal value As String)
            hfItemClass.Value = value
        End Set
    End Property

    Public Sub Refresh()
        dsReports.DataBind()
    End Sub

    Public Sub goReport(ByVal sender As LinkButton, ByVal e As EventArgs)
        'btnDOC.Attributes.Add("onclick", "document.body.style.cursor = 'wait';")
        'imbClose.Attributes.Add("onclick", "document.body.style.cursor = 'auto';")

        Thread.Sleep(3000)
        Dim lb As LinkButton = sender
        Session("ReportID") = lb.CommandArgument
        RaiseEvent LinkClicked(lb.CommandArgument)
        mdlPopup.Show()
    End Sub

    Private Function validateParams() As Boolean
        Dim result As Boolean = True
        For Each ri As RepeaterItem In repeaterParams.Items
            Dim pOptional As Boolean = DirectCast(ri.FindControl("paramIsOptionalLabel"), Label).Text
            If Not pOptional Then
                Dim txtP As TextBox = DirectCast(ri.FindControl("txtParam"), TextBox)
                Dim txtD As TextBox = DirectCast(ri.FindControl("calParam"), TextBox)
                DirectCast(ri.FindControl("imgReq"), Image).Visible = False
                If txtP.Visible Or txtD.Visible Then
                    If txtP.Text.Trim = "" And txtD.Text.Trim = "" Then
                        DirectCast(ri.FindControl("imgReq"), Image).Visible = True
                        result = False
                    End If
                End If
            End If
        Next

        Return result
    End Function

    Protected Sub genDOC(ByVal sender As Object, ByVal e As ImageClickEventArgs)
        If validateParams() Then GenerarReporte("doc", ExportFormatType.WordForWindows)
    End Sub

    Protected Sub genXLS(ByVal sender As Object, ByVal e As ImageClickEventArgs)
        If validateParams() Then GenerarReporte("xls", ExportFormatType.Excel)
    End Sub

    Protected Sub genXLD(ByVal sender As Object, ByVal e As ImageClickEventArgs)
        If validateParams() Then GenerarReporte("xls", ExportFormatType.ExcelRecord)
    End Sub

    Protected Sub genPDF(ByVal sender As Object, ByVal e As ImageClickEventArgs)
        If validateParams() Then GenerarReporte("pdf", ExportFormatType.PortableDocFormat)
    End Sub

    Protected Sub GenerarReporte(ByVal exportExtension As String, ByVal exportFormat As ExportFormatType)

        Dim dv As DataView = DirectCast(dsReport.Select(DataSourceSelectArguments.Empty), DataView)
        Dim dr As DataRow = dv.Item(0).Row

        Dim reportFile As String = dr.Item("reportFile")
        Dim reportName As String = Mid(reportFile, reportFile.LastIndexOf("/") + 2)
        Dim reportTitle As String = dr.Item("reportTitle").ToString.Trim.Replace(" ", "_")
        Dim serverName As String = dr.Item("DatabaseServerName")
        Dim databaseName As String = dr.Item("DatabaseName")

        Dim oDfDopt As New DiskFileDestinationOptions
        Dim expo As New ExportOptions

        '  Dim reportName As String = reportFile

        Dim strCrystalReportFilePath As String = reportFile
        Dim oRDoc As New ReportDocument

        Dim strFileDestinationPath As String = MapPath("~/_temp/" & reportName.Replace(".", "_") & "_" & Session.SessionID.ToString & Now.GetHashCode & ".tmp")

        oRDoc.Load(MapPath(strCrystalReportFilePath)) 'loads the crystalreports in to the memory
        'oRDoc.RecordSelectionFormula = sRecSelFormula 'used if u want pass the query to u r crystal form
        'oRDoc.RecordSelectionFormula = "{vDocuments.documentDeptoID} = " & hfParamOptional1.Value

        Dim dvParams As DataView = DirectCast(dsParams.Select(DataSourceSelectArguments.Empty), DataView)

        For Each r As RepeaterItem In repeaterParams.Items

            Dim paramControlType As String = DirectCast(r.FindControl("paramControlLabel"), Label).Text.Trim
            Dim paramVisible As Boolean = DirectCast(r.FindControl("paramTitleLabel"), Label).Visible
            Dim paramIsID As Boolean = DirectCast(r.FindControl("paramIsIdLabel"), Label).Text.Trim
            Dim paramIsOptional As Boolean = DirectCast(r.FindControl("paramIsOptionalLabel"), Label).Text.Trim
            Dim paramOptionalID As String = DirectCast(r.FindControl("paramOptionalIDLabel"), Label).Text.Trim

            Dim paramData As String = String.Empty

            If paramVisible Then
                Select Case paramControlType
                    Case "textbox"
                        paramData = DirectCast(r.FindControl("txtParam"), TextBox).Text.Trim
                    Case "calendar"
                        paramData = CDate(DirectCast(r.FindControl("calParam"), TextBox).Text.Trim)
                    Case "checkbox"
                        paramData = DirectCast(r.FindControl("chkParam"), CheckBox).Checked
                End Select
            Else
                If paramIsID Then
                    'Default ID
                    paramData = hfParamID.Value
                    'paramData = Session("paramID")
                ElseIf paramIsOptional Then
                    Select Case paramOptionalID
                        Case "1"
                            paramData = hfParamOptional1.Value
                        Case "2"
                            paramData = hfParamOptional2.Value
                        Case "3"
                            paramData = hfParamOptional3.Value
                    End Select
                End If
            End If

            Dim paramName As String = DirectCast(r.FindControl("paramNameLabel"), Label).Text.Trim
            oRDoc.SetParameterValue(paramName, paramData)
        Next

        oDfDopt.DiskFileName = strFileDestinationPath 'path of file where u want to locate ur PDF
        oRDoc.SetDatabaseLogon("CooperIntranetUser", "cpr2012")
        expo = oRDoc.ExportOptions
        expo.ExportDestinationType = ExportDestinationType.DiskFile
        expo.ExportFormatType = exportFormat
        expo.DestinationOptions = oDfDopt

        oRDoc.Export()
        oRDoc.Close()
        oRDoc.Dispose()

        Response.Redirect("../app_addins/getReport.aspx?reportFile=" & strFileDestinationPath & "&reportTitle=" & reportTitle & "&reportType=" & exportExtension, False)

    End Sub

    Protected Sub DataList1_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemCreated

        DirectCast(e.Item.FindControl("reportTitleLinkButton1"), LinkButton).CssClass = hfItemClass.Value
    End Sub


End Class
