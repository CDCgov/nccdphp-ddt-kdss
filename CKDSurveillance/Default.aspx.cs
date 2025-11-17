using ckdlibV2;
using System;
using System.Data;

namespace CKDSurveillance_RD
{
    public partial class Default : Classes.NCCDPage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "KDSS | Home  | CDC";

            //Cache Application Settings
            ManageApplicationSettings();          
        }

        private void ManageApplicationSettings()
        {
            if (Cache["ApplicationSettings"] == null)
            {
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable answer = DAL.getApplicationSettings();

                if (answer != null)
                {
                    Cache.Insert("ApplicationSettings", answer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                }
            }
        }                       
    }
}