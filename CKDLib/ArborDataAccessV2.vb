Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Data
Imports System.Text
Imports System.Xml

''**ARBOR RESEARCH**''
Imports NG.NCCDPHP.DataAccess2.Sql
''**ARBOR RESEARCH**''


''**NG/CDC**''
Imports NG.NCCDPHP.Common
Imports NG.NCCDPHP.DataAccess
Imports NG.NCCDPHP.Utilities
'Imports NG.NCCDPHP.DataAccess.Sql
Imports Microsoft.Practices.EnterpriseLibrary.Data.Sql
Imports DocumentFormat.OpenXml.Office2013.Excel
''**NG/CDC**''


Public Class ArborDataAccessV2

    Public Sub New()

    End Sub


    Public Function getConnectionString() As String

        Dim answer As String = ""

        ''**ARBOR RESEARCH**''
        ''Get the connection string from the Web.config
        If (ConfigurationManager.AppSettings("Environment") = "MPR") Then
            answer = ConfigurationManager.ConnectionStrings("CKD_NEW").ConnectionString.ToString()
        Else
            answer = DBUtil.GetSqlDBConnection().ConnectionString()
        End If

        'answer = cryptor.DecryptString(encrypted_string)
        ''**ARBOR RESEARCH**''


        ''**NG/CDC**''
        ''answer = GetSqlDBConnectionByPlainConnectionString().ConnectionString
        'answer = DBUtil.GetSqlDBConnection().ConnectionString()
        ''**NG/CDC**''

        Return answer
    End Function

#Region "CDC Connection"

    '********************************
    '*SURYA - Uncomment this section* - also uncomment line 129 in the web.config and comment out line 126 in the web.config to get the connection string
    '********************************

    'Private Function GetSqlDBConnectionByPlainConnectionString() As SqlDatabase
    ''    Dim sqlDB As New SqlDatabase(ConfigurationManager.AppSettings("CKD_CDC"), False) --*Original*

    '    Dim cn As String = ConfigurationManager.ConnectionStrings("CKD_CDC").ConnectionString.ToString()
    '    Dim sqlDB As New SqlDatabase(cn, False)

    '    Return sqlDB
    'End Function

#End Region

#Region "ObjectReturn"

    Public Function getSQLConnection() As SqlConnection

        Dim str As String = getConnectionString() 'ConfigurationManager.ConnectionStrings("dev").ConnectionString.ToString()

        Dim cn As New SqlConnection(str)

        Return cn

    End Function

#End Region

#Region "DataRetrieval"

    Private Function returnDataSet(ByVal sqlparams() As SqlParameter, ByVal sql As String, ByVal tableName As String) As DataSet
        '** (Has SQL parameters) **

        Dim ds As New DataSet()
        Dim str As String = getConnectionString()

        '*******************************************************
        '*Execute the Stored Procedure with provided Parameters*
        '*******************************************************
        Using cn = New SqlConnection(str)
            Using cmd As New SqlCommand(sql, cn)

                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddRange(sqlparams)

                Using da = New SqlDataAdapter(cmd)
                    da.Fill(ds)
                    ds.Tables(0).TableName = tableName
                End Using
            End Using
        End Using

        'Return the DataSet
        Return ds

    End Function
    Private Function returnDataSet(ByVal sql As String, ByVal tableName As String) As DataSet
        '** (Has NO SQL parameters) **

        Dim ds As New DataSet()
        Dim str As String = getConnectionString()

        '*************************************************
        '*Execute the Stored Procedure with No Parameters*
        '*************************************************
        Using cn = New SqlConnection(str)
            Using cmd As New SqlCommand(sql, cn)

                cmd.CommandType = CommandType.StoredProcedure

                Using da = New SqlDataAdapter(cmd)
                    da.Fill(ds)
                    ds.Tables(0).TableName = tableName
                End Using
            End Using
        End Using

        'Return the DataSet
        Return ds

    End Function

#End Region

#Region "DataInsert"
    Private Sub NonQuery(ByVal sqlparams() As SqlParameter, ByVal sql As String)

        'Dim cmd As SqlCommand

        Dim str As String = getConnectionString()

        Try
            Using cn = New SqlConnection(str)
                Using cmd = New SqlCommand(sql, cn)
                    With cmd
                        .CommandType = CommandType.StoredProcedure
                        .Parameters.AddRange(sqlparams)
                    End With

                    With cn
                        .Open()
                        cmd.ExecuteNonQuery()
                        .Close()
                    End With
                End Using
            End Using
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw ex
        Finally

        End Try

    End Sub
