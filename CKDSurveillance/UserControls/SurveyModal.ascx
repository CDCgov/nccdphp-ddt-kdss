<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SurveyModal.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.SurveyModal" %>


<style>
    /*.modal-header
    {
        height:60px !important;
    }*/

    .modal-body
    {
        overflow:auto;
    }

    .modal-header span
    {
        font-size:20pt !important;

    }

    .surveyCboxList tbody tr td label
    {
        padding-left:20px !important;
    }

    .modal-header
    {
        border-radius: 5px 5px 0px 0px;
        background: #deeee9;
        border-bottom: 2px solid /*#c1ded5*/ #E1F3F8CC;
    }

    h5 {
        font-family:Verdana !important;
    }

    h4 {
        font-family:Verdana !important;
    }

    .modal button.close {
        background:none;
        border:none;
    }
</style>

<script type="text/javascript">

    $(function () {
        
            console.log("hfVal=" + $("#HF_ShowModalPopupFlag").val());

            if ($("#HF_ShowModalPopupFlag").val() == "1") {
                $("#surveyModal").modal('show');
                //$("#surveyModal").css("z-index", "1000")
            }
            else
                $("#surveyModal").css("z-index", "-1")

            $("input[id$='BTN_SurveyW_Submit']").attr('disabled', true);

            $("input[id$='BTN_SurveyW_Submit']").click(function () {

                $(this).hide();
                //$(this).attr('disabled', true);
                //$(this).addClass("btn_disabled");

            });
        
    });

    function clearAssociatedTB() {
        console.log("clearAssociatedTB");
        if( $(this).prop("checked") == false)
            $("input[id$='TBox_Q1_Other']").val("");

        checkform();
    }

    function checkform() {
        
        console.log("checkform");
        var validform = false;
        var values = '';

        //loop through each checkbox and append all checked values into a string to use for validation below
        $('input[type=checkbox][id^="CBox_Q1_"]:checked').each(function (index, item) {
            if (values.length == 0)
                values =$(item).val();                               
            else 
                values += "," + $(item).val();                   

            validform = true;//setting boolean to true since a value has been checked
        });

        
        if (values.indexOf($("#HF_TextboxAssocCboxID").val()) > -1 && $("input[id$='TBox_Q1_Other']").val() == "") //if other has been selected, but the text box is empty, then the user can't submit
            validform = false;
        else if (values.indexOf($("#HF_TextboxAssocCboxID").val()) == -1)//otherwise if the other checkbox is not selected, empty out the textbox. This accounts for the user inputting text into the field and then changing their answer
            $("input[id$='TBox_Q1_Other']").val("");
        
        if (validform) {
            $("input[id$='BTN_SurveyW_Submit']").removeClass("btn btn-default disabled").addClass("btn btn-success active"); //changing style of button to indicate it is can be pressed.
            $("input[id$='BTN_SurveyW_Submit']").prop('disabled', false); //enabling the button
            $("input[id$='BTN_SurveyW_Submit']").attr('disabled', false); //enabling the button IE
        }
        else {
            $("input[id$='BTN_SurveyW_Submit']").removeClass("btn btn-success active ").addClass("btn btn-default disabled");//changing style of button to indicate it is disabled.
            $("input[id$='BTN_SurveyW_Submit']").prop('disabled', true); //disabling the button
            $("input[id$='BTN_SurveyW_Submit']").attr('disabled', true); //disabling the button IE
        }
    }

    function checkTBCB(v) {
        console.log("v=" + v);
        $('input[type=checkbox][id^="CBox_Q1_"]').each(function (index, item) {
            var lival = $(item).val();
            if (lival == v) {
                $(item).prop('checked', true);
                checkform();
            }
        });
        //$('input[type=checkbox][id^="CBox_Q1_"][index="' + i + '"]').prop("checked", true);
    }

</script>
<%--<a data-toggle="modal" id="modallink" runat="server" data-target="#surveyModal" class="modallink" style="position:relative">Answer One Question Survey</a>--%>
<asp:HiddenField ID="HF_ShowModalPopupFlag" runat="server" />
<asp:HiddenField ID="HF_TextboxAssocCboxID" runat="server" />

<div class="modal fade" id="surveyModal" tabindex="-1" role="dialog" aria-labelledby="surveyModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                
                <h4 class="modal-title" id="surveyModalLabel" style="font-family: Poppins;">Help us meet your needs</h4>                  
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              </div>
               
                 <div class="modal-body form-horizontal"> 
                    <div class="form-group" id="onequestionform" runat="server" >

                        <%--<h5>What brought you to this website?</h5>
                        <div class="col-sm-8">
                            <asp:CheckBoxList ID="CBox_Q1" CssClass="surveyCboxList" runat="server" RepeatLayout="Table" onchange="checkform()" >
                                <asp:ListItem Text="I’m a researcher" Value="1"></asp:ListItem>
                                <asp:ListItem Text="I’m a health care provider" Value="2"></asp:ListItem>
                                <asp:ListItem Text="I’m a public health official" Value="3"></asp:ListItem>
                                <asp:ListItem Text="I work for a health care company" Value="4"></asp:ListItem>
                                <asp:ListItem Text="I have kidney disease or someone close to me does" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Other" Value="6"></asp:ListItem>
                            </asp:CheckBoxList>
                            <asp:TextBox ID="TBox_Q1_Other" style="max-width:90%" MaxLength="100" CssClass="form-control input-sm" onkeyup="checkform()" runat="server" ></asp:TextBox>

                        </div>--%>
                    </div>
                     
                    
                    <div style="text-align:right;">
                        <asp:Button ID="BTN_SurveyW_Submit" CssClass="btn disabled" runat="server" Text="Submit" OnClick="BTN_SurveyW_Submit_Click"></asp:Button> <!-- OnClientClick="validateselection()" -->
                    </div>
                </div>
            </div>
        </div>
    </div>