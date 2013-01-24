Imports Microsoft.VisualBasic
Imports System.Data

Public Class qaUser
    Public Property PrivLevel As Integer
        Get
            Return _privLevel
        End Get
        Set(value As Integer)
            _privLevel = value
        End Set
    End Property

    Public ReadOnly Property IsMgrOf As String
        Get
            Return _mgrOfDepto
        End Get
    End Property

    Public ReadOnly Property IsCalEngOf As String
        Get
            Return _isCalEngOf
        End Get
    End Property

    Public ReadOnly Property IsMfgEngOf As String
        Get
            Return _isMfgEngOf
        End Get
    End Property

    Dim _mgrOfDepto As String
    Dim _isCalEngOf As String
    Dim _isMfgEngOf As String
    Dim _privLevel As Integer

    Public Sub New(username As String)

        Dim dt As DataTable = SQLDataTable("select * from qaa.vUsers where username = '" & username & "'")

        If dt.Rows.Count >= 1 Then
            Dim dr As DataRow = dt.Rows(0)
            _privLevel = dr.Item("userPriv")
            _mgrOfDepto = isNull(dr.Item("mgrOfDepto"), "")
            _isCalEngOf = isNull(dr.Item("calEngOf"), "")
            _isMfgEngOf = isNull(dr.Item("mfgEngOf"), "")
        Else
            _privLevel = 0
            _mgrOfDepto = ""
            _isCalEngOf = ""
            _isMfgEngOf = ""
        End If

    End Sub
End Class
