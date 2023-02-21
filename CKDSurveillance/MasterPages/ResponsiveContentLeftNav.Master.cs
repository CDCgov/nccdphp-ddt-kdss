using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CKDSurveillance_RD.UserControls.TemplateLocal;
using System.Configuration;

namespace CKDSurveillance_RD.MasterPages
{
    public partial class ResponsiveContentLeftNav : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        //************************
        //*Do not cache this page* - reload it every time (Helps with when people hit the back button)
        //************************

            if(! Page.IsPostBack==true)
            {
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.CacheControl = "no-cache";
                HttpContext.Current.Response.AddHeader("Pragma", "no-cache");
                HttpContext.Current.Response.AppendHeader("Cache-Control", "no-store");
                HttpContext.Current.Response.Expires = -1441;
                HttpContext.Current.Response.Cache.SetNoStore();
                HttpContext.Current.Response.Cache.AppendCacheExtension("no-cache");
            }


            //*********************************
            //*Populate last Updated Meta Tags* (March 2020)
            //*********************************
            string wcLU = System.Configuration.ConfigurationManager.AppSettings["LastReleaseDate"].Trim();
            string mtLastUpdated = "<meta property='cdc:last_updated' content='" + wcLU + "' />";
            litMetaTagsLastUpdated.Text = mtLastUpdated;
        }

        //commented out 8/20/19
        //public string ExtraCrumbs
        //{
        //    get
        //    {
        //        return ucBreadcrumbs.extraCrumbs;
        //    }
        //    set
        //    {
        //        ucBreadcrumbs.extraCrumbs = value;
        //    }
        //}

       
    }
}