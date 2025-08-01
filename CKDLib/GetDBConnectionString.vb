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

            ' Build SQL connection string
            Dim builder As New SqlConnectionStringBuilder()

            'Windows 

            builder.DataSource = DBServer
            builder.InitialCatalog = DBName
            builder.IntegratedSecurity = True ' Equivalent to "Integrated Security=SSPI"

            strReturn = builder.ConnectionString


            'strReturn = "Data Source=dsdv-infc-2200.cdc.gov,1433;Initial Catalog=NCCD_DDT_CKD;Integrated Security=SSPI"
            '' Test 
            'Dim sqlDB As New SqlDatabase(strReturn)

            'Using conn As New SqlConnection(strReturn)
            '    conn.Open()
            '    Console.WriteLine("Connection successful!")

            '    Dim query As String = "SELECT * FROM AYA"
            '    Using cmd As New SqlCommand(query, conn)
            '        Using reader As SqlDataReader = cmd.ExecuteReader()
            '            While reader.Read()
            '                'Create A New DataTable if needed (optional)
            '                Dim dt As New DataTable()

            '                'Uncomment below to load data into DataTable
            '                dt.Load(reader)

            '                'Example:                    Print the first column (adjust index/type as needed)
            '                For Each row As DataRow In dt.Rows
            '                    Console.WriteLine(row(0).ToString())
            '                Next
            '                Exit While
            '            End While
            '        End Using
            '    End Using

            '    conn.Close()
            'End Using
            strReturn = ConfigurationManager.ConnectionStrings("CKD_2022").ConnectionString.ToString()
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
