Imports System.Data
Imports System.IO
Imports CrystalDecisions.ReportSource
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Class qa_cAuditData
    Inherits System.Web.UI.UserControl

    Public Sub View(sender As Object, e As ImageClickEventArgs)
        GridView1.Visible = False

        qaAuditDetail1.NoFolio = DirectCast(sender, ImageButton).CommandArgument
        qaAuditDetail1.Visible = True
        pnlFilter.Visible = False
    End Sub

    Public Sub enableAdd(sender As Object, e As ImageClickEventArgs)
        GridView1.EditIndex = -1
        GridView1.Visible = False

        qaAuditDetail1.NoFolio = 0
        qaAuditDetail1.Visible = True
        pnlFilter.Visible = False
    End Sub

    Public Function canEdit() As Boolean
        Dim mee As New qaUser(Session("myUsername"))
        Return mee.PrivLevel > 0
    End Function

    Public Sub Delete(sender As Object, e As ImageClickEventArgs)

        GridView1.Visible = False

        qaAuditDetail1.NoFolio = DirectCast(sender, ImageButton).CommandArgument * -1
        qaAuditDetail1.Visible = True
        pnlFilter.Visible = False
    End Sub

    Protected Sub GridView1_PreRender(sender As Object, e As System.EventArgs) Handles GridView1.PreRender
        If Not Session("filterDateInit") Is Nothing Then
            txtDate.Text = CDate(Session("filterDateInit")).ToString("dd/MM/yyyy")
            txtDate0.Text = CDate(Session("filterDateFinal")).ToString("dd/MM/yyyy")
        Else
            txtDate.Text = Now.AddDays(1 - Now.Day).ToString("dd/MM/yyyy")
            txtDate0.Text = Now.ToString("dd/MM/yyyy")
        End If
        filterDates()
    End Sub

    Protected Sub qaAuditDetail1_Closed() Handles qaAuditDetail1.Closed
        qaAuditDetail1.Visible = False
        GridView1.Visible = True
        GridView1.DataBind()
        pnlFilter.Visible = True
    End Sub

    Public Sub Edit(sender As Object, e As ImageClickEventArgs)

        GridView1.Visible = False

        qaAuditDetail1.NoFolio = DirectCast(sender, ImageButton).CommandArgument
        qaAuditDetail1.Visible = True
        pnlFilter.Visible = False
    End Sub

    Protected Sub imbFilter_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbFilter.Click
        filterDates()
    End Sub

    Protected Sub filterDates()
        Session("filterDateInit") = CDate(Mid(txtDate.Text, 4, 2) & "/" & Mid(txtDate.Text, 1, 2) & "/" & Mid(txtDate.Text, 7, 11))
        Session("filterDateFinal") = CDate(Mid(txtDate0.Text, 4, 2) & "/" & Mid(txtDate0.Text, 1, 2) & "/" & Mid(txtDate0.Text, 7, 11))
        GridView1.DataBind()
        cntrlReports1.ParamOptional1 = Session("filterDateInit")
        cntrlReports1.ParamOptional2 = Session("filterDateFinal")
    End Sub


End Class
