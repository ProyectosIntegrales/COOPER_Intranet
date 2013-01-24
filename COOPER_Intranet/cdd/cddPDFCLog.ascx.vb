Imports System.IO
Partial Class cdd_cddPDFCLog
    Inherits System.Web.UI.UserControl

    Protected Sub LinkButton2_Click(sender As Object, e As System.EventArgs) Handles LinkButton2.Click
        ListView1.DataBind()
        ListDocs()
    End Sub

    Protected Sub LinkButton1_Click(sender As Object, e As System.EventArgs) Handles LinkButton1.Click
        doSQLProcedure("delete from cdd.tblPDFConverterLog", Data.CommandType.Text)
        ListView1.DataBind()
    End Sub

    Protected Sub Timer1_Tick(sender As Object, e As System.EventArgs) Handles Timer1.Tick
        ListView1.DataBind()
        ListDocs()
    End Sub

    Protected Sub LinkButton3_Click(sender As Object, e As System.EventArgs) Handles LinkButton3.Click
        Dim di As New DirectoryInfo(MapPath("~/cdd/_temp/convert"))
        Dim filex As FileInfo()
        filex = di.GetFiles("*.*")
        For Each f As FileInfo In filex
            File.Delete(f.FullName)
        Next

    End Sub

    Protected Sub ListDocs()
        PlaceHolder1.Controls.Clear()
        Dim di As New DirectoryInfo(MapPath("~/cdd/_temp/convert"))
        Dim filex As FileInfo()
        filex = di.GetFiles("*.*")
        For Each f As FileInfo In filex
            Dim lb As New Label
            lb.Text = "<br>" & f.Name
            PlaceHolder1.Controls.Add(lb)

        Next
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        ListDocs()
    End Sub
End Class
