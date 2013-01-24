
Partial Class _Default
    Inherits System.Web.UI.Page

    Dim CONTROL_NAME As String
    Dim CONTROL_TYPE As String
    Dim CONTROL_MASTER As Boolean

    Protected Sub SelectAddIn()
        Me.Title = getSectionTitle("esp", isNull(Session("myID"), 1))
        Session("sectionID") = getSectionID(Session("myID"))

        Dim dr As Data.DataRow
        Try
            dr = SQLDataTable("select sectionControlName, sectionHasMaster from tblSections where sectionID = " & Session("sectionID")).Rows(0)
            CONTROL_TYPE = Mid(dr.Item("sectionControlName").ToString.Trim, dr.Item("sectionControlName").ToString.Trim.LastIndexOf(".") + 2, 3).ToLower
            CONTROL_NAME = dr.Item("sectionControlName").ToString.Trim
            CONTROL_MASTER = isNull(dr.Item("sectionHasMaster"), False)
        Catch ex As Exception
            CONTROL_NAME = "app_addIns/blog.aspx"
            iFrameSource(CONTROL_NAME)
        End Try

        Select Case CONTROL_TYPE

            Case "asc"
                Dim userControl As UserControl
                Try
                    userControl = Page.LoadControl(CONTROL_NAME)
                    userControl.ID = CONTROL_NAME.Replace("/", "_")
                    PlaceHolder1.Controls.Add(userControl)

                Catch ex As Exception
                    CONTROL_NAME = "app_addIns/blog.aspx"
                    iFrameSource(CONTROL_NAME)
                    ' userControl.ViewStateMode = UI.ViewStateMode.Disabled
                End Try

            Case "asp", "htm", "htm", "php"

                'If CONTROL_MASTER Then
                '    Response.Redirect(CONTROL_NAME)
                'Else
                iFrameSource(CONTROL_NAME)
                'End If


        End Select
    End Sub

    Protected Sub iFrameSource(Name As String)
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
        Try
            PlaceHolder1.Controls.Add(New LiteralControl("<iframe id='xframe' frameborder=0 width=100% src='" & CONTROL_NAME & "'></iframe>" & scriptCode))

        Catch ex As Exception

        End Try
 
    End Sub

    Protected Sub refreshAddin()
        Try
            PlaceHolder1.Controls.Clear()
            SelectAddIn()
        Catch ex As Exception

        End Try
    End Sub

    Protected WithEvents myMaster As MasterPage = DirectCast(Me.Master, MasterPage)

    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init

        AddHandler Me.Master.MenuItemSelected, AddressOf refreshAddin
        SelectAddIn()
    End Sub

    Protected Sub myMaster_MenuItemSelected() Handles myMaster.MenuItemSelected
        refreshAddin()
    End Sub


End Class
