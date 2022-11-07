    Public Class Null
        Public Shared Function StringtoNull(ByVal strValue As String) As Object
            If strValue = String.Empty Then
                Return DBNull.Value
            Else
                Return strValue
            End If
        End Function
        Public Shared Function InttoNull(ByVal intValue As Integer) As Object
            If intValue = 0 Then
                Return DBNull.Value
            Else
                Return intValue
            End If
        End Function
    End Class