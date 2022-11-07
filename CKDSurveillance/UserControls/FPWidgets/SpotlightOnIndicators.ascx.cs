using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls.FPWidgets
{
    public partial class SpotlightOnIndicators : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //*Get the AYA information*
            populateAYAs();


            //*Set Button Link*
            setAYAMoreButtonLink();
        }

        private void populateAYAs()
        {            
            //*Get Table*          
            DataTable dtAYA = getAYADataTable();

                      
            //Process table*            
            StringBuilder sb = new StringBuilder();
            foreach (DataRow dr in dtAYA.Rows)
            {
                sb.Append(getAYAEntry(dr["Title"].ToString().Trim(), dr["AYALink"].ToString().Trim(), dr["tickerDate"].ToString().Trim()));
            }

            
            //*Put it on the page*
            litAYADetails.Text = sb.ToString().Trim();

            
            //*Clean-up*
            dtAYA.Dispose();
            dtAYA = null;
        }

        private void setAYAMoreButtonLink()
        {            
            //*Get Table*            
            DataTable dtAYA = getAYADataTable();

            
            //*Get Values*
            int rowToUse = 0;
            string link = dtAYA.Rows[rowToUse]["AYALink"].ToString().Trim();
            

            //*Build button string*
            StringBuilder sb = new StringBuilder();            
            sb.Append("<a href='");
            sb.Append(link);
            sb.Append("' class='btn btn-primary specialLinkIconLeft float-right'>");
            sb.Append("More");
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

        private string getAYAEntry(string title, string link, string tickerDate)
        {
            StringBuilder sbAnswer = new StringBuilder();

            sbAnswer.Append("<p>");
            sbAnswer.Append(title);
            sbAnswer.Append("&nbsp; &mdash;");
            sbAnswer.Append("<a class='list-title' href='" + link + "'>");
            sbAnswer.Append("&nbsp;");
            sbAnswer.Append("<span class='tickerDate'>" + tickerDate + "</span>");
            sbAnswer.Append("</a>");            
            sbAnswer.Append("</p>");

            return sbAnswer.ToString().Trim();
        }
              
    }
}