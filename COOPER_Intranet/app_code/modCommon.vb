Imports CrystalDecisions.Shared
Imports System.Data
Imports System.IO

Public Module modCommon

    Dim cnCOOPER_Intranet As New SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("COOPER_IntranetConnectionString").ToString)

    Public Function isNull(ByVal objToEvaluate As Object, ByVal returnValue As Object) As Object

        If objToEvaluate Is DBNull.Value Or objToEvaluate Is Nothing Then
            Return returnValue
        Else
            Return objToEvaluate
        End If
    End Function

    Public Function doSQLProcedure(ByVal Procedure As String, ByVal commandType As CommandType, _
                                   Optional ByVal ParmName1 As String = "", Optional ByVal ParmValue1 As Object = Nothing, _
                                   Optional ByVal ParmName2 As String = "", Optional ByVal ParmValue2 As Object = Nothing, _
                                   Optional ByVal ParmName3 As String = "", Optional ByVal ParmValue3 As Object = Nothing, _
                                   Optional ByVal ParmName4 As String = "", Optional ByVal ParmValue4 As Object = Nothing, _
                                   Optional ByVal ParmName5 As String = "", Optional ByVal ParmValue5 As Object = Nothing, _
                                   Optional ByVal ParmName6 As String = "", Optional ByVal ParmValue6 As Object = Nothing,
                                   Optional ByVal ParmName7 As String = "", Optional ByVal ParmValue7 As Object = Nothing,
                                   Optional ByVal ParmName8 As String = "", Optional ByVal ParmValue8 As Object = Nothing,
                                Optional ByVal ParmName9 As String = "", Optional ByVal ParmValue9 As Object = Nothing, _
                                Optional ParmName10 As String = "", Optional ParmValue10 As Object = Nothing, _
                                Optional ParmName11 As String = "", Optional ParmValue11 As Object = Nothing, _
                                Optional ParmName12 As String = "", Optional ParmValue12 As Object = Nothing, _
                                Optional ParmName13 As String = "", Optional ParmValue13 As Object = Nothing, _
                                Optional ParmName14 As String = "", Optional ParmValue14 As Object = Nothing, _
                                Optional ParmName15 As String = "", Optional ParmValue15 As Object = Nothing, _
                                Optional ParmName16 As String = "", Optional ParmValue16 As Object = Nothing) As Object

        Dim cm As New SqlClient.SqlCommand

        Try

            With cm
                .CommandText = Procedure
                .CommandType = commandType
                .Connection = cnCOOPER_Intranet

                If ParmName1 <> "" Then
                    .Parameters.AddWithValue(ParmName1, ParmValue1)
                End If
                If ParmName2 <> "" Then
                    .Parameters.AddWithValue(ParmName2, ParmValue2)
                End If
                If ParmName3 <> "" Then
                    .Parameters.AddWithValue(ParmName3, ParmValue3)
                End If
                If ParmName4 <> "" Then
                    .Parameters.AddWithValue(ParmName4, ParmValue4)
                End If
                If ParmName5 <> "" Then
                    .Parameters.AddWithValue(ParmName5, ParmValue5)
                End If
                If ParmName6 <> "" Then
                    .Parameters.AddWithValue(ParmName6, ParmValue6)
                End If
                If ParmName7 <> "" Then
                    .Parameters.AddWithValue(ParmName7, ParmValue7)
                End If
                If ParmName8 <> "" Then
                    .Parameters.AddWithValue(ParmName8, ParmValue8)
                End If
                If ParmName9 <> "" Then
                    .Parameters.AddWithValue(ParmName9, ParmValue9)
                End If
                If ParmName10 <> "" Then
                    .Parameters.AddWithValue(ParmName10, ParmValue10)
                End If
                If ParmName11 <> "" Then
                    .Parameters.AddWithValue(ParmName11, ParmValue11)
                End If
                If ParmName12 <> "" Then
                    .Parameters.AddWithValue(ParmName12, ParmValue12)
                End If
                If ParmName13 <> "" Then
                    .Parameters.AddWithValue(ParmName13, ParmValue13)
                End If
                If ParmName14 <> "" Then
                    .Parameters.AddWithValue(ParmName14, ParmValue14)
                End If
                If ParmName15 <> "" Then
                    .Parameters.AddWithValue(ParmName15, ParmValue15)
                End If
                If ParmName16 <> "" Then
                    .Parameters.AddWithValue(ParmName16, ParmValue16)
                End If
                .Connection.Open()
                Dim result As Object = .ExecuteScalar
                Return result
            End With

        Catch ex As Exception
            Return "error: " & ex.Message
        Finally
            cm.Connection.Close()
        End Try

    End Function

    Public Function SQLDataTable(ByVal selectCommand As String) As DataTable
        Dim da As New SqlClient.SqlDataAdapter(selectCommand, cnCOOPER_Intranet)
        Dim ds As New DataSet
        da.Fill(ds)
        Return ds.Tables(0)
    End Function

    Public Function Mes(ByVal month As Integer) As String
        Dim meses() As String = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"}
        Return meses(month)
    End Function

    Public Function getSectionTitle(Language As String, menuID As Integer) As String

        Dim dt As Data.DataTable = SQLDataTable("SELECT CASE WHEN '" & Language & "' = 'eng' THEN dbo.tblSections.sectionTitleENG ELSE dbo.tblSections.sectionTitleESP END AS sectionTitle FROM dbo.tblMenuItems INNER JOIN dbo.tblSections ON dbo.tblMenuItems.menuSection = dbo.tblSections.sectionID WHERE (dbo.tblMenuItems.menuID = " & menuID & ")")

        If dt.Rows.Count > 0 Then
            Return isNull(dt.Rows(0).Item(0), "")
        Else
            Return ""
        End If

    End Function

    Public Function getSectionID(menuID As Integer) As String

        Dim dt As Data.DataTable = SQLDataTable("SELECT menuSection FROM dbo.tblMenuItems WHERE (dbo.tblMenuItems.menuID = " & menuID & ")")

        If dt.Rows.Count > 0 Then
            Return isNull(dt.Rows(0).Item(0), 0)
        Else
            Return 0
        End If

    End Function

    Public Function getParentID(menuID As Integer) As String

        Dim dt As Data.DataTable = SQLDataTable("SELECT menuParent FROM dbo.tblMenuItems WHERE (dbo.tblMenuItems.menuID = " & menuID & ")")

        If dt.Rows.Count > 0 Then
            Return isNull(dt.Rows(0).Item(0), 0)
        Else
            Return 0
        End If

    End Function

    Public Function canEdit(UserName As String, SectionID As Integer) As Boolean
        Dim dt As Data.DataTable = SQLDataTable("SELECT dbo.tblPrivs.sectionID, dbo.tblUsers.userName FROM dbo.tblUsers INNER JOIN dbo.tblPrivs ON dbo.tblUsers.userId = dbo.tblPrivs.userID WHERE (dbo.tblPrivs.sectionID = " & SectionID & ") AND (dbo.tblUsers.userName = '" & UserName & "')")
        Return dt.Rows.Count > 0
    End Function

    Public Function helpFile(SectionID As Integer) As String
        Dim dt As Data.DataTable = SQLDataTable("SELECT sectionHelpFile from tblSections where sectionID = " & SectionID)
        If dt.Rows.Count = 1 Then
            Return isNull(dt.Rows(0).Item(0), "")
        Else
            Return False
        End If
    End Function

    Public Function menuVisible(SectionID As Integer) As Boolean
        Dim dt As Data.DataTable = SQLDataTable("SELECT sectionLeftMenu from tblSections where sectionID = " & SectionID)
        If dt.Rows.Count = 1 Then
            Return dt.Rows(0).Item(0)
        Else
            Return False
        End If
    End Function

    'Public Function getName(emplNumber As Object) As String
    '    Try
    '        Return SQLDataTable("select userFirstName + ' ' + userLastName from tblUsers where userEmployeeNo = " & emplNumber).Rows(0).Item(0)
    '    Catch ex As Exception
    '        Return "<span class='blink'>No. de Empleado inválido</span>"
    '    End Try
    'End Function

    Public Function ReadText(ByVal TextFilePath As String) As String

        Dim sr As StreamReader
        sr = File.OpenText(TextFilePath)
        Dim contents As String = sr.ReadToEnd()
        sr.Close()
        Return contents

    End Function



End Module
