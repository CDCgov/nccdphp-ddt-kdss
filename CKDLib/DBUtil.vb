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
Imports NG.NCCDPHP.DataAccess.Sql

Public Class DBUtil
    Public Shared Function GetSqlDBConnection() As SqlDatabase
        Dim sqlDB As New SqlDatabase(ConfigurationManager.AppSettings("Database"), _
                                     ConfigurationManager.AppSettings("DBAccount"), _
                                     ConfigurationManager.AppSettings("DBServer"), _
                                     ConfigurationManager.AppSettings("DBKey"))
        Return sqlDB
    End Function
End Class
