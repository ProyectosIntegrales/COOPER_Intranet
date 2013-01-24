Imports Microsoft.VisualBasic
Imports System.Data

Public Class cddUserx
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

    Public ReadOnly Property AuthType As String
        Get
            Return _authType
        End Get
    End Property

    Dim _mgrOfDepto As String
    Dim _isCalEngOf As String
    Dim _isMfgEngOf As String
    Dim _privLevel As Integer
    Dim _authType As String

    Public Sub New(username As String)

        Dim dt As DataTable = SQLDataTable("select * from cdd.vUsers where username = '" & username & "'")

        If dt.Rows.Count >= 1 Then
            Dim dr As DataRow = dt.Rows(0)
            _privLevel = dr.Item("privLevel")
            _mgrOfDepto = isNull(dr.Item("mgrOfDepto"), "")
            _isCalEngOf = isNull(dr.Item("calEngOf"), "")
            _isMfgEngOf = isNull(dr.Item("mfgEngOf"), "")
            _authType = IIf(_mgrOfDepto <> "", "MGR", IIf(_isMfgEngOf <> "", "MFG", IIf(_isCalEngOf <> "", "CAL", "")))
        Else
            _privLevel = 0
            _mgrOfDepto = ""
            _isCalEngOf = ""
            _isMfgEngOf = ""
        End If

    End Sub
End Class

Public Class DocumentType

    Public Property TypeID As Integer
        Get
            Return _TypeId
        End Get
        Set(value As Integer)
            _TypeId = value
        End Set
    End Property

    Public ReadOnly Property Name As String
        Get
            Return _name
        End Get
    End Property

    Public ReadOnly Property ByDept As Boolean
        Get
            Return _bydept
        End Get
    End Property

    Public ReadOnly Property mgrApproval As Boolean
        Get
            Return _reqap
        End Get
    End Property

    Public ReadOnly Property mfgEngApproval As Boolean
        Get
            Return _mfgap
        End Get
    End Property

    Public ReadOnly Property calEngApproval As Boolean
        Get
            Return _calap
        End Get
    End Property

    Public ReadOnly Property FolderName As String
        Get
            Return _folder
        End Get
    End Property

    Public ReadOnly Property NameFormat As String
        Get
            Return _format
        End Get
    End Property

    Dim _TypeId As Integer
    Dim _name, _folder, _format As String
    Dim _bydept, _reqap, _mfgap, _calap As Boolean

    Public Sub New(TypeId As Integer)

        getInfo(TypeId)
    End Sub

    Protected Sub getInfo(type As Integer)

        Dim dt As DataTable = SQLDataTable("select * from cdd.tblDoctypes where typeId = " & type)

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)

            _TypeId = type
            _name = isNull(dr.Item("typeNameEsp"), "")
            _folder = isNull(dr.Item("typeFolderName"), "")
            _format = isNull(dr.Item("typeNameFormat"), "")
            _bydept = isNull(dr.Item("SelectDept"), False)
            _reqap = isNull(dr.Item("mgrApproval"), False)
            _mfgap = isNull(dr.Item("mfgengApproval"), False)
            _calap = isNull(dr.Item("calengApproval"), False)

        Else

            _TypeId = 0
            _name = ""
            _folder = ""
            _format = ""
            _bydept = False
            _reqap = False

        End If
    End Sub
End Class


