using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ckdlibV2;
using System.Data;


namespace CKDSurveillance_RD.UserControls
{
    public partial class Bibliography : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        
        string urlParam = Request.Params["section"];

        if(urlParam.ToUpper() != "B")
        {
                return;
        }

        ArborDataAccessV2 DAL = new ArborDataAccessV2();
        DataTable dt = DAL.getBibliography();


        //*******************
        //*Populate Repeater*
        //*******************
        populateRepeater("", rptBib, dt);



        //**********
        //*Clean-Up*
        //**********
        dt.Dispose();
        DAL = null;
        }

      private void populateRepeater(string filter, Repeater rptCtrl, DataTable dt) {
      
          DataView dv = dt.DefaultView;

         if (filter != "") 
         {
             dv.RowFilter = filter;
         }
         
         rptCtrl.DataSource = dv;
         rptCtrl.DataBind();
     }

    }
}