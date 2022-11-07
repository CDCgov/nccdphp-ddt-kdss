using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CKDSurveillance_RD.UserControls;
using ckdlibV2;

namespace CKDSurveillance_RD
{
    public partial class NewIndicatorList : Classes.NCCDPage
    {
        

        private void InitCrumbs()
        {
            //this.breadcrumbs_wide1.AddCrumbToDefault(ckdlibV2.CrumbText.Data, ckdlibV2.CrumbUrls.Data);
            //this.breadcrumbs_wide1.DataBind();
        }



        protected void Page_Load(object sender, EventArgs e)
        {

            //Description
            //litDescription.Text = "In 2016, 20 new indicators of CKD have been added to the resources on this site.";

            //Grid
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dt = DAL.getNewIndicatorList();
            
            gvNewIndicatorList.DataSource = dt.DefaultView;
            gvNewIndicatorList.DataBind();
        }

        
       
        
    }
}