<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StratYearsLinksMaps.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.StratYearsLinksMaps" %>

<%--****************--%>
<%--*Control Styles*--%>
<%--****************--%>
<style type="text/css">
   
    .dataSourceRBTitle {
        background-color: #c5ded6;
        color:#1a7aa2;
        border-top-left-radius:5px;
        border-top-right-radius:5px;
    }
    .MapViews 
    {        
        border-radius:10px;     
        padding-bottom:5px;
        
    }
    .MapAnimationSection {
        display:none; /* Hide for now since we are using new maps*/
    }
    .mapviewText 
    {
        font-size:16px;
        font-weight:bold;
        text-align:center;
        background-color: #c5ded6;
        color:#1a7aa2;
        width: 100%;   
        padding:3px;

        border-top-left-radius:10px;
        border-top-right-radius:10px;
    }
    .spanPlus, .spanMinus
    {
        font-weight:bold;
        font-size:18px;        
        cursor:pointer;
        margin-left:5px !important;
        padding-right:5px !important;
    }
    .ULMapyearList 
    {
        list-style-type:none;
    }
    .spnAllYearsLink 
    {        
        cursor:pointer;
        color: #075290;
        padding-right: 0px !important;        
    }
        .spnAllYearsLink:hover 
        {
            text-decoration:underline;
        }
    .selectedItemFormat 
    {
        color:#000;
        font-weight:bold;
        cursor:default;
    }
    .unstyled 
    {        
        background-color:#f6fbff;
        border-bottom-left-radius:5px;
        border-bottom-right-radius:5px;
    }
        .unstyled li
        {        
            margin-bottom:3px;
            padding-left:12px !important;
        }

    .divMapSelectedYears {
        background-color:#f6fbff;
    }

    .divMapAllYears {
          background-color:#f6fbff;
    }


</style>





    
    <div id="divStratButtonOuter" class="">


    <%--***************************************************--%>
    <%--*View Consistent Color Categories Across All Years*--%>
    <%--***************************************************--%>
    <div id="divAcrossAllYears" class="MapViews">
        
        <table class="mapviewText">
            <tr>
                <td style="vertical-align:top;" >
                    <span id="spnAcrossAllYearsPlus" class="spanPlus" title="Expand" onclick="$(this).hide(); $('#spnAcrossAllYearsMinus').show();$('#divMapAllYears').slideDown(1000); $('#spnSelectedYearMinus').trigger('click');">+</span> 
                    <span id="spnAcrossAllYearsMinus" class="spanMinus" title="Collapse" style="display:none;" onclick="$('#divMapAllYears').slideUp(1000);$(this).hide(); $('#spnAcrossAllYearsPlus').show();">-</span> 
                </td>
                <td>
                    <div id='divMapViewTextAll' class="mapviewText">
                        Multi-year: Use Quintiles Across All Years
                    </div>
                </td>
            </tr>
        </table>
        
        <div id="divMapAllYears" class="divMapAllYears">
            <asp:Literal ID="litAllYears" runat="server"></asp:Literal>
        </div>
    </div>


        <br />
        <br />


    <%--*************************************************--%>
    <%--*View Colors as Quintiles for Selected Year Only*--%>
    <%--*************************************************--%>
    <div id="divSelectedYear" class="MapViews">
        <table class="mapviewText">
            <tr>
                <td style="vertical-align:top;">
                    <span id="spnSelectedYearPlus" class="spanPlus" title="Expand" onclick="$(this).hide(); $('#spnSelectedYearMinus').show(); $('#divMapSelectedYears').slideDown(1000);$('#spnAcrossAllYearsMinus').trigger('click');">+</span> 
                    <span id="spnSelectedYearMinus" class="spanMinus" title="Collapse" style="display:none;" onclick="$('#divMapSelectedYears').slideUp(1000);$(this).hide(); $('#spnSelectedYearPlus').show();">-</span>    
                </td>
                <td>
                    <div id='divMapViewTextSelectedYear' class="mapviewText">
                       Single-year: Use Quintiles For Each Year
                        <%--&nbsp;Quintiles For Each Year&nbsp;--%>
                    </div>
                </td>
            </tr>
        </table>
            
        <div id="divMapSelectedYears" class="divMapSelectedYears">
            <asp:Literal ID="litSelectedYear" runat="server"></asp:Literal>
        </div>
    </div>




</div>


<%--Maintain csv list of years--%>
<asp:HiddenField ID="hfCSVYears" runat="server" ClientIDMode="Static" Value="" />
<asp:HiddenField ID="hfMapWhatNavToShow" runat="server" ClientIDMode="Static" Value="a" />
