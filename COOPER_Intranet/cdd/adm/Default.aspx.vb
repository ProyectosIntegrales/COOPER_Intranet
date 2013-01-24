Imports System.IO
Partial Class cdd_adm_Default
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load


    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim pdfName As String = DirectCast(e.Row.FindControl("Label1"), HyperLink).Text
            DirectCast(e.Row.FindControl("Label1"), HyperLink).NavigateUrl = MapPath(DirectCast(e.Row.FindControl("Label1"), HyperLink).Text)
            pdfName = Mid(pdfName, 1, pdfName.LastIndexOf(".") + 1) & "pdf"
            DirectCast(e.Row.FindControl("lblPDF"), HyperLink).Text = pdfName
            DirectCast(e.Row.FindControl("lblPDF"), HyperLink).NavigateUrl = MapPath(pdfName)
            Dim fe As Boolean = File.Exists(MapPath(pdfName))
            DirectCast(e.Row.FindControl("Image2"), Image).Visible = fe
            If fe Then
                doSQLProcedure("update cdd.tblDocuments set documentFinalFileName='" & pdfName & "', documentFinalFileType = 'pdf' where documentFinalFileName = '" & DirectCast(e.Row.FindControl("Label1"), HyperLink).Text & "'", Data.CommandType.Text)
            End If
        End If
    End Sub
End Class