#End Region

#Region "Legacy"

    Public Function GetExecutiveSummaryYears(ByVal fileInfoOnly As Boolean) As DataTable

        Dim ds As DataSet = New DataSet()
        Dim sql As String = "proc_GetExecutiveSummary"

        Dim DontGetFileData As Integer = 0

        If (fileInfoOnly = True) Then
            DontGetFileData = 1
        Else
            DontGetFileData = 0
        End If

        Try
            Dim sp1 As New SqlParameter("@FileInfoOnly", DontGetFileData) '3/12/2012 BobG added the optional parameter to reduce network traffic on page loads
            Dim sqlparams As SqlParameter() = {sp1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, sql, DBCONSTANTS.DATAPOINT)

        Catch ex As Exception
            Throw ex
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function GetExecutiveSummaryYears() As DataTable

        Dim ds As DataSet = New DataSet()
        Dim sql As String = "proc_GetExecutiveSummary"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, DBCONSTANTS.DATAPOINT)

        Catch ex As Exception
            Throw ex
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function

#End Region


#Region "Arbor Additions"


    Public Sub SaveTimings(ByVal url As String, ByVal pagename As String, ByVal serverTime As Integer, ByVal clientTime As Integer)

        'Get the connection string from the Web.config
        Dim str As String = getConnectionString()

        Dim sql As String = "usp_InsertTimings"
        Dim cmd As SqlCommand = Nothing
        Dim p1 As SqlParameter = New SqlParameter("@URL", url)
        Dim p2 As SqlParameter = New SqlParameter("@page", pagename)
        Dim p3 As SqlParameter = New SqlParameter("@ServerLoadTime", serverTime)
        Dim p4 As SqlParameter = New SqlParameter("@clientLoadTime", clientTime)

        Dim sqlparam As SqlParameter() = {p1, p2, p3, p4}

        Try
            Using cn = New SqlConnection(str)
                cmd = New SqlCommand(sql, cn)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddRange(sqlparam)

                cn.Open()
                cmd.ExecuteNonQuery()
                cn.Close()
            End Using
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw ex
        Finally
            p1 = Nothing
            p2 = Nothing
            p3 = Nothing
            p4 = Nothing
            cmd.Dispose()
        End Try

    End Sub
    Public Sub SaveTimings(ByVal url As String, ByVal pagename As String, ByVal serverTime As Integer, ByVal clientTime As Integer, ByVal version As String)

        'Get the connection string from the Web.config
        Dim str As String = getConnectionString()

        Dim sql As String = "usp_InsertTimings2"
        Dim cmd As SqlCommand = Nothing
        Dim p1 As SqlParameter = New SqlParameter("@URL", url)
        Dim p2 As SqlParameter = New SqlParameter("@page", pagename)
        Dim p3 As SqlParameter = New SqlParameter("@ServerLoadTime", serverTime)
        Dim p4 As SqlParameter = New SqlParameter("@clientLoadTime", clientTime)
        Dim P5 As SqlParameter = New SqlParameter("@Version", version)

        Dim sqlparam As SqlParameter() = {p1, p2, p3, p4, P5}

        Try
            Using cn = New SqlConnection(str)
                cmd = New SqlCommand(sql, cn)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddRange(sqlparam)

                cn.Open()
                cmd.ExecuteNonQuery()
                cn.Close()
            End Using
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw ex
        Finally
            p1 = Nothing
            p2 = Nothing
            p3 = Nothing
            p4 = Nothing
            P5 = Nothing
            cmd.Dispose()
        End Try

    End Sub
    Public Function getExcelDownload(ByVal chartID As Integer, ByVal yr As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetDownloadExcelTable"

        Try
            Dim sqlparamsList As New List(Of SqlParameter)
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            sqlparamsList.Add(sp1)

            Dim sp2 As SqlParameter
            If Not String.IsNullOrEmpty(yr) Then
                sp2 = New SqlParameter("@Year", yr)
                sqlparamsList.Add(sp2)
            End If

            'Dim sqlparams As SqlParameter() = sqlparamsAL.ToArray()


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparamsList.ToArray(), Sql, "Table")

            '*********
            '*CleanUp*
            '*********
            sqlparamsList = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function

    Public Function getExcelDownloadForMaps(ByVal chartID As Integer, ByVal yr As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetDownloadExcelTableForMaps"

        Try
            Dim sqlparamsList As New List(Of SqlParameter)
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            sqlparamsList.Add(sp1)

            Dim sp2 As SqlParameter
            If Not String.IsNullOrEmpty(yr) Or chartID < 0 Then
                sp2 = New SqlParameter("@Year", yr)
                sqlparamsList.Add(sp2)
            End If

            'Dim sqlparams As SqlParameter() = sqlparamsAL.ToArray()


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparamsList.ToArray(), Sql, "Table")

            '*********
            '*CleanUp*
            '*********
            sqlparamsList = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function


    Public Function getPage(ByVal QNum As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetPage"

        Try
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "PageData")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function

    Public Function getMapDataAllYears(ByVal chartID As Integer) As DataSet
        Dim ds As DataSet = New DataSet()
        Dim sql As String = "proc_GetMapData_AllYears"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sqlparams As SqlParameter() = {sp1}
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, sql, "Chart")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function

    Public Function getChartForMaps(ByVal chartID As Integer, ByVal year As String, ByVal range As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetChartForMaps"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sp2 As New SqlParameter("@year", year)
            Dim sp3 As New SqlParameter("@nTiles", 5) 'hardcoded for now
            Dim sp4 As New SqlParameter("@Range", range)
            Dim sqlparams As SqlParameter() = {sp1, sp2, sp3, sp4}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Chart")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function

    Public Function getChartForMaps_AllYearsOneState(ByVal chartID As Integer, ByVal fipsstate As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetChartForMaps_AllYearsOneState"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sp2 As New SqlParameter("@fipsstate", fipsstate)
            Dim sqlparams As SqlParameter() = {sp1, sp2}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Chart")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function

    Public Function getChart(ByVal chartID As Integer, ByVal year As String, ByVal range As String) As DataSet

        Dim ds As DataSet = New DataSet()
        ' Dim Sql As String = "proc_GetChart"
        Dim Sql As String = "proc_GetChartWithShort"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sp2 As New SqlParameter("@year", year)
            Dim sp3 As New SqlParameter("@nTiles", 5) 'hardcoded for now
            Dim sp4 As New SqlParameter("@Range", range)
            Dim sqlparams As SqlParameter() = {sp1, sp2, sp3, sp4}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Chart")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function


    Public Function getTableForMaps(ByVal chartID As Integer, ByVal yr As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetTableForMaps"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sp2 As New SqlParameter("@Year", yr)
            Dim sqlparams As SqlParameter() = {sp1, sp2}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Table")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function
    Public Function getTable(ByVal chartID As Integer, ByVal yr As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetTable"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sp2 As New SqlParameter("@Year", yr)
            Dim sqlparams As SqlParameter() = {sp1, sp2}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Table")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function
    Public Function getTableLinear(ByVal chartID As Integer, ByVal yr As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetTableLinear"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sp2 As New SqlParameter("@Year", yr)
            Dim sqlparams As SqlParameter() = {sp1, sp2}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Table")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function
    Public Function getTableDisparities(ByVal chartID As Integer, ByVal yr As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetDisparitiesTable"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sp2 As New SqlParameter("@Year", yr)
            Dim sqlparams As SqlParameter() = {sp1, sp2}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Table")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function
    Public Function getAllNonMegaMenuTMI() As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetNonMegaMenuTMI"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(Sql, "nonMMTMI")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function
    Public Function getChartPivot(ByVal chartID As Integer) As DataSet
        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetChartPivot"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Table")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds
    End Function
    Public Function getChartChooser(ByVal chartID As Integer) As DataSet
        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetChartChooser"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Table")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds
    End Function
    Public Function getDisparities(ByVal chartID As Integer, ByVal yr As String) As DataSet
        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetDisparities"

        Try
            Dim sp1 As New SqlParameter("@ChartID", chartID)
            Dim sp2 As New SqlParameter("@year", yr)
            Dim sqlparams As SqlParameter() = {sp1, sp2}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Disparities")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds
    End Function

    Public Function getTopic(ByVal topicid As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetTopic"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@TopicID", topicid)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Topics")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function

    Public Function getTopics(ByVal hp As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetTopics"
        'Dim sql As String = "proc_GetAccordionTopics"
        'Dim sql As String = "proc_GetTopicList"

        Try
            'Dim p1 As SqlParameter = New SqlParameter("@HealthyPeople", hp)
            'Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            'ds = returnDataSet(sqlparam, sql, "Topics")
            ds = returnDataSet(sql, "Topics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getMeasuresByTopicID(ByVal id As Integer, Optional ByVal hp As Integer = 0) As DataTable
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetMeasuresByTopicID"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@TopicID", id)
            Dim p2 As SqlParameter = New SqlParameter("@HealthyPeople", hp)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Measures")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)
    End Function
    Public Function getIndicatorsByMeasureID(ByVal measureID As Integer) As DataTable

        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetIndicatorsByMeasureID"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@MeasureID", measureID)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Indicators")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)
    End Function
    Public Function getIndicatorsByTopicID(ByVal id As Integer) As DataSet

        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetIndicatorsByTopicID"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@TopicID", id)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Topics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds
    End Function
    Public Function getDBStats() As DataTable

        Dim ds As DataSet = New DataSet()
        Dim sql As String = "proc_getDBStats"

        Try
            ds = returnDataSet(sql, "DBStats")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getUniversalNotes(ByVal chartID As Integer, ByVal yr As String) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetPageUniversalNotes" '"proc_GetTildeNote"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@ChartID", chartID)
            Dim p2 As SqlParameter = New SqlParameter("@Year", yr)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "TildeNote")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)
    End Function
    Public Function getGlobals() As DataTable

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_getGlobals"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(Sql, "Globals")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)

    End Function
    Public Function getSubTopics(ByVal topicID As Integer, ByVal hp As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        'Dim sql As String = "proc_GetMeasuresByTopic"
        Dim sql As String = "proc_GetAccordionMeasures"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@TopicID", topicID)
            Dim p2 As SqlParameter = New SqlParameter("@HealthyPeople", hp)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "SubTopics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getSubTopicsWKD(ByVal topicID As Integer, ByVal hp As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        'Dim sql As String = "proc_GetMeasuresByTopic"
        Dim sql As String = "proc_GetAccordionMeasuresKidneyDay"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@TopicID", topicID)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "SubTopics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getSubTopicsSpecialDay(ByVal topicID As Integer, ByVal hp As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        'Dim sql As String = "proc_GetMeasuresByTopic"
        Dim sql As String = "proc_GetAccordionMeasuresSpecialDay"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@TopicID", topicID)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "SubTopics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getSubTopicsSpecialFactors_ALL() As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionMeasuresSpecialFactors_ALL"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "SubTopics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getSubTopicsSpecialFactors(ByVal factor As String, ByVal topicID As Integer, ByVal hp As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionMeasuresSpecialFactors"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@Factor", factor)
            Dim p2 As SqlParameter = New SqlParameter("@TopicID", topicID)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "SubTopics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getSubTopicsSearch(ByVal topicID As Integer, ByVal list As DataTable) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionMeasuresSearchList"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@TopicID", topicID)
            Dim p2 As SqlParameter = New SqlParameter("@SearchList", list)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "SubTopics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getFootNotes(ByVal QNum As String) As DataTable

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetFootnote"

        Try
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "FootNotes")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)

    End Function
    Public Function getMethodText(ByVal QNum As String, ByVal includeSS As Byte) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetMethodsText"

        Try
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sp2 As New SqlParameter("@includeSpecSheet", includeSS)
            Dim sqlparams As SqlParameter() = {sp1, sp2}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Methods")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing
            sp2 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds

    End Function
    Public Function getReferences(ByVal QNum As String) As DataTable

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetReferences"

        Try
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "References")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)

    End Function
    Public Function getIndicators(ByVal subTopicID As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionIndicators"
        'Dim sql As String = "proc_GetIndicatorsByMeasure"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@MeasureID", subTopicID)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Indicators")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getIndicatorsWKD(ByVal subTopicID As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionIndicatorsKidneyDay"
        'Dim sql As String = "proc_GetIndicatorsByMeasure"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@MeasureID", subTopicID)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Indicators")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getIndicatorsSpecialDay(ByVal subTopicID As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionIndicatorsSpecialDay"
        'Dim sql As String = "proc_GetIndicatorsByMeasure"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@MeasureID", subTopicID)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Indicators")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getIndicatorsSpecialFactors(ByVal subTopicID As Integer, ByVal factor As String) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionIndicatorsSpecialFactors"
        'Dim sql As String = "proc_GetIndicatorsByMeasure"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@MeasureID", subTopicID)
            Dim p2 As SqlParameter = New SqlParameter("@Factor", factor)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Indicators")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getNewIndicatorList() As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "Proc_GetNewIndicators"

        Try

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "Indicators")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getIndicatorsSearch(ByVal measureID As Integer, ByVal List As DataTable) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionIndicatorsSearchList"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@MeasureID", measureID)
            Dim p2 As SqlParameter = New SqlParameter("@SearchList", List)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Indicators")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getApplicationSettings() As DataTable

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_getAllAppSetting"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(Sql, "ApplicationSettings")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)

    End Function
    Public Function getDataSources() As DataTable

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_getDataSourcePopupInfo"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(Sql, "Datasources")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)

    End Function
    Public Function getKPandMethods(ByVal QNum As String) As DataTable

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_getKPandMethodsText"

        Try
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "KPMethods")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)

    End Function
    Public Function getKeypoints(ByVal QNum As String) As DataTable

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetKeypoints"

        Try
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "KPs")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)


    End Function
    Public Function getMethods(ByVal QNum As String) As DataTable


        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetMethods"

        Try
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "Methods")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)

    End Function
    Public Function getAccordianTopics() As DataTable

        '*****************************
        '*Used on the Data2.aspx page*
        '*****************************

        Dim ds As DataSet = New DataSet()
        Dim sql As String = "proc_GetAccordionTopics"

        Try
            ds = returnDataSet(sql, "Topics")
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getAccordianTopics(ByVal hp As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionTopics"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@HealthyPeople", hp)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Topics")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getAccordionTopics(ByVal hp As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        'Dim sql As String = "proc_GetTopics"
        'Dim sql As String = "proc_GetAccordionTopics"
        Dim sql As String = "proc_GetAccordionTopics"

        Try
            'Dim p1 As SqlParameter = New SqlParameter("@HealthyPeople", hp)
            'Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            'ds = returnDataSet(sqlparam, sql, "Topics")
            ds = returnDataSet(sql, "Topics")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getAccordianTopics(ByVal hp As Integer, ByVal pops As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionTopics"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@HealthyPeople", hp)
            Dim p2 As SqlParameter = New SqlParameter("@SpecialPops", pops)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Topics")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getAccordianWKDTopics() As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionTopicsKidneyDay"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "Topics")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getAccordionSpecialDayTopics() As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionTopicsSpecialDay"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "Topics")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getAccordionSpecialFactorTopics(ByVal factor As String) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetAccordionTopicsSpecialFactors"

        Try

            Dim p1 As SqlParameter = New SqlParameter("@Factor", factor)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "SpecialFactorTopics")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getAccordionLocalSearchTopics(ByVal ss As String) As DataSet

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()
        Dim ds2 As DataSet = New DataSet()

        Dim sql As String = "proc_GetFullTextSearch"

        Try

            Dim p1 As SqlParameter = New SqlParameter("@Search", ss)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "preSearchTopics")

            '*Send this result back to get the actual Topics*            
            sql = "proc_GetAccordionTopicsSearchList"

            Dim p2 As New SqlParameter("@SearchList", ds.Tables(0))
            Dim sqlparam2 As SqlParameter() = {p2}

            ds2 = returnDataSet(sqlparam2, sql, "SearchTopics")

            ds.Tables.Add(ds2.Tables(0).Copy())

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds

    End Function

    Public Function getQuestionDetails(ByVal QNum As String) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()
        Dim answer As DataTable

        Dim sql As String = "proc_GetTopicsMeasuresIndicatorByQNum"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@QNum", QNum)
            Dim sqlparam As SqlParameter() = {p1}
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Details")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try


        answer = ds.Tables(0)

        Return answer

    End Function
    Public Function getMethodIDFromQNum(ByVal QNum As String) As String

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()
        Dim answer As String = ""

        Dim sql As String = "proc_GetTopicsMeasuresIndicatorByQNum"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@QNum", QNum)
            Dim sqlparam As SqlParameter() = {p1}
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "MethodID")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Dim cnt As Integer = ds.Tables(0).Rows.Count

        If cnt > 0 Then
            answer = ds.Tables(0).Rows(0)("MeasureID").ToString()
        Else
            answer = "0"
        End If


        Return answer
    End Function
    Public Function isLegitimateQNumber(ByVal QNum As String) As Boolean

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()
        Dim answer As Boolean = False

        Dim sql As String = "proc_GetTopicsMeasuresIndicatorByQNum"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@QNum", QNum)
            Dim sqlparam As SqlParameter() = {p1}
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Count")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Dim cnt As Integer = ds.Tables(0).Rows.Count
        answer = IIf(cnt > 0, True, False)

        Return answer

    End Function
    Public Function getAllLegitimateQNumbers() As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()
        Dim answer As Boolean = False

        Dim sql As String = "proc_getAllLegitimateQNums"

        Try
            ds = returnDataSet(sql, "QNUMs")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try


        Return ds.Tables(0)

    End Function
    Public Function getTopicsAndMeasures() As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetTopicMeasures"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "TopicsAndMeasure")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getRelatedIndicators(ByVal QNum As String) As DataSet

        Dim ds As DataSet = New DataSet()
        Dim Sql As String = "proc_GetRelatedIndicatorsFromQNum"

        Try
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sqlparams As SqlParameter() = {sp1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparams, Sql, "RelatedIndicators")

            '*********
            '*CleanUp*
            '*********
            sqlparams = Nothing
            sp1 = Nothing


        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds '.Tables(0)

    End Function
    Public Function getTopicForCategoryControl(ByVal hp As Integer) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetTopics"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@HealthyPeople", hp)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "Topics")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getIndicatorsFromMeasureID(ByVal measureID As String) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetIndicator"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@MeasureID", measureID)
            Dim sqlparam As SqlParameter() = {p1}
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "TopicsAndMeasure")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function
    Public Function getDatasourcesFromIndicatorCode(ByVal measureID As String) As DataTable

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_getDataSourcesFromQNum"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@QNum", measureID)
            Dim sqlparam As SqlParameter() = {p1}
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "DataSources")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return ds.Tables(0)

    End Function

    Public Function getQuestionEnabled(ByVal QNum As String) As Boolean

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_CheckQuestionEnabled"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@QNum", QNum)
            Dim sqlparam As SqlParameter() = {p1}
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "DataSources")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '*********************
        '*Return the Data set*
        '*********************
        Return CType(ds.Tables(0).Rows(0)(0), Boolean)

    End Function

    Public Function getGlossaryEntries() As DataSet

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_getGlossaryList"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "Glossary")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try


        '***********************
        '*Return the Data Table*
        '***********************
        Return ds

    End Function

    Public Function getBibliography() As DataTable

        'Get the connection string from the Web.config
        Dim ds As New DataSet()

        Dim sql As String = "proc_getBibliographyList"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "Bibliography")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try


        '***********************
        '*Return the Data Table*
        '***********************
        Return ds.Tables(0)

    End Function

    Public Function getFAQs() As DataSet

        'Get the connection string from the Web.config
        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_getFAQList"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "FAQ")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try


        '***********************
        '*Return the Data Table*
        '***********************
        Return ds

    End Function


    Public Function getMapJSCode(ByVal QNum As String, ByVal yr As String) As DataSet

        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetMapSVG"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@QNum", QNum)
            Dim p2 As SqlParameter = New SqlParameter("@Year", yr)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "MapJSCode")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '***********************
        '*Return the Data Table*
        '***********************
        Return ds
    End Function

    Public Function getSpecialTopics() As DataTable
        Dim dtAnswer As DataTable

        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetTopics"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@SpecialPopulationsOnly", 1)
            Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "SpecialPops")
            dtAnswer = ds.Tables(0)

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '***********************
        '*Return the Data Table*
        '***********************



        Return dtAnswer
    End Function

    Public Function getFactorsOfInterest() As DataTable
        Dim dtAnswer As DataTable

        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetFactorsOfInterest"

        Try
            'Dim p1 As SqlParameter = New SqlParameter("@SpecialPopulationsOnly", 1)
            'Dim sqlparam As SqlParameter() = {p1}

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sql, "FactorsOfInterest")
            dtAnswer = ds.Tables(0)

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try


        '***********************
        '*Return the Data Table*
        '***********************
        Return dtAnswer

    End Function
    Public Function getFactorsOfInterest(ByVal factor As String) As DataTable
        Dim dtAnswer As DataTable

        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetFactorsOfInterest"

        Try
            Dim p1 As SqlParameter = New SqlParameter("@Factor", factor)
            Dim sqlparam As SqlParameter() = {p1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, sql, "FactorsOfInterest")
            dtAnswer = ds.Tables(0)

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try


        '***********************
        '*Return the Data Table*
        '***********************
        Return dtAnswer

    End Function
    Public Function getPageLinks(ByVal QNum As String) As DataTable
        Dim dtAnswer As DataTable

        Dim ds As DataSet = New DataSet()

        Dim sql As String = "proc_GetLinkedPagesFromQNum"

        Try
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            Dim sp1 As New SqlParameter("@QNum", QNum)
            Dim sqlparams As SqlParameter() = {sp1}

            ds = returnDataSet(sqlparams, sql, "LinkedPages")
            dtAnswer = ds.Tables(0)

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        '***********************
        '*Return the Data Table*
        '***********************
        Return dtAnswer
    End Function

    Public Sub insertSurveyAnswer(ByVal sessionid As String, ByVal qid As String, ByVal aid As String, Optional ByVal atext As String = Nothing)
        Dim sql As String = "proc_SurveySaveAnswer"

        Try
            Dim ps1 As SqlParameter = New SqlParameter("@SurveyAnswerSessionID", sessionid)
            Dim p1 As SqlParameter = New SqlParameter("@SurveyQuestionID", qid)
            Dim p2 As SqlParameter = New SqlParameter("@SurveyAnswerID", aid)
            Dim p3 As SqlParameter

            If atext = Nothing Then 'if it is not missing a value
                p3 = New SqlParameter("@SurveyAnswerText", DBNull.Value)
            Else
                p3 = New SqlParameter("@SurveyAnswerText", atext)
            End If

            Dim sqlparam As SqlParameter() = {p1, p2, p3, ps1}


            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            NonQuery(sqlparam, sql)


        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try
    End Sub

    Public Function getSurveyQuestionsAndAnswers(ByVal surveyID As String) As DataTable
        Dim ds As DataSet = New DataSet()

        Try
            Dim Sql As String = "proc_SurveyGetQuestionAndAnswer" 'proc_GetSurveyQuestionAndAnswers
            Dim p1 As SqlParameter = New SqlParameter("@SurveyID", surveyID)
            Dim sqlparam As SqlParameter() = {p1}
            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(sqlparam, Sql, "SurveyQuestionsAndAnswers")


        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)
    End Function


    Public Function get_AYA_Entries_for_FP_Widget() As DataTable

        Dim ds As DataSet = New DataSet()

        Try
            Dim Sql As String = "proc_GetAYAFPWidget"

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(Sql, "AYAFPWidget")


        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)

    End Function

    Public Function proc_IsRelatedToAgeSTD(ByVal Qnum As String, Optional ByVal Strat As String = "") As Boolean
        Try
            Dim Sql As String = "proc_IsRelatedToAgeSTD"
            Dim p1 As SqlParameter = New SqlParameter("@QNum", Qnum)
            Dim p2 As SqlParameter = New SqlParameter("@Strat", Strat)
            Dim sqlparam As SqlParameter() = {p1, p2}

            '*******************************
            '*Execute SP and get the result*
            '*******************************
            Return returnDataSet(sqlparam, Sql, "IsRelatedToAgeSTD").Tables(0).Rows(0)("AgeSTD") > 0
        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return False
    End Function

    Public Function proc_GetAgeSTDLabel() As DataTable
        Dim ds As DataSet = New DataSet()

        Try
            Dim Sql As String = "proc_GetAgeSTDLabel"

            '********************************
            '*Execute SP and get the Dataset*
            '********************************
            ds = returnDataSet(Sql, "AgeSTDLabel")

        Catch sqlEx As SqlException
            Throw
        Catch ex As Exception
            Throw
        End Try

        Return ds.Tables(0)
    End Function

#End Region

#Region "Utility"

    Private Function manageNullsWith0s(ByVal value As String) As String

        Dim answer As String = "0"
        If value IsNot Nothing Then answer = value

        Return answer

    End Function

#End Region


End Class
