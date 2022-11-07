<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContent_popup.Master" AutoEventWireup="true" CodeBehind="contactus.aspx.cs" Inherits="CKDSurveillance_RD.contactus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .ConfirmMessage {
            color: maroon;
            font-weight: bold;
            margin-left: 3em;
        }

        #recaptchaError, #g-recaptcha {
            display: flex;
            justify-content: center;
        }

        .passedVerify {
            font-weight: bold;
            color: Green;
        }

        .failedVerify {
            font-weight: bold;
            color: maroon;
        }

        .cdcPhone {
            margin-top: 10px;
        }

        .SeparatorBar {
            margin-left: 0px;
        }

        input[disabled='disabled']:hover {
            cursor: not-allowed;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <%--*Separator bar*--%>
    <div class="SeparatorBar">
        <div class="col-lg-12">
            <h4>Chronic Kidney Disease (CKD) in the United States</h4>
        </div>
    </div>

    <div class="col-lg-12 mt-4">
        <h4>Contact Us</h4>
    </div>

    <a id="contentArea" name="contentArea" />
    <%--******--%>
    <%--*FORM*--%>
    <%--******--%>
    <div class="">
        <div class="col-lg-12">
            <asp:Panel ID="pnlForm" runat="server" Visible="true">

                <table class="ckd-contact-us table">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblIntro" runat="server" Text="Use this form to send questions or comments about the information presented within the CKD web site.  We value your opinions."></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label AssociatedControlID="txtName" ID="lblName" runat="server" CssClass="label" Text="Name:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtName" runat="server" CssClass="value name form-control" MaxLength="100" Style="max-width: 50%;"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblTelephone" AssociatedControlID="txtTelephone" runat="server" CssClass="label" Text="Telephone:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTelephone" runat="server" CssClass="value telephone form-control" MaxLength="20" Style="max-width: 50%;"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblEmailAddress" AssociatedControlID="txtEmailAddress" runat="server" CssClass="label" Text="E-Mail Address:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="value e-mail form-control" MaxLength="500" Style="max-width: 60%;"></asp:TextBox>
                            <asp:Label ID="txtEmailAddressExtra" runat="server" CssClass="value extra" Text="Example: yourname@yourcompany.com"></asp:Label>
                            <asp:RegularExpressionValidator ID="revEmailAddress" runat="server" ControlToValidate="txtEmailAddress"
                                EnableClientScript="false" SetFocusOnError="true" CssClass="validator-error"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="The e-mail address you entered does not appear to be valid."></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMailingAddress" AssociatedControlID="txtMailingAddress" runat="server" CssClass="label" Text="Mailing Address:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMailingAddress" runat="server" CssClass="value mailing form-control" TextMode="MultiLine"
                                Rows="4" Columns="70" MaxLength="4000"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblComments" AssociatedControlID="txtComments" runat="server" CssClass="label" Text="Comments:"></asp:Label>
                            <br />
                            <asp:Label ID="lblCommentsExtra" runat="server" CssClass="" Text="(<em>required</em>)"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtComments" runat="server" CssClass="value comments form-control" TextMode="MultiLine"
                                Rows="6" Columns="70" MaxLength="5000"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvComments" runat="server" ControlToValidate="txtComments"
                                EnableClientScript="false" SetFocusOnError="true" CssClass="validator-error"
                                ErrorMessage="Please enter your comments before clicking the Send button."></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <%--*********--%>
                            <%--*Captcha*--%>
                            <%--*********--%>
                            <div class="g-recaptcha" id='g-recaptcha'></div>
                            <div id="recaptchaError" class="red-color"></div>
                            <noscript>
                                <div>
                                    <div>
                                        <div>
                                            <iframe src="https://www.google.com/recaptcha/api/fallback?k=6LcYlBMTAAAAAFpu9YY0uN_PEu4usgUDaSRIolrH" frameborder="0" scrolling="no"></iframe>
                                            <%--*This is the test key again - uncomment the above the get the CDC key, and comment out the one below*--%>
                                            <%--<iframe src="https://www.google.com/recaptcha/api/fallback?k=6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI" frameborder="0" scrolling="no"></iframe>--%>
                                        </div>
                                        <div>
                                            <textarea id="g-recaptcha-response" name="g-recaptcha-response" class="g-recaptcha-response"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </noscript>

                        </td>
                        <td colspan="2" class="buttons">
                            <div class="row">
                                <div class="col-md-10">
                                    <asp:Button ID="cmdSubmit" runat="server" Text="Send" OnClick="cmdSubmit_Click" CssClass="btn btn-primary float-right" ClientIDMode="Static" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-10">
                                    <span class="float-right" id="spnRecaptcha"></span>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>

                <br />
                <br />

                <table class="ckd-contact-us table-reponsive" style="width: 90%;">
                    <tr>
                        <td colspan="2">Alternatively, you can contact us via postal mail, phone, or email.
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="address">
                                Division of Diabetes Translation<br />
                                National Center for Chronic Disease<br />
                                Prevention and Health Promotion<br />
                                Centers for Disease Control and Prevention<br />
                                4770 Buford Highway, NE<br />
                                Mailstop F75<br />
                                Atlanta, GA 30341-3717
                            </div>
                        </td>
                        <td>
                            <ul class="cdcPhone">
                                <li>(770) 488-5000</li>
                                <li><a href="http://www.cdc.gov/cdc-info/requestform.html" target="_blank">Contact CDC-INFO</a></li>
                            </ul>
                        </td>
                    </tr>
                </table>

            </asp:Panel>
        </div>
    </div>

    <%--******************************--%>
    <%--*Successful Comment Submitted*--%>
    <%--******************************--%>
    <div class="row">
        <div class="col-lg-12">
            <asp:Panel ID="pnlConfirmation" runat="server" Visible="false" CssClass="ckd-contact-us-confirm">
                <br />
                <br />
                <div class="ckd-contact-us-confirm-message ConfirmMessage">
                    <span>Your message has been sent.  Thank for for your input!</span>
                </div>
                <br />
                <br />
                <br />
            </asp:Panel>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">

    <script type="text/javascript">

        try {

            //*****************************
            //Build Recaptcha on page load*
            //*****************************
            var renderRecaptcha = function () {
                grecaptcha.render('g-recaptcha', {
                    'sitekey': '6LcYlBMTAAAAAFpu9YY0uN_PEu4usgUDaSRIolrH', //CDCKey
                    //'sitekey': '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI', //test key
                    'callback': 'onloadCallback',
                    theme: 'light', //light or dark    
                    type: 'image',// image or audio    
                    size: 'normal'//normal or compact
                });
            };

            //Show it - in app.js it is hidden by default
            $('#g-recaptcha').show();

        } catch (err) {
            console.log(err)
        }


        //**********
        //*Callback*
        //**********
        var onloadCallback = function (response) {
            //console.log('in callback! response: ' + response);
            if (response !== '') {
                $('#cmdSubmit').removeClass('aspNetDisabled').removeAttr('disabled');
            } else {
                $('#cmdSubmit').addClass('aspNetDisabled').attr('disabled', 'disabled');
            }
        };


        //*********************
        //*Submit button click*
        //*********************
        $('#cmdSubmit').on('click', function (event) {
            var msg = 'Please verify this is a human submitting the form by addressing the Captcha challenge';

            if (typeof (grecaptcha) != 'undefined') {
                var response = grecaptcha.getResponse();

                if (response.length === 0) {
                    msg = 'Please verify this is a human submitting the form by addressing the Captcha challenge';
                    $('#spnRecaptcha').addClass('failedVerify').remove('passedVerify');
                    event.preventDefault();
                } else {
                    $('#spnRecaptcha').addClass('passedVerify').remove('failedVerify');
                    msg = 'Verified';
                }
            }

            $('#spnRecaptcha').text(msg);
        });

        function DisableButton(ButtonId) {
            $("#" + ButtonId).attr("disabled", "disabled");
        }

        function EnableButton(ButtonId) {
            $("#" + ButtonId).removeAttr('disabled');
        }

        $(document).ready(function () {
            DisableButton('cmdSubmit');
        })


    </script>

    <!--Note: this must be placed after the the function definitions,etc., as per Google documentation -->
    <script src='https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit' async defer></script>

</asp:Content>
