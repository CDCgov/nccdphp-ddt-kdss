Imports System
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO
Imports System.Net
Imports System.Text
Imports Microsoft.Extensions.Configuration
Imports Newtonsoft.Json
Imports NG.NCCDPHP.DataAccess
'Imports NG.NCCDPHP.DataAccess.Sql
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports ConfigurationManager = System.Configuration.ConfigurationManager
Public Class GetDBConnectionString
    Private configuration As IConfiguration

    Public Function GetConnectionString() As String
        Dim strReturn As String = String.Empty

        Try

            ' Read DB settings from Web.config
            Dim DBName As String = System.Configuration.ConfigurationManager.AppSettings("DBName")
            Dim DBServer As String = System.Configuration.ConfigurationManager.AppSettings("DBServer")

            Dim connectionString As String = String.Format("Server={0};Database={1};Integrated Security=True;TrustServerCertificate=True", DBServer, DBName)
            strReturn = connectionString


        Catch ex As Exception
            Console.WriteLine("Connection String Creation Failed")
            Console.WriteLine("Check Web.config parameters or JSON formatting.")
            'Console.WriteLine("Here is your logged JSON Data: " & json.ToString())
            Console.WriteLine(ex.ToString())
        End Try

        Return strReturn



    End Function
    Public Class PasswordResponse
        Public Property Password As String
        Public Property [error] As String
    End Class

End Class
