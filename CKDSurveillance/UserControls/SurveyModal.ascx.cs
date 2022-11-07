using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Configuration;
using System.Data;
using System.Web.UI.HtmlControls;
using ckdlibV2;
using System.Web.Security.AntiXss;
using System.Text.RegularExpressions;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
    public partial class SurveyModal : System.Web.UI.UserControl
    {
        public string qid;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            HttpCookie surveyCookie = Request.Cookies[Convert.ToString(ConfigurationManager.AppSettings["SurveyW_CookieName"])];


            if (surveyCookie == null && Convert.ToString(ConfigurationManager.AppSettings["SurveyW_Enabled"]) == "1") // if the cookie doesn't exist, then display the modal, create a new cookie with a Max expire date
            {
                //No cookie found or cookie expired.
                HF_ShowModalPopupFlag.Value = "1";
                surveyCookie = new HttpCookie(Convert.ToString(ConfigurationManager.AppSettings["SurveyW_CookieName"]));

                //Fix for an empty cookie for new Production "DMZ" server, recommendation from Alex @CDC 7/23/2019
                surveyCookie.Value = Convert.ToString(ConfigurationManager.AppSettings["SurveyW_CookieName"]);
                if (surveyCookie.Value == "")
                    surveyCookie.Value = "XXX";

                DateTime expiredate = DateTime.Now.AddYears(1);     //expiration data added by Alex @ CDC 2/28/2020                           
                surveyCookie.Expires = expiredate;//have the cookie expire in the future
                HttpContext.Current.Response.Cookies.Add(surveyCookie);                            
            }
            else //otherwise don't show the modal popup
            {
                HF_ShowModalPopupFlag.Value = "0";                 
            }

            if (Convert.ToString(ConfigurationManager.AppSettings["SurveyW_Enabled"]) == "1")
            {
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable dt = DAL.getSurveyQuestionsAndAnswers(Convert.ToString(ConfigurationManager.AppSettings["SurveyW_ID"]));

                string current_qid = "";
                CheckBoxList cboxlist = new CheckBoxList();

                HtmlGenericControl divctrl = new HtmlGenericControl("div");
                divctrl.Attributes.Add("class", "col-sm-12");

                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    string s_qid = dt.Rows[i]["SurveyQuestionID"].ToString();
                    qid = s_qid;//this only works for one question
                    string s_qtext = dt.Rows[i]["SurveyQuestionText"].ToString();
                    string s_tbox = dt.Rows[i]["SurveyAnswerChoiceIncludeTextbox"].ToString();

                    if (current_qid != s_qid)
                    {
                        current_qid = s_qid;

                        HtmlGenericControl h5ctrl = new HtmlGenericControl("h5");
                        h5ctrl.InnerHtml = s_qtext;
                        onequestionform.Controls.Add(h5ctrl);

                        onequestionform.Controls.Add(divctrl);

                        cboxlist = new CheckBoxList();
                        cboxlist.ID = "CBox_Q1";
                        cboxlist.Attributes.Add("class", "surveyCboxList");
                        
                        divctrl.Controls.Add(cboxlist);

                    }

                    string s_aid = dt.Rows[i]["SurveyAnswerChoiceID"].ToString();
                    string s_atext = dt.Rows[i]["SurveyAnswerChoiceText"].ToString();
                    ListItem li = new ListItem(s_atext, s_aid);
                    cboxlist.Items.Add(li);

                    if (s_tbox.ToLower() == "true")
                    {
                        TextBox tbox = new TextBox();
                        tbox.MaxLength = 100;
                        tbox.ID = "TBox_Q1_Other";
                        tbox.CssClass = "form-control input-sm";
                        tbox.Attributes.Add("style", "max-width:90%");
                        tbox.Attributes.Add("onkeyup", "checkform()");
                        tbox.Attributes.Add("onfocus", "checkTBCB(" + s_aid + ")");
                        divctrl.Controls.Add(tbox);

                        HF_TextboxAssocCboxID.Value = s_aid;
                        li.Attributes.Add("onchange", "clearAssociatedTB()");
                        HtmlGenericControl tboxlbl = new HtmlGenericControl("label");
                        tboxlbl.Attributes.Add("for", "TBox_Q1_Other");
                        tboxlbl.Attributes.Add("style", "color:#fff");
                        tboxlbl.InnerHtml = "_";
                        divctrl.Controls.Add(tboxlbl); //508 compliance                        
                    }
                    else
                        li.Attributes.Add("onchange", "checkform()");
                }
            }

        }

        protected void BTN_SurveyW_Submit_Click(object sender, EventArgs e)
        {

            try
            {
                CheckBoxList CBox_Q1 = (CheckBoxList)onequestionform.FindControl("CBox_Q1");
                TextBox TBox_Q1_Other = (TextBox)onequestionform.FindControl("TBox_Q1_Other");
                string sessionid = HttpContext.Current.Session.SessionID;
                ArborDataAccessV2 DAL = new ArborDataAccessV2();

                foreach (ListItem li in CBox_Q1.Items)
                {
                    if(li.Selected && li.Text.ToLower() != "other")
                        DAL.insertSurveyAnswer(sessionid, qid, li.Value);
                    else if(li.Selected && li.Text.ToLower() == "other")
                        DAL.insertSurveyAnswer(sessionid, qid, li.Value, AntiXssEncoder.HtmlEncode(SanitizeHtml(TBox_Q1_Other.Text), false));                    
                }               

                HF_ShowModalPopupFlag.Value = "0";

                Response.Redirect("default.aspx");
            }
            catch (Exception ex)
            {
            }

        }

        protected string SanitizeHtml(string html)
        {
            html = System.Web.HttpUtility.HtmlDecode(html);

            List<string> blackListedTags = new List<string>()
            {
                    "body", "script", "iframe", "form", "object", "embed", "link", "head", "meta"
            };

            foreach (string tag in blackListedTags)
            {
                html = Regex.Replace(html, "<" + tag, "<p", RegexOptions.IgnoreCase);
                html = Regex.Replace(html, "</" + tag, "</p", RegexOptions.IgnoreCase);
            }

            //*Scrub for SQL*
            List<string> blackListedSQL = new List<string>()
            {
                "insert", "select", "delete", "update", "drop", "truncate", "join", "backup", "dbreindex", "dbcc", "create", "alter", ";", "database", "table", "*", "from", "%","#","@","^","!","<", ">","$"
            };

            foreach (string word in blackListedSQL)
            {
                int index = html.IndexOf(word, StringComparison.OrdinalIgnoreCase);
                if (index >= 0)
                {
                    html = html.Remove(index, word.Length);
                }
            }

            return html.Trim();
        }

    }
}