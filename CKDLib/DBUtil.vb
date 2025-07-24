Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Web
Imports System.Text
Imports System.Data.SqlClient
Imports System.Data.Common
Imports System.Configuration
Imports NG.NCCDPHP.DataAccess
Imports NG.NCCDPHP.Utilities
'Imports NG.NCCDPHP.DataAccess.Sql
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql

Public Class DBUtil
    Public Shared Function GetSqlDBConnection() As SqlDatabase

        Dim connHelper As New GetDBConnectionString()
        Dim connectionString As String = connHelper.GetConnectionString()
        Dim sqlDB As New SqlDatabase(connectionString)
        Return sqlDB
    End Function
End Class
