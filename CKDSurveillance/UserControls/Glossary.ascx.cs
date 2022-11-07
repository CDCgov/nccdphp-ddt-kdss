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
    public partial class Glossary : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string urlParam = Request.Params["section"];

            if (urlParam.ToUpper() != "G")
            {
                return;
            }


            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataSet ds;
            DataTable dt;

            try
            {
                ds = DAL.getGlossaryEntries();
                dt = ds.Tables[0];
            }
            catch (Exception ex)
            {
                throw;
            }



            //*******
            //*A - F*
            //*******
            populateRepeater("substring(GlossaryTerm,1,1) IN('A','B','C','D','E','F')", rptGlossaryAF, dt);


            //*******
            //*G - L*
            //*******
            populateRepeater("substring(GlossaryTerm,1,1) IN('G','H','I','L')", rptGlossaryGL, dt);


            //*******
            //*M - R*
            //*******
            populateRepeater("substring(GlossaryTerm,1,1) IN('M','N','O','P','Q','R')", rptGlossaryMR, dt);


            //*******
            //*S - Z*
            //*******
            populateRepeater("substring(GlossaryTerm,1,1) IN('S','T','U','V','W','X','Y','Z')", rptGlossarySZ, dt);



            //*********
            //*Sources*
            //*********
            DataTable dtSources = ds.Tables[1];
            populateRepeater("", rptSources, dtSources);


            //**********
            //*Clean-Up*
            //**********
            dt.Dispose();
            dtSources.Dispose();
            ds.Dispose();
            DAL = null;
        }

        private void populateRepeater(string filter, Repeater rptCtrl, DataTable dt)
        {
            DataView dv = dt.DefaultView;
            dv.RowFilter = filter;
            rptCtrl.DataSource = dv;
            rptCtrl.DataBind();
        }

        private void rptGlossaryAF_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            // *Add an anchor tag so that each term can be reached via a link*
            RepeaterItem ri = (RepeaterItem)e.Item;
            
            if (ri.ItemType == ListItemType.AlternatingItem || ri.ItemType == ListItemType.Item)
            {
                Literal lit = (Literal)ri.FindControl("litAnchorAF");
                Label gt = (Label)ri.FindControl("lblGlossaryTerm");

                //*Create the Anchor*
                lit.Text = "<a name=\"" + gt.Text.Replace(":", "").Trim() + "\"></a>";
            }
        }


        private void rptGlossaryGL_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            // *Add an anchor tag so that each term can be reached via a link*
            RepeaterItem ri = (RepeaterItem)e.Item;
            
            
            if (ri.ItemType == ListItemType.AlternatingItem || ri.ItemType == ListItemType.Item)
            {
                Literal lit = (Literal)ri.FindControl("litAnchorGL");
                Label gt = (Label)ri.FindControl("lblGlossaryTermGL");

                //*Create the Anchor*
                lit.Text = "<a name=\"" + gt.Text.Replace(":", "").Trim() + "\"></a>";
            }
        }

        private void rptGlossaryMR_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            // *Add an anchor tag so that each term can be reached via a link*
            RepeaterItem ri = (RepeaterItem)e.Item;

            
            if (ri.ItemType == ListItemType.AlternatingItem|| ri.ItemType == ListItemType.Item)
            {
                Literal lit = (Literal)ri.FindControl("litAnchorMR");
                Label gt = (Label)ri.FindControl("lblGlossaryTermMR");


                //*Create the Anchor*
                lit.Text = "<a name=\""+ gt.Text.Replace(":", "").Trim() + "\"></a>";
            }
        }

        private void rptGlossarySZ_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            // *Add an anchor tag so that each term can be reached via a link*
            RepeaterItem ri = (RepeaterItem)e.Item;
         
            
            if (ri.ItemType == ListItemType.AlternatingItem || ri.ItemType == ListItemType.Item)
            {
                Literal lit = (Literal)ri.FindControl("litAnchorSZ");
                Label gt = (Label)ri.FindControl("lblGlossaryTermSZ");

                //*Create the Anchor*
                lit.Text = "<a name=\"" + gt.Text.Replace(":", "").Trim() + "\"></a>";
            }
        }


    }
}