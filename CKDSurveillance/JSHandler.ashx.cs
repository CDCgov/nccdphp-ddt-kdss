using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;


namespace CKDSurveillance_RD
{
    /// <summary>
    /// HTTP Handler for a utility.js call with screen width so that the code behind can make a decision about which table to show (phone or desktop)
    /// </summary>
    public class JSHandler : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                if(context.Request.Form["message"] != null)
                {

                    string val = context.Request.Form["message"].ToString();

                    Int32 width = 0;
                    if (val.Contains("[width]"))
                    {
                        width = Convert.ToInt32(val.Replace("[width]", "").Trim());

                        if (System.Web.HttpContext.Current.Session["screenwidth"] != null)
                        {
                            Int32 currentWidth = Convert.ToInt32(System.Web.HttpContext.Current.Session["screenwidth"]);
                            if (currentWidth != width)
                            {
                                System.Web.HttpContext.Current.Session["screenwidth"] = width;
                            }
                        }
                        else
                        {
                            System.Web.HttpContext.Current.Session.Add("screenwidth", width);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //silently discard
            }            
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}