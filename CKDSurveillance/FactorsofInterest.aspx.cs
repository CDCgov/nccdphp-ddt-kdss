using System;
using System.Web.UI;

namespace CKDSurveillance_RD
{
    public partial class FactorsofInterest : System.Web.UI.Page
    {
        
        private void InitCrumbs()
        {
            //this.breadcrumbs_wide1.AddCrumbToDefault(ckdlibV2.CrumbText.Data, ckdlibV2.CrumbUrls.Data);
            //this.breadcrumbs_wide1.DataBind();
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            //*******************************
            //*Manage the title (508 change)*
            //*******************************

            //*Get and title case the passed in risk factor*
            string factor = Request.QueryString["type"];
            string fc = factor.Substring(0, 1).ToUpper();
            factor = fc + factor.Substring(1, factor.Length - 1);

            Page.Title = "Chronic Kidney Disease (CKD) in the United States - " + factor;
            litBrowseLabel.Text = litBrowseLabel.Text + ": " + factor;

            InitCrumbs();
           
        }     
    }
}