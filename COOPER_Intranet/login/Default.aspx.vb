
Partial Class login_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Session("myUsername") Is Nothing Then
            Dim username = Request.ServerVariables("AUTH_USER").ToLower


            username = "piratazz-pc\piratazz"
            'TODO Usuario Temporal
            'username = "NAM\DCAA6" 'Pepe
            'username = "NAM\MA9769" 'Claudia
            'username = "NAM\MB4352" 'Marisol
            'username = "NAM\MB0433" 'Jackeline
            'username = "NAM\MA6689" 'Rodolfo Aguilera
            'username = "NAM\MB2117" 'Ramses Tapia
            'username = "NAM\MB0616" 'Fernando Lopez
            'username = "NAM\A8070" 'Mario Armenta
            'username = "NAM\MB1911" 'Zuilma
            'username = "NAM\MB0982" 'Mayra
            'username = "NAM\MB0617" 'Carlos Plaza
            'username = "NAM\E9130" 'Fernando Acosta
            'username = "NAM\MA9710" 'Enrique Tapia
            'username = "NAM\AB98D" 'Jesus Trejo

            Dim User As New User(username)

            If User.Username <> "" Then
                Response.Cookies("myUsername").Value = User.Username
                Response.Cookies("myUsername").Expires = Now.AddDays(1)
                Session("myUsername") = User.Username
                Session("myFirstname") = User.FirstName
                Session("myLastname") = User.LastName
                Session("myEmployeeNo") = User.EmployeeNo
                Session("myDept") = User.Department
                Session("myArea") = User.Area
                Session("myBirthdate") = User.BirthDate
                Session("myGender") = User.Gender
                Session("isAdmin") = User.Admin


            End If
        Else
            Session("myUsername") = Nothing

        End If

        Try
            Response.Redirect(Request.UrlReferrer.ToString)
        Catch ex As Exception
            Response.Redirect(System.Web.HttpContext.Current.Request.ApplicationPath)
        End Try

    End Sub
End Class
