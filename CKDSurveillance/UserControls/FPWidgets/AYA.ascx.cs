using ckdlibV2;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.UserControls.FPWidgets
{
    public partial class AYA : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            setAYAMoreButtonLink();
        }

        private void setAYAMoreButtonLink()
        {
            //*Get Table*            
            DataTable dtAYA = getAYADataTable();


            //*Get Values*
            int rowToUse = 0;
            string link = dtAYA.Rows[rowToUse]["AYALink"].ToString().Trim();
            link = link.Replace("../", "");

            string topicText = "";
            if(dtAYA.Rows[rowToUse]["TopicText"] != null)
            {
                topicText = dtAYA.Rows[rowToUse]["TopicText"].ToString().TrimStart().TrimEnd();
                link = link + "&TopicText=" + HttpUtility.UrlEncode(topicText);
            }

            //*Build button string*
            StringBuilder sb = new StringBuilder();
            sb.Append("<a href='");
            sb.Append(link);
            sb.Append("' class='aya-button float-right'>");
            sb.Append("View Spotlight");
            sb.Append("</a>");


            //*Send to Page*
            litBtnMore.Text = sb.ToString().Trim();


            //*Clean-up*
            dtAYA.Dispose();
            dtAYA = null;
        }

        private DataTable getAYADataTable()
        {
            DataTable dtAYA = null;

            //*Get Table*
            if (Cache["FPAYAInfo"] != null)
            {
                //Get from Cache
                dtAYA = (DataTable)Cache["FPAYAInfo"];
            }
            else
            {
                //*Get from DB*
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                dtAYA = DAL.get_AYA_Entries_for_FP_Widget();

                //*Cache this*
                Cache.Insert("FPAYAInfo", dtAYA, null, DateTime.MaxValue, TimeSpan.FromDays(2));
            }

            return dtAYA;
        }
    }
}