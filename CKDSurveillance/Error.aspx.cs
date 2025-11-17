using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;

namespace CKDSurveillance_RD
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Page.Title = ConfigurationManager.AppSettings["AppName"].ToString() + " Application Error";

            //*Set the contactus link behaviors for a pop-up*
            lnkContact.NavigateUrl = "javascript:void(0);";
            lnkContact.Target = "";
            lnkContact.Attributes.Add("onclick", "popupWindow('" + HttpRuntime.AppDomainAppVirtualPath.TrimEnd('/') + "/contactUs.aspx', 800, 600); return false;");            
            //*************************
            //*Build the error message*
            //*************************
            StringBuilder msg = new StringBuilder();
            msg.Append("We apologize for the inconvenience. Your last request generated an error.");
            msg.Append("<br /><br />");


            //*********************************************
            //*Append error messages from the Query string*
            //*********************************************        
            string errors = getErrorMessages();
            if (!String.IsNullOrEmpty(errors))
            {
                msg.Append(errors);
            }


            string url = HttpRuntime.AppDomainAppVirtualPath.TrimEnd('/') + ("/Default.aspx");
            //Contact us link on page appears adjacent to this asp:label, so it appears as part of the sentence
            msg.Append("Please press the browser's back button to try again, use the navigation links above, or return to the CKD Surveillance <a class=\"no-link\" href=\"" + url + "\">home page</a>"); //<a class="no-link" href="Default.aspx">CKD Surveillance Home</a>
            msg.Append("<br /><br />");
            msg.Append("If this message persists, please "); //Contact us. 


            //*Assign the message to the Label*
            this.lblErrorMessage.Text = msg.ToString();

            if (Session != null)
            {
                Session.Clear();
                Session.Abandon();
            }

        }

        private string getErrorMessages()
        {
            string answer = "";

            //*************************************************
            //*Return any error messages from the Query string*
            //************************************************
            string param = "";

            if (Request.QueryString["errormsg"] == null)
            {
                param = "";

            }
            else
            {
                param = Request.QueryString["errormsg"].ToString();
            }


            if (!string.IsNullOrEmpty(param))
            {
                switch (param)
                {
                    case "BadIndicator":
                        answer = "The provided indicator does not appear to be legitimate.<br /><br />";
                        break;
                }
            }

            return answer;

        }

        private void Page_Init(object sender, System.EventArgs e)
        {

            Page.ViewStateUserKey = HttpContext.Current.Session.SessionID;

        }
    }
}