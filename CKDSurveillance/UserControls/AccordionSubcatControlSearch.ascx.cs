using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class AccordionSubcatControlSearch : System.Web.UI.UserControl
    {
        public int categoryid
        {
            get
            {
                object o = null;
                o = ViewState["categoryid"];
                if (o != null)
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

        public DataTable SearchList
        {
            get
            {
                if (ViewState["SearchList"] != null)
                {
                    return (DataTable)ViewState["SearchList"];
                }
                else
                {
                    return null;
                }
            }
            set { ViewState["SearchList"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                //***************
                //*Bind the Data*
                //***************            
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable dtSubCats = new DataTable("SubCategories");
                dtSubCats = DAL.getSubTopicsSearch(categoryid, SearchList);


                
                rptSubcategories.DataSource = dtSubCats.DefaultView;
                rptSubcategories.DataBind();


                //*Clean-up*
                DAL = null;
                dtSubCats.Dispose();

            }

        }

        protected void rptSubcategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //*Consider only Item Types*

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
                AccordionIndicatorControlSearch AccordionIndicatorControl1 = (AccordionIndicatorControlSearch)e.Item.FindControl("AccordionIndicatorControlSearch1");                
                AccordionIndicatorControl1.categoryid = val;
                AccordionIndicatorControl1.SearchList = SearchList;



                //******************************************
                //*Do not repeat the title and [conclusion]*
                //******************************************
                HtmlGenericControl dvSubCategoryRegular = (HtmlGenericControl)e.Item.FindControl("_dvSubCategoryRegular");
                string QTest = currentCategory.Row["QuestionText"].ToString();
                
            }

        }
    }
}