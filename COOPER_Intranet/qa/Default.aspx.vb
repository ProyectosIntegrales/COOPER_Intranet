Imports System.Data

Partial Class qa_Default
    Inherits System.Web.UI.Page

    Protected Sub qa_Default_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender

 
        Dim scriptCode As String = "<script type='text/javascript'>" & _
                                         "function resizeIframe() { " & _
                                         "var height = document.documentElement.clientHeight;" & _
                                         "height -= document.getElementById('xframe').offsetTop;" & _
                                         "height -= 160; " & _
                                         "try {document.getElementById('xframe').style.height = height +'px';} catch(err) {};" & _
                                         "};" & _
                                         "document.getElementById('xframe').onload = resizeIframe;" & _
                                         "window.onresize = resizeIframe; " & _
                                         "</script>"
        PlaceHolder1.Controls.Add(New LiteralControl("<iframe id='xframe' frameborder=0 width=100% src='../app_addins/blog.aspx'></iframe>" & scriptCode))




    End Sub

End Class

