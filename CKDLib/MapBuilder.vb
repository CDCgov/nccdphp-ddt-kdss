Imports System
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Collections
Imports System.Web


Public Class MapBuilder
    Implements IDisposable

#Region "Declarations"

    Dim sb As StringBuilder
    Dim _error As String = ""

    '*Div*
    Dim _mapDivID As String = ""
    Dim _divTitle As String = "This is a map of the United States of America"

    '*States*
    Dim _useFullStateNames As Boolean = False
    Dim _useAllLabels As Boolean = True
    Dim _showMouseOvers As Boolean = True
    Dim _useLegendToColorStates As Boolean = False
    Dim _stateTextFontColor As String = "#000000"
    Dim _mouseOverBackGroundColor As String = "#0000FF"
    Dim _mouseOverTextColor As String = "#ffffff"
    Dim _stateValues As DataTable = Nothing

    '*Title(s)*
    Dim _mapTitleLine1 As String = ""
    Dim _mapTitleFontLine1 As String = ""
    Dim _mapTitleFontColorLine1 As String = "#000000"
    Dim _mapTitleFontSizeLine1 As String = ""

    Dim _mapTitleLine2 As String = ""
    Dim _mapTitleFontLine2 As String = ""
    Dim _mapTitleFontColorLine2 As String = "#000000"
    Dim _mapTitleFontSizeLine2 As String = ""

    '*Legend*
    Dim _legendTitle As String = "Legend"
    Dim _legendTextFontSize As String = "16px"
    Dim _legendTextFont As String = "Arial"
    Dim _legendTextFontColor As String = "#000000"
    Dim _legendValues As DataTable = Nothing

    '*Logo*
    Dim _logoPath As String = ""
    Dim _logoTextLine1 As String = ""
    Dim _logoTextLine2 As String = ""
    Dim _logoTextFontSize As String = "14px"
    Dim _logoTextFont As String = ""
    Dim _logoTextFontColor As String = "#000000"

#End Region

