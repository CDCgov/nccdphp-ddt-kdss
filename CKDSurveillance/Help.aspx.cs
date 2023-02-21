using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD
{
    public partial class Help : Classes.NCCDPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hideAllSections();

            string urlParam = Request.Params["section"];
            
            // *On first visit - handle a missing url parameter*
            if ((Page.IsPostBack == false))
            {
                if (string.IsNullOrEmpty(urlParam))
                {
                    Response.Redirect("Help.aspx?section=F");
                }
            }
            
            // *Manage the Choice*
            if (!string.IsNullOrEmpty(urlParam))
            {
                if (urlParam != "F" && urlParam != "G" && urlParam != "B" && urlParam != "D" && urlParam != "H")
                {
                    Response.Redirect("Help.aspx?section=F");
                }

                switch (urlParam.ToUpper())
                {
                    //case "B":
                    //    btnBibliography_Click();
                    //    break;
                    case "D":
                        btnDataSources_Click();
                        break;
                    case "F":
                        btnFAQ_Click();
                        break;
                    case "G":
                        btnGlossary_Click();
                        break;
                    case "H":
                        btnAboutProject_Click();
                        break;
                }
            }

        }

        private void hideAllSections()
        {
            FAQ.Visible = false;
            Glossary.Visible = false;
            DataSources.Visible = false;
            //Bibliography.Visible = false;
            AboutTheProject.Visible = false;
        }

        //private void btnBibliography_Click()
        //{
        //    Page.Title = "CDC - Chronic Kidney Disease - Bibliography";
        //    Bibliography.Visible = true;
        //}

        private void btnDataSources_Click()
        {
            Page.Title = "CDC - Chronic Kidney Disease - Data Sources";
            DataSources.Visible = true;
        }

        private void btnFAQ_Click()
        {
            Page.Title = "CDC - Chronic Kidney Disease - FAQ";
            FAQ.Visible = true;
        }
        private void btnGlossary_Click()
        {
            Page.Title = "CDC - Chronic Kidney Disease - Glossary";
            Glossary.Visible = true;
        }
        private void btnAboutProject_Click()
        {
            Page.Title = "CDC - Chronic Kidney Disease - About The Project";
            AboutTheProject.Visible = true;
        }
    }
}