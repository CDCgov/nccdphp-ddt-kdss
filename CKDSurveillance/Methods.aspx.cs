using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using ckdlibV2;

namespace CKDSurveillance_RD.MasterPages
{
    public partial class Methods : NCCDPage//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string QNum = Request.QueryString["QNum"];

            if (QNum == null || QNum == "" || QNum.Length == 0)
            {
                QNum = Session["qnum"].ToString();
            }

            //**************
            //*Get the Data*
            //**************
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataSet ds = DAL.getMethodText(QNum, 1);
            //1 means include the spec sheet
            DataTable dtMethodText = ds.Tables[0];
            DataTable dtSpecSheet = ds.Tables[1];



            //***************************
            //*Populate the Methods Text*
            //***************************

            for (int i = 0; i <= dtMethodText.Rows.Count - 1; i++)
            {
                if (!string.IsNullOrEmpty(dtMethodText.Rows[i]["MethodText"].ToString()))
                {
                    //*Add the text*
                    litMethodsText.Text += dtMethodText.Rows[i]["MethodText"].ToString();

                    //*Add some space*
                    if (i != dtMethodText.Rows.Count - 1)
                    {
                        litMethodsText.Text += "<br /><br />";
                    }
                }

            }



            //**************
            //*Header Label*
            //**************
            DataTable dtHeader = DAL.getQuestionDetails(QNum);

            litMeasure.Text = dtHeader.Rows[0]["MeasureText"].ToString();
            litIndicator.Text = dtHeader.Rows[0]["IndicatorText"].ToString();



            //************************
            //*Populate the specsheet*
            //************************
            buildSpectSheetTable(dtSpecSheet, dtHeader.Rows[0]["IndicatorText"].ToString());

        }

        private void buildSpectSheetTable(DataTable dt, string indicatorText)
        {
            //*Header*
            StringBuilder sb = new StringBuilder();            
            sb.Append("<table class=\"table\" summary=\"This table provides the specification sheet's entry and value for the indicator " + indicatorText + "\" style=\"border:solid 1px #bfbfbf;\" cellpadding=\"2px\" width=\"100%\">");
            sb.Append("<thead>");
            sb.Append("<tr>");
            sb.Append("<th scope=\"col\" style=\"background-color:#E1F3F8CC; color:#ffb655; border-right:solid 1px #bfbfbf;\">Field</th>");
            sb.Append("<th scope=\"col\" style=\"background-color:#E1F3F8CC; color:#ffb655; border-right:solid 1px #bfbfbf;\">Data</th>");
            sb.Append("<tr>");
            sb.Append("</thead>");
            sb.Append("<tbody>");


            //*Loop through the rows and get rows*
            string th1 = "<th scope=\"row\" align=\"left\" valign=\"top\" style=\"border-right:solid 1px silver; border-top:solid 1px silver; padding:3px 3px 3px 3px; background-color:#E1F3F8CC;\">";
            string td2 = "<td align=\"left\" valign=\"top\" style=\"border-right:solid 1px silver; border-top:solid 1px silver; padding:3px 3px 3px 3px;\">";
            foreach (DataRow dr in dt.Rows)
            {

                sb.Append("<tr>");
                sb.Append(th1 + dr["Field"].ToString() + "</th>");
                sb.Append(td2 + dr["Data"].ToString() + "</td>");
                sb.Append("</tr>");
            }

            sb.Append("</tbody>");
            sb.Append("</table>");


            //*Put it on the form*
            this.litSpecSheetGrid.Text = sb.ToString();


            //*Clean up*
            sb = null;

        }
    }
}