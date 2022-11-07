Public Class Utilities

    Public Shared Function CheckForNumeric(ByVal val As String) As Boolean
        Dim answer = False

        If IsNumeric(val) Then
            answer = True
        End If

        Return answer
    End Function
    Public Shared Function CheckForDBNull(ByVal val As String) As Boolean
        Dim answer = False

        If IsDBNull(val) Then
            answer = True
        End If

        Return answer
    End Function

    Public Shared Function CheckIfValueExists(ByVal val As String) As Boolean
        Dim answer As Boolean = True

        If String.IsNullOrEmpty(val) OrElse String.IsNullOrWhiteSpace(val) Then
            answer = False
        ElseIf Not val Is Nothing AndAlso val <> "" AndAlso val.Length > 0 Then
            answer = True
        End If

        Return answer
    End Function
End Class
