using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls.FPWidgets
{
    public partial class SpecialDay : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            manageSpecialDayWidget();
        }

        private void manageSpecialDayWidget()
        {
            //*Check the special day widget date to determine which widget should be there
            string widgetName = "";
            string fallBackWidget = "";
            DateTime widgetExpirationDate = DateTime.Now;
            Control uc = null;

            DataTable dtSettings = getWidgetSettings();

            foreach (DataRow dr in dtSettings.Rows)
            {
                string name = dr["name"].ToString().Trim().ToLower();
               
                switch (name)
                {
                    case "frontpagefallbackwidget":
                        fallBackWidget = "~/UserControls/SpecialDayWidgets/" + dr["Value"].ToString().Trim();
                        break;
                    case "frontpagespecialdaywidget":
                        widgetName = "~/UserControls/SpecialDayWidgets/" + dr["Value"].ToString().Trim();
                        break;
                    case "frontpagewidgetexpirationdate":
                        widgetExpirationDate = Convert.ToDateTime(dr["Value"]);
                        break;
                }                
            }

            if (DateTime.Now >= widgetExpirationDate)
            {
                uc = LoadControl(fallBackWidget);
            }
            else
            {
                uc = LoadControl(widgetName);
            }
            phWidget.Controls.Add(uc);


            //Clean up
            dtSettings.Dispose();
            dtSettings = null;
        }
        private DataTable getWidgetSettings()
        {
            DataTable answer = null;

            //Ensure Cache is not empty
            if (Cache["ApplicationSettings"] == null)
            {
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable tempAnswer = DAL.getApplicationSettings();

                if (tempAnswer != null)
                {
                    Cache.Insert("ApplicationSettings", tempAnswer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                }

                //Clean-up
                tempAnswer.Dispose();
                tempAnswer = null;
            }

            DataTable dt = (DataTable)Cache["ApplicationSettings"];
            DataRow[] drs = dt.Select("Name='FrontPageFallBackWidget' OR Name='FrontPageSpecialDayWidget' or name='FrontPageWidgetExpirationDate'");
            answer = drs.CopyToDataTable();

            return answer;
        }
    }
}