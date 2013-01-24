
Partial Class MasterPage
    Inherits System.Web.UI.MasterPage

    Protected Sub lnbLogin_Click(sender As Object, e As System.EventArgs) Handles lnbLogin.Click

        If Session("myUsername") Is Nothing Or Session("myUsername") = "" Then
            Response.Redirect("~/login/Default.aspx")
        Else
            Response.Cookies.Remove("myUsername")
            Session("myUsername") = Nothing
            clearUser()
        End If

    End Sub

    Private Sub setLabels()
        Session("sectionID") = getSectionID(Session("myID"))
        Session("mylanguage") = "esp"

        If Not Request.Cookies("myUsername") Is Nothing Then

            If Request.Cookies("myUsername").Value <> "" Then
                Session("myUsername") = Request.Cookies("myUsername").Value
            Else
                Request.Cookies.Remove("myUsername")
            End If

        End If

        If Not Session("myUsername") Is Nothing Then
            If Not Session("myUsername") = "" Then


                'Usuario Logeado
                'TODO Verificar si puede editar.
                Dim User As New User(Session("myUsername"))

                If User.Username <> "" Then
                    Response.Cookies("myUsername").Expires = Now.AddDays(1)
                    Session("myFirstname") = User.FirstName
                    Session("myLastname") = User.LastName
                    Session("myEmployeeNo") = User.EmployeeNo
                    Session("myDept") = User.Department
                    Session("myArea") = User.Area
                    Session("myBirthdate") = User.BirthDate
                    Session("myGender") = User.Gender
                    Session("isAdmin") = User.Admin
                End If

                lblFullname.Text = Session("myFirstname") & " " & Session("myLastname")
                lblWelcome.Text = IIf(Session("myLanguage") = "esp", "Bienvenid" & IIf(Session("myGender") = "M", "o", "a"), "Welcome")
                lnbLogin.Text = IIf(Session("myLanguage") = "esp", "Cerrar Sesión", "Logout")

                Response.Cookies("IntranetLanguage").Value = "esp"
                Response.Cookies("IntranetLanguage").Expires = Today.AddDays(30)

                lblEditing.Visible = imbEnableEdit.Visible And Session("editEnabled")

                imbEnableEdit.Visible = canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin")
            Else
                clearUser()
            End If


        Else
            clearUser()
        End If

        hlnHelp.Text = "<img border='0' src='images/Icons/16X16/help.png' style='padding-left:3px' align='middle' />"

        If Session("myID") Is Nothing Then
            Session("myID") = 0
        End If
        lblSectionTitle.Text = getSectionTitle(Session("myLanguage"), Session("myID"))

    End Sub

    Private Sub clearUser()
        'Usuario no logueado
        imbEnableEdit.Visible = False
        Session("editEnabled") = False
        lblEditing.Visible = False
        hlnHelp.Visible = False
        Session("isAdmin") = False
        lblFullname.Text = ""
        lblWelcome.Text = ""
        lnbLogin.Text = IIf(Session("myLanguage") = "esp", "Entrar", "Login")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
      
    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender

        If Session("myUsername") Is Nothing Then
            If lblFullname.Text.Trim <> "" Then
                lblFullname.Text = ""
                'MsgBox("Sesión ha finalizado debido a inactividad.", MsgBoxStyle.ApplicationModal & MsgBoxStyle.Exclamation & MsgBoxStyle.SystemModal, "Sesión caducada")
                Response.Redirect(".")
            End If
        End If

        Dim mySection As String = Request.QueryString("ID")
        If mySection <> "" Then
            Session("myID") = mySection
        End If
        setLabels()
        lblEditing.Visible = Session("editEnabled") And (canEdit(Session("myUsername"), Session("sectionID")) Or Session("isAdmin"))

        cntrlLeftSide1.Visible = menuVisible(Session("SectionID"))
        hlnHelp.Visible = helpFile(Session("SectionID")) <> "" And imbEnableEdit.Visible
        hlnHelp.NavigateUrl = helpFile(Session("SectionID"))
    End Sub

    Protected Sub imbEnableEdit_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbEnableEdit.Click
        Session("editEnabled") = Not Session("editEnabled")

    End Sub

    Public Event MenuItemSelected()

    Protected Sub cntrlTopMenu1_ItemSelected() Handles cntrlTopMenu1.ItemSelected
        RaiseEvent MenuItemSelected()
    End Sub

    Protected Sub btnShowEditor_Click(sender As Object, e As ImageClickEventArgs) Handles imbShowEditor.Click
        cntrlEditor1.Size = "Body"
        cntrlEditor1.ItemID = Session("itemID")
        cntrlEditor1.ImageURL = Session("imageURL")
        cntrlEditor1.Header = Session("HeaderText")
        cntrlEditor1.Content = Session("ContentText")
        cntrlEditor1.Show()
    End Sub

    Protected Sub cntrlEditor1_DeleteClicked() Handles cntrlEditor1.DeleteClicked
        If cntrlEditor1.ItemID > 0 Then
            doSQLProcedure("spDeleteContent", Data.CommandType.StoredProcedure, "@itemSection", Session("sectionID"), "@itemID", cntrlEditor1.ItemID, "@itemLang", Session("myLanguage"))
        End If
        ' repContent.DataBind()
    End Sub

    Protected Sub EditOk() Handles cntrlEditor1.OKClicked
        If cntrlEditor1.ItemID > 0 Then
            doSQLProcedure("spUpdateContent", Data.CommandType.StoredProcedure, "@itemSection", Session("sectionID"), "@itemID", cntrlEditor1.ItemID, "@itemHeader", cntrlEditor1.Header, "@itemText", cntrlEditor1.Content, "@imageURL", cntrlEditor1.ImageURL)
        Else
            doSQLProcedure("spInsertContent", Data.CommandType.StoredProcedure, "@itemSection", Session("sectionID"), "@itemLang", Session("myLanguage"), "@itemHeader", cntrlEditor1.Header, "@itemText", cntrlEditor1.Content, "@imageURL", cntrlEditor1.ImageURL)
        End If
        ' repContent.DataBind()
    End Sub

End Class

