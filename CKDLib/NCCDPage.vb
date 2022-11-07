Imports Microsoft.VisualBasic
Imports System
Imports System.Web
Imports System.Text.RegularExpressions
Imports System.Configuration
Imports System.Web.UI.WebControls

Public Class NCCDPage
    Inherits System.Web.UI.Page

    ' Dim startTime As DateTime
    'Dim endTime As DateTime
    'Public LoadTimes As String

    Private strModule As String = String.Empty
    Private strSection As String = String.Empty
    Private strAccessLevel As String = String.Empty
    Private blnEditAccess As Boolean = True

    Public Property PageModule() As String
        Get
            Return strModule
        End Get
        Set(ByVal Value As String)
            strModule = Value
        End Set
    End Property


    Public Property PageSection() As String
        Get
            Return strSection
        End Get
        Set(ByVal Value As String)
            strSection = Value
        End Set
    End Property

    Public ReadOnly Property HasEditAccess() As Boolean
        Get
            Return blnEditAccess
        End Get
    End Property

    Public ReadOnly Property AccessLevel() As String
        Get
            Return strAccessLevel
        End Get
    End Property

    Private Sub Page_Error(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Error

    End Sub

    Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        'startTime = DateTime.Now
        ViewStateUserKey = HttpContext.Current.Session.SessionID
    End Sub


    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Dim slowPageTimeThreshold As String = System.Configuration.ConfigurationManager.AppSettings("slowpagethreshold").ToString()
        'Dim showLoadSettings As String = System.Configuration.ConfigurationManager.AppSettings("showPageTiming").ToString()
        'Dim showLoadTimesOnPage As Integer = IIf(IsNumeric(showLoadSettings) = True, CInt(showLoadSettings), 0)

        'Dim lit As New Literal()
        'lit.Text = "<script type='text/javascript'>var start = new Date(); var threshold = " & slowPageTimeThreshold & "; var showTimes = " & showLoadTimesOnPage & "</script>"

        'Page.Header.Controls.AddAt(1, lit)
        'Dim str2 As String = Page.ResolveUrl("~/local/js/Utility.js")
        'Page.ClientScript.RegisterClientScriptInclude("UtilityJS", str2)

    End Sub

    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        
        'Dim tsp As TimeSpan
        'Dim totalTime As Integer

        '*Calculates Page Load Time*
        'endTime = DateTime.Now
        'tsp = endTime - startTime

        '*Total Time in Milliseconds*
        'totalTime = (tsp.Minutes * 60 * 1000)
        'totalTime += (tsp.Seconds * 1000)
        'totalTime += tsp.Milliseconds

        'Me.ClientScript.RegisterStartupScript(Me.GetType(), "PageServerTimeVar", "<script type='text/javascript'>var serverTime = " + totalTime.ToString + "; $(document).ready(function() { task_page_load_complete(); });</script>")

    End Sub

End Class

