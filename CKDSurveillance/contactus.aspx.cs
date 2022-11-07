using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ckdlibV2;

namespace CKDSurveillance_RD
{
    public partial class contactus : Classes.NCCDPage// 9/24 updated per Alex System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cmdSubmit_Click(object sender, EventArgs e)
        {
            bool capPassed = isRecapValid();

            if (capPassed == true)
            {
                Page.Validate();
                if (Page.IsValid)
                {
                    SmtpClient client = null;
                    string name = null;
                    string telephone = null;
                    string eMail = null;
                    string mailingAddress = null;
                    string comments = null;
                    try
                    {
                        client = new SmtpClient();
                        name = Server.HtmlEncode(txtName.Text);
                        telephone = Server.HtmlEncode(txtTelephone.Text);
                        eMail = Server.HtmlEncode(txtEmailAddress.Text);
                        mailingAddress = Server.HtmlEncode(txtMailingAddress.Text);
                        comments = Server.HtmlEncode(txtComments.Text);


                        StringBuilder body = new System.Text.StringBuilder();
                        StringBuilder bodyTemplate = new System.Text.StringBuilder();

                        bodyTemplate.Append("<br />");
                        bodyTemplate.Append("The following message was sent by the CDC CKD Surveillance Web application:");
                        bodyTemplate.Append("<br /><br />");
                        bodyTemplate.Append("<table style='border:solid 1px silver; border-collapse:collapse;'>");
                        bodyTemplate.Append("<tr>");
                        bodyTemplate.Append("<td style='border:solid 1px silver; color:white;background-color:Navy;'><strong>Name:</strong></td>");
                        bodyTemplate.Append("<td style='border:solid 1px silver;'>{0}</td>");
                        bodyTemplate.Append("</tr>");
                        bodyTemplate.Append("<tr>");
                        bodyTemplate.Append("<td style='border:solid 1px silver; color:white;background-color:Navy;'><strong>Telephone:</strong></td>");
                        bodyTemplate.Append("<td style='border:solid 1px silver;'>{1}</td>");
                        bodyTemplate.Append("</tr>");
                        bodyTemplate.Append("<tr>");
                        bodyTemplate.Append("<td style='border:solid 1px silver; color:white;background-color:Navy;'><strong>E-Mail Address:</strong></td>");
                        bodyTemplate.Append("<td style='border:solid 1px silver;'>{2}</td>");
                        bodyTemplate.Append("</tr>");
                        bodyTemplate.Append("<tr>");
                        bodyTemplate.Append("<td style='border:solid 1px silver; color:white;background-color:Navy;'><strong>Mailing Address:</strong></td>");
                        bodyTemplate.Append("<td style='border:solid 1px silver;'>{3}</td>");
                        bodyTemplate.Append("</tr>");
                        bodyTemplate.Append("<tr>");
                        bodyTemplate.Append("<td style='border:solid 1px silver; color:white;background-color:Navy;'><strong>Comments:</strong></td>");
                        bodyTemplate.Append("<td style='border:solid 1px silver;'>{4}</td>");
                        bodyTemplate.Append("</tr>");
                        bodyTemplate.Append("</table>");

                        MailMessage message = new MailMessage(ConfigurationManager.AppSettings["MailSender"], ConfigurationManager.AppSettings["SupportMailReciever"], "CDC CKD Surveillance Contact Us Message", body.AppendFormat(bodyTemplate.ToString(), name, telephone, eMail, mailingAddress, comments).ToString());
                        message.From = new MailAddress(ConfigurationManager.AppSettings["MailSender"].ToString()); // redundant from change just above - but...
                        message.IsBodyHtml = true;
                        

                        client.Host = ConfigurationManager.AppSettings["MailServer"].ToString();
                        client.EnableSsl = true; //Critical finding (5/5/2020) - secure transport
                        client.Send(message);

                        pnlForm.Visible = false;
                        pnlConfirmation.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        client = null;
                    }
                }
            }
        }

        protected bool isRecapValid()
        {
            bool result = false;

            var getResponse = Request.Form["g-recaptcha-response"];
            var secretKey = "6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe"; // This is the test key - I have no reference to CDC key [might need to omit this check if no CDC secret key is available]
            var api = "https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}";

            var requestUri = string.Format(api, secretKey, getResponse);
            var request = (HttpWebRequest)WebRequest.Create(requestUri);

            using (WebResponse response = request.GetResponse())
            {
                using (StreamReader stream = new StreamReader(response.GetResponseStream()))
                {
                   string contents = stream.ReadToEnd();
                    
                    //-----------------
                    //Example response:
                    //-----------------

                    //{
                    //"success": true,
                    //"challenge_ts": "2020-10-22T18:48:23Z",
                    //"hostname": "testkey.google.com"
                    //}
                   string[] splitter = contents.Split(':');
                   string[] successSplitter = splitter[1].Split(',');

                   if (successSplitter[0].ToLower().Contains("true"))
                   {
                       result = true;
                   }                    
                }
            }  

            return result;
        }
    }
}