Imports Microsoft.VisualBasic
Imports System.Net.Mail
Imports System.Net

Public Module modEmail

    Public Sub sendEmail(EmailAddress As String, EmailSubject As String, EmailBody As String, FromAddress As String, FromName As String)
        '---------------------------------------------------------
        '--- Send Mail 
        '---------------------------------------------------------
        If System.Web.HttpContext.Current.Server.MachineName.Trim = "WDNO-HTSXPN1" Then

            Try

                If Not EmailAddress Is Nothing Then

                    Dim addresses As String() = EmailAddress.Split(",")

                    Dim mailMessage As New System.Net.Mail.MailMessage
                    For Each e As String In addresses
                        mailMessage.To.Add(New MailAddress(e))
                    Next

                    'mailMessage.CC.Add(t.Text.Trim)
                    mailMessage.From = New MailAddress(FromAddress, FromName)
                    mailMessage.Subject = EmailSubject
                    mailMessage.Body = EmailBody
                    mailMessage.IsBodyHtml = True
                    'mailMessage.Attachments.Add(New Attachment(fName))
                    Dim SMTPServer As New MailServer
                    Dim smtpClient As New SmtpClient(SMTPServer.SMPTAddress)

                    With smtpClient
                        .Port = SMTPServer.SMTPPort
                        If SMTPServer.SMTPAuthentication Then
                            .EnableSsl = SMTPServer.SMTPSSL
                            .Credentials = New NetworkCredential(SMTPServer.EmailAddress, SMTPServer.Password)
                        End If
                        .Timeout = 20000       ' I add this extra line
                    End With

                    AddHandler smtpClient.SendCompleted, AddressOf smtpClient_OnCompleted
                    smtpClient.Send(mailMessage)

                End If

            Catch ex As Exception

            End Try

        End If
        '--------------------------------------------------
    End Sub

    Public Sub smtpClient_OnCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        Dim mailMessage As MailMessage

        mailMessage = CType(e.UserState, MailMessage)

        'If (e.Cancelled) Then
        '    MsgBox("Sending of email message was cancelled. Address=" + mailMessage.To(0).Address)
        'End If

        If Not (e.Error Is Nothing) Then
            doSQLProcedure("spErrorLog", Data.CommandType.StoredProcedure, "@logText", e.Error.ToString)
            'Else
            '    MsgBox("El Correo se ha enviado Exitosamente!", MsgBoxStyle.Information)
            '    Try
            '        File.Delete(fName)
            '    Catch ex As Exception
            '    End Try
        End If
    End Sub

End Module
