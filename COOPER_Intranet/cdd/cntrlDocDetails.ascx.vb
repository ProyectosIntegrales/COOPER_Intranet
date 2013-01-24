Imports System.Data
Imports System.IO

Partial Class cntrlDocDetails
    Inherits System.Web.UI.UserControl

    Const TEMP_FOLDER As String = "~/cdd/_temp/upload/"
    Const CONV_FOLDER As String = "~/cdd/_temp/convert/"

    Dim MySelf As User

    Protected Sub setLabels()

        lblHeader.Text = "Cargar Nuevo Documento"
        lblDocName.Text = "Nombre de Documento:"

        lblRev.Text = "Revisión:"
        lblDesc.Text = "Descripción:"
        lblDocUpload.Text = "Seleccionar Archivo:"
        lblCopies.Text = "Copias impresas:"
        lblPlano.Text = "Num. de Plano:"
        lblResp.Text = "Reponsable del area:"
    End Sub

    Public Event Closed()

    Private Function getFolderName(Optional ByVal virtualPath As Boolean = False) As String
        Dim fn As String = "documents\"
        Dim docType As New DocumentType(hflType.Value)
        Dim docDepto As New Depto(cddSelectLoad1.DeptoID)

        fn &= docType.FolderName.Trim & "\CN-" & docDepto.Code.Trim & "\"

        Dim di As New DirectoryInfo(MapPath(fn))
        If Not di.Exists Then
            di.Create()
        End If

        If Not virtualPath Then
            Return MapPath(fn)
        Else
            Return fn
        End If

    End Function

    Public Sub AddNew(DeptoID As Integer, AreaID As Integer, _
                      CeldaID As Integer, TypeID As Integer)

        setLabels()
        hflDocId.Value = 0
        btnOK.Enabled = True

        disableTextBoxes(False)
        hflAction.Value = "ADD"

        'Inicializar objetos
        txtDescEsp.Text = ""
        txtRev.Text = ""
        hflType.Value = TypeID
        txtFilename.Text = ""
        txtCopies.Text = ""
        lblMessage.Text = ""
        hflAuth.Value = Session("myUsername")
        Timer1.Enabled = False

        Try
            ddlAuthor.DataBind()
            ddlAuthor.SelectedValue = Session("myUsername").ToString.ToUpper
        Catch ex As Exception

        End Try

        hflAuthLevel.Value = -99
        lblMessage.Text = "Seleccione el 'Tipo de Documento', Seleccione su documento a cargar y llene los datos restantes."
        imgDocUploadIcon.ImageUrl = "~/images/Icons/16X16/documents.png"
        imgDocIcon.ImageUrl = "~/images/Icons/16X16/documents.png"

        Dim dn As String = getDocNumber()
        If dn <> "" Then
            lblDocNameData.Text = dn
        Else
            lblDocNameData.Text = "Seleccione 'Tipo de Documento'."
        End If

        Session("TempDocName") = Nothing
        Session("uploadedDocName") = Nothing

        cddSelectLoad1.DeptoID = DeptoID
        cddSelectLoad1.AreaID = AreaID
        cddSelectLoad1.CeldaID = CeldaID
        lblError.Text = ""

        initTypeSelector()

        'Mostrar objetos
        pnlUpload.Visible = True
        lblDocUpload.Visible = True
        pnlDocTypes.Visible = True

        'Ocultar objetos
        imbConvertPDF.Visible = False
        btnReject.Visible = False
        txtMessage.Visible = False
        txtCopies.Visible = False
        lblCopies.Visible = False
        lblPlano.Visible = False
        txtPlano.Visible = False
        lblResp.Visible = False
        txtResp.Visible = False
        imbUpload.Visible = False
        imgOptions.Visible = True
        pnlButtons.Visible = True
        imbObsoleto.Visible = False
        imbEdit.Visible = True
        imbOriginal.Visible = False
        lblAuthor.Visible = False
        ddlAuthor.Visible = False

        'Habilitar objetos
        cddSelectLoad1.Enabled = True
        lnbDocType_HoverMenuExtender.Enabled = True

        'Inhabilitar objetos
        txtDescEsp.ReadOnly = False
        txtRev.ReadOnly = False

        lblDocNameData.Text = getDocNumber()
        txtDocName.Text = getDocNumber()
    End Sub

    Protected Sub initTypeSelector()
        Dim dt As Data.DataTable = SQLDataTable("select typeNameEsp from cdd.tblDocTypes where typeID = " & hflType.Value)
        If dt.Rows.Count > 0 Then
            lnbDocType.Text = dt.Rows(0).Item(0)
        Else
            lnbDocType.Text = "[Seleccionar]"
        End If
    End Sub

    Protected Function isRevChanging(DocControlNo As String) As Boolean
        Dim dt As DataTable = SQLDataTable("select * from cdd.vDocuments where documentControlNo = '" & DocControlNo & "' and documentAuthLevel >= 0 and documentAuthLevel <3 and documentRevChange = 1")

        Return dt.Rows.Count > 0

    End Function

    Public Sub Modify(docID As Integer, Level As Integer)

        setLabels()

        Timer1.Enabled = False
        btnOK.Enabled = True

        disableTextBoxes(False)

        hflAction.Value = "UPD"

        'Obtener datos del registro
        Dim dr As DataRow = SQLDataTable("select * from cdd.tblDocuments where documentID = " & docID).Rows(0)

        Dim obs1 As String = isNull(dr.Item("documentObsolete1"), "")
        Dim obs2 As String = isNull(dr.Item("documentObsolete2"), "")
        Dim obs3 As String = isNull(dr.Item("documentObsolete3"), "")

        'Inicializar objetos
        hflDocId.Value = docID
        Dim mee As New cddUserx(Session("myUsername"))
        lblDocNameData.Text = isNull(dr.Item("documentControlNo"), "")
        lblDocNameData.NavigateUrl = isNull(dr.Item("documentFilename"), "")
        txtDescEsp.Text = isNull(dr.Item("documentDescriptionEsp"), "")
        txtRev.Text = isNull(dr.Item("documentRev"), "")
        hflType.Value = dr.Item("documentType")

        initTypeSelector()

        imgDocUploadIcon.ImageUrl = "~/images/icons/files/" & Mid(dr.Item("documentFileType").ToString.Trim, 1, 3) & ".png"
        imgDocIcon.ImageUrl = imgDocUploadIcon.ImageUrl

        hflAuth.Value = dr.Item("documentAuthor")

        Try
            ddlAuthor.DataBind()
            ddlAuthor.SelectedValue = dr.Item("documentAuthor").ToString.ToUpper
        Catch ex As Exception

        End Try

        hflAuthLevel.Value = Level

        cddSelectLoad1.DeptoID = dr.Item("documentDeptoID")
        '        btnOK.OnClientClick = "javascript:window.location='?dept=" & Request.QueryString("dept") & "'"

        cddSelectLoad1.AreaID = isNull(dr.Item("documentAreaID"), 0)
        cddSelectLoad1.CeldaID = isNull(dr.Item("documentCeldaID"), 0)
        Session("uploadedDocName") = Nothing
        Session("TempDocName") = isNull(dr.Item("documentFileName"), Nothing)
        lblError.Text = isNull(dr.Item("documentMessage"), "")
        Dim fe As String = isNull(dr.Item("documentFileType"), "").trim.tolower

        txtCopies.Text = isNull(dr.Item("documentHardCopies"), "")
        txtResp.Text = isNull(dr.Item("documentResponsible"), "")
        txtPlano.Text = isNull(dr.Item("documentNumPlano"), "")

        Dim RevChg As Boolean = isRevChanging(lblDocNameData.Text)

        Dim fn As String = isNull(dr.Item("documentFileName"), "")
        Dim f1 As String = Mid(fn, fn.LastIndexOf("/") + 2)
        Dim f2 As String = Mid(f1, 1, f1.LastIndexOf("."))
        Dim f3 As String
        Try
            f3 = Mid(f1, 1, f1.Length - 18)
        Catch ex As Exception
            f3 = f1
        End Try

        txtFilename.Text = f3 & "." & isNull(dr.Item("documentFileType"), "")


        'Mostrar objetos
        btnOK.Visible = True
        pnlButtons.Visible = True
        imbObsoleto.Visible = True
        lblAuthor.Visible = True
        ddlAuthor.Visible = True

        'Ocultar objetos
        lblReject.Visible = False
        txtMessage.Visible = False
        pnlDocTypes.Visible = False
        imbConvertPDF.Visible = False
        lblCopies.Visible = False
        txtCopies.Visible = False
        lblPlano.Visible = False
        txtPlano.Visible = False
        lblResp.Visible = False
        txtResp.Visible = False
        imbOriginal.Visible = False
        imgOptions.Visible = False
        imgChgRev.Visible = False

        'Inhabilitar objetos
        lnbDocType_HoverMenuExtender.Enabled = False
        cddSelectLoad1.Enabled = False
        ddlAuthor.Enabled = False

        Select Case Level

            Case 0 'Modificar
                lblHeader.Text = "Modificar Documento"
                lblMessage.Text = "Modificar datos de documento o subir un nuevo documento para reemplazar el actual."
                pnlUpload.Visible = False
                lblDocUpload.Text = "Seleccionar Documento:"

                txtDescEsp.ReadOnly = False
                txtRev.ReadOnly = RevChg
                imgChgRev.Visible = RevChg

                btnReject.Visible = False

                txtMessage.Visible = False
                lblDocUpload.Visible = False
                txtMessage.Visible = False

                imbUpload.Visible = True
                imgOptions.Visible = True
                imbObsoleto.Visible = False
                imbEdit.Visible = True
                ddlAuthor.Enabled = True

            Case 1 'Revisión
                lblHeader.Text = "Revisar documento para enviarlo a aprobación."
                lblMessage.Text = ""
                pnlUpload.Visible = False
                lblDocUpload.Visible = False
                txtDescEsp.ReadOnly = False
                txtMessage.Visible = False
                btnReject.Visible = True
                imbConvertPDF.Visible = isOfficeFile(fe)
                lblCopies.Visible = True
                txtCopies.Visible = True
                lblPlano.Visible = True
                txtPlano.Visible = True
                lblResp.Visible = True
                txtResp.Visible = True
                imbUpload.Visible = True
                imgOptions.Visible = True
                imbOriginal.Visible = isNull(dr.Item("documentFileType"), "").tolower <> isNull(dr.Item("documentFinalFileType"), "").tolower And isNull(dr.Item("documentFinalFileName"), "") <> "" And imbConvertPDF.Visible
                imbObsoleto.Visible = False
                ddlAuthor.Enabled = True

            Case 2 'Aprobacion
                lblHeader.Text = "Aprobar documento para su publicación"
                lblMessage.Text = "Para aprobar el documento utilice el botón 'Aceptar', del caso contrario utilice 'Rechazar' para devolver el documento al originador o 'Cerrar' para no hacer nada."
                pnlUpload.Visible = False
                lblDocUpload.Visible = False
                txtDescEsp.ReadOnly = True
                txtRev.ReadOnly = True
                txtMessage.Visible = False
                btnReject.Visible = True
                imbUpload.Visible = False
                imbConvertPDF.Visible = False
                lblDocNameData.NavigateUrl = isNull(dr.Item("documentFinalFilename"), "")
                imgDocIcon.ImageUrl = "~/images/icons/files/" & Mid(dr.Item("documentFinalFileType").ToString.Trim, 1, 3) & ".png"
                imgOptions.Visible = False
                pnlButtons.Visible = False

            Case 3 'Modificacion por Control de Docs
                lblHeader.Text = "Realizar Cambios y Publicar"
                lblMessage.Text = "Para publicar el documento final unicamente haga en 'Aceptar', o utilice 'Cerrar' para no realizar ninguan acción."
                lblDocUpload.Visible = False
                imbConvertPDF.Visible = isOfficeFile(isNull(dr.Item("documentFinalFileType"), ""))
                imbUpload.Visible = True

                pnlUpload.Visible = False
                txtDescEsp.ReadOnly = False
                cddSelectLoad1.Enabled = mee.PrivLevel = 9

                imgChgRev.Visible = RevChg
                txtRev.ReadOnly = RevChg

                txtFilename.Text = ""
                btnReject.Visible = False
                txtMessage.Visible = False
                lblDocNameData.NavigateUrl = isNull(dr.Item("documentFinalFilename"), "")
                imgDocIcon.ImageUrl = "~/images/icons/files/" & Mid(dr.Item("documentFinalFileType").ToString.Trim, 1, 3) & ".png"

                imgDocUploadIcon.ImageUrl = "~/images/icons/files/" & Mid(dr.Item("documentFinalFileType").ToString.Trim, 1, 3) & ".png"
                lblDocName.Text = "Documento Original:"

                Session("DocName") = isNull(dr.Item("documentFinalFilename"), "")
                Session("DocExt") = isNull(dr.Item("documentFinalFileType"), "")

                If mee.PrivLevel = 9 Then
                    lblCopies.Visible = True
                    txtCopies.Visible = True
                    lblPlano.Visible = True
                    txtPlano.Visible = True
                    lblResp.Visible = True
                    txtResp.Visible = True
                End If

                imbObsoleto.Visible = True

                ddlAuthor.Enabled = True

                imgOptions.Visible = True
                imbOriginal.Visible = isNull(dr.Item("documentFileType"), "").tolower <> isNull(dr.Item("documentFinalFileType"), "").tolower And Not imbConvertPDF.Visible



            Case 5 'Autorizar obsolescencia
                lblHeader.Text = "Autorizar obsolescencia del documento"
                lblMessage.Text = "Para autorizar la obsolescencia del documento utilice el botón 'Aceptar', del caso contrario utilice 'Rechazar' para devolver el cancelar el proceso de obsolescencia o 'Cerrar' para no hacer nada."
                pnlUpload.Visible = False
                lblDocUpload.Visible = False
                txtDescEsp.ReadOnly = True
                txtRev.ReadOnly = True
                txtMessage.Visible = False
                btnReject.Visible = True
                imbUpload.Visible = False
                imbConvertPDF.Visible = False
                lblDocNameData.NavigateUrl = isNull(dr.Item("documentFinalFilename"), "")
                imgDocIcon.ImageUrl = "~/images/icons/files/" & Mid(dr.Item("documentFinalFileType").ToString.Trim, 1, 3) & ".png"
                imgOptions.Visible = False
                pnlButtons.Visible = False
                btnReject.Visible = False

            Case 6 'Realizar Obsolescencia
                lblHeader.Text = "Realizar obsolescencia del documento"
                lblMessage.Text = "Para realizar la obsolescencia del documento utilice el botón 'Aceptar', del caso contrario utilice 'Rechazar' para devolver el cancelar el proceso de obsolescencia o 'Cerrar' para no hacer nada."
                pnlUpload.Visible = False
                lblDocUpload.Visible = False
                txtDescEsp.ReadOnly = True
                txtRev.ReadOnly = True
                txtMessage.Visible = False
                btnReject.Visible = True
                imbUpload.Visible = False
                imbConvertPDF.Visible = False
                lblDocNameData.NavigateUrl = isNull(dr.Item("documentFinalFilename"), "")
                imgDocIcon.ImageUrl = "~/images/icons/files/" & Mid(dr.Item("documentFinalFileType").ToString.Trim, 1, 3) & ".png"
                imgOptions.Visible = False
                pnlButtons.Visible = False
                btnReject.Visible = False

            Case 7 'Aprobacion de Entranamiento
                lblHeader.Text = "Aprobación del documento por Entrenamiento"
                lblMessage.Text = "Para aprobar documento utilice el botón 'Aceptar' o 'Cerrar' para no hacer nada."
                pnlUpload.Visible = False
                lblDocUpload.Visible = False
                txtDescEsp.ReadOnly = True
                txtRev.ReadOnly = True
                txtMessage.Visible = False
                btnReject.Visible = False
                imbUpload.Visible = False
                imbConvertPDF.Visible = False
                lblDocNameData.NavigateUrl = isNull(dr.Item("documentFinalFilename"), "")
                imgDocIcon.ImageUrl = "~/images/icons/files/" & Mid(dr.Item("documentFinalFileType").ToString.Trim, 1, 3) & ".png"
                imgOptions.Visible = False
                pnlButtons.Visible = False

        End Select

    End Sub

    Protected Function getDocNumber() As String
        Dim myDocType As New DocumentType(hflType.Value)
    
        Dim offset As Integer = 1
        Dim NewDocNo As String = ""

        If myDocType.NameFormat <> "" Then
            Dim initCounter As Integer = 0 'doSQLProcedure("cdd.spGenerateNumber", CommandType.StoredProcedure, "@typeID", hflType.Value, "@Mnemonic", cddSelectLoad1.Mnemonic)
            Do While True
                Dim dt As DataTable
                Dim Counter As Integer = initCounter + offset
                Dim nums As Integer = getZeros(myDocType.NameFormat)
                Dim xs As Integer = getXs(myDocType.NameFormat)
                NewDocNo = myDocType.NameFormat.Replace("%DEPT%", cddSelectLoad1.Mnemonic.Trim).Replace(Mid("0000000000", 1, nums), Counter.ToString.PadLeft(nums, "0"))
                Dim SearchDocNo As String
                If xs > 0 Then
                    SearchDocNo = NewDocNo.Replace(Mid("XXXXXXXXXX", 1, xs), "%").Trim.ToUpper()
                    dt = SQLDataTable("Select documentControlNo from cdd.tblDocuments where documentControlNo Like '" & SearchDocNo & "'")
                Else
                    SearchDocNo = NewDocNo
                    dt = SQLDataTable("Select documentControlNo from cdd.tblDocuments where documentControlNo = '" & SearchDocNo & "'")
                End If

                If dt.Rows.Count = 0 Then
                    Session("Counter") = Counter
                    Exit Do
                Else
                    offset += 1
                End If
            Loop

            Return NewDocNo
        Else
            Return ""
        End If

    End Function

    Protected Function getZeros(nameFormat As String) As Integer
        Dim z As String = "0000000000"
        For i = 10 To 1 Step -1
            Dim s As String = Mid(z, 1, i)
            If nameFormat.IndexOf(s) > 0 Then
                Return i
            End If
        Next

        Return 0

    End Function

    Protected Function getXs(nameFormat As String) As Integer
        Dim z As String = "XXXXXXXXXX"
        For i = 10 To 1 Step -1
            Dim s As String = Mid(z, 1, i)
            If nameFormat.IndexOf(s) > 0 Then
                Return i
            End If
        Next

        Return 0

    End Function

    Protected Sub btnOK_Click(sender As Object, e As System.EventArgs) Handles btnOK.Click
        Dim fn As String = getFolderName()
        MySelf = New User(Session("myUsername"))

        Dim authLevel As Integer = IIf(hflAuthLevel.Value < 0, 0, hflAuthLevel.Value)

        Select Case hflAction.Value

            Case "CHR"
                If Not Session("uploadedDocName") Is Nothing Then
                    Dim fileName As String = Session("TempDocName")
                    Dim docNumber As String

                    docNumber = lblDocNameData.Text

                    Dim fileType As String = Mid(fileName, fileName.LastIndexOf(".") + 2)

                    lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                                   "@action", hflAction.Value, _
                                   "@documentId", hflDocId.Value, _
                                   "@documentControlNo", docNumber, _
                                   "@documentFileName", fileName, _
                                   "@documentFiletype", fileType, _
                                   "@documentType", hflType.Value, _
                                   "@documentDeptoID", cddSelectLoad1.DeptoID, _
                                   "@documentAreaID", cddSelectLoad1.AreaID, _
                                   "@documentCeldaID", cddSelectLoad1.CeldaID, _
                                   "@documentDescriptionEsp", txtDescEsp.Text, _
                                   "@documentRev", txtRev.Text, _
                                   "@documentAuthor", hflAuth.Value, _
                                   "@documentAuthLevel", authLevel, _
                                   "@documentHardCopies", txtCopies.Text, _
                                   "@documentResponsible", txtResp.Text, _
                                   "@documentNumPlano", txtPlano.Text)

                    If lblError.Text <> "" Then Exit Sub
                    sendMailTo(14)

                Else
                    lblError.Text = "Aún no se ha cargado ningún documento."
                    Exit Sub
                End If

            Case "ADD"
                If Not Session("uploadedDocName") Is Nothing Then
                    Dim fileName As String = Session("TempDocName")
                    Dim docNumber As String

                    docNumber = lblDocNameData.Text

                    Dim fileType As String = Mid(fileName, fileName.LastIndexOf(".") + 2)

                    lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                                   "@action", hflAction.Value, _
                                   "@documentId", hflDocId.Value, _
                                   "@documentControlNo", docNumber, _
                                   "@documentFileName", fileName, _
                                   "@documentFiletype", fileType, _
                                   "@documentType", hflType.Value, _
                                   "@documentDeptoID", cddSelectLoad1.DeptoID, _
                                   "@documentAreaID", cddSelectLoad1.AreaID, _
                                   "@documentCeldaID", cddSelectLoad1.CeldaID, _
                                   "@documentDescriptionEsp", txtDescEsp.Text, _
                                   "@documentRev", txtRev.Text, _
                                   "@documentAuthor", hflAuth.Value, _
                                   "@documentAuthLevel", authLevel)

                    If lblError.Text <> "" Then Exit Sub
                    sendMailTo(1)

                    doSQLProcedure("Update cdd.tblCounters set [counter] = " & Session("counter") & " Where typeID = " & hflType.Value & " and [mnemonic] = '" & cddSelectLoad1.Mnemonic.Trim & "'", CommandType.Text)

                Else
                    lblError.Text = "Aún no se ha cargado ningún documento."
                    Exit Sub
                End If

            Case "UPD"
                Dim mee As New cddUserx(Session("myUsername"))

                Dim modf As Boolean = False
                If hflAuthLevel.Value = 3 And mee.PrivLevel <> 9 Then
                    hflAuthLevel.Value = 0
                    modf = True
                End If

                Select Case hflAuthLevel.Value

                    Case 0 'Change

                        authLevel = IIf(authLevel = 3 And mee.PrivLevel <> 9, 0, authLevel)

                        If Not Session("TempDocName") Is Nothing Then
                            Dim fileName As String = Session("TempDocName")
                            Dim docNumber As String = lblDocNameData.Text

                            Dim fileType As String = Mid(fileName, fileName.LastIndexOf(".") + 2)

                            lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                                           "@action", hflAction.Value, _
                                           "@documentId", hflDocId.Value, _
                                           "@documentControlNo", docNumber, _
                                           "@documentFileName", fileName, _
                                           "@documentFiletype", fileType, _
                                           "@documentType", hflType.Value, _
                                           "@documentDeptoID", cddSelectLoad1.DeptoID, _
                                           "@documentAreaID", cddSelectLoad1.AreaID, _
                                           "@documentCeldaID", cddSelectLoad1.CeldaID, _
                                           "@documentDescriptionEsp", txtDescEsp.Text, _
                                           "@documentRev", txtRev.Text, _
                                           "@documentAuthor", ddlAuthor.SelectedValue, _
                                           "@documentAuthLevel", authLevel)

                            If lblError.Text <> "" Then Exit Sub

                            If modf Then
                                sendMailTo(13)
                            Else
                                sendMailTo(3)
                            End If

                            If ddlAuthor.SelectedValue.Trim <> hflAuth.Value.ToUpper.Trim Then
                                sendMailTo(11)
                            End If
                        Else
                            lblError.Text = "Aún no se ha cargado ningún documento."
                            Exit Sub
                        End If

                            'Enviar Correo a Control de Documentos y al manager del Departamento

                    Case 1 'Revisión

                            Dim myType As New DocumentType(hflType.Value)
                            Dim myDept As New Depto(cddSelectLoad1.DeptoID)
                            Dim folderName As String = "~/cdd/documents/CN-" & myDept.Code & "/" & myType.FolderName & "/"
                            If Not Directory.Exists(MapPath(folderName)) Then
                                Directory.CreateDirectory(MapPath(folderName))
                            End If
                            Dim fileExtension As String = Mid(Session("TempDocName").ToString.Trim, Session("TempDocName").ToString.Trim.LastIndexOf(".") + 1).ToLower
                            Dim fileName As String = folderName & lblDocNameData.Text & fileExtension

                        Try
                            Dim tf As String = MapPath(Session("TempDocName"))
                            If tf <> MapPath(fileName) Then
                                If File.Exists(tf) Then
                                    If File.Exists(MapPath(fileName)) Then
                                        File.Delete(MapPath(fileName))
                                    End If

                                    File.Copy(tf, MapPath(fileName))
                                    File.Delete(tf)
                                Else
                                    lblError.Text = "No se encuentra el documento para cargar."
                                    Exit Sub
                                End If
                            End If
                        Catch ex As Exception
                            lblError.Text = ex.Message
                        End Try

                        Dim OriginalFileName As String
                        Dim OriginalFileType As String

                        If Not Session("OriginalFileName") Is Nothing Then
                            OriginalFileName = Session("OriginalFileName")
                            OriginalFileType = Mid(OriginalFileName, OriginalFileName.LastIndexOf(".") + 2)
                        Else
                            OriginalFileName = fileName
                            OriginalFileType = fileExtension.Replace(".", "")
                        End If

                        lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                                       "@action", hflAction.Value, _
                                       "@documentId", hflDocId.Value,
                                       "@documentFileName", OriginalFileName, _
                                       "@documentControlNo", lblDocNameData.Text, _
                                       "@documentFileType", OriginalFileType, _
                                       "@documentFinalFileName", fileName, _
                                       "@documentFinalFileType", fileExtension.Replace(".", ""), _
                                       "@documentDescriptionEsp", txtDescEsp.Text, _
                                       "@documentRev", txtRev.Text.ToUpper, _
                                       "@documentInitializer", Session("myUsername"), _
                                       "@documentAuthLevel", hflAuthLevel.Value, _
                                       "@documentHardCopies", txtCopies.Text, _
                                       "@documentResponsible", txtResp.Text, _
                                       "@documentNumPlano", txtPlano.Text, _
                                       "@documentAuthor", ddlAuthor.SelectedValue)
                            '-------------

                            If lblError.Text <> "" Then Exit Sub
                            sendMailTo(2)

                    Case 2 'Aprobar y publicar

                        lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                                       "@action", hflAction.Value, _
                                       "@documentId", hflDocId.Value,
                                       "@documentAuthorizer", Session("myUsername"), _
                                       "@AuthType", mee.AuthType, _
                                       "@documentAuthLevel", 2)

                        If lblError.Text <> "" Then Exit Sub

                        Dim drd As DataRow = SQLDataTable("select * from cdd.vDocuments where documentID = " & hflDocId.Value).Rows(0)

                        If drd.Item("documentAuthLevel") <> 3 Then
                            sendMailTo(4)
                        ElseIf drd.Item("documentAuthLevel") = 3 Then

                            If isNull(drd.Item("documentRevchange"), False) Then
                                doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                                     "@action", "CHRO", _
                                     "@documentId", hflDocId.Value)
                            End If
                            sendMailTo(5)

                        End If


                    Case 3 'Modificacion

                        Dim myType As New DocumentType(hflType.Value)
                        Dim myDept As New Depto(cddSelectLoad1.DeptoID)
                        Dim folderName As String = "~/cdd/documents/CN-" & myDept.Code & "/" & myType.FolderName & "/"

                        If Not Directory.Exists(MapPath(folderName)) Then
                            Directory.CreateDirectory(MapPath(folderName))
                        End If

                        Dim fileExtension As String
                        Dim fileName As String

                        If Not Session("uploadedDocName") Is Nothing Then
                            fileExtension = Mid(Session("TempDocName").ToString.Trim, Session("TempDocName").ToString.Trim.LastIndexOf(".") + 1).ToLower
                            fileName = folderName & lblDocNameData.Text & fileExtension

                            If MapPath(Session("TempDocName")) <> MapPath(fileName) Then
                                Dim tf As String = MapPath(Session("TempDocName"))
                                If File.Exists(tf) Then
                                    If File.Exists(MapPath(fileName)) Then
                                        File.Delete(MapPath(fileName))
                                    End If

                                    File.Copy(tf, MapPath(fileName))
                                    File.Delete(tf)

                                Else
                                    lblError.Text = "No se encuentra el documento para cargar."
                                    Exit Sub
                                End If
                            End If

                        Else
                            fileName = Session("DocName")
                            fileExtension = Session("DocExt")
                        End If



                        lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                                       "@action", hflAction.Value, _
                                       "@documentId", hflDocId.Value,
                                       "@documentFinalFileName", fileName, _
                                       "@documentFinalFileType", fileExtension.Replace(".", ""), _
                                       "@documentDescriptionEsp", txtDescEsp.Text, _
                                       "@documentRev", txtRev.Text.ToUpper, _
                                       "@documentInitializer", Session("myUsername"), _
                                       "@documentAuthLevel", hflAuthLevel.Value, _
                                       "@documentHardCopies", txtCopies.Text, _
                                       "@documentResponsible", txtResp.Text, _
                                       "@documentNumPlano", txtPlano.Text, _
                                       "@documentAuthor", ddlAuthor.SelectedValue)

                        If lblError.Text <> "" Then Exit Sub



                        sendMailTo(3)




                    Case 4 'Iniciar Obsolescencia


                        lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                         "@action", "OBS", _
                         "@documentId", hflDocId.Value,
                         "@documentRejecter", Session("myUsername"), _
                         "@documentAuthLevel", 1)

                        If lblError.Text <> "" Then Exit Sub
                        sendMailTo(6)

                    Case 5 'Autorizar obsolescencia

                        lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                         "@action", "OBS", _
                         "@documentId", hflDocId.Value,
                         "@documentRejecter", Session("myUsername"), _
                         "@documentMessage", "Obsolecencia aprobada por " & Mid(MySelf.FirstName, 1, 1) & ". " & MySelf.LastName, _
                         "@documentAuthLevel", 2)

                        If lblError.Text <> "" Then Exit Sub
                        sendMailTo(7)

                    Case 6 'Realizar Obsolescencia

                        lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                         "@action", "OBS", _
                         "@documentId", hflDocId.Value,
                         "@documentRejecter", Session("myUsername"), _
                         "@documentMessage", "Obsolescencia realizada por " & Mid(MySelf.FirstName, 1, 1) & ". " & MySelf.LastName, _
                         "@documentAuthLevel", 3)

                        If lblError.Text <> "" Then Exit Sub
                        sendMailTo(8)

                    Case 7 'Aprobar por entrenamiento
                        lblError.Text = doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                            "@action", hflAction.Value, _
                            "@documentId", hflDocId.Value,
                            "@documentAuthorizer", Session("myUsername"), _
                            "@documentAuthLevel", 7)

                        If lblError.Text <> "" Then Exit Sub
                        sendMailTo(12)

                End Select

        End Select
        Session("TempDocName") = Nothing

        RaiseEvent Closed()

    End Sub

    Private Function docType() As String
        Dim dt As DataTable = SQLDataTable("Select typeNameEsp from cdd.tblDocTypes Where typeId = " & hflType.Value)
        Return dt.Rows(0).Item(0)
    End Function

    Private Function deptName() As String
        Dim dt As DataTable = SQLDataTable("Select deptoName from tblDeptos Where deptoID = " & cddSelectLoad1.DeptoID)
        Return dt.Rows(0).Item(0)
    End Function

    Private Sub sendMailTo(MailType As Integer)

        'Datos del Correo
        Dim dr As DataRow = SQLDataTable("select * from cdd.tblEmailNotifications where EmailId = " & MailType).Rows(0)
        Dim Disabled As Boolean = isNull(dr.Item("emailDisabled"), False)

        If Disabled Then Exit Sub

        Dim Subject As String = dr.Item("EmailSubject")
        Dim Message As String = dr.Item("EmailMessage")
        Dim toAll As Boolean = isNull(dr.Item("emailToAll"), False)
        Dim toDepto As Boolean = isNull(dr.Item("emailToDepto"), False)
        Dim toMgr As Boolean = isNull(dr.Item("emailToMgr"), False)
        Dim toOwner As Boolean = isNull(dr.Item("emailToOwner"), False)
        Dim toDocs As Boolean = isNull(dr.Item("emailToDocs"), False)
        Dim toEngs As Boolean = isNull(dr.Item("emailToEngs"), False)
        Dim toNewOwner As Boolean = isNull(dr.Item("emailToNewOwner"), False)
        Dim toTraining As Boolean = isNull(dr.Item("emailToTrain"), False)

        Dim Lvl As Integer = hflAuthLevel.Value

        Dim deptoName As String = cddSelectLoad1.DeptoName
        Dim areaName As String = cddSelectLoad1.AreaName
        Dim celdaname As String = cddSelectLoad1.CeldaName

        Dim Recipients As String = ""
        Dim toEmailAddresses As String = ""

        'Datos del Documento
        Dim drd As DataRow = SQLDataTable("select * from cdd.vDocuments where documentID = " & getDocID).Rows(0)
        Dim Approval As String = IIf(isNull(drd.Item("mgrApproval"), False), _
                                     isNull(drd.Item("documentMgrApprName"), "Gerente"), _
                                     IIf(isNull(drd.Item("mfgEngApproval"), False), _
                                         isNull(drd.Item("areaMfgEngName"), "Ing. de Manufactura") & _
                                        " y " & isNull(drd.Item("areaCalEngName"), "Calidad"), _
                                        "[No hay aprobador definido para este documento]"))

        Dim Author As New User(hflAuth.Value)
        Dim AuthorName As String = Author.FirstName & " " & Author.LastName
        MySelf = New User(Session("myUsername"))

        'Replace de acuerdo a los tags de arriba
        Message = Message _
            .Replace("{type}", drd.Item("typenameESP")) _
            .Replace("{dept}", cddSelectLoad1.DeptoName) _
            .Replace("{area}", isNull(drd.Item("areaName"), "")) _
            .Replace("{approval}", Approval) _
            .Replace("{rejecter}", isNull(drd.Item("documentRejecterName"), "")) _
            .Replace("{rejectNote}", isNull(drd.Item("documentMessage"), "")) _
            .Replace("{author}", AuthorName) _
            .Replace("{user}", MySelf.FirstName & " " & MySelf.LastName) _
            .Replace("{missingappr}", Approval.Replace(MySelf.FirstName & " " & MySelf.LastName, "").Replace(" y ", "").Trim)

        Dim Description As String = txtDescEsp.Text

     

        Dim dtEmailUsers As DataTable = SQLDataTable("select * from cdd.vEmailUsers")

        If toAll Then
            Dim dv As DataView = dtEmailUsers.DefaultView
            dv.RowFilter = ""
            For Each rv As DataRowView In dv
                toEmailAddresses &= rv.Item("userEmailAddress") & ", "
            Next
            toEmailAddresses = Mid(toEmailAddresses.Trim, 1, toEmailAddresses.Trim.Length - 1)
            Recipients = "Todos los empleados"
            FormatAndSend(toEmailAddresses, Subject, Message, Recipients, Description, cddSelectLoad1.DeptoName, AuthorName, MySelf.FirstName & " " & MySelf.LastName)

        Else
            If toDepto Then
                Dim dv As DataView = dtEmailUsers.DefaultView
                dv.RowFilter = "deptoMnemonic = '" & cddSelectLoad1.deptoMnemonic & "'"
                For Each rv As DataRowView In dv
                    toEmailAddresses &= rv.Item("userEmailAddress") & ", "
                Next
                toEmailAddresses = Mid(toEmailAddresses.Trim, 1, toEmailAddresses.Trim.Length - 1)
                Recipients = "Todos los empleados de " & cddSelectLoad1.DeptoName
                FormatAndSend(toEmailAddresses, Subject, Message, Recipients, Description, cddSelectLoad1.DeptoName, AuthorName, MySelf.FirstName & " " & MySelf.LastName)
            End If

            If toMgr Then
                toEmailAddresses = MySelf.ManagerEmailAddress
                Recipients = MySelf.ManagerName
                FormatAndSend(toEmailAddresses, Subject, Message, Recipients, Description, cddSelectLoad1.DeptoName, AuthorName, MySelf.FirstName & " " & MySelf.LastName)
            End If

            If toEngs Then
                toEmailAddresses = ""
                Dim dv As DataView = SQLDataTable("select * from cdd.vEmailUsers where mfgEngOf like '%" & cddSelectLoad1.areaMnemonic.Trim & "%' or calEngOf like '%" & cddSelectLoad1.areaMnemonic.Trim & "%'").DefaultView
                For Each rv As DataRowView In dv
                    toEmailAddresses &= rv.Item("userEmailAddress") & ", "
                Next

                If toEmailAddresses.Trim <> "" Then
                    toEmailAddresses = Mid(toEmailAddresses.Trim, 1, toEmailAddresses.Trim.Length - 1)
                    Recipients = "Ingenieros de Manufactura y Calidad del area de " & cddSelectLoad1.AreaName
                    FormatAndSend(toEmailAddresses, Subject, Message, Recipients, Description, cddSelectLoad1.DeptoName, AuthorName, MySelf.FirstName & " " & MySelf.LastName)
                End If

            End If

            If toDocs Then
                toEmailAddresses = ""
                Dim dv As DataView = dtEmailUsers.DefaultView
                dv.RowFilter = "privlevel = 9"
                For Each rv As DataRowView In dv
                    toEmailAddresses &= rv.Item("userEmailAddress") & ", "
                Next
                toEmailAddresses = Mid(toEmailAddresses.Trim, 1, toEmailAddresses.Trim.Length - 1)
                Recipients = "Control de Documentos"
                FormatAndSend(toEmailAddresses, Subject, Message, Recipients, Description, cddSelectLoad1.DeptoName, AuthorName, MySelf.FirstName & " " & MySelf.LastName)
            End If

            If toOwner Then
                Recipients = AuthorName
                FormatAndSend(Author.EMailAddress, Subject, Message, Recipients, Description, cddSelectLoad1.DeptoName, AuthorName, MySelf.FirstName & " " & MySelf.LastName)
            End If

            If toNewOwner Then
                Dim newOwner As New User(ddlAuthor.SelectedValue)
                Message.Replace("{newowner}", newOwner.FirstName & " " & newOwner.LastName)
                FormatAndSend(toEmailAddresses, Subject, Message, Recipients, Description, cddSelectLoad1.DeptoName, AuthorName, MySelf.FirstName & " " & MySelf.LastName)
            End If

            If toTraining Then
                toEmailAddresses = ""
                Dim dv As DataView = dtEmailUsers.DefaultView
                dv.RowFilter = "privlevel = 7"
                For Each rv As DataRowView In dv
                    toEmailAddresses &= rv.Item("userEmailAddress") & ", "
                Next
                toEmailAddresses = Mid(toEmailAddresses.Trim, 1, toEmailAddresses.Trim.Length - 1)
                Recipients = "Departamento de Entrenamiento"
                FormatAndSend(toEmailAddresses, Subject, Message, Recipients, Description, cddSelectLoad1.DeptoName, AuthorName, MySelf.FirstName & " " & MySelf.LastName)

            End If
            End If

    End Sub

    Private Function getDocID() As Integer
        If Not hflDocId.Value = 0 Then
            Return hflDocId.Value
        Else
            Return SQLDataTable("select top 1 documentID from cdd.tblDocuments where documentAuthor = '" & MySelf.Username & "'").Rows(0).Item(0)
        End If

    End Function

    Protected Sub FormatAndSend(toEmailAddresses As String, Subject As String, Message As String, Recipients As String, Description As String, DeptoDesc As String, Author As String, Sender As String)
        Dim template As String = ReadText(MapPath("emailTemplate.htm"))
        Dim Body As String = template.Replace("{Message}", Message).Replace("{Recipients}", Recipients).Replace("{Description}", Description).Replace("{DeptoAreaCell}", DeptoDesc).Replace("{Author}", Author).Replace("{Sender}", Sender).Replace("{DocControlNo}", lblDocNameData.Text)
        Dim myFullName As String = MySelf.FirstName & " " & MySelf.LastName
        sendEmail(toEmailAddresses, Subject & " (" & lblDocNameData.Text.Trim & "  Rev: " & txtRev.Text.Trim & ")", Body, MySelf.EMailAddress, myFullName)
    End Sub

    Private Function isOfficeFile(ByVal fileExtension As String) As Boolean
        Dim extensions() = {"doc", "docx", "xls", "xlsx", "ppt", "pptx", "pub", "pubx"}
        For Each e As String In extensions
            If e = fileExtension.Trim.ToLower Then
                Return True
            End If
        Next
        Return False
    End Function

    Protected Sub AsyncFileUpload1_UploadedComplete(sender As Object, e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete

        Dim fe As String = Mid(AsyncFileUpload1.FileName, AsyncFileUpload1.FileName.LastIndexOf(".") + 2)

        Dim docName As String = AsyncFileUpload1.FileName
        Session("uploadedDocName") = docName
        Session("TempDocName") = TEMP_FOLDER & Mid(docName, 1, docName.LastIndexOf(".")) & DateTime.Now.ToString("_yyMMdd,hhmmss") & "." & fe
        Dim myCookie As HttpCookie = New HttpCookie("FileName", Session("TempDocName"))

        myCookie.Expires = Now.AddDays(1)
        Response.Cookies.Add(myCookie)

        Dim c2 As HttpCookie = New HttpCookie("DocName", Mid(docName, 1, docName.LastIndexOf(".")))
        c2.Expires = Now.AddDays(1)
        Response.Cookies.Add(c2)

        If AsyncFileUpload1.HasFile Then
            AsyncFileUpload1.SaveAs(MapPath(Session("TempDocName")))
        End If

    End Sub

    Protected Sub btnReject_Click(sender As Object, e As System.EventArgs) Handles btnReject.Click
        Dim mee As New cddUserx(Session("myUsername"))
        If txtMessage.Visible And txtMessage.Text <> "" Then

            Dim rjcode As String
            If mee.PrivLevel = 9 Then
                rjcode = "REJD"
                hflAuthLevel.Value = -2
            Else
                rjcode = "REJG"
                hflAuthLevel.Value = -1
            End If

            doSQLProcedure("cdd.spDocuments", CommandType.StoredProcedure, _
                           "@action", rjcode, _
                           "@documentId", hflDocId.Value,
                           "@documentRejecter", Session("myUsername"),
                           "@documentMessage", txtMessage.Text)

            If rjcode = "REJD" Then
                sendMailTo(10)
            Else
                sendMailTo(9)
            End If

            Session("TempDocName") = Nothing
            RaiseEvent Closed()
        Else
            btnOK.Visible = False
            lblError.Text = "Escriba una nota sobre la razón del rechazo."
            lblReject.Text = "Razón de rechazo:"
            lblReject.Visible = True
            txtMessage.Visible = True
            lblCopies.Visible = False
            txtCopies.Visible = False
            lblResp.Visible = False
            txtResp.Visible = False
            lblPlano.Visible = False
            txtPlano.Visible = False
            imbConvertPDF.Visible = False

            txtMessage.Focus()
        End If

    End Sub

    Protected Sub btnClose_Click(sender As Object, e As System.EventArgs) Handles btnClose.Click
        RaiseEvent Closed()

    End Sub

    Public Sub selectType(sender As Object, e As EventArgs)
        Dim lnb As LinkButton = sender
        lnbDocType.Text = lnb.Text
        hflType.Value = lnb.CommandArgument
        lblDocNameData.Text = getDocNumber()

    End Sub

    Protected Sub cddSelectLoad1_Changed() Handles cddSelectLoad1.Changed
        lblDocNameData.Text = getDocNumber()
        txtDocName.Text = getDocNumber()
    End Sub

    Protected Sub imbConvertPDF_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbConvertPDF.Click

        If File.Exists(MapPath(Session("TempDocName"))) Then

            Dim fileName As String
            If Not Directory.Exists(MapPath(CONV_FOLDER)) Then
                Directory.CreateDirectory(MapPath(CONV_FOLDER))
            End If

            fileName = CONV_FOLDER & Mid(Session("TempDocName"), Session("TempDocName").ToString.Replace("\", "/").LastIndexOf("/") + 2)
            If File.Exists(MapPath(fileName)) Then
                File.Delete(MapPath(fileName))
            End If

            IO.File.Copy(MapPath(Session("TempDocName")), MapPath(fileName))

            Session("OriginalFileName") = Session("TempDocName")
            Session("TempDocName") = Mid(fileName, 1, fileName.LastIndexOf(".")) & ".pdf"

            Timer1.Enabled = True
            btnOK.Enabled = False
            imbConvertPDF.Visible = False
            imbUpload.Visible = False
            lblDocNameData.NavigateUrl = Session("TempDocName")
            imgDocIcon.ImageUrl = "~/images/icons/files/pdf.png"
            imbOriginal.Visible = True

        Else
            lblError.Text = "<br><br><strong>No existe el documento solicitado.</strong>"

        End If
    End Sub

    Protected Sub imbUpload_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbUpload.Click
        lblDocUpload.Visible = True
        pnlUpload.Visible = True
        imbUpload.Visible = False
        imbConvertPDF.Visible = hflAuthLevel.Value = 1 Or hflAuthLevel.Value = 3
        imbOriginal.Visible = False
    End Sub

    Protected Sub imbOriginal_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbOriginal.Click
        Dim dr As DataRow = SQLDataTable("select * from cdd.tblDocuments where documentID = " & hflDocId.Value).Rows(0)
        Response.Redirect(isNull(dr.Item("documentFilename"), ""))
    End Sub

    Protected Sub imbObsoleto_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbObsoleto.Click
        'Inicia proceso de obsolescencia
        lblMessage.Text = "Iniciar proceso de obsolescencia."
        hflAuthLevel.Value = 4
        disableTextBoxes(True)
        imgOptions.Visible = False
        pnlButtons.Visible = False

    End Sub

    Protected Sub disableTextBoxes(value As Boolean)
        For Each c As Control In Me.Controls

            If c.GetType.Name = "TextBox" Then
                DirectCast(c, TextBox).Enabled = Not value

            End If
        Next
    End Sub

    Protected Sub imbEdit_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbEdit.Click
        txtDocName.Text = lblDocNameData.Text
        txtDocName.Visible = True
        lblDocNameData.Visible = False
        imbEditOK.Visible = True
        imbEditCancel.Visible = True
    End Sub


    Protected Sub imbEditCancel_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbEditCancel.Click
        txtDocName.Text = lblDocNameData.Text
        txtDocName.Visible = False
        imbEditOK.Visible = False
        imbEditCancel.Visible = False
        lblDocNameData.Visible = True
    End Sub

    Protected Sub imbEditOK_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imbEditOK.Click
        lblDocNameData.Text = txtDocName.Text
        txtDocName.Visible = False
        imbEditOK.Visible = False
        imbEditCancel.Visible = False
        lblDocNameData.Visible = True
    End Sub

    Protected Sub txtRev_TextChanged(sender As Object, e As System.EventArgs) Handles txtRev.TextChanged
        If hflAction.Value = "UPD" And hflAuthLevel.Value = 3 Then
            hflRevChange.Value = 1
            hflAction.Value = "CHR"
            pnlUpload.Visible = True
            If Not Session("uploadedDocName") Is Nothing Then
                lblMessage.Text = "La revisión ha sido cambiada."
            Else
                lblMessage.Text = "La revisión ha sido cambiada. Es necesario cargar un nuevo documento para esta nueva revisión."
            End If
        End If
    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        If Session("myUsername") Is Nothing Then
           
            ' MsgBox("Sesión ha finalizado debido a inactividad.", MsgBoxStyle.ApplicationModal & MsgBoxStyle.Exclamation & MsgBoxStyle.SystemModal, "Sesión caducada")
                Response.Redirect(".")

        End If
    End Sub

    Protected Sub Timer1_Tick(sender As Object, e As System.EventArgs) Handles Timer1.Tick
        If File.Exists(MapPath(Session("TempDocName"))) Then
            btnOK.Enabled = True
            lblMessage.Text = "Documento Convertido a PDF"
            Timer1.Enabled = False
        End If
    End Sub

  
End Class
