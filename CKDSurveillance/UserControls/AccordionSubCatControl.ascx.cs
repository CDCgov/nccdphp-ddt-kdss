using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class AccordionSubCatControl : System.Web.UI.UserControl
    {
        public int categoryid
        {
            get
            {
                object o = null;
                o = ViewState["categoryid"];
                if ((o != null))
                {
                    return Convert.ToInt32(o);
                }
                else
                {
                    return -1;
                }
            }
            set { ViewState["categoryid"] = value; }
        }

        //public string trendID
        //{
        //    //Used in the markup for reading the trendID
        //    get
        //    {
        //        object o = null;
        //        o = Request["categoryID"];
        //        if ((o != null))
        //        {
        //            return Convert.ToString(o);
        //        }
        //        else
        //        {
        //            return "1";
        //        }
        //    }
        //}


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //********************************
                //*Determine if Happy People 2020*
                //********************************
                int hp = 0;
                if (Request.QueryString["CategoryID"] != null)
                {
                    if (Request.QueryString["CategoryID"].ToString() == "67")
                    {
                        hp = 1;
                    }
                }


                //***************
                //*Bind the Data*
                //***************            
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable dtSubCats = new DataTable("SubCategories");
                dtSubCats = DAL.getSubTopics(this.categoryid, hp);

                
                rptSubcategories.DataSource = dtSubCats;
                rptSubcategories.DataBind();

            }
        }

        protected void rptSubcategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //*Consider only Item Types*

            {

                if (e.Item.ItemType == ListItemType.Item | e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    //***************************************
                    //*Get The SubtopicID for the Leaf Level*
                    //***************************************
                    int val = 0;
                    DataRowView currentCategory = (DataRowView)e.Item.DataItem;
                    val = Convert.ToInt32(currentCategory.Row["QuestionID"]);




                    //*********************
                    //*Bind the Leaf Level*
                    //*********************
                    AccordionIndicatorControl AccordionIndicatorControl1 = (AccordionIndicatorControl)e.Item.FindControl("AccordionIndicatorControl");
                    AccordionIndicatorControl1.categoryid = val;


                    //******************************************
                    //*Do not repeat the title and [conclusion]*
                    //******************************************
                    HtmlGenericControl dvSubCategoryRegular = (HtmlGenericControl)e.Item.FindControl("_dvSubCategoryRegular");
                    string QTest = currentCategory.Row["QuestionText"].ToString();
                }
            }
        }
    }
}