#Region "Properties"    

    Public ReadOnly Property MapError() As String
        Get
            Return _error
        End Get
    End Property


    '*Div Properties*
    ''' <summary>
    ''' What is the ID of the Div used to show the map (do not include a '#')
    ''' </summary>
    Public Property MapDivID As String
        Get
            Return _mapDivID
        End Get
        Set(value As String)
            _mapDivID = value
        End Set
    End Property

    ''' <summary>
    ''' Text that appears when mousing over the div
    ''' </summary>
    Public WriteOnly Property DivTitle As String
        Set(value As String)
            _divTitle = value
        End Set
    End Property



    '*Map Properties*
    ''' <summary>
    ''' true = full state name (Michigan) false = Abbreviated state names (MI)
    ''' </summary>
    Public Property UseFullStateNames As Boolean
        Get
            Return _useFullStateNames
        End Get
        Set(value As Boolean)
            _useFullStateNames = value
        End Set
    End Property

    ''' <summary>
    ''' true=show labes on each state, false=blank
    ''' </summary>
    Public Property UseStateLabels As Boolean
        Get
            Return _useAllLabels
        End Get
        Set(value As Boolean)
            _useAllLabels = value
        End Set
    End Property
        
    ''' <summary>
    ''' color of font on state
    ''' </summary>
    Public Property StateTextFontColor As String
        Get
            Return _stateTextFontColor
        End Get
        Set(value As String)
            _stateTextFontColor = value
        End Set
    End Property
        
    ''' <summary>
    ''' Provide a Datatable with two columns - 1:state abbrev. (eg. MI) 2:hex color (eg. #FF0000)
    ''' </summary>
    Public WriteOnly Property StateValues As DataTable
        Set(value As DataTable)
            _stateValues = value
        End Set
    End Property
        
    ''' <summary>
    ''' Apply legend ranges and colors to states table
    ''' </summary>
    Public WriteOnly Property useLegendValuesToColorStates As Boolean
        Set(value As Boolean)
            _useLegendToColorStates = value
        End Set
    End Property
        
    ''' <summary>
    ''' Whether the map will show mouseovers with state data (eg: MI: 56.76)
    ''' </summary>
    Public WriteOnly Property showMouseOvers As Boolean
        Set(value As Boolean)
            _showMouseOvers = value
        End Set
    End Property
        
    ''' <summary>
    ''' Background color of the mouseovers on the map
    ''' </summary>
    Public WriteOnly Property MouseOverBackGroundColor As String
        Set(value As String)
            _mouseOverBackGroundColor = value
        End Set
    End Property

    ''' <summary>
    ''' Color of the mouseover text on the maps
    ''' </summary>
    Public WriteOnly Property MouseOverTextColor As String
        Set(value As String)
            _mouseOverTextColor = value
        End Set
    End Property


    '*Title*
    ''' <summary>
    ''' First line of map title - will need trial and error Mapping tool doesn't have word wrap
    ''' </summary>
    Public WriteOnly Property MapTitleLine1 As String
        Set(value As String)
            _mapTitleLine1 = value
        End Set
    End Property

    ''' <summary>
    ''' Second line of map title - will need trial and error Mapping tool doesn't have word wrap
    ''' </summary>
    Public WriteOnly Property MapTitleLine2 As String
        Set(value As String)
            _mapTitleLine2 = value
        End Set
    End Property

    ''' <summary>
    ''' What font-family to use for the title? (eg. calibri)
    ''' </summary>
    Public WriteOnly Property MapTitleTextFontLine1 As String
        Set(value As String)
            _mapTitleFontLine1 = value
        End Set
    End Property

    ''' <summary>
    ''' What color should the Title Text be? (eg. #ff0000)
    ''' </summary>
    Public WriteOnly Property MapTitleFontColorLine1 As String
        Set(value As String)
            _mapTitleFontColorLine1 = value
        End Set
    End Property

    ''' <summary>
    ''' How big to make Map Title Font (eg. 22px)
    ''' </summary>
    Public WriteOnly Property MapTitleTextFontSizeLine1 As String
        Set(value As String)
            _mapTitleFontSizeLine1 = value
        End Set
    End Property

    ''' <summary>
    ''' What font-family to use for the title Line2? (eg. calibri)
    ''' </summary>
    Public WriteOnly Property MapTitleTextFontLine2 As String
        Set(value As String)
            _mapTitleFontLine2 = value
        End Set
    End Property

    ''' <summary>
    ''' What color should the Title Text be (Line 2)? (eg. #ff0000)
    ''' </summary>
    Public WriteOnly Property MapTitleFontColorLine2 As String
        Set(value As String)
            _mapTitleFontColorLine2 = value
        End Set
    End Property

    ''' <summary>
    ''' How big to make Map Title Font Line 2(eg. 12px)
    ''' </summary>
    Public WriteOnly Property MapTitleTextFontSizeLine2 As String
        Set(value As String)
            _mapTitleFontSizeLine2 = value
        End Set
    End Property


    '*Legend*
    ''' <summary>
    ''' Provide a DataTable with two string-valued columns - first column: legend text | second columns: Hex color for box (eg. #FF0000) (or color name eg: silver).
    ''' </summary>
    Public WriteOnly Property LegendValues As DataTable
        Set(value As DataTable)
            _legendValues = value
        End Set
    End Property

    ''' <summary>
    '''  <summary>Add the title that will appear above the legend.</summary>
    ''' </summary>
    Public WriteOnly Property LegendTitle As String
        Set(value As String)
            _legendTitle = value
        End Set
    End Property

    ''' <summary>
    ''' Legend font size
    ''' </summary>
    Public WriteOnly Property LegendFontSize As String
        Set(value As String)
            _legendTextFontSize = value
        End Set
    End Property

    ''' <summary>
    ''' What font-family to use for the legend? (eg. calibri)
    ''' </summary>
    Public WriteOnly Property LegendTextFont As String
        Set(value As String)
            _legendTextFontSize = value
        End Set
    End Property

    ''' <summary>
    ''' What color should the Legend Text be? (eg. #ff0000)
    ''' </summary>
    Public WriteOnly Property LegendTextFontColor As String
        Set(value As String)
            _legendTextFontColor = value
        End Set
    End Property


    '*Logo*
    ''' <summary>
    ''' Relative path to the logo (will have to be appropriately sized)
    ''' </summary>
    Public WriteOnly Property LogoPath As String
        Set(value As String)
            _logoPath = value
        End Set
    End Property

    ''' <summary>
    ''' First line of Logo Text (map tool has no understanding of word wrap)
    ''' </summary>
    Public WriteOnly Property LogoTextLine1 As String
        Set(value As String)
            _logoTextLine1 = value
        End Set
    End Property

    ''' <summary>
    ''' Second line of Logo Text (map tool has no understanding of word wrap)
    ''' </summary>
    Public WriteOnly Property LogoTextLine2 As String
        Set(value As String)
            _logoTextLine2 = value
        End Set
    End Property

    ''' <summary>
    ''' What font family to use with the logo text? (eg. Times, Verdana)
    ''' </summary>
    Public WriteOnly Property LogoTextFont As String
        Set(value As String)
            _logoTextFont = value
        End Set
    End Property

    ''' <summary>
    ''' How big should the font be? (eg. 12px)
    ''' </summary>
    Public WriteOnly Property LogoFontSize As String
        Set(value As String)
            _logoTextFontSize = value
        End Set
    End Property

    ''' <summary>
    ''' What color should the Logo Text be? (eg. #ff0000)
    ''' </summary>
    Public WriteOnly Property LogoFontColor As String
        Set(value As String)
            _logoTextFontColor = value
        End Set
    End Property

#End Region

    '*External*
    Public Sub New()
        sb = New StringBuilder()       'Used to build the map-building jQuery string
    End Sub

    Public Function getJSMapCode() As String
        Dim answer As String = ""

        Dim issues As String = checkForCompletion()

        If issues.Length = 0 Then
            If _useLegendToColorStates = True Then
                'If this fails, it will just take whatever colors it receives from the db
                applyLegendColorsToStates()
            End If

            answer = buildJSCall()
        Else
            answer = issues
        End If

        Return answer
    End Function

    Public Function getJSMapCodeAsJQueryCommand() As String
        Dim answer As String = ""

        Dim issues As String = checkForCompletion()

        If issues.Length = 0 Then
            If _useLegendToColorStates = True Then
                'If this fails, it will just take whatever colors it receives from the db
                applyLegendColorsToStates()
            End If

            answer = buildJSCall(True)
        Else
            answer = issues
        End If

        Return answer
    End Function

    '*Internal*
    Private Function buildLegend() As String
        '* Must have two columns
        '* First column is labels for color
        '* second column is hex color

        Dim LegendSB As New StringBuilder()
        Dim dtLegend As DataTable = _legendValues


        If dtLegend IsNot Nothing Then
            If dtLegend.Rows.Count > 0 Then
                LegendSB.Append("legendNameValues: [")

                For Each dr As DataRow In dtLegend.Rows
                    LegendSB.Append("{ label: """ & dr(4).ToString() & """, color: """ & dr(2).ToString() & """ },")
                Next
            Else
                _legendTitle = ""
                Return ""
            End If
        Else
            _legendTitle = ""
            Return ""
        End If

        Dim len As Integer = LegendSB.Length - 1
        LegendSB.Remove(len, 1)

        LegendSB.Append(" ], ")

        Return LegendSB.ToString()
    End Function
    Private Function buildStateProperties() As String
        Dim StateSB As New StringBuilder()
        Dim StateVals As New StringBuilder()
        Dim dtStates As DataTable = _stateValues

        'getStates();
        StateVals.Append("stateValues: [")
        StateSB.Append("stateSpecificStyles: {")

        For Each dr As DataRow In dtStates.Rows
            StateVals.Append("{ name: """ & dr(2).ToString() & """, value: """ & dr(0).ToString() & """ },")
            StateSB.Append("'" & dr(2).ToString() & "' : { fill: '" & dr(3).ToString() & "' },")
        Next

        Dim len As Integer = StateVals.Length - 1
        With StateVals
            .Remove(len, 1)
            .Append(" ], ")
        End With


        StateSB.Append(" } ")
        StateVals.Append(StateSB.ToString())

        Return StateVals.ToString()
    End Function
    Private Function buildJSCall(Optional ByVal asCommand As Boolean = False) As String
        '* 7/2014
        '*This builds the JQuery/Javascript call to the usmap2.js file to build the us map

        If asCommand = False Then
            'Open script tag*
            With sb
                .Append("<script type='text/javascript' language='javascript'>")
                .Append("$(document).ready(function() {")
            End With
        Else
            '*leave off the script tag
        End If


        With sb
            '*Begin Content*


            .Append("$('#" & MapDivID & "').usmap({")
            .Append("useFullStateNames: " & _useFullStateNames.ToString().ToLower() & ",")
            .Append("useAllLabels: " & _useAllLabels.ToString().ToLower() & ",")
            .Append("showMouseOvers: " & _showMouseOvers.ToString().ToLower() & ",")
            .Append("mouseOverBackGroundColor: """ & _mouseOverBackGroundColor.ToString() & """,")
            .Append("mouseOverTextColor: """ & _mouseOverTextColor.ToString() & """,")
            .Append("stateHoverStyles: { fill: 'silver' },")



            '********
            '*Legend*
            '********
            .Append("legendTitle: """ & _legendTitle & """,")
            .Append("legendFontSize: """ & _legendTextFontSize & """,")
            .Append("legendFontFamily: """ & _legendTextFont & """,")
            .Append("legendFontColor: """ & _legendTextFontColor & """,")
            .Append(buildLegend())


            '********
            '*Titles*
            '********
            '*Title Line 1*
            .Append("titleTextLine1: """ & _mapTitleLine1 & """,")
            .Append("titleTextFontFamilyLine1: """ & _mapTitleFontLine1 & """,")
            .Append("titleTextFontSizeLine1: """ & _mapTitleFontSizeLine1 & """,")
            .Append("titleTextFontColorLine1: """ & _mapTitleFontColorLine1 & """,")
            'Title Line 2
            .Append("titleTextLine2: """ & _mapTitleLine2 & """,")
            .Append("titleTextFontFamilyLine2: """ & _mapTitleFontLine2 & """,")
            .Append("titleTextFontSizeLine2: """ & _mapTitleFontSizeLine2 & """,")
            .Append("titleTextFontColorLine2: """ & _mapTitleFontColorLine2 & """,")


            '******
            '*Logo*
            '******
            .Append("logoPath: """ & _logoPath & """,")
            .Append("logoTextLine1: """ & _logoTextLine1 & """,")
            .Append("logoTextLine2: """ & _logoTextLine2 & """,")
            .Append("logoFontFamily: """ & _logoTextFont & """,")
            .Append("logoTextFontSize: """ & _logoTextFontSize & """,")
            .Append("logoTextFontColor: """ & _logoTextFontColor & """,")


            'State Colors
            .Append("stateTextFontColor: """ & _stateTextFontColor & """,")
            'applyLegendColorsToStates()
            '_stateValues = convertStateNamesToAbbreviations(_stateValues, 1)
            .Append(buildStateProperties())


            'Close up properties, etc.            
            .Append("});")
        End With

        If asCommand = False Then

            sb.Append("});")

            'Set the Div Title
            If _divTitle <> "" Then
                sb.Append("")
                sb.Append("$('#" & MapDivID & "').attr('title','" & _divTitle & "');")
            End If

            'Close the script tag
            sb.Append("</script>")

        Else
            '*leave off the script tag
        End If












        Return sb.ToString()
    End Function

#Region "Utilities"

    Private Function checkForCompletion() As String        

        Dim answer As StringBuilder = New StringBuilder()
        Dim returnedAnswer As String = ""
        Dim cnt As Integer = 0


        answer.Append("<ul>")
        If _legendValues Is Nothing Or _legendValues.Rows.Count = 0 Then
            cnt += 1
            answer.Append("<li>The legend values appear to be missing</li>")
        End If


        If _stateValues Is Nothing Or _stateValues.Rows.Count = 0 Then
            cnt += 1
            answer.Append("<li>The state values appear to be missing</li>")
        End If

        answer.Append("</ul>")

        If cnt > 0 Then
            returnedAnswer = "error"
            _error = answer.ToString()
        End If

        Return returnedAnswer
    End Function
    Private Sub applyLegendColorsToStates()       

        If _stateValues Is Nothing OrElse _stateValues.Rows.Count = 0 Then
            Return
        End If

        If _legendValues Is Nothing OrElse _legendValues.Rows.Count = 0 Then
            Return
        End If

        Try
            'Sort the passed-in data table
            Dim dv As DataView = _legendValues.DefaultView
            dv.Sort = "RangeStart asc"
            Dim dt As DataTable = dv.ToTable()

            'Get Highest Range
            Dim rowWithMax As Integer = 0
            Dim maxVal As Double = 0.0
            'Dim legendVals = dt.AsEnumerable()

            'Dim max_value = (From m In legendValsm.Field(Of Decimal)("RangeStart")).Max()
            'maxVal = Convert.ToDouble(max_value)

            'For i As Integer = 0 To dt.Rows.Count - 1
            '    If Convert.ToDouble(dt.Rows(i)("RangeStart")) = maxVal Then
            '        rowWithMax = i
            '    End If
            'Next



            '*Add the colors based on ranges defined in legend table*
            For Each dr As DataRow In _stateValues.Rows
                For i As Integer = 0 To dt.Rows.Count - 1
                    Dim stateValue As Double = Convert.ToDouble(dr(2))
                    Dim rangeEnd As Double = Convert.ToDouble(dt.Rows(i)("RangeEnd"))

                    If stateValue < rangeEnd Then
                        dr(1) = dt.Rows(i)(1)
                        Exit For
                    ElseIf stateValue > rangeEnd AndAlso i = rowWithMax Then
                        dr(1) = dt.Rows(i)(1)
                        Exit For
                    End If
                Next
            Next
        Catch ex As Exception
            Dim [error] As String = ex.Message
        End Try
    End Sub
    Private Function convertStateNamesToAbbreviations(ByRef dt As DataTable, ByVal colNum As Integer) As DataTable

        Dim answer As DataTable = dt.Copy()


        For Each dr As DataRow In answer.Rows
            Select Case dr(colNum).ToString().ToLower()
                Case "alabama"
                    dr(colNum) = "AL"
                Case "alaska"
                    dr(colNum) = "AK"
                Case "arizona"
                    dr(colNum) = "AZ"
                Case "arkansas"
                    dr(colNum) = "AR"
                Case "california"
                    dr(colNum) = "CA"
                Case "colorado"
                    dr(colNum) = "CO"
                Case "connecticut"
                    dr(colNum) = "CT"
                Case "district of columbia"
                    dr(colNum) = "DC"
                Case "delaware"
                    dr(colNum) = "DE"
                Case "florida"
                    dr(colNum) = "FL"
                Case "georgia"
                    dr(colNum) = "GA"
                Case "hawaii"
                    dr(colNum) = "HI"
                Case "idaho"
                    dr(colNum) = "ID"
                Case "illinois"
                    dr(colNum) = "IL"
                Case "indiana"
                    dr(colNum) = "IN"
                Case "iowa"
                    dr(colNum) = "IA"
                Case "kansas"
                    dr(colNum) = "KS"
                Case "kentucky"
                    dr(colNum) = "KY"
                Case "louisiana"
                    dr(colNum) = "LA"
                Case "maine"
                    dr(colNum) = "ME"
                Case "maryland"
                    dr(colNum) = "MD"
                Case "massachusetts"
                    dr(colNum) = "MA"
                Case "michigan"
                    dr(colNum) = "MI"
                Case "minnesota"
                    dr(colNum) = "MN"
                Case "mississippi"
                    dr(colNum) = "MS"
                Case "missouri"
                    dr(colNum) = "MO"
                Case "montana"
                    dr(colNum) = "MT"
                Case "nebraska"
                    dr(colNum) = "NE"
                Case "nevada"
                    dr(colNum) = "NV"
                Case "new hampshire"
                    dr(colNum) = "NH"
                Case "new jersey"
                    dr(colNum) = "NJ"
                Case "new mexico"
                    dr(colNum) = "NM"
                Case "new york"
                    dr(colNum) = "NY"
                Case "north carolina"
                    dr(colNum) = "NC"
                Case "north dakota"
                    dr(colNum) = "ND"
                Case "ohio"
                    dr(colNum) = "OH"
                Case "oklahoma"
                    dr(colNum) = "OK"
                Case "oregon"
                    dr(colNum) = "OR"
                Case "pennsylvania"
                    dr(colNum) = "PA"
                Case "rhode island"
                    dr(colNum) = "RI"
                Case "south carolina"
                    dr(colNum) = "SC"
                Case "south dakota"
                    dr(colNum) = "SD"
                Case "tennessee"
                    dr(colNum) = "TN"
                Case "texas"
                    dr(colNum) = "TX"
                Case "utah"
                    dr(colNum) = "UT"
                Case "vermont"
                    dr(colNum) = "VT"
                Case "virginia"
                    dr(colNum) = "VA"
                Case "washington"
                    dr(colNum) = "WA"
                Case "west virginia"
                    dr(colNum) = "WV"
                Case "wisconsin"
                    dr(colNum) = "WI"
                Case "wyoming"
                    dr(colNum) = "WY"
            End Select
        Next

        Return answer

    End Function

#End Region



#Region "IDisposable Support"
    Private disposedValue As Boolean ' To detect redundant calls

    ' IDisposable
    Protected Overridable Sub Dispose(disposing As Boolean)
        If Not Me.disposedValue Then
            If disposing Then
                ' TODO: dispose managed state (managed objects).
            End If

            ' TODO: free unmanaged resources (unmanaged objects) and override Finalize() below.
            ' TODO: set large fields to null.
        End If
        Me.disposedValue = True
    End Sub

    ' This code added by Visual Basic to correctly implement the disposable pattern.
    Public Sub Dispose() Implements IDisposable.Dispose
        ' Do not change this code.  Put cleanup code in Dispose(ByVal disposing As Boolean) above.
        Dispose(True)
        GC.SuppressFinalize(Me)
    End Sub
#End Region

End Class